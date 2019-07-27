# override aws cli to use aws-vault automatically
# based on https://github.com/oh-my-fish/plugin-aws
function aws -a cmd -d 'Wrapper For AWS CLI to use AWS-Vault automatically'

    switch "$cmd"
        case profile
            if set -q argv[2]
                set -gx AWS_PROFILE "$argv[2]"

                # verify role was assumed
                eval aws-vault exec "$AWS_PROFILE" -- (which aws) sts get-caller-identity --output table

            else if set -q FILTER
                aws profiles | command env $FILTER | read -gx AWS_PROFILE
                echo $AWS_PROFILE
            else
                echo $AWS_PROFILE
            end

        case profiles
            command sed -n -e 's/^\[\(.*\)\]/\1/p' "$HOME/.aws/config"

        case '*'

            if test -z $AWS_PROFILE
                echo "No active profile found"
                echo "Set a profile with: aws profile <profile>"
                echo "See available profiles with: aws profiles"

                return 1
            else
                eval aws-vault exec $AWS_PROFILE -- (which aws) "$argv"
            end
    end

end