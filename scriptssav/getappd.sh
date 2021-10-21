#!/bin/bash


function parse_input() {
  # jq reads from stdin so we don't have to set up any inputs, but let's validate the outputs
  eval "$(jq -r '@sh "export NBRAPM=\(.nbrapm)  NBRMA=\(.nbrma) NBRSIM=\(.nbrsim) NBRNET=\(.nbrnet)"')"
  if [[ -z "${NBRAPM}" ]]; then export NBRAPM=none; fi
  if [[ -z "${NBRMA}" ]]; then export NBRMA=none; fi
  if [[ -z "${NBRSIM}" ]]; then export NBRSIM=none; fi
  if [[ -z "${NBRNET}" ]]; then export NBRNET=none; fi
}

echo "An error message" > /dev/stderr
parse_input
#echo "syarting"
#apt install dos2unix -y
cp ./scripts/devnet-controller-setup.zip /tmp
cp ./scripts/workshop-setup.yaml /tmp
#rm -rf /home/ec2-user
mkdir -p /home/ec2-user/environment/workshop/
cp /tmp/devnet-controller-setup.zip /home/ec2-user/environment/workshop
cd /home/ec2-user/environment/workshop
#unzip ./scripts/devnet-controller-setup.zip -d /home/ec2-user/environment/workshop
unzip /home/ec2-user/environment/workshop/devnet-controller-setup.zip -d /home/ec2-user/environment/workshop
chmod +x /home/ec2-user/environment/workshop/*.sh
sed 's/nbrapm/'${NBRAPM}'/g' /tmp/workshop-setup.yaml > /tmp/workshop.file
sed 's/nbrma/'${NBRMA}'/g' /tmp/workshop.file > /tmp/workshop1.file
sed 's/nbrsim/'${NBRSIM}'/g' /tmp/workshop1.file > /tmp/workshop2.file
sed 's/nbrnet/'${NBRNET}'/g' /tmp/workshop2.file > /tmp/workshop3.file
cp /tmp/workshop3.file /home/ec2-user/environment/workshop/workshop-setup.yaml
export appd_workshop_user=SBUser
/home/ec2-user/environment/workshop/setupWorkshop.sh
#dos2unix /home/ec2-user/environment/workshop/application.env
#. /home/ec2-user/environment/workshop/application.env
#echo $APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY > /tmp/accesskey
#access="$(grep -Po '(?<=^APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=)\w*$' /home/ec2-user/environment/workshop/application.env)"
access="$(awk -v FS="APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=" 'NF>1{print $2}' /home/ec2-user/environment/workshop/application.env)"


echo -n "{\"accesskey\":\"${access}\"}"




#access="$(echo $APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY)"
access="testing"
#echo -n "{\"download\":${download}, \"install\":${install}}" | tr -d ']['
#echo -n "{\"accesskey\":thisisit}" | tr -d ']['
#echo -n "{\"download\":${download}, \"install\":${install}}" | tr -d ']['
#echo -n "{\"accesskey\":${access}}" | tr -d ']['
#echo -n "{\"accesskey\":\"aaa\"}" | tr -d ']['
#echo -n "{\"accesskey\":\"${access}\"}"
#echo -n "{\"accesskey\":\"aaa\", \"install\":\"yyy\" }" | tr -d ']['
#END
