# Exports all databases data from a Cloud SQL instance to a Google Cloud Storage bucket as a SQL dump file

if [ -z "$BUCKET_URI" ] || [ -z "$INSTANCE_ID" ]; then
    echo 'Please pass Bucket URI and Instance ID'
else
    gcloud auth login
    echo 'Bucket URI '$BUCKET_URI
    echo 'Instance ID '$INSTANCE_ID
    databases=$(gcloud sql databases list -i $INSTANCE_ID | awk 'NR>1 {print $1}')
    for database in $databases; do
        fileName=$BUCKET_URI'/'$database'_'$(date +%d-%b-%Y-%H:%M:%S)
        gcloud sql export sql $INSTANCE_ID $fileName --database $database
    done
fi
