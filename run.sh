sam package --template-file template.yaml --output-template-file pck.yml --s3-bucket onlinejavaclass-newsletter
sam deploy --region eu-central-1 --capabilities CAPABILITY_IAM --template-file pck.yml  --stack-name aws-newsletter
