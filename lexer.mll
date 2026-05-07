{
  open Parser
  exception ErreurLexicale of string
}


let chiffre = ['0'-'9']
let nombre = '-'? chiffre+
let espace = [' ' '\t' '\r']
let lettre = ['a'-'z' 'A'-'Z']
let alphanum = ['a'-'z' 'A'-'Z' '0'-'9' '_']
let hexa = ['0'-'9' 'A'-'F' 'a'-'f'](* Pour les couleurs hexadécimales *)
let hexcode = hexa hexa hexa hexa hexa hexa(*6 car 6 caractères *)

let identifiant = lettre alphanum*

rule token = parse
  | espace+ { token lexbuf }
  | '\n' { Lexing.new_line lexbuf; token lexbuf }
  | "Var" { VAR } 
  | '=' { EGAL } 
  | "Couleur Pinceau" { COULEUR_PINCEAU }
  | "Largeur Pinceau" { LARGEUR_PINCEAU }
  | "Var" { VAR }
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
  | "vrai" { VRAI } 
  | "faux" { FAUX }
  | "Si"     { SI }
  | "Alors"  { ALORS }
  | "Sinon"  { SINON }
  | "Tant que" { TANTQUE }
  | "Faire"  { FAIRE }
  | "Repeter" { REPETER }
  | "Fois"   { FOIS }
  | "Debut"  { DEBUT }
  | "Fin"    { FIN }
  | "=="     { EQUAL_COMP }
  | "!="     { DIFF }
  | "<"      { INF }
  | ">"      { SUP }
  | "<="     { INFEGAL }
  | ">="     { SUPEGAL }
  | "&&"     { AND }
  | "||"     { OR }
  | "!"      { NOT }
  | '+' { PLUS }
  | '-' { MOINS }
  | '*' { MUL }
  | '/' { DIV }
  | '(' { GPAREN }
  | ')' { DPAREN }
  | ';' { PV }
  | nombre as n { NOMBRE (int_of_string n) }
  | identifiant as id { ID id }
  | eof { EOF }
  | _ as c { raise (ErreurLexicale ("Caractère inattendu : " ^ String.make 1 c)) }