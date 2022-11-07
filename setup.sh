# Suppress interactive prompt, see details at
# https://askubuntu.com/questions/1367139/apt-get-upgrade-auto-restart-services
sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' /etc/needrestart/needrestart.conf

# Update libraries and set time zone
sudo apt update
sudo apt-get upgrade
sudo timedatectl set-timezone America/Los_Angeles

##############################
## attach scratch space 
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


##############################
## install R packages
##############################

# install R
sudo apt-get -y install r-base-core r-cran-irkernel

# for devtools
sudo apt-get install build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev libgsl-dev libgeos-dev libcairo2-dev libxt-dev


cp .Renviron ~/
R -e "source('setup.R')"