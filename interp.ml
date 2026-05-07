open Arbre
open Graphics

let x = ref 400.0 
let y = ref 400.0
let angle = ref 90.0 
let pinceau_baisse = ref false 
let couleur_actuelle = ref Graphics.black
let epaisseur_actuelle = ref 1

let deg_to_rad d = d *. (Stdlib.acos (-1.0) /. 180.0)


type etat_var = { 
  mutable est_init : bool; 
  mutable valeur : float 
}

type env = (string * etat_var) list
let env_initial : env = []

let rec eval_expr env = function
  | Nombre n -> float_of_int n
  | Var i ->
      (try 
         let etat = List.assoc i env in
         if etat.est_init then etat.valeur
         else failwith ("Variable non initialisée : " ^ i)
       with Not_found -> failwith ("Variable non déclarée : " ^ i))
  | Add(e1, e2) -> eval_expr env e1 +. eval_expr env e2
  | Sub(e1, e2) -> eval_expr env e1 -. eval_expr env e2
  | Mul(e1, e2) -> eval_expr env e1 *. eval_expr env e2
  | Div(e1, e2) -> 
      let v2 = eval_expr env e2 in
      if v2 = 0.0 then failwith "Erreur : Division par zéro !"
      else eval_expr env e1 /. v2

let rec eval_cond env = function
  | Vrai -> true
  | Faux -> false
  | Comp (Egal, e1, e2) -> eval_expr env e1 = eval_expr env e2
  | Comp (Diff, e1, e2) -> eval_expr env e1 <> eval_expr env e2
  | Comp (Inferieur, e1, e2) -> eval_expr env e1 < eval_expr env e2
  | Comp (Superieur, e1, e2) -> eval_expr env e1 > eval_expr env e2
  | Comp (InfEgal, e1, e2) -> eval_expr env e1 <= eval_expr env e2
  | Comp (SupEgal, e1, e2) -> eval_expr env e1 >= eval_expr env e2
  | Not c -> not (eval_cond env c)
  | And (c1, c2) -> eval_cond env c1 && eval_cond env c2
  | Or (c1, c2) -> eval_cond env c1 || eval_cond env c2

let col_to_graphics = function
  | Noir -> Graphics.black
  | Rouge -> Graphics.red
  | Bleu -> Graphics.blue
  | Vert -> Graphics.green
  | Jaune -> Graphics.yellow
  | Hex h -> int_of_string ("0x" ^ h)

let rec execute env inst =
  match inst with
  | BaisserPinceau -> pinceau_baisse := true; env
  | LeverPinceau -> pinceau_baisse := false; env
  | Tourner e -> 
      let a = eval_expr env e in
      angle := !angle +. a;
      env
  | Avancer e ->
      let d = eval_expr env e in
      print_endline ("Avancer de : " ^ string_of_float d);
      let new_x = !x +. d *. cos (deg_to_rad !angle) in
      let new_y = !y +. d *. sin (deg_to_rad !angle) in

      if !x < 0. || !x > 800. || !y < 0. || !y > 800. then
        print_endline "Attention : Le curseur est sorti de l'écran !";
      
      if !pinceau_baisse then
        lineto (int_of_float new_x) (int_of_float new_y) 
      else
        moveto (int_of_float new_x) (int_of_float new_y); 
      
      x := new_x;
      y := new_y;
      env
  | CouleurPinceau c -> 
      couleur_actuelle := col_to_graphics c;
      Graphics.set_color !couleur_actuelle;
      env
  | LargeurPinceau e -> 
      let ep = eval_expr env e in
      if ep < 1.0 then failwith "Erreur : L'épaisseur doit être au moins de 1"
      else (
        epaisseur_actuelle := int_of_float(ep);
        Graphics.set_line_width !epaisseur_actuelle
      )
      ; env
  | VarDecl nom ->
      if List.mem_assoc nom env then
        failwith ("Erreur : Variable '" ^ nom ^ "' déjà déclarée.")
      else
        (nom, { est_init = false; valeur = 0.0 }) :: env

  | VarInit (nom, expr) ->
      if List.mem_assoc nom env then
        failwith ("Erreur : Variable '" ^ nom ^ "' déjà déclarée.")
      else
        let valeur = eval_expr env expr in
        (nom, { est_init = true; valeur } ) :: env

  | Affectation (nom, expr) ->
      if not (List.mem_assoc nom env) then
        failwith ("Erreur : Variable '" ^ nom ^ "' non déclarée.")
      else begin
        let etat = List.assoc nom env in
        etat.valeur <- eval_expr env expr;
        etat.est_init <- true;
        env
      end
  | Bloc instructions ->
      let _env_local = List.fold_left execute env instructions in
      env

  | Si (cond, inst_alors, inst_sinon) ->
      if eval_cond env cond then
        let _ = List.fold_left execute env inst_alors in env
      else
        let _ = List.fold_left execute env inst_sinon in env

  | TantQue (cond, instructions) ->
      let rec loop current_env =
        if eval_cond current_env cond then
          let _ = List.fold_left execute current_env instructions in
          loop current_env
        else
          current_env
      in
      let _ = loop env in
      env

  | Repeter (expr, instructions) ->
      let n = int_of_float (eval_expr env expr) in
      for _i = 1 to n do
        let _ = List.fold_left execute env instructions in ()
      done;
      env

let interpreter programme =
  let _environnement_final = List.fold_left execute env_initial programme in
  ()