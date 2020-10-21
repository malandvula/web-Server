#!/bin/bash

# assign variables
ACTION=${1:-launch}
VERSION=1.0.0

function run() {
sudo yum update -y
sudo amazon-linux-extras install nginx1.12 -y
sudo chkconfig nginx on
sudo aws s3 cp s3://mala-assignment-webserver/index.html /usr/share/nginx/html/index.html
sudo service nginx start
}

function delete_stuff() {
sudo service nginx stop
sudo rm /usr/share/nginx/html/*.html
sudo yum remote nginx -y
}

function show_version() {
echo "$VERSION"
}

function display_help() {
cat << EOF

Usage: ${0} {""|-h|--help|-r|--remove|-v|--version}

OPTIONS:
	no input 	Default run
	-h | --help	Display the command help
	-r | --remove	Remove nginx files and services
	-v | --version	Version number displayed

Examples:
	Start webserver with index page:
		$ ${0}
	Display help commands
		$ ${0} -h
	Remove websever and pages:
		$ ${0} -r
	Show version number
		$ ${0} -v

EOF
}

case "$ACTION" in
	launch)
		run
		;;
	-r|--remove)
		delete_stuff
		;;
	-v|--version)
		show_version
		;;
	-h|--help)
		display_help
		;;
	*)
	exit 1
esac

