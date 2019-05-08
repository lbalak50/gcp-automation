# To run: aws_account_id=123456789012 sh generate-ecr-migration-commands-for-gcr-images.sh
# First make sure to download images from gcr (google container registery)
# Following will remove aws tags for gcr images as we are going to do again inside awk
docker images | grep $aws_account_id | awk '{print $1 ":" $2}' | xargs docker rmi
docker images | awk -v aws_account_id=$aws_account_id 'NR > 1 {
    imageName = $1;
    awsImageName = $1;

    gsub("gcr.io/","", imageName); 
    gsub("gcr.io/", aws_account_id ".dkr.ecr.ap-south-1.amazonaws.com/", awsImageName); 

    system("docker tag " $1 ":" $2 " " awsImageName ":" $2);
    system("echo " "aws ecr create-repository --region ap-south-1 --repository-name " imageName)
    system("echo " "docker push " awsImageName ":" $2);
    }' > /data/scripts/ecr-push-commands.sh # change this as per your needs

# after this you can run: sh /data/scripts/ecr-push-commands.sh for actual migration