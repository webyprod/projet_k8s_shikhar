# FROM centos:7
# RUN yum install -y httpd zip unzip
# ADD https://templatemo.com/tm-zip-files-2020/templatemo_598_sleeky_pro.zip /var/www/html/
# WORKDIR /var/www/html/
# RUN unzip photogenic.zip
# RUN cp -rvf photogenic/* .
# RUN rm -rf photogenic photogenic.zip
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# EXPOSE 80 443

FROM centos:7

# Corriger les dépôts CentOS 7 vers vault.centos.org
RUN sed -i 's|^mirrorlist=|#mirrorlist=|g; s|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo \
    && yum clean all \
    && yum install -y httpd zip unzip curl \
    && yum clean all

# Télécharger le fichier via curl (plus fiable que ADD avec URL)
RUN curl -fSL https://templatemo.com/tm-zip-files-2020/templatemo_598_sleeky_pro.zip -o /tmp/template.zip

WORKDIR /var/www/html/

# Décompresser et déplacer les fichiers
RUN unzip /tmp/template.zip -d /tmp/template \
    && cp -rvf /tmp/template/* . \
    && rm -rf /tmp/template /tmp/template.zip

EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
