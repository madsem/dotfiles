# import the private ssh key under <path>
# into the AWS secrets manager with <path> as name
function aws_import_ssh_key --description '<path> <region>'

    if not test -e "$argv[1]"
        or test -z "$argv[2]"
        echo "The private key file at $argv[1] does not exist, or <region> is not set."
        return 1
    end

    set -l tmpFile ~/.tmpAwsKeyFile.txt

    # remove expanded $HOME from key file path
    # to save the key under a name that does
    # not depend on the user name
    set -l keyName (string replace $HOME '' $argv[1])

    touch $tmpFile
    chmod go-rx $tmpFile
    cat $argv[1] >>$tmpFile

    aws secretsmanager create-secret \
        --name $keyName \
        --description "private_SSH_key" \
        --secret-binary file://$tmpFile \
        --region $argv[2]

    shred -u $tmpFile

end