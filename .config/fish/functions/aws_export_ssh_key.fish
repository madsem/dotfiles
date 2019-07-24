##
# export private SSH key from AWS secrets manager & save as file:
# 
# 1. (Re-)Create file under <path> (<path> equals name) & set permissions
# 2. Regenerate the public key from this private key & set permissions
# 3. Add identity to ssh-agent
#
# Any existing private or public key files of the same name,
# will be backed up in the same directory & have .timestamp.old appended.
function aws_export_ssh_key --description '<path> <region>'

    if test (count $argv) -ne 2
        echo "<path> and <region> are required."
        return 1
    end

    # remove expanded $HOME from key file path
    # because keys are saved with names
    # that don't include the user name
    set -l keyName (string replace $HOME '' $argv[1])

    # key paths & aws region
    set -l privateKey "$argv[1]"
    set -l publicKey $argv[1]".pub"
    set -l region $argv[2]

    # check if SSH key of <name> exists
    aws secretsmanager describe-secret \
        --secret-id $keyName \
        --region $region >/dev/null 2>&1

    if test $status -ne 0
        echo "The SSH key $keyName does not exist, maybe try another region?"
        return 1
    end

    # create ~/.ssh/ dir if it doesn't exist
    if not test -d ~/.ssh
        mkdir -m 700 ~/.ssh
    end

    # if private key file already exists
    if test -e $privateKey
        mv $privateKey $privateKey"."(date +%s)".old"
    end

    # if public key file already exists
    if test -e $publicKey
        mv $publicKey $publicKey"."(date +%s)".old"
    end

    # export SSH key & write to file
    touch $privateKey
    chmod go-rx $privateKey

    aws secretsmanager get-secret-value \
        --secret-id $keyName \
        --query SecretBinary \
        --output text \
        --region $region | base64 --decode >>$privateKey

    # create public key from private key
    echo "Please enter password for this SSH key:"
    ssh-keygen -y -f $privateKey >$publicKey
    chmod 644 $publicKey

    # add new private key to ssh-agent
    ssh-add -K $privateKey

    echo "Keys were created at $privateKey (600) & $publicKey (644). Private key was added to ssh-agent."
    echo "You're all set now, well, you should be :)"

end