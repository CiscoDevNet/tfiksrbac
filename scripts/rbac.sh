sudo apt update
sudo apt install unzip -y
sudo apt install dos2unix -y
sudo apt install openjdk-8-jdk -y
sudo rm -rf /home/ec2-user
sudo mkdir -p /home/ec2-user/environment/workshop/
sudo chgrp -R iksadmin /home/ec2-user/
sudo chown -R iksadmin /home/ec2-user/

cp /tmp/devnet-controller-setup.zip /home/ec2-user/environment/workshop
kubectl delete secret accesssecret
unzip /home/ec2-user/environment/workshop/devnet-controller-setup.zip -d /home/ec2-user/environment/workshop
chmod +x /home/ec2-user/environment/workshop/setupWorkshop.sh
chmod +x /home/ec2-user/environment/workshop/teardownWorkshop.sh
chmod +x /home/ec2-user/environment/workshop/terminateApps.sh
chmod +x /home/ec2-user/environment/workshop/workshopPrereqs.sh
sed 's/nbrapm/'$1'/g' /tmp/workshop-setup.yaml > /tmp/workshop.file
sed 's/nbrma/'$2'/g' /tmp/workshop.file > /tmp/workshop1.file
sed 's/nbrsim/'$3'/g' /tmp/workshop1.file > /tmp/workshop2.file
sed 's/nbrnet/'$4'/g' /tmp/workshop2.file > /tmp/workshop3.file
cp /tmp/workshop3.file /home/ec2-user/environment/workshop/workshop-setup.yaml
export appd_workshop_user=SBUser
/home/ec2-user/environment/workshop/setupWorkshop.sh
#sudo -s
cd /home/ec2-user/environment/workshop
access="$(awk -v FS="APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=" 'NF>1{print $2}' /home/ec2-user/environment/workshop/application.env)"
#source application.env
echo $access > /tmp/accesskey
dos2unix /tmp/accesskey
kubectl create secret generic accesssecret --from-file=/tmp/accesskey
