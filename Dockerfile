FROM quay.io/baguette.io/baguette-base:latest
RUN apk add --no-cache gitolite openssh
# Config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
RUN sed -i 's@Subsystem\ssftp\s/usr/lib/ssh/sftp-server@Subsystem sftp no@g' /etc/ssh/sshd_config
# Entrypoint
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
#RUN sed -i 's/^AcceptEnv LANG LC_\*$//g' /etc/ssh/sshd_config
#RUN echo "Host 127.0.0.1" >> ~/.ssh/config
#RUN echo "    StrictHostKeyChecking no" >> ~/.ssh/config
