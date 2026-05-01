type expr =
  | Nombre of int
  | Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Div of expr * expr

type instruction =
  | BaisserPinceau
  | LeverPinceau
  | Avancer of expr
  | Tourner of expr

type programme = instruction list