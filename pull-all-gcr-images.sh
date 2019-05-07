# First login gcp
gcloud auth login 
# Login to gcr
gcloud auth configure-docker
images=$(gcloud container images list | sed -e "s/NAME//g")
subImages=$images
for image in $images
do
    subImages="$subImages $(gcloud container images list --repository=$image | sed -e 's/NAME//g')"
done

for subImage in $subImages
do
    docker pull $subImage:master
    docker pull $subImage:latest
done
