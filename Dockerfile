FROM centos

RUN yum -y install initscripts MAKEDEV

RUN yum check

RUN yum -y update

RUN yum -y install openssh-server

RUN sed -ri 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config

RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

RUN systemctl start sshd.service

RUN passwd -d root

RUN echo 'root:academy_0033' | chpasswd

EXPOSE 22

CMD /sbin/init
