#!/usr/bin/env bash

while getopts p:u:t:r:w: option
  do
  case "${option}"
  in
    p) AWSProfile=${OPTARG};;
    u) GitHubUsername=${OPTARG};;
    t) GitHubToken=${OPTARG};;
    r) GitHubRepoName=${OPTARG};;
    w) Website=${OPTARG};;
  esac
done

# Configuration
StackName=${GitHubRepoName}-pipeline
TemplateFile=packaged-${StackName}-template.yaml
BucketName=${StackName}
WebsiteBucketName=${Website}

aws s3 --profile ${AWSProfile} mb s3://${BucketName}

# Package and deploy
aws cloudformation package \
--profile ${AWSProfile} \
--template-file service.yaml \
--s3-bucket ${BucketName} \
--output-template-file ${TemplateFile}

aws cloudformation deploy \
--profile ${AWSProfile} \
--stack-name ${StackName} \
--template-file ${TemplateFile} \
--parameter-overrides \
"GitHubUsername=${GitHubUsername}" \
"GitHubToken=${GitHubToken}" \
"GitHubRepoName=${GitHubRepoName}" \
"WebsiteBucketName=${WebsiteBucketName}" \
--s3-bucket ${BucketName} \
--capabilities CAPABILITY_IAM
