{
  open Parser
  exception ErreurLexicale of string
}


let chiffre = ['0'-'9']
let nombre = '-'? chiffre+
let espace = [' ' '\t' '\r']

rule token = parse
  | espace+ { token lexbuf }
  | '\n' { Lexing.new_line lexbuf; token lexbuf }
  | "Baisser Pinceau" { BAISSER_PINCEAU }
  | "Lever Pinceau" { LEVER_PINCEAU }
  | "Avancer" { AVANCER }
  | "Tourner" { TOURNER }
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