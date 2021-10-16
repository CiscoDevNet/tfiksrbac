#!/bin/bash


function parse_input() {
  # jq reads from stdin so we don't have to set up any inputs, but let's validate the outputs
  eval "$(jq -r '@sh "export APP_NAME=\(.appname)  URL=\(.url) ACC_KEY=\(.accesskey) CLIENT_SECRET=\(.clientsecret) CLIENT_ID=\(.clientid) JVER=\(.jver)"')"
  if [[ -z "${APP_NAME}" ]]; then export APP_NAME=none; fi
  if [[ -z "${ACC_KEY}" ]]; then export ACC_KEY=none; fi
  if [[ -z "${JVER}" ]]; then export JVER=none; fi
  if [[ -z "${URL}" ]]; then export URL=none; fi
  if [[ -z "${CLIENT_ID}" ]]; then export CLIENT_ID=none; fi
  if [[ -z "${CLIENT_SECRET}" ]]; then export CLIENT_SECRET=none; fi
}

#function parse_input() {
  # jq reads from stdin so we don't have to set up any inputs, but let's validate the outputs
#  eval "$(jq -r '@sh "export NBRAPM=\(.nbrapm)  NBRMA=\(.nbrma) NBRSIM=\(.nbrsim) NBRNET=\(.nbrnet)"')"
#  if [[ -z "${NBRAPM}" ]]; then export NBRAPM=none; fi
#  if [[ -z "${NBRMA}" ]]; then export NBRMA=none; fi
#  if [[ -z "${NBRSIM}" ]]; then export NBRSIM=none; fi
#  if [[ -z "${NBRNET}" ]]; then export NBRNET=none; fi
#}

parse_input

#apt install dos2unix -y
#rm -rf /home/ec2-user
#mkdir -p /home/ec2-user/environment/workshop/
#cp /tmp/devnet-controller-setup.zip /home/ec2-user/environment/workshop
#cd /home/ec2-user/environment/workshop
#unzip /home/ec2-user/environment/workshop/devnet-controller-setup.zip -d /home/ec2-user/environment/workshop
#chmod +x /home/ec2-user/environment/workshop/*.sh
#sed 's/nbrapm/'${NBRAPM}'/g' /tmp/workshop-setup.yaml > /tmp/workshop.file
#sed 's/nbrma/'${NBRMA}'/g' /tmp/workshop.file > /tmp/workshop1.file
#sed 's/nbrsim/'${NBRSIM}'/g' /tmp/workshop1.file > /tmp/workshop2.file
#sed 's/nbrnet/'${NBRNET}'/g' /tmp/workshop2.file > /tmp/workshop3.file
#cp /tmp/workshop3.file /home/ec2-user/environment/workshop/workshop-setup.yaml
#export appd_workshop_user=SBUser
#/home/ec2-user/environment/workshop/setupWorkshop.sh
#dos2unix /home/ec2-user/environment/workshop/application.env
#. /home/ec2-user/environment/workshop/application.env
#echo $APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY > /tmp/accesskey

download="zzz"
install="yyy"
jq -n  '{"branch":"branch", "commit":"commit"}'
#echo -n "{\"download\":${download}, \"install\":${install}}" | tr -d ']['
#echo -n "{\"download\":${download}, \"install\":${install}}" | tr -d ']['
#echo -n "{\"download\":aaa, \"install\":yyy }" | tr -d ']['
#END
