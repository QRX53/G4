grammar Q;

// Rules
program : ;

// Value, so an int, string, or identifier, etc
value :
    IDENTIFIER |
    NUM |
    STRING |
    // Function return value. f(x)
    IDENTIFIER LPAREN (params)? RPAREN
      ;

// Variable assignment
// var x = 300;
assignment :
    (VAR | CONST) IDENTIFIER EQUALS value SEMICOLON
    ;

// Function definition
// pub fn main(args) { // code }
// or
// priv fn retType() -> int { return int }
fnDefine :
    ( PUB | PRIV ) FN IDENTIFIER LPAREN params RPAREN (MINUS GT vType)? LBRACE program RBRACE |
    ;

// Define statement
// #define "_x as 300"
// would permanently define '_x' as 300 throughout the entire program.
defStatement :
    HASH DEF STRING
    ;

// Variable types, used for Variable objects/classes, or for return types in the language itself
vType :
    INT |
    STR |
    BOOL |
    UINT
    ;

// Parameters rule, used almost exclusively for function definition and function calls
params :
    value (COMMA value)*?
    ;

// Function call
// addTwoNums(x, y);
// or the @ version, which doesn't require (), but can't take params.
// @printTheNumberOne
fnCall :
    IDENTIFIER LPAREN (params)? RPAREN SEMICOLON |
    AT IDENTIFIER SEMICOLON
    ;

// Class definition.
// pub class Apple from Fruit { // code }
// or
// priv class Apple { // code }
classDef :
    (PUB | PRIV) CLASS IDENTIFIER (FROM IDENTIFIER)? 
    ;

add :
    value PLUS value
    ;

sub :
    value MINUS value
    ;

mul :
    value STAR value
    ;

div :
    value SLASH value
    ;

modu :
    value MOD value
    ;

// Keywords
VAR     : 'var' ;
CONST   : 'const';
LET     : 'let' ;
FN      : 'fn'  ;
IF      : 'if'  ;
ELSE    : 'else';
ELIF    : 'elif';
VOID    : 'void';
CLASS   : 'class';
PUB     : 'pub' ;
PRIV    : 'priv';
INCLUDE : 'include';
MODULE  : 'mod';
DEF     : 'define' ;
SELF    : 'self';
RETURN  : 'return';
FROM    : 'from';

// Variable types
INT     : 'int';
STR     : 'string';
BOOL    : 'bool';
UINT    : 'uint';

// Tokens
AT      : '@';
HASH    : '#';
LPAREN  : '(';
RPAREN  : ')';
EXCLAIM : '!';
DOT     : '.';
AND     : '&';
COLON   : ':';
SEMICOLON: ';';
SLASH   : '/';
MOD     : '%';
STAR    : '*';
PLUS    : '+';
MINUS   : '-';
EQUALS  : '=';
DOLLAR  : '$';
RBRACKET: ']';
LBRACKET: '[';
CAROT   : '^';
QUOTE   : '"';
SINGLEQUOTE: '\'';
RBRACE  : '}';
LBRACE  : '{';
COMMA   : ',';
GT      : '>';
LT      : '<';

// Technical
// Regex expressions for Identifiers, Strings, Numbers, etc.
IDENTIFIER: [a-zA-Z0-9]+;
STRING: QUOTE IDENTIFIER QUOTE ;
NUM
   : INTEGER+ ('.' INTEGER+)?
   ;

fragment INTEGER
   : ('0' .. '9')
   ;