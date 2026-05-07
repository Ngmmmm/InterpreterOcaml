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

type comparaison =
  | Egal
  | Diff
  | Inferieur
  | Superieur
  | InfEgal
  | SupEgal

type condition = 
  | Vrai
  | Faux
  | Comp of comparaison * expr * expr
  | Not of condition
  | And of condition * condition
  | Or of condition * condition

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
  | Si of condition * instruction list * instruction list
  | TantQue of condition * instruction list
  | Repeter of expr * instruction list
  | Bloc of instruction list

type programme = instruction list