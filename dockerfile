FROM centos
MAINTAINER SRINIVAS
RUN yum update -y && yum install httpd -y &&yum install git -y
