apt install dos2unix -y
rm -rf /home/ec2-user
mkdir -p /home/ec2-user/environment/workshop/
cp /tmp/devnet-controller-setup.zip /home/ec2-user/environment/workshop 
#cd /home/ec2-user/environment/workshop
unzip /home/ec2-user/environment/workshop/devnet-controller-setup.zip -d /home/ec2-user/environment/workshop
chmod +x /home/ec2-user/environment/workshop/*.sh
sed 's/nbrapm/'$1'/g' /tmp/workshop-setup.yaml > /tmp/workshop.file
sed 's/nbrma/'$2'/g' /tmp/workshop.file > /tmp/workshop1.file
sed 's/nbrsim/'$3'/g' /tmp/workshop1.file > /tmp/workshop2.file
sed 's/nbrnet/'$4'/g' /tmp/workshop2.file > /tmp/workshop3.file
cp /tmp/workshop3.file /home/ec2-user/environment/workshop/workshop-setup.yaml
export appd_workshop_user=SBUser
/home/ec2-user/environment/workshop/setupWorkshop.sh
dos2unix /home/ec2-user/environment/workshop/application.env
. /home/ec2-user/environment/workshop/application.env
echo $APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY > /tmp/accesskey

