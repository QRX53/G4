grammar Q;

// Rules
program : ;

value :
    IDENTIFIER |
    NUM |
    STRING
      ;

assignment :
    VAR IDENTIFIER EQUALS value SEMICOLON
    ;

fnDefine :
    FN IDENTIFIER LPAREN params RPAREN (MINUS GT vType)? LBRACE program RBRACE |
    ;

defStatement :
    HASH DEF STRING
    ;

vType :
    INT |
    STR |
    BOOL |
    UINT
    ;

params :
    value (COMMA value)*?
    ;

// Keywords
VAR : 'var' ;
LET : 'let' ;
FN  : 'fn'  ;
IF  : 'if'  ;
ELSE: 'else';
ELIF: 'elif';
VOID: 'void';
CLASS: 'class';
PUB : 'pub' ;
PRIV: 'priv';
INCLUDE: 'include';
MODULE: 'mod';
DEF : 'define' ;
SELF: 'self';
RETURN: 'return';

// Variable types
INT: 'int';
STR: 'string';
BOOL: 'bool';
UINT: 'uint';

// Tokens
AT : '@';
HASH: '#';
LPAREN: '(';
RPAREN: ')';
EXCLAIM: '!';
DOT: '.';
AND: '&';
COLON: ':';
SEMICOLON: ';';
SLASH: '/';
MOD: '%';
STAR: '*';
PLUS: '+';
MINUS: '-';
EQUALS: '=';
DOLLAR: '$';
RBRACKET: ']';
LBRACKET: '[';
CAROT: '^';
QUOTE: '"';
SINGLEQUOTE: '\'';
RBRACE : '}';
LBRACE : '{';
COMMA  : ',';
GT : '>';
LT : '<';

// Technical
IDENTIFIER: [a-zA-Z0-9]+;
STRING: QUOTE IDENTIFIER QUOTE ;
NUM
   : INTEGER+ ('.' INTEGER+)?
   ;

fragment INTEGER
   : ('0' .. '9')
   ;