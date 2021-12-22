# Exercice 1 - Créer un cluster GKE avec Terraform

L'objectif de cet exercice est de créer un cluster GKE avec terraform.

Pour réaliser cet exercice, vous allez avoir besoin des outils suivants:

* Terraform _(> 0.13.x)_
* kubectl

## Etapes

1. Modifiez le code terraform fournit avec l'exercice et créer un cluster GKE avec les conditions suivantes:

    * Utiliser le module:  `terraform-google-modules/kubernetes-engine/google//modules/private-cluster`

    * Le cluster doit être `zonal` dans la region `europe-west1` et dans la zone `europe-west1-b`

    * Le cluster doit être privé UNIQUEMENT pour les noeuds _(worker nodes)_. Le control plan _(master nodes)_ lui doit être accessible publiquement pour le déroulement de l'exercice _(tips: il existe des variables dans le module terraform pour configurer ce scénario)_.

    * La configuration réseau du cluster doit être la suivante:
        
        * Sous réseau pour les noeuds: `k8s-subnet`
        * Sous réseau pour les pods: `k8s-subnet-pods`
        * Sous réseau pour les services: `k8s-subnet-services`
        * CIDR du control plan: `172.16.0.0/28`

    * Le cluster devra avoir un nodepool avec les configurations suivantes:

        * Nom: default-node-pool
        * VM SKU: "e2-medium"
        * minimum       = 1
        * maximum       = 5

2. Executez le code terraform et vérifiez que le cluster est bien crée.

    Pour pouvoir executer le code terraform, l'examinateur va vous fournir un fichier comportant les credentials pour se connecter à l'environnement GCP. Configurer la variable d'environnement ci-dessous avant d'exécuter le code terraform

    ```bash
    export GOOGLE_CREDENTIALS="./key.json"
    ```

3. Connectez-vous au cluster kubernetes avec le kubeconfig qui vous sera fourni.

    Il faudra configurer la variable d'environnement ci-dessous

    ```bash
    KUBECONFIG="<PATH_TO_KUBECONFIG>"
    ```
