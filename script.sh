# Inspired from:
# - https://stackoverflow.com/a/71034328
# - https://github.com/shahzaib-sheikh/replace-env-vars/blob/master/replace-env-vars.sh

if [ $# -eq 2 ]; then
    echo "[+] Building enviroment variables"

    # Get contents of example file
    ENV_CONTENT=$(cat $1)

    # Output the content into sh script
    echo "#! /bin/bash
    echo \"
${ENV_CONTENT}
    \"" > ./env.sh

    # sed replace as key=${BITBUCKET_ENV_VARIABLE:-default_value_from_example}
    sed -i -E "s/^([A-Z_]+)=(.*)$/\1=\${\1:-\2}/g" ./env.sh

    chmod +x ./env.sh

    # Exec the env sh script and output content to .env file
    ./env.sh > $2

    # Remove env.sh file
    rm ./env.sh
else
    echo "not enough arguments"
    exit 1
fi