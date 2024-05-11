
cd iot_lambda_app

npm install

npx jest


cd ../terraform

terraform init

terraform plan -out=plan.out

terraform apply "plan.out"

