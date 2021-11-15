FROM centos:7

COPY ./scripts* /root/scripts

# install base
RUN yum -y update

# install required packages
RUN yum install -y sudo firefox

RUN /root/scripts/config/system/createUser.sh "kai" "centos"

