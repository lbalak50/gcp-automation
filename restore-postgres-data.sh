if [ -z "$FOLDER" ] || [ -z "$HOST" ] || [ -z "$USERNAME" ] || [ -z "$PGPASSWORD" ] || [ -z "$DEFAULT_DATABASE" ]; then
    echo 'Please pass FOLDER, HOST, USERNAME, PGPASSWORD, DEFAULT_DATABASE'
else
    cd $FOLDER
    for f in "."/*; do
        FILE_NAME=$(echo $f | cut -b 3-)
        DATABASE=$(echo $FILE_NAME | cut -d "." -f 1)
        echo 'Dropping database: '$DATABASE
        psql -h $HOST -U $USERNAME -d $DEFAULT_DATABASE -c 'drop database '$DATABASE
        echo 'Creating database: '$DATABASE
        psql -h $HOST -U $USERNAME -d $DEFAULT_DATABASE -c 'create database '$DATABASE
        echo 'Storing started for file: '$FILE_NAME
        echo 'Restoring started for database: '$DATABASE
        psql -h $HOST -U $USERNAME -d $DATABASE < $FILE_NAME
    done
    cd ..
fi