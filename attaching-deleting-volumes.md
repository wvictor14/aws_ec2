# Stolen from Frank

## EC2 

### Attach a volume 

```bash
# 1. attach from EC2 console 
# 2. lsblk find block 
lsblk 
# 3. format the disk 
sudo mkfs -t ext4 /dev/nvme{n}n{n}
# 4. mount 
sudo mount /dev/nvme{n}n{n} ~/data 
# 5. change owner
sudo chown -R ubuntu:ubuntu ~/data
```

### Delete a volume 

```bash
# 1. umount
sudo umount data 

# 2. detach 
aws ec2 detach-volume --volume-id {VOLUME-ID} # replace with the volume id 

# 3. delete volume 
aws ec2 delete-volume --volume-id {VOLUME-ID} # replace with the volume id 
```