FROM debian:8
MAINTAINER ranpanfeng ranpanfeng@bytedance.com

COPY sources.list /etc/apt/sources.list
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update --fix-missing -y 
RUN apt-get install -y --no-install-recommends --allow-unauthenticated perl
RUN apt-get install -y --no-install-recommends --allow-unauthenticated wget 
RUN apt-get install -y --no-install-recommends --allow-unauthenticated xzdec

COPY install-tl-20181222 /install-tl
COPY texlive.profile /texlive.profile
RUN  cd install-tl &&  ./install-tl -profile /texlive.profile

RUN tlmgr init-usertree
#RUN tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet
RUN tlmgr update --self
RUN tlmgr update --all
RUN tlmgr install ctex
#RUN tlmgr update --all --repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet
