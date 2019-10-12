#Makefile
AWS_ACCOUNT ?= "10000000"
AWS_ROLE ?= "Jenkins-Local-Admin"
KEY ?= "id_rsa.test"
CERT_NAME ?= "stunnel"
.PHONY: all

all: init plan build

init:
	rm -rf .terraform/modules/
	terraform init -reconfigure

getkeys:
	bash ../../scripts/getkeys.sh ${AWS_ROLE} ${AWS_ACCOUNT} ${KEY}
	chmod 600 ${KEY}

createCert:
	openssl req -x509 -newkey rsa:4096 -keyout ${CERT_NAME}-key.pem -out ${CERT_NAME}.pem \
	 	-days 365 -nodes -subj '/CN=localhost.com'
	bash ../../scripts/uploadCerts.sh ${AWS_ROLE} ${AWS_ACCOUNT} ${CERT_NAME}

getCerts:
	bash ../../scripts/getCerts.sh ${AWS_ROLE} ${AWS_ACCOUNT} ${CERT_NAME}

fix:
	chmod 600 ./id_rsa*

plan: init getkeys fix
	terraform plan -refresh=true
	rm -rf id_rsa.*

build: getkeys fix
	terraform apply -auto-approve
	rm -rf id_rsa.*

check: getkeys fix init
	terraform plan -detailed-exitcode

destroy: getkeys init
	terraform destroy -force

docs:
	terraform-docs md . > README.md

valid:
	tflint
	terraform fmt -check=true -diff=true
