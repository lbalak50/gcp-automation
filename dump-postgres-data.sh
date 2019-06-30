if [ -z "$HOST" ] || [ -z "$USERNAME" ] || [ -z "$DATABASES" ] || [ -z $PGPASSWORD ] || [ -z $FOLDER ]; then
    echo 'Please pass HOST, USERNAME, DATABASES, PGPASSWORD, FOLDER'
else
    IFS=',' read -ra ADDR <<<"$DATABASES"
    for i in "${ADDR[@]}"; do
        mkdir -p $FOLDER
        storePath=$FOLDER'/'
        fileName=$i'.sql'
        echo 'Dumping started for database '$i
        # pg_dump -Fc --no-owner --no-acl -h $HOST -U $USERNAME $i >$storePath$fileName
        pg_dump  --no-owner --no-acl -h $HOST -U $USERNAME $i >$storePath$fileName
        sed -i -- 's/COMMENT ON EXTENSION/-- COMMENT ON EXTENSION/g' $storePath$fileName
    done
fi
