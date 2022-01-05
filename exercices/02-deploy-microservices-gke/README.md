# Exercice 2 - Déployer une application microservices

L'objectif de cet exercice est de déployer une application complexe construite en microservices.

Cette application se compose de plusieurs microservices développés dans des langages différents et qui communique entre eux. Dans ces microservices, vous trouverez également une interface web _(frontend)_, qui vous permettra de visualiser l'application et d'intéragir avec les différents services. 

Pour réaliser cet exercice, vous allez avoir besoin des outils suivants:

* kubectl

## Etapes

1. Connectez-vous à votre cluster Kubernetes.
2. Créez un namespace qui se nomme `eshop`.
3. Dans le namespace `eshop`, deployez l'application. Vous trouverez l'ensemble des fichiers de déploiement dans le dossier `manifests`.
4. Modifiez les fichiers de déploiement afin d'exposer l'application derrière un Load Balancer.
5. Essayez d'accéder à l'application depuis votre navigateur web.
5. L'application comporte des erreurs. Analysez la situation et essayez de rétablir le service.
