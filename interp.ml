open Arbre
open Graphics

let x = ref 400.0 
let y = ref 400.0
let angle = ref 90.0 
let pinceau_baisse = ref false 

let deg_to_rad d = d *. (Stdlib.acos (-1.0) /. 180.0)

let rec eval_expr = function
  | Nombre n -> n
  | Add(e1, e2) -> eval_expr e1 + eval_expr e2
  | Sub(e1, e2) -> eval_expr e1 - eval_expr e2
  | Mul(e1, e2) -> eval_expr e1 * eval_expr e2
  | Div(e1, e2) -> 
      let v2 = eval_expr e2 in
      if v2 = 0 then failwith "Erreur : Division par zéro !"
      else eval_expr e1 / v2

