# Projet Grammaires et Analyse Syntaxique 2026

**Binôme :**
* Noa GREGOIRE MELLIER
* Marc YOUNAN

---

## Compilation et Exécution

* **Dépendances** : Nécessite la bibliothèque `graphics` d'OCaml.
  ```bash 
  opam install graphics
  ``` 
* **Compilation** : Utilisation de dune
  ```bash
  dune build
  ```
* **Exécution** : 
  ```bash 
  dune exec ./dessin.exe -- exemples/carre.txt
  ```

## Etape 1 : 
### Fonctionnalités réalisées :
Nous avons implémenté la base de l'interpréteur permettant de dessiner des formes géométriques simples :

  - **Analyse lexicale et syntaxique** : Reconnaissance des commandes *Avancer*, *Tourner*, *BaisserPinceau*, *LeverPinceau* et des expressions arithmétiques prioritaires.

  - **Interpréteur graphique** : Gestion du curseur (position, angle, état du pinceau) avec rendu en temps réel via le module OCaml Graphics.

  - **Gestion d'erreurs** : Détection et affichage de messages d'erreurs (par ex :pour la division par zéro et les sorties de canevas.) 

### Répartition du travail : 

**Noa** : Développement du Front-end. Réalisation du Lexer (`lexer.mll`) et du Parser (`parser.mly`). Définition de la structure de l'arbre de syntaxe abstraite dans `arbre.ml`.

**Marc** : Développement du Back-end. Création de l'interpréteur (`interp.ml`) incluant la logique d'évaluation des expressions et la gestion de la bibliothèque Graphics. Mise en place du point d'entrée principal dans `dessin.ml`.

## Etape 2:
### Fonctionnalités réalisées :
Nous avons étendu le langage pour supporter la personnalisation du tracé :

- **Couleurs** : Support des constantes (noir, rouge, bleu, vert, jaune) et des codes hexadécimaux personnalisés (`format RRGGBB`).  

- **Épaisseur** : Modification de la largeur du trait via l'instruction `Largeur Pinceau <exp>`.  

### Répartition du travail :
- **Noa** : Mise à jour du Lexer (gestion de l'hexadécimal) et du Parser pour intégrer les nouvelles instructions de style.  

- **Marc** : Implémentation de la sémantique des couleurs et de l'épaisseur dans l'interpréteur. Conversion des types AST vers les fonctions natives de la bibliothèque Graphics.

## Etape 3 :
### Fonctionnalités réalisées :
Nous avons étendu le langage pour lui permettre de mémoriser et manipuler des données:

- **Var** : Il est possible de déclarer une variable `Var x;`, de l'initialiser `Var x = 10;` ou de modifier sa valeur plus tard `x = x + 5;`. 

- **Gestion de l'Environnement** : Utilisation d'une liste d'association `string * etat_var list` pour stocker l'état des variables.

- **Gestion des erreurs** : Vérification systématique que chaque variable utilisée est bien déclarée et initialisée avant usage.  

### Répartition du travail :
- **Noa** : Mise à jour du Lexer et du Parser pour intégrer la grammaire des variables et des affectations.  

- **Marc** : Création de la logique de gestion d'environnement dans interp.ml (ajout, recherche et mise à jour dans la liste d'association).

# Etape 4 :
### Fonctionnalités réalisées :

- **Blocs** : Introduction des blocs `Debut...Fin`. Les variables déclarées à l'intérieur d'un bloc sont locales : elles sont supprimées de l'environnement dès que l'on sort du bloc.

- **Structures de Contrôle** : Ajout des boucles Tant que et Repeter ainsi que des conditions Si...Alors...Sinon

### Répartition du travail :
- **Noa** : Résolution des conflits de grammaire dans le Parser (ambiguïté du Sinon et des Debut/Fin). Support des expressions logiques (&&, ||, !).

- **Marc** : Correction de la logique récursive dans `interp.ml` pour permettre aux variables d'évoluer au sein des boucles `Tant que` et `Repeter`.