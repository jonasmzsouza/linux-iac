#!/bin/bash

echo "Creating directories..."
mkdir /public
mkdir /adm
mkdir /ven
mkdir /sec

echo "Creating user groups..."
groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

echo "Creating users..."
useradd carlos -c "Carlos Silva" -m -s /bin/bash -p $(openssl passwd 1234567) -G GRP_ADM
useradd maria -c "Maria Sousa" -m -s /bin/bash -p $(openssl passwd 1234567) -G GRP_ADM
useradd joao -c "João Costa" -m -s /bin/bash -p $(openssl passwd 1234567) -G GRP_ADM

useradd debora -c "Debora Santos" -m -s /bin/bash -p $(openssl passwd 1234567) -G GRP_VEN
useradd sebastiana -c "Sebastiana Gomes" -m -s /bin/bash -p $(openssl passwd 1234567) -G GRP_VEN
useradd roberto -c "Roberto Pereira" -m -s /bin/bash -p $(openssl passwd 1234567) -G GRP_VEN

useradd josefina -c "Josefina Machado" -m -s /bin/bash -p $(openssl passwd 1234567) -G GRP_SEC
useradd amanda -c "Amanda Nunes" -m -s /bin/bash -p $(openssl passwd 1234567) -G GRP_SEC
useradd rogerio -c "Rogerio Oliveira" -m -s /bin/bash -p $(openssl passwd 1234567) -G GRP_SEC

echo "Specifying permissions to directories..."
chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /public

echo "End..."








