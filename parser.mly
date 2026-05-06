%{
  open Arbre
%}

%token <int> NOMBRE
%token BAISSER_PINCEAU LEVER_PINCEAU AVANCER TOURNER
%token PLUS MOINS FOIS DIV
%token GPAREN DPAREN
%token PV
%token EOF
%token COULEUR_PINCEAU LARGEUR_PINCEAU
%token NOIR ROUGE BLEU VERT JAUNE
%token SI ALORS SINON TANTQUE FAIRE REPETER FOIS DEBUT FIN
%token EQUAL_COMP DIFF INF SUP INFEGAL SUPEGAL AND OR NOT
%token <string> HEXCODE
%token VAR EGAL
%token <string> ID

%nonassoc low_prec
%nonassoc SINON

%left PLUS MOINS
%left FOIS DIV
%left OR
%left AND
%nonassoc NOT

%start<Arbre.programme> main

%%

main:
  | b = bloc_commandes EOF { b }

bloc_commandes:
  | { [] }
  | i = commande PV suite = bloc_commandes { i :: suite }

commande:
  | BAISSER_PINCEAU { BaisserPinceau }
  | LEVER_PINCEAU { LeverPinceau }
  | AVANCER e = expression { Avancer e }
  | TOURNER e = expression { Tourner e }
  | COULEUR_PINCEAU c = couleur { CouleurPinceau c }
  | LARGEUR_PINCEAU e = expression { LargeurPinceau e }
  | VAR i = ID { VarDecl i }
  | VAR i = ID EGAL e = expression { VarInit(i, e) } 
  | i = ID EGAL e = expression { Affectation(i, e) }
  | SI c = condition ALORS i1 = bloc_ou_inst %prec low_prec
      { Si(c, i1, []) }
  | SI c = condition ALORS i1 = bloc_ou_inst SINON i2 = bloc_ou_inst
      { Si(c, i1, i2) }
  | TANTQUE c = condition FAIRE i = bloc_ou_inst
      { TantQue(c, i) }
  | DEBUT l = suite_instructions FIN { Bloc l }

couleur:
  | NOIR { Noir }
  | ROUGE { Rouge }
  | BLEU { Bleu }
  | VERT { Vert }
  | JAUNE { Jaune }
  | h = HEXCODE { Hex h }

expression:
  | n = NOMBRE { Nombre n }
  | i = ID { Var i }
  | GPAREN e = expression DPAREN { e }
  | e1 = expression PLUS e2 = expression { Add(e1, e2) }
  | e1 = expression MOINS e2 = expression { Sub(e1, e2) }
  | e1 = expression FOIS e2 = expression { Mul(e1, e2) }
  | e1 = expression DIV e2 = expression { Div(e1, e2) }