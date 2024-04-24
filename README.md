# PROJET UE-NUAGE DAI Julien ET PARION ARNAUD

## Structure

Notre projet est séparé en deux branches :
- main qui comporte la partie kubernetes, et la partie terraform pour kubernetes
- dockercompose-terraform_docker qui comporte la partie docker compose et la partie terraform pour docker

Une version de fonctionnelle de docker est nécessaire pour suivre les prochaines étapes.

## Docker Compose

Pour cette partie, allez sur la branche dockercompose-terraform_docker et lancez les commandes suivantes :
- ```docker compose build```
- ```docker compose up```

## Terraform pour Docker

Pour cette partie, allez sur la branche dockercompose-terraform_docker et lancez les commandes suivantes :
- ```terraform init```
- ```terraform plan```
- ```terraform apply```
- "yes"

## Kubernetes

Pour déployer le projet il faut avoir installé Google Cloud CLI et Kubernetes CLI, ainsi qu'avoir un compte Google Cloud Platform (gcp).

Une fois le compte obtenu, il faut :
- créer un nouveau projet
- activer le service Kubernetes Engine API
- s'authentifier avec les commandes suivantes :
    - ```gcloud auth login```
    - ```gcloud config set project PROJECT-ID``` (avec PROET-ID l'ID de votre projet)
    - ```gcloud container clusters create NAME-CLUSTER --machine-type n1-standard-2 --num-nodes 3 --zone us-central1-c``` (avec NAME-CLUSTER le nom de votre choix)

Puis une fois le cluster créer, il faut s'y connecter (bouton se connecter) et utiliser la commande affichée sur la page, ressemblant à cela : ```gcloud container clusters get-credentials CLUSTER-NAME --region REGION --project PROJECT-ID```

La connexion devrait être établie après cela.

Pour la suite, il faut push des images docker sur un artifact registry du projet.
Pour cela il faut aller créer un nouveau registre puis s'authentifier (dans Setup Instructions). La commande est similaire à la suivante : ```gcloud auth configure-docker europe-west9-docker.pkg.dev```
Copiez l'adresse du répertoire, et modifiez dans le docker-compose.yaml le lien des images vote, seed, worker et result. Les liens devraient ressembler à : ```europe-west9-docker.pkg.dev/your-gcp-project/voting-image/result```
Enfin construisez les images avec ```docker compose build```, et ajoutez les au registre avec : ```docker compose push```.

finalement pour lancer le projet il faut déployer les services avec les commandes suivantes :
- ```kubectl create -f db-service.yaml```
- ```kubectl create -f db-deployement.yaml```
- ```kubectl create -f redis-svc.yaml```
- ```kubectl create -f redis-deployment.yaml```
- ```kubectl create -f worker/worker-deployement.yaml```
- ```kubectl create -f result/result-svc.yaml```
- ```kubectl create -f result/result-deployement.yaml```
- ```kubectl create -f vote/vote-svc.yaml```
- ```kubectl create -f vote/vote-deployement.yaml```
- ```kubectl create -f seed-data/seed-job.yaml```

## Terraform pour kubernetes
Avant de faire cette partie, il faut avoir fait les étapes de la partie Kubernetes.

Installer terraform.
Après avoir créé un projet sur gcp, allez dans "IAM" puis "Service Accounts".
Créez un nouveau compte de service avec le rôle éditeur.
Ensuite activez les services suivants :
- Kubernetes Engine API
- Compute Engine API
  Retournez sur "Service Accounts" téléchargez une clé au format json.
  Ensuite modifiez les configurations gcp dans le fichier providers.tf avec les informations suivantes :
  ```provider "google" {```
  ```  project = "your-project-id"```
  ```  region  = "europe-west9"```
  ```  zone    = "europe-west9-a"```
  ```  credentials = file("downloaded_file.json")}```

Cliquez ensuite sur l'adresse mail du compte par défaut du service Compute Engine. Ensuite dans les autorisations cliquez sur Grand accès. Dans le champ "Nouveaux comptes principaux" utilisez l'autocomplétion pour ajoutez le compte du service terraform (commence par terraform").
Assignez-lui le rôle "Créateur de jetons du compte de service"

Ensuite lancez les commandes suivantes :
- ```terraform init```
- ```terraform plan```
- ```terraform apply```
- "yes"