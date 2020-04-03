#以nginx为基础镜像
FROM nginx:1.16.1

MAINTAINER cshimu@foxmail.com

#======安装nodejs
#将nodejs安装包上传到Docker 上
ADD node-v8.10.0-linux-x64.tar.xz /usr/local

#设置环境变量
ENV PATH $PATH:/usr/local/node-v8.10.0-linux-x64/bin
#ENV DEBIAN_FRONTEND noninteractive
ENV APP_ROOT /app/web
ENV PATH /usr/local/nginx/sbin:$PATH


# 安装npm，建立软链接，建立软链接，创建根目录，安装编译器
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
    
RUN npm install pm2 -g \
	&& ln -s /root/node-v10.14.2-linux-x64/bin/pm2 /usr/local/bin/

	

# 指定工作目录
VOLUME ["/etc/nginx/conf.d","/app/web"]
WORKDIR $APP_ROOT

#COPY nginx.conf /etc/nginx/nginx.conf

#RUN  mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak \
#     && mv /etc/nginx/nginx1.conf /etc/nginx/nginx.conf

#暴露出80和443端口
EXPOSE 80 443 8888

CMD ["nginx", "-g", "daemon off;"]
