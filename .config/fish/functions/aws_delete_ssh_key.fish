# delete ssh key named <path> in <region> of aws secrets manager
function aws_delete_ssh_key --description '<path> <region> [-f --force]'

    argparse 'f/force' -- $argv

    if test (count $argv) -lt 2
        echo "<path> and <region> are required."
        return 1
    end

    # remove expanded $HOME from key file path
    # because keys are saved with names
    # that don't include the user name
    set -l keyName (string replace $HOME '' $argv[1])

    # set arguments
    set -l arguments \
        "--secret-id $keyName" \
        "--region $argv[2] >/dev/null 2>&1"

    # either force delete, or make secret recoverable for 30 days (default)
    if set -q _flag_force
        set -a arguments "--force-delete-without-recovery"
    else
        set -a arguments "--recovery-window-in-days 30"
    end

    aws secretsmanager delete-secret $arguments

    switch "$status"
        case 0
            if set -q _flag_force
                echo "$keyName was force-deleted, and is not recoverable."
            else
                echo "$keyName was successfully deleted, you have 30 days to recover it."
            end

        case '*'
            echo "This secret doesn't exist."
            return 1
    end

end