FROM registry.access.redhat.com/ubi8/ubi:8.4-211

#RUN yum check-update; \
#    yum install -y gcc libffi-devel python3 epel-release; \
#    yum install -y python3-pip; \
#    yum install -y openssh-server openssh-clients sshpass; \
#    yum clean all

COPY openssh-clients-8.0p1-6.el8_4.2.x86_64.rpm /install/
COPY sshpass-1.06-3.el8ae.x86_64.rpm /install/

RUN yum install -y gcc openssl-devel bzip2-devel libffi-devel zlib-devel python3
RUN yum install -y python3-pip
RUN yum install -y /install/openssh-clients-8.0p1-6.el8_4.2.x86_64.rpm
RUN yum install -y /install/sshpass-1.06-3.el8ae.x86_64.rpm
RUN yum clean all

#RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
#RUN dnf update
#RUN dnf install -y gcc openssl-devel bzip2-devel libffi-devel zlib-devel python3
#RUN dnf install -y python3-pip
##RUN systemctl start sshd
##RUN dnf install -y openssh-server
##RUN dnf install -y openssh-clients
#RUN dnf install -y sshpass
#RUN dnf clean all

RUN pip3 install --upgrade pip; \
    pip3 install ansible==4.1.0 --no-cache-dir; \
    pip3 install pypsrp --no-cache-dir; \
    pip3 install pywinrm --no-cache-dir; \
    pip3 install requests-credssp --no-cache-dir; \
    pip3 install docker --no-cache-dir;

COPY hosts /etc/ansible/
COPY ansible.cfg /etc/ansible/