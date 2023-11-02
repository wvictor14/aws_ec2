# https://www.nextflow.io/docs/latest/getstarted.html
# install sdk man to install java
curl -s "https://get.sdkman.io" | bash
source "/home/ubuntu/.sdkman/bin/sdkman-init.sh" # or open new terminal
sdk install java 17.0.6-amzn

# download executable
wget -qO- https://get.nextflow.io | bash
chmod +x nextflow
sudo mv nextflow /usr/bin