#!/bin/bash

#
# Utility script to initialize the workshop prerequisites on the Cloud9 EC2 instance
#
# 
#
# NOTE: All inputs are defined by external environment variables.
#       Optional variables have reasonable defaults, but you may override as needed.
#---------------------------------------------------------------------------------------------------

#set -x  # turn command display back ON.

##### Increase the EBS disk size to 80GB

# Rewrite the partition table so that the partition takes up all the space that it can.
#sudo growpart /dev/nvme0n1 1

# Expand the size of the file system.
#sudo xfs_growfs -d /



