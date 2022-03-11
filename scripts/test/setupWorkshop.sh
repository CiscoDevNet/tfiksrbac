#!/bin/bash

#
# Utility script to initialize the workshop prerequisites on the Cloud9 EC2 instance
#
# export appd_workshop_user=JEIDI
#
# NOTE: All inputs are defined by external environment variables.
#       Optional variables have reasonable defaults, but you may override as needed.
#---------------------------------------------------------------------------------------------------

#set -x  # temporarily turn command display OFF.
#set +x  # turn command display back ON.


# [MANDATORY] workshop user identity.
# appd_workshop_user="${appd_workshop_user:-}"
appd_workshop_user="SBUser"

echo ""
echo ""
echo ""
echo ""

echo "           ######################################################################################################################################################################################################################"
echo "                                                                                                                                                                                                                                 "
echo "                                                                                                                                                                                                                                 "
echo "                %%%%%%%          %%%%%%%%%%%%%%%     %%%%%%%%%%%%%%%     %%%%%%%%%%%%%%%     %%%         %%%    %%%%%      %%%          %%%%%%%          %%%           %%%    %%%        %%%%%%%%%%%        %%%%%%%%%%%          "
echo "               %%%   %%%         %%%          %%%    %%%          %%%    %%%          %%%     %%%       %%%     %%% %%     %%%         %%%   %%%         %%%%         %%%%    %%%      %%%                 %%%                   "
echo "              %%%     %%%        %%%           %%%   %%%           %%%   %%%           %%%     %%%     %%%      %%%  %%    %%%        %%%     %%%        %% %%       %% %%    %%%     %%%                   %%%                  "
echo "             %%%       %%%       %%%          %%%    %%%          %%%    %%%            %%%     %%%   %%%       %%%   %%   %%%       %%%       %%%       %%% %%     %% %%%    %%%    %%%                      %%%                "
echo "            %%%%%%%%%%%%%%%      %%%%%%%%%%%%%%%     %%%%%%%%%%%%%%%     %%%            %%%       %%%%%         %%%    %%  %%%      %%%%%%%%%%%%%%%      %%%   %%  %%  %%%    %%%    %%%                        %%%              "
echo "           %%%           %%%     %%%                 %%%                 %%%           %%%         %%%          %%%     %% %%%     %%%           %%%     %%%    %%%%   %%%    %%%     %%%                        %%%             "
echo "          %%%             %%%    %%%                 %%%                 %%%          %%%          %%%          %%%      %%%%%    %%%             %%%    %%%           %%%    %%%      %%%                       %%%             "
echo "         %%%               %%%   %%%                 %%%                 %%%%%%%%%%%%%%%           %%%          %%%       %%%%   %%%               %%%   %%%           %%%    %%%        %%%%%%%%%%%   %%%%%%%%%%%%              "
echo "                                                                                                                                                                                                                                 "
echo "                                                                                                                                                                                                                                 "
echo "#######################################################################################################################################################################################################################          "

echo ""
echo ""
echo ""
echo ""

echo "########################################################################################    STARTING APPDYNAMICS CLOUD WORKSHOP PREREQUISITES    ################################################################################"

# check to see if we have the XFS file system
#df_output=$(df -khT)

#if [[ !$df_output != *"/dev/nvme0n1p1 xfs"* ]]; then
#  echo "CloudWorkshop|ERROR| - Oops, :(  it looks like you may have accidentally selected Amazon Linux instead of Amazon Linux 2 for the Platform option."
#  echo "CloudWorkshop|ERROR| - Please discard this Cloud9 instance and create a new one with the required Amazon Linux 2 Platform option."
#  #echo "$df_output"
#  exit 1
#fi


# check to see if user_id file exists and if so read in the user_id
if [ -f "/home/ec2-user/environment/workshop/appd_workshop_user.txt" ]; then

  appd_workshop_user=$(cat /home/ec2-user/environment/workshop/appd_workshop_user.txt)

