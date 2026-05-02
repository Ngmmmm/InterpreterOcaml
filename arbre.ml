type expr =
  | Nombre of int
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

type programme = instruction list