#!/usr/bin/env bash
# yanne

#LABEL script to build docker image delete docker file and directory

echo "What name would you like your workspace dir to be called ?: "

read ifolder

mkdir ${ifolder} && cd ${ifolder} && touch dockerfile

echo "What is your base OS ? centos, alpine or ubuntu ?:"

read iname

if [ ${iname} != centos ] || [ ${iname} != alpine ] || [ ${iname} != ubuntu ]
then
echo "Please enter a valid choice between centos, alpine ubuntu"
exit 1
fi

echo "What port do you want to use ?: "

read p

echo "what version do you want to use ?: "

read MYV

if [[ ${iname} = centos ]];then
echo -e "FROM ${iname}:${MYV}""\nMAINTAINER ${USER}""\nEXPOSE ${p}""\nRUN yum update -y" > dockerfile
echo "Building ${iname} image."
 elif
 [[ ${iname} = alpine ]];then
 echo -e "FROM ${iname}:${MYV}""\nMAINTAINER ${USER}""\nEXPOSE ${p}""\nRUN apk update" > dockerfile
 echo "Building ${iname} image."
  else
  if
  [[ ${iname} = ubuntu ]]; then
  echo -e "FROM ${iname}:${MYV}""\nMAINTAINER ${USER}""\nRUN apt-get update -y""\nEXPOSE ${p}" > dockerfile
  echo "Building ${iname} image."
fi
 fi

docker image build -t ${USER}_${iname} .
if [[ $? -eq 0 ]];
then
rm -f dockerfile
cd -
rm -r ${ifolder}
echo -e  "${iname} image built successfully and dockerfile and directory deleted.\n Please run the docker images command to check"
exit 0
fi
