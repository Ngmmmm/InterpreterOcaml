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