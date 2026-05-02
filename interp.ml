open Arbre
open Graphics

let x = ref 400.0 
let y = ref 400.0
let angle = ref 90.0 
let pinceau_baisse = ref false 
let couleur_actuelle = ref Graphics.black
let epaisseur_actuelle = ref 1

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

let col_to_graphics = function
  | Noir -> Graphics.black
  | Rouge -> Graphics.red
  | Bleu -> Graphics.blue
  | Vert -> Graphics.green
  | Jaune -> Graphics.yellow
  | Hex h -> int_of_string ("0x" ^ h)

let execute inst =
  match inst with
  | BaisserPinceau -> pinceau_baisse := true 
  | LeverPinceau -> pinceau_baisse := false 
  | Tourner e -> 
      let a = float_of_int (eval_expr e) in
      angle := !angle +. a 
  | Avancer e ->
      let d = float_of_int (eval_expr e) in
      let new_x = !x +. d *. cos (deg_to_rad !angle) in
      let new_y = !y +. d *. sin (deg_to_rad !angle) in
      
      if !pinceau_baisse then
        lineto (int_of_float new_x) (int_of_float new_y) 
      else
        moveto (int_of_float new_x) (int_of_float new_y); 
      
      x := new_x;
      y := new_y;
      if !x < 0. || !x > 800. || !y < 0. || !y > 800. then
        print_endline "Attention : Le curseur est sorti de l'écran !"
  | CouleurPinceau c -> 
      couleur_actuelle := col_to_graphics c;
      Graphics.set_color !couleur_actuelle
  | LargeurPinceau e -> 
      let ep = eval_expr e in
      if ep < 1 then failwith "Erreur : L'épaisseur doit être au moins de 1"
      else (
        epaisseur_actuelle := ep;
        Graphics.set_line_width !epaisseur_actuelle
      )

let interpreter programme =
  List.iter execute programme