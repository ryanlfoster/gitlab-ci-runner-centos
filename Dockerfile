FROM centos:centos7
MAINTAINER recteurlp@keep-it.fr

ADD assets/ /app/

RUN yum update -y && yum install -y libyaml-devel libffi-devel glibc-headers autoconf gcc-c++ glibc-devel patch readline-devel zlib-devel bzip2 automake libtool bison which tar libicu-devel sudo git openssl-devel && \
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && \
\curl -sSL https://get.rvm.io | bash -s stable --ruby && \
useradd -c 'GitLab CI Runner' gitlab_ci_runner && \
rm -rf /usr/local/rvm/src && yum clean all && \
chmod -R 755 /app && \
/app/setup/install

VOLUME ["/home/gitlab_ci_runner/data"]

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
