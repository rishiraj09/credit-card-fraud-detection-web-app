#!/bin/#!/usr/bin/env bash

tar -xf deploy.tar.xz

echo " UPDATING PYTHON CONFIGURATION "
sudo apt-get install python3-pip
sudo pip3 install flask
sudo pip3 install psycopg2
sudo pip3 install psycopg2-binary
pip3 install Flask_SQLAlchemy
pip3 install numpy
pip3 install pandas
pip3 install matplotlib
pip3 install seaborn
pip3 install scipy

echo " INSTALLING AND CONFIGURING POSTGRESQL "
sudo apt-get install postgresql postgresql-contrib
sudo -i -u postgres psql -d template1 -c "alter user postgres with password 'admin';"
sudo -i -u postgres psql -d template1 -c "CREATE DATABASE mluser;"
chmod 777 tableconfig.py
python3 tableconfig.py
sudo -i -u postgres psql -d mluser -c "insert into ml_user (id, username, password) values (1,'admin', md5('admin'));"

echo " Running Credit Card Fraud Detection app"
sudo chmod 777 ref.sh
python3 app.py
