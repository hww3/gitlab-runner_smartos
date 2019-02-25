#!/bin/sh

USERNAME=gitlab-runner
GROUP=gitlab-runner
TARBALL_URL=http://bill.welliver.org/dist/gitlab-runner.tar.gz
touch /.configuring

pkgin update
pkgin -y in wget smtools build-essential
pkgin -y keep wget smtools build-essential

groupadd $GROUP
useradd -g $GROUP -m -s /usr/bin/bash -d /home/$USERNAME $USERNAME

cd /opt
wget $TARBALL_URL -O - |tar zxv
ls -l /opt
touch /var/log/gitlab_runner.log && chown gitlab-runner:gitlab-runner /var/log/gitlab_runner.log

svccfg import /opt/gitlab-runner/gitlab-runner.xml
/usr/sbin/svcadm enable -r svc:/application/gitlab-runner:default

/usr/sbin/svcadm disable inetd
/usr/sbin/svcadm disable pfexec

pkgin -y ar

rm /.configuring
