{
  open Parser
  exception ErreurLexicale of string
}


let chiffre = ['0'-'9']
let nombre = '-'? chiffre+
let espace = [' ' '\t' '\r']
let lettre = ['a'-'z' 'A'-'Z']
let alphanum = ['a'-'z' 'A'-'Z' '0'-'9' '_']
let id = lettre alphanum*
let hexa = ['0'-'9' 'A'-'F' 'a'-'f'](* Pour les couleurs hexadécimales *)
let hexcode = hexa hexa hexa hexa hexa hexa(*6 car 6 caractères *)

rule token = parse
  | espace+ { token lexbuf }
  | '\n' { Lexing.new_line lexbuf; token lexbuf }
  | "Var" { VAR } 
  | '=' { EGAL } 
  | "Couleur Pinceau" { COULEUR_PINCEAU }
  | "Largeur Pinceau" { LARGEUR_PINCEAU }
  | "noir" { NOIR }
  | "rouge" { ROUGE }
  | "bleu" { BLEU }
  | "vert" { VERT }
  | "jaune" { JAUNE }
  | hexcode as h { HEXCODE h }
  | "Baisser Pinceau" { BAISSER_PINCEAU }
  | "Lever Pinceau" { LEVER_PINCEAU }
  | "Avancer" { AVANCER }
  | "Tourner" { TOURNER }
  | id as i { ID i }         
  | nombre as n { NOMBRE (int_of_string n) } 
  | '+' { PLUS }
  | '-' { MOINS }
  | '*' { FOIS }
  | '/' { DIV }
  | '(' { GPAREN }
  | ')' { DPAREN }
  | ';' { PV }
  | eof { EOF }
  | _ as c { raise (ErreurLexicale ("Caractère inattendu : " ^ String.make 1 c)) }