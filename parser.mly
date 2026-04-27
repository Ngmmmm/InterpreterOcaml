%{
  open Arbre
%}

%token <int> NOMBRE
%token BAISSER_PINCEAU LEVER_PINCEAU AVANCER TOURNER
%token PLUS MOINS FOIS DIV
%token GPAREN DPAREN
%token PV
%token EOF

%left PLUS MOINS
%left FOIS DIV

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

expression:
  | n = NOMBRE { Nombre n }
  | GPAREN e = expression DPAREN { e }
  | e1 = expression PLUS e2 = expression { Add(e1, e2) }
  | e1 = expression MOINS e2 = expression { Sub(e1, e2) }
  | e1 = expression FOIS e2 = expression { Mul(e1, e2) }
  | e1 = expression DIV e2 = expression { Div(e1, e2) }