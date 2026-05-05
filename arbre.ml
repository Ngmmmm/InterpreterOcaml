type expr =
  | Nombre of int
  | Var of string
  | Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Div of expr * expr

type couleur =
  | Noir
  | Rouge
  | Bleu
  | Vert
  | Jaune
  | Hex of string

type instruction =
  | BaisserPinceau
  | LeverPinceau
  | Avancer of expr
  | Tourner of expr
  | CouleurPinceau of couleur
  | LargeurPinceau of expr
  | VarDecl of string 
  | VarInit of string * expr
  | Affectation of string * expr

type programme = instruction list