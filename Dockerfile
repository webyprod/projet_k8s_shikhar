FROM centos:7
RUN yum install -y httpd zip unzip
ADD https://templatemo.com/tm-zip-files-2020/templatemo_598_sleeky_pro.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip photogenic.zip
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80 443