#!/bin/bash

#     ▄███████▄ ███    █▄     ▄████████    ▄█    █▄    ▀█████████▄  ███    █▄   ▄█        ▄█          ▄████████     ███     
#    ███    ███ ███    ███   ███    ███   ███    ███     ███    ███ ███    ███ ███       ███         ███    ███ ▀█████████▄ 
#    ███    ███ ███    ███   ███    █▀    ███    ███     ███    ███ ███    ███ ███       ███         ███    █▀     ▀███▀▀██ 
#    ███    ███ ███    ███   ███         ▄███▄▄▄▄███▄▄  ▄███▄▄▄██▀  ███    ███ ███       ███        ▄███▄▄▄         ███   ▀ 
#  ▀█████████▀  ███    ███ ▀███████████ ▀▀███▀▀▀▀███▀  ▀▀███▀▀▀██▄  ███    ███ ███       ███       ▀▀███▀▀▀         ███     
#    ███        ███    ███          ███   ███    ███     ███    ██▄ ███    ███ ███       ███         ███    █▄      ███     
#    ███        ███    ███    ▄█    ███   ███    ███     ███    ███ ███    ███ ███▌    ▄ ███▌    ▄   ███    ███     ███     
#   ▄████▀      ████████▀   ▄████████▀    ███    █▀    ▄█████████▀  ████████▀  █████▄▄██ █████▄▄██   ██████████    ▄████▀   

#################################################################
# Ce script permet d'envoyer divers commande à l'API PushBullet #
#################################################################

# Liste les périphériques

list_device () {
curl --header 'Access-Token: '$1 https://api.pushbullet.com/v2/devices | jq .
}

# Envoie un push à tout les device

push_commun () {
r=$(curl -i -u $1: -H "Accept: application/json" -X POST -d "type=note" -d "title=$2" -d "body=$3" https://api.pushbullet.com/v2/pushes > log)

}

# Envoie un push à un contact

push_contact () {
r=$(curl -i -u $1: -H "Accept: application/json" -X POST -d "type=note" -d "email=$4;" -d "title=$2" -d "body=$3" https://api.pushbullet.com/v2/pushes > log)
}

# Envoie un push à un device

push_device () {
r=$(curl -i -u $1: -H "Accept: application/json" -X POST -d "type=note" -d "iden=$4;" -d "title=$2" -d "body=$3" https://api.pushbullet.com/v2/pushes > log)
}

# Liste les push

list_push () {
let b=$(date +"%s")-3600
if [ "$2" == "" ]; then ts=$b; else ts=$2; fi
curl --header 'Access-Token: '$1 --data-urlencode active="true" --data-urlencode modified_after="$ts" --get https://api.pushbullet.com/v2/pushes | jq . 
}

if [ "$1" == "--list_device" ]; then list_device $2; fi
if [ "$1" == "--push_commun" ]; then push_commun $2 "$3" "$4"; fi
if [ "$1" == "--push_contact" ]; then push_contact $2 "$3" "$4" $5; fi
if [ "$1" == "--push_device" ]; then push_device $2 "$3" "$4" $5; fi
if [ "$1" == "--list_push" ]; then list_push $2 $3; fi
