#!/bin/bash
#
# Instalação do Ica-AtoM -  Ubuntu LTS 14.04
#

echo "Bem-vindo à instalação do Ica-AtoM. Sua senha de usuário poderá ser solicitada algumas vezes."

# Verifica e instala MySQL
if which -a mysql
   then
   echo "O MYSQL JÁ ESTÁ INSTALADO"
   read -t 1
else
   echo "TENTANDO INSTALAR O MYSQL. SUA SENHA PODERÁ SER SOLICITADA"
   echo "VoCÊ TERÁ QUE DEFINIR UMA SENHA PARA O MYSQL. ELA SERÁ SOLICITADA DUAS VEZES"
   read -t 2
   sudo apt-get install -y mysql-server-5.5
fi

# Verifica se a instalação do MySQL foi bem sucedida
if which -a mysql
   then
   # Verifica se já existe o Java
   if which -a java
      then
      echo "JAVA JÁ ESTÁ INSTALADO"
      read -t 1
   else
      echo "TENTANDO INSTALAR O JAVA. SUA SENHA PODERÁ SER SOLICITADA"
      read -t 2
      sudo apt-get install -y openjdk-7-jre-headless
   fi
else
   echo "PROBLEMAS COM A INSTALAÇÃO DO MYSQL. CONSULTE A DOCUMENTAÇÃO"
fi

# Verifica se MySQL e Java foram instalados
if which -a mysql java
   then
   if [ -e elasticsearch-1.7.2.deb ]
   	then
   	echo "INICIANDO A INSTALAÇÃO DO ELASTICSEARCH..."
   	sudo dpkg -i elasticsearch-1.7.2.deb
   	sudo update-rc.d elasticsearch defaults
   	sudo /etc/init.d/elasticsearch start
   else
   	echo "INICIANDO O DOWNLOAD E A INSTALAÇÃO DO ELASTICSEARCH..."
   	read -t 2
   	wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.2.deb
   	sudo dpkg -i elasticsearch-1.7.2.deb
   	sudo update-rc.d elasticsearch defaults
   	sudo /etc/init.d/elasticsearch start
   fi
else
   echo "PROBLEMAS COM A INSTALAÇÃO DO MYSQL E/OU JAVA. CONSULTE A DOCUMENTAÇÃO"
fi

# Verifica se as dependências foram instaladas
if which -a mysql java #"$elastisearch"
   then
   sudo apt-get install -y nginx
   sudo touch /etc/nginx/sites-available/atom
   sudo ln -sf /etc/nginx/sites-available/atom /etc/nginx/sites-enabled/atom
   sudo rm /etc/nginx/sites-enabled/default
   sudo mv atom /etc/nginx/sites-enabled/
   sudo service nginx restart
else
   echo "PROBLEMA COM A INSTALAÇÃO DAS DEPENDÊNCIAS"
fi

# Verifica dependências
if which -a mysql java nginx #"$elastisearch"
   then
   if which -a php
      then
      echo "PHP JÁ ESTÁ INSTALADO"
   else
      echo "TENTANDO INSTALAR PHP E SEUS PACOTES..."
      sudo apt-get install -y php5-cli php5-fpm php5-curl php5-mysql php5-xsl php5-json php5-ldap php-apc
      sudo apt-get install -y php5-readline
      sudo mv atom.conf /etc/php5/fpm/pool.d/
      sudo service php5-fpm restart
      sudo php5-fpm --test
   fi
else
   echo "OCORREU ALGUM ERRO. CONSULTE A DOCUMENTAÇÃO"
fi

# Instalação de outros pacotes importantes
echo "PREPARANDO A INSTALAÇÃO DE ALGUNS OUTROS PACOTES..."
sudo apt-get install -y gearman-job-server
wget https://archive.apache.org/dist/xmlgraphics/fop/binaries/fop-1.0-bin.tar.gz
tar -zxvf fop-1.0-bin.tar.gz
rm fop-1.0-bin.tar.gz
mv fop-1.0 /usr/share
ln -s /usr/share/fop-1.0/fop /usr/bin/fop
sudo echo 'FOP_HOME="/usr/share/fop-1.0"' >> /etc/environment
sudo apt-get install -y imagemagick ghostscript poppler-utils
sudo add-apt-repository ppa:archivematica/externals
sudo apt-get update
sudo apt-get install -y ffmpeg

# Obtenção e instalação do Ica-AtoM
echo "OBTENDO E PREPARANDO A INSTALAÇÃO DO ATOM..."
wget https://storage.accesstomemory.org/releases/atom-2.2.1.tar.gz
echo "INICIANDO A INSTALAÇÃO DO ATOM..."
sudo mkdir /usr/share/nginx/atom
sudo tar xzf atom-2.2.1.tar.gz -C /usr/share/nginx/atom --strip 1
sudo chown -R www-data:www-data /usr/share/nginx/atom
sudo chmod o= /usr/share/nginx/atom

# Criação das tabelas no banco de dados
echo "AS TABELAS DO BANCO DE DADOS SERÃO CRIADAS AGORA. INSIRA A SENHA QUE VOCÊ DENIFIU PARA O MYSQL SEMPRE QUE SOLICITAD"
mysql -h localhost -u root -p -e "CREATE DATABASE atom CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
mysql -h localhost -u root -p -e "GRANT INDEX, CREATE, SELECT, INSERT, UPDATE, DELETE, ALTER, LOCK TABLES ON atom.* TO 'atom'@'localhost' IDENTIFIED BY '12345';"

# Orientações
echo "ACESSE http://localhost NO SEU NAVEGADOR FAVORITO E CONCLUA A INSTALAÇÃO DO ICA-ATOM ATRAVÉS DO WEB INSTALLER"
