# Suppress interactive prompt, see details at
# https://askubuntu.com/questions/1367139/apt-get-upgrade-auto-restart-services
sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' /etc/needrestart/needrestart.conf

# Update libraries and set time zone
sudo apt update
sudo apt-get upgrade
sudo timedatectl set-timezone America/Los_Angeles

##############################
## attach scratch space     ##
##############################
# Create mountpoint for additional storage volume
cd /
sudo mkdir workspace

# Mount ephemeral storage
cd
sudo mkfs -t ext4 /dev/nvme1n1
sudo mount /dev/nvme1n1 /workspace

# Make ephemeral storage mounts persistent
# See http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html for guidance on setting up fstab records for AWS
uuid=$(sudo lsblk -f|grep nvme1n1|awk '{print $4}')

echo -e "LABEL=cloudimg-rootfs / ext4 defaults,discard 0 0\nUUID=${uuid} /workspace ext4 defaults,nofail 0 2" | sudo tee /etc/fstab


# Change permissions on required drives
sudo chown -R ubuntu:ubuntu /workspace

# Create symlink to the added volume in your home directory
cd ~
ln -s /workspace workspace

#############################
## password ##
#############################
sudo passwd ubuntu #interactively type password

##############################
##          ohmyzsh         ##
##############################

# install
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# verify version
zsh --version #5.8.1

# make default shell if not applied via script
chsh -s $(which zsh)
# test it is default
echo $SHELL

# copy .zshrc custom settings
code ~/.zshrc

# syntax highlightting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

##############################
##           git            ##
##############################
git config --global user.name "Victor Yuan"
git config --global user.email vyuan@sonomabio.com


##############################
##  install python          ##
##############################
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh

##############################
## install R and Rstudio
##############################

# update indices
sudo apt update -qq
# install two helper packages we need
sudo apt install --no-install-recommends software-properties-common dirmngr
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# Update ubuntu package repo, to get latest R
sudo apt update

# Install R
sudo apt install --no-install-recommends r-base r-base-dev

# Install RStudio-server
## Install debian package manager, gdebi
sudo apt install gdebi-core

# see https://jagg19.github.io/2019/08/aws-r/ for details
wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.04.0-735-amd64.deb
sudo gdebi rstudio-server-2024.04.0-735-amd64.deb
sudo rm rstudio-server-2024.04.0-735-amd64.deb

# Install R packages
# Dependencies for R packages like RMariaDB, devtools, tidyverse, sparklyr
sudo apt -y install libcurl4-openssl-dev 
sudo apt -y install libssl-dev libxml2-dev libmariadb-dev build-essential libcurl4-gnutls-dev 
sudo apt -y install libfontconfig1-dev libharfbuzz-dev libfribidi-dev
sudo apt -y install libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev
sudo apt -y install libcairo2-dev libxt-dev Cmake
sudo apt -y install libxml2-dev libfontconfig1-dev
sudo apt -y install libproj-dev 

R -e "source('setup.R')"

# install radian
conda install -c conda-forge radian
echo "alias r=\"radian\"" >> ~/.zshrc   

##############################
##      install docker      ##
##############################
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# install docker packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# sudo docker run hello-world

##############################
##      install aws cli     ##
##############################
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
