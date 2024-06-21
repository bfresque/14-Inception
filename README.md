# 14-Inception

Les conteneurs Docker que vous allez créer pour le projet Inception servent à virtualiser et isoler différents services nécessaires pour héberger une application web complète. Voici une explication détaillée des rôles et de l'importance de chaque conteneur :

## 1. Conteneur NGINX

**Fonction :**

NGINX est un serveur web qui gère les requêtes HTTP et HTTPS (via TLS/SSL). Dans ce projet, NGINX servira de passerelle (reverse proxy) vers le service WordPress, tout en assurant une connexion sécurisée.

**Utilisations spécifiques :**

- **Gestion du trafic** : Redirige les requêtes HTTP vers HTTPS pour sécuriser les communications.
- **Serveur proxy** : Transmet les requêtes des utilisateurs vers le conteneur WordPress.
- **Sécurité** : Met en œuvre TLS/SSL pour chiffrer les communications entre le client et le serveur.

## 2. Conteneur WordPress avec php-fpm

**Fonction :**

WordPress est un système de gestion de contenu (CMS) populaire utilisé pour créer et gérer des sites web. php-fpm (FastCGI Process Manager) est une méthode avancée de gestion des scripts PHP, utilisée ici pour améliorer les performances.

**Utilisations spécifiques :**

- **Hébergement du site web** : Gère le contenu et les pages du site web.
- **Traitement PHP** : php-fpm permet de gérer les requêtes PHP de manière efficace, améliorant les performances du site.

## 3. Conteneur MariaDB

**Fonction :**

MariaDB est un système de gestion de base de données relationnelle. Il stocke toutes les données du site WordPress, y compris les informations sur les utilisateurs, les articles, les pages, et les paramètres du site.

**Utilisations spécifiques :**

- **Stockage des données** : Gère les bases de données nécessaires pour le fonctionnement de WordPress.
- **Accès aux données** : Permet aux scripts PHP de WordPress d'accéder aux données de manière rapide et sécurisée.

## 4. Réseau Docker

**Fonction :**

Le réseau Docker assure la communication entre les différents conteneurs. En utilisant un réseau bridge, les conteneurs peuvent se découvrir et communiquer entre eux de manière sécurisée.

**Utilisations spécifiques :**

- **Isolation réseau** : Chaque conteneur fonctionne dans un réseau isolé, améliorant la sécurité.
- **Communication inter-conteneurs** : Permet aux conteneurs NGINX, WordPress et MariaDB de communiquer entre eux.

## 5. Volumes Docker

**Fonction :**

Les volumes Docker sont utilisés pour stocker les données de manière persistante. Ils permettent de conserver les données même si le conteneur est recréé ou redémarré.

**Utilisations spécifiques :**

- **Persistance des données WordPress** : Stocke les fichiers et la base de données de WordPress.
- **Isolation des données** : Sépare les données de la configuration des conteneurs, facilitant les sauvegardes et les migrations.

## Récapitulatif des Interactions

- **Requêtes des Utilisateurs** :

  Les utilisateurs accèdent au site via https://login.42.fr.
  NGINX reçoit les requêtes sur le port 443, applique les certificats TLS/SSL, et redirige les requêtes vers WordPress.

- **Traitement des Requêtes** :

  WordPress (via php-fpm) traite les requêtes et génère des pages dynamiques en accédant aux données stockées dans MariaDB.

- **Stockage et Gestion des Données** :

  MariaDB gère les bases de données nécessaires pour WordPress.
  Les volumes Docker assurent la persistance des données du site WordPress et de la base de données.

## Avantages de l'utilisation de Docker

- **Isolation** : Chaque service fonctionne dans son propre conteneur, isolé des autres, ce qui augmente la sécurité et la stabilité.
- **Portabilité** : Les conteneurs peuvent être facilement déplacés et exécutés sur différents environnements sans modification.
- **Gestion Simplifiée** : Docker Compose facilite la gestion de plusieurs conteneurs, en automatisant la construction et l'orchestration des services.
- **Efficacité** : Les conteneurs sont légers et consomment moins de ressources que les machines virtuelles, permettant une utilisation optimale des ressources système.

En utilisant Docker pour ce projet, vous créez une infrastructure modulaire, sécurisée et facilement gérable pour héberger un site WordPress complet.
