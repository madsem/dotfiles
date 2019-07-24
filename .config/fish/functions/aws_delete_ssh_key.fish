# delete ssh key named <path> in <region> of aws secrets manager
function aws_delete_ssh_key --description '<path> <region>'

    if test (count $argv) -ne 2
        echo "<path> and <region> are required."
        return 1
    end

    # remove expanded $HOME from key file path
    # because keys are saved with names
    # that don't include the user name
    set -l keyName (string replace $HOME '' $argv[1])

    aws secretsmanager delete-secret \
        --secret-id $keyName \
        --recovery-window-in-days 30 \
        --region $argv[2] >/dev/null 2>&1

    if test $status -eq 0
        echo "$keyName was successfully deleted, you have 30 days to recover it."
    end

end