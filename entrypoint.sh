#!/bin/bash

#set -e

#MONGO_URL=$1
BASE_PATH=127.0.0.1
DEPLOYMENT=production
echo $MONGO_URL
#echo ${MONGO_URL}
echo $MONGO_CONN_STR
MONGO_URL=$MONGO_CONN_STR
echo $MONGO_URL

#cp -r portal/.routes.bak portal/routes
#wget $MONGO_CERT

#cd /app

for file in  accounts authentication portal bills transactions userbase
do
    cd $file
    cp .env.example .env
    sed -i "s!<YOUR_MONGODB_CONNECTION_STRING>!$MONGO_URL!" .env
    sed -i "s!<YOUR_PUBLIC_IP_ADDRESS>!$BASE_PATH!" .env
    cd ..
done

#/sbin/init

ps -ef | grep ssh

echo -e "#!/bin/bash\ncd /app\nnpm start" > /etc/rc.local
chmod +x /etc/rc.local

exec /sbin/init
