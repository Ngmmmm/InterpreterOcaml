(* dessin.ml *)
open Graphics

let () =
  (* 1. Vérification des arguments (nom du fichier .txt) *)
  if Array.length Sys.argv < 2 then (
    print_endline "Usage: dune exec ./dessin.exe -- <fichier_test.txt>";
    exit 1
  );

  let filename = Sys.argv.(1) in
  let chan = open_in filename in
  let lexbuf = Lexing.from_channel chan in

  try
    (* 2. Appel du Parser et du Lexer pour créer l'AST *)
    let ast = Parser.main Lexer.token lexbuf in
    close_in chan;

    (* 3. Initialisation de la fenêtre Graphics selon le sujet [cite: 58] *)
    open_graph " 800x800";
    moveto 400 400; (* Centre du canevas [cite: 58] *)

    (* 4. Appel de l'interpréteur (le code que tu as déplacé dans interp.ml) *)
    Interp.interpreter ast;

    (* 5. Attente pour voir le dessin *)
    print_endline "Dessin terminé. Appuyez sur une touche pour quitter.";
    ignore (wait_next_event [Key_pressed])
  with
  | Parser.Error ->
      Printf.fprintf stderr "Erreur de syntaxe à la ligne %d\n" 
        lexbuf.lex_curr_p.pos_lnum;
      exit 1
  | Failure msg ->
      Printf.fprintf stderr "Erreur d'exécution : %s\n" msg;
      exit 1