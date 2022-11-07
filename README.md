# For setting up EC2 instance

1. Create EC2
I created an instance with the following specs, with scRNAseq analysis in mind:

Martin 2019 scRNAseq IBD (52.38.2.61)
| OS | Ubuntu 22.04 |
| key pair name | victor-sonoma-thinkpad |
| Instance type | r6a.2xlarge |
| volumes | sda1 8 Gib, sdb 200 GiB |

2. Login
chmod 400 [instructor-key].pem
ssh -i [instructor-key].pem ubuntu@[public.ip.address]
#ssh -i "victor-sonoma-thinkpad.pem" ubuntu@ec2-52-38-2-61.us-west-2.compute.amazonaws.com

3. Setup data mounts and install software
`sudo bash setup.sh`

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

# Resources
[Griffith lab "Intro to AWS" workshop](https://rnabio.org/module-00-setup/0000/06/01/Intro_to_AWS/#how-much-does-it-cost-to-use-aws-ec2-resources)