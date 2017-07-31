#!/bin/bash
BASEDIR=/root/sar

SAR_GIT_URL=https://github.com/CatalystCode/cell-sar.git
LOGFILE=/boot/bootstrapper.log

# Colors and Styling
RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'

if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}The Search and Rescue Installer script must be run as root.${RESTORE}"
   exit 1
fi

# ---=[ PREREQUISITES ]=--- #
echo -e "${BLUE}+ Retrieving and installing required packages from Aptitude.${RESTORE}"
apt-get -y install git >> "${LOGFILE}" 2>&1

# ---=[ ACQUIRE PACKAGES ]=--- #
echo -e "${BLUE}+ Downloading packages...${RESTORE}"

if [[ ! -d "${BASEDIR}" ]]; then
	echo -e "${BLUE}	+ Cloning cell-sar from ${SAR_GIT_URL}...${RESTORE}"
	git clone "${SAR_GIT_URL}" "${BASEDIR}" >> "${LOGFILE}" 2>&1
else
	echo -e "${YELLOW}		! SAR git repository exists, skipping.${RESTORE}"
fi

# ---=[ XFER CONTROL ]=---
echo -e "${BLUE}+ Transferring control to installer...${RESTORE}"

${BASEDIR}/devops/installer.sh > /boot/install.log 2>&1