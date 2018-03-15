FROM amazonlinux:latest
LABEL amazonlinux
LABEL hahatake
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
RUN install -d /root/.ssh -m 0700

RUN yum install -y openssh-server aws-cli ec2-utils jq \
  && sed -i s/PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && sed -i s/PasswordAuthentication.*/PasswordAuthentication\ yes/ /etc/ssh/sshd_config \
  && sed -i s/#PermitUserEnvironment.*/PermitUserEnvironment\ yes/ /etc/ssh/sshd_config

ADD entrypoint.sh /entrypoint.sh
ADD environment /root/.ssh/environment

RUN ["yum",  "-y", "install", "httpd"]
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
