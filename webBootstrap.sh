#!/bin/bash
webCurrDir=$PWD

if [ "$EUID" -ne 0 ]
  then echo "Please run as root or under sudo"
  exit -1
fi

if [ -z "$1" ]; then
   branch=master
else
  branch=$1
fi

#INITIAL BASIC TOOLS INSTALL
yum update -y

#INSTALL GIT
yum install git -y

#Set Cloning Properties
pkg=Web
gitRepo="linux-scripts-apps-web.git"
installDir="/tmp/scripts/apps/WEB"
if [ -f ~/.ssh/gitHub.key ]; then
   clone="git clone -b $branch git@github.com:RMelanson/"
else
   clone="git clone -b $branch https://github.com/RMelanson/"
fi

# Clone $pkg
echo Executing $clone$gitRepo $installDir
$clone$gitRepo $installDir

exit 1

# Setup $pkg
cd $installDir
. ./setup.sh

cd $webCurrDir