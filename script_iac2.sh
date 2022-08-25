!# /bin/bash

if [[ $USER == root ]]
then
echo "Atualizando o sistema..."

apt-get update
apt-get upgrade -y

echo "fim da atualizacao"

echo "instalando pre requisitos..."


if ! [[ $(service apache2 status) == *"active (running)"* ]];
then
echo "Apache nao esta rodando! Instalando..."
	apt install apache2 -y
fi

echo "$(service apache2 status)"


if ! [ -x /usr/bin/unzip ] ; 
then
echo "Unzip nao encontrado! Instalando..."
	apt install unzip -y
fi

echo "fim da instalacao..."

if [[ -d /tmp ]]
then
echo "Mudando de pasta para /tmp"
cd /tmp
else
echo "Pasta /tmp nao encontrada!"
cd /
mkdir tmp
chmod 700 tmp
cd tmp
fi


if [ -x /usr/bin/wget ] ; 
then
if [ -f main.zip ]; 
then
echo "Main.zip encontrado no diretorio tmp! Removendo antes de baixar o novo"
rm -rf main.zip
fi
echo "Baixando main.zip do github!"
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
else
"Wget nao encontrado... Instalando!"
apt install wget -y
"Baixando main.zip do github!"
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
fi

if [ -f main.zip ]; 
then
unzip main.zip
else
echo "Main.zip nao encontrado! Ocorreu algum erro ao rodar o script...)"
exit 0
fi

if [ -d linux-site-dio-main ]; 
then
echo "Copiando arquivos da pasta linux-site-dio-main para /var/www/html"
cd linux-site-dio-main
cp -R * /var/www/html
else
echo "Pasta linux-site-dio nao encontrada! Ocorreu algum erro ao rodar o script...)"
exit 0
fi


echo "Script chegou ao fim com sucesso!"

else
echo "Script deve ser executado com usuario root"
fi
