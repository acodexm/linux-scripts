#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y git npm nodejs openjdk-11-jdk
echo `\nJAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"\nexport JAVA_HOME` | sudo tee /etc/environment

#Mongo
echo "installing MongoDB"

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo service mongod start


#Docker
echo "installing Docker"

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker $USER

#Fix hmr
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p


# Add templates
touch ~/Templates/Untitled.txt
touch ~/Templates/script.sh
touch ~/Templates/file
echo "#!/bin/bash" > ~/Templates/script.sh
sudo chmod 0755 ~/Templates/script.sh


#Yarn

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn


#Finish
echo "Script finished! Do you want to REBOOT SYSTEM??"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Reboot system"; reboot; break;;
        No )  echo "Exit script"; exit;;
    esac
done