# For setting up EC2 instance

1. Create EC2
I created an instance with the following specs, with scRNAseq analysis in mind:

Instance Name: Martin 2019 scRNAseq IBD
| OS | Ubuntu 22.04 |
| key pair name | victor-sonoma-thinkpad |
| Instance type | r6a.2xlarge |
| volumes | sda1 8 Gib, sdb 200 GiB |

For accessing rstudio-server, set security group to allow incoming traffic with following settings:
Port range:8787, TCP, 0.0.0.0/0

2. Login via terminal (linux)

<!--- I log in through ubuntu terminal (window subsytem linux, ubuntu 22) --->
chmod 400 [instructor-key].pem 
ssh -i [instructor-key].pem ubuntu@[public.ip.address]
#ssh -i "victor-sonoma-thinkpad.pem" ubuntu@ec2-52-38-2-61.us-west-2.compute.amazonaws.com 

3. Setup data mounts and install software
`sudo bash setup.sh`

4. Rstudio setup

Ensure incoming traffic is enabled (create new rule, add TCP, port 8787, and 0.0.0.0/0)
Install Rstudio server 
Add user / pw

# EC2 management tips
## Taking stock of compute resources within an Ubuntu Linux instance
#### How are storage volumes mounted?
`lsblk`

#### How much storage space in being used for various mount points?
`df -h`

#### Detailed description of hardware
`lshw`

#### See active resource usage right now with `top`.  Use `1` to see all CPUs individually.  Use `q` to exit
`top`

# Transferring data

[How to Move files in and out of an AWS EC2 Instance – Windows](https://asf.alaska.edu/how-to/data-recipes/moving-files-into-and-out-of-an-aws-ec2-instance-windows/)

I use PuTTY + winscp

Create PuTTY Private Key file (.ppk)

Then, in WinSCP, add new site with public DNS of EC2 instance. Under Advanced Site Settings, SSH, add .ppk file.

# Resources
[Griffith lab "Intro to AWS" workshop](https://rnabio.org/module-00-setup/0000/06/01/Intro_to_AWS/#how-much-does-it-cost-to-use-aws-ec2-resources)

[Running R on AWS EC2 and Logging into RStudio from Anywhere](https://jagg19.github.io/2019/08/aws-r/)