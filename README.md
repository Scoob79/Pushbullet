# Pushbullet
Ce script permet d'envoyer divers commande à l'API PushBullet

# Installation 

- `nano pushbullet.sh`
- copie collé du code
- ctrl+x

Le rendre executable
- `chmod +x ./pushbullet.sh`

C'est tout :thumbsup:

# Utilisation 

Commande de base :

`./pushbullet.sh --list_device api_key`                           Liste tout les périphériques sur le compte 

`./pushbullet.sh --push_commun api_key titre message`             Envoi un message à tout les périphériques

`./pushbullet.sh --push_contact api_key titre message adresse`    Envoi un message à un contact 

`./pushbullet.sh --push_device api_key titre message adresse`     Envoi un message à un périphérique 

# Fonction avancées

Il est tout a fait possible d'effectuer des retour chariot en procédant comme suit :

`./pushbullet.sh --push_commun 0.dsf4658dgd4fg8reg6565fdg "Ceci est le titre de mon message" "Bonjour,`

`et voici mon message,`

`avec des retour de chariot"`

