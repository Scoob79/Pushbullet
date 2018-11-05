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

# Aide

aide () {
echo "
     ▄███████▄ ███    █▄     ▄████████    ▄█    █▄    ▀█████████▄  ███    █▄   ▄█        ▄█          ▄████████     ███     
    ███    ███ ███    ███   ███    ███   ███    ███     ███    ███ ███    ███ ███       ███         ███    ███ ▀█████████▄ 
    ███    ███ ███    ███   ███    █▀    ███    ███     ███    ███ ███    ███ ███       ███         ███    █▀     ▀███▀▀██ 
    ███    ███ ███    ███   ███         ▄███▄▄▄▄███▄▄  ▄███▄▄▄██▀  ███    ███ ███       ███        ▄███▄▄▄         ███   ▀ 
  ▀█████████▀  ███    ███ ▀███████████ ▀▀███▀▀▀▀███▀  ▀▀███▀▀▀██▄  ███    ███ ███       ███       ▀▀███▀▀▀         ███     
    ███        ███    ███          ███   ███    ███     ███    ██▄ ███    ███ ███       ███         ███    █▄      ███     
    ███        ███    ███    ▄█    ███   ███    ███     ███    ███ ███    ███ ███▌    ▄ ███▌    ▄   ███    ███     ███     
   ▄████▀      ████████▀   ▄████████▀    ███    █▀    ▄█████████▀  ████████▀  █████▄▄██ █████▄▄██   ██████████    ▄████▀   

#################################################################
# Ce script permet d'envoyer divers commande à l'API PushBullet #
#################################################################

UtIlisation
 :
=============

Commande de base :
------------------

./pushbullet.sh --list_device   api_key                             Liste tout les périphériques sur le compte
./pushbullet.sh --push_commun   api_key titre message               Envoi un message à tout les périphériques
./pushbullet.sh --push_contact  api_key titre message adresse       Envoi un message à un contact
./pushbullet.sh --push_device   api_key titre message adresse       Envoi un message à un périphérique

Fonction avancées
 :
-------------------

Il est tout a fait possible d'effectuer des retour chariot en procédant comme suit :

./pushbullet.sh --push_commun 0.dsf4658dgd4fg8reg6565fdg \"Ceci est le titre de mon message\" \"Bonjour,
et voici mon message,
avec des retour de chariot\"
"
}

# Liste les périphériques

list_device () {
if [ -z $1 ]; then echo "Il manque la clé API."; echo "Fin du script.";exit 1; fi

curl --header 'Access-Token: '$1 https://api.pushbullet.com/v2/devices | jq .
}

# Envoie un push à tout les device

push_commun () {
if [ -z $1 ]; then echo "Il manque la clé API."; erreur=1; fi
if [ -z $2 ]; then echo "Il manque le titre."; erreur=1; fi
if [ -z $3 ]; then echo "Il manque le message."; erreur=1; fi
if [ -z $erreur ]; then echo "Fin du script."; erreur=1; exit 1; fi
r=$(curl -i -u $1: -H "Accept: application/json" -X POST -d "type=note" -d "title=$2" -d "body=$3" https://api.pushbullet.com/v2/pushes > log)

}

# Envoie un push à un contact

push_contact () {
if [ -z $1 ]; then echo "Il manque la clé API."; erreur=1; fi
if [ -z $2 ]; then echo "Il manque le titre."; erreur=1; fi
if [ -z $3 ]; then echo "Il manque le message."; erreur=1; fi
if [ -z $4 ]; then echo "Il manque l'adresse maIl."; erreur=1; fi
if [ -z $erreur ]; then echo "Fin du script."; erreur=1; exit 1; fi
r=$(curl -i -u $1: -H "Accept: application/json" -X POST -d "type=note" -d "emaIl=$4;" -d "title=$2" -d "body=$3" https://api.pushbullet.com/v2/pushes > log)
}

# Envoie un push à un device

push_device () {
if [ -z $1 ]; then echo "Il manque la clé API."; erreur=1; fi
if [ -z $2 ]; then echo "Il manque le titre."; erreur=1; fi
if [ -z $3 ]; then echo "Il manque le message."; erreur=1; fi
if [ -z $4 ]; then echo "Il manque l'iden du périphérique."; erreur=1; fi
if [ -z $erreur ]; then echo "Fin du script."; erreur=1; exit 1; fi
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
if [ "$1" == "--help" ]; then aide; fi
if [ "$1" == "-h" ]; then aide; fi