else
  
  # validate mandatory environment variables.

  if [ -z "$appd_workshop_user" ]; then
    echo "CloudWorkshop|ERROR| - 'appd_workshop_user' environment variable not set or is not at least five alpha characters in length."
    exit 1
  fi

  LEN=$(echo ${#appd_workshop_user})

  if [ $LEN -lt 5 ]; then
    echo "CloudWorkshop|ERROR| - 'appd_workshop_user' environment variable not set or is not at least five alpha characters in length."
    exit 1
  fi


  if [ "$appd_workshop_user" == "<YOUR USER NAME>" ]; then
    echo "CloudWorkshop|ERROR| - 'appd_workshop_user' environment variable not set properly. It should be at least five alpha characters in length."
    echo "CloudWorkshop|ERROR| - 'appd_workshop_user' environment variable should not be set to <YOUR USER NAME>."
    exit 1
  fi


  # write the user_id to a file
  echo "$appd_workshop_user" > /home/ec2-user/environment/workshop/appd_workshop_user.txt

  # echo $USER = ec2-user

  # write the C9 user to a file     example:  james.schneider
  echo "$C9_USER" > /home/ec2-user/environment/workshop/appd_env_user.txt

  # write the Hostname to a file   example:  ip-172-31-14-237.us-west-1.compute.internal
  echo "$HOSTNAME" > /home/ec2-user/environment/workshop/appd_env_host.txt

fi	

# !!!!!!! BEGIN BIG IF BLOCK !!!!!!!
if [ -f "/home/ec2-user/environment/workshop/appd_workshop_setup.txt" ]; then

  appd_wrkshp_last_setupstep_done=$(cat /home/ec2-user/environment/workshop/appd_workshop_setup.txt)

  java -DworkshopUtilsConf=/home/ec2-user/environment/workshop/workshop-setup.yaml -DworkshopLabUserPrefix=${appd_workshop_user} -DworkshopAction=setup -DlastSetupStepDone=${appd_wrkshp_last_setupstep_done} -DshowWorkshopBanner=false -jar /home/ec2-user/environment/workshop/AD-Workshop-Utils.jar

else

#echo ""
#echo "CloudWorkshop|INFO| - Updating packages and Java JRE"
#echo ""

#set +x  # turn command display back ON.

##### Install Java 1.8

#set -x  # temporarily turn command display OFF.
#sudo yum -y update
#set +x  # turn command display back ON.

#echo "CloudWorkshop|INFO|     - Updating packages and Java JRE ....."

#set -x  # temporarily turn command display OFF.
#sudo rpm --import https://yum.corretto.aws/corretto.key
#set +x  # turn command display back ON.

#echo "CloudWorkshop|INFO|     - Updating packages and Java JRE ...."

#set -x  # temporarily turn command display OFF.
#sudo curl --silent -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
#set +x  # turn command display back ON.

#echo "CloudWorkshop|INFO|     - Updating packages and Java JRE ..."

#set -x  # temporarily turn command display OFF.
#sudo yum install -y java-1.8.0-amazon-corretto-devel
#set +x  # turn command display back ON.


#set -x  # temporarily turn command display OFF.
#java -version
#set +x  # turn command display back ON.

#echo "CloudWorkshop|INFO|     - Updating packages and Java JRE .."

##### Clone workshop repo

#set -x  # temporarily turn command display OFF.



#set +x  # turn command display back ON.

#echo ""
#echo "CloudWorkshop|INFO| - Finished Updating packages and Java JRE"
#echo ""

# write last setup step file
appd_wrkshp_last_setupstep_done="100"

echo "$appd_wrkshp_last_setupstep_done" > /home/ec2-user/environment/workshop/appd_workshop_setup.txt

java -DworkshopUtilsConf=/home/ec2-user/environment/workshop/workshop-setup.yaml -DworkshopLabUserPrefix=${appd_workshop_user} -DworkshopAction=setup -DlastSetupStepDone=${appd_wrkshp_last_setupstep_done} -DshowWorkshopBanner=false -jar /home/ec2-user/environment/workshop/AD-Workshop-Utils.jar

fi
# !!!!!!! END BIG IF BLOCK !!!!!!!
