grammar Q;

// Rules
program : ;

// Value, so an int, string, or variable, etc
value :
    IDENTIFIER |
    NUM |
    STRING |
    // Function return value. f(x)
    IDENTIFIER LPAREN (params)? RPAREN |
    selfCall
      ;

// Variable assignment
// var x = 300;
assignment :
    (VAR | CONST) IDENTIFIER EQUALS value SEMICOLON |
    LET IDENTIFIER vType EQUALS value
    ;

// Function definition
// pub fn main(args) { // code }
// or
// priv fn retType() -> int { return int }
fnDefine :
    ( PUB | PRIV ) FN IDENTIFIER LPAREN params RPAREN (MINUS GT vType)? LBRACE block RBRACE |
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
// Or call the parent class as well.
// std::coutln("Hello, World!");
fnCall :
    ( IDENTIFIER ACCESSOR )? IDENTIFIER LPAREN (params)? RPAREN SEMICOLON |
    AT IDENTIFIER SEMICOLON
    ;

// Class definition.
// pub class Apple from Fruit { // code }
// or
// priv class Apple { // code }
classDef :
    (PUB | PRIV) CLASS IDENTIFIER (FROM IDENTIFIER)? 
    ;

// Addition rule, not complicated, just x + y
add :
    value PLUS value
    ;

// Subtraction rule
sub :
    value MINUS value
    ;

// Multiplication rule
mul :
    value STAR value
    ;

// Division rule
div :
    value SLASH value
    ;

// Modulus rule (return the remainder)
modu :
    value MOD value
    ;

// A 'self' statement.
// Used to access members of a class, similar to 'this'
selfCall :
    SELF ACCESSOR IDENTIFIER
    ;

// Math statement, any operation can be wrapped in parentheses.
mathStatement :
    LPAREN add RPAREN |
    add |
    LPAREN sub RPAREN |
    sub |
    LPAREN mul RPAREN |
    mul |
    LPAREN div RPAREN |
    div |
    LPAREN modu RPAREN |
    modu
    ;

// Block statement. This is used to define everything that can be used within something like a function.
// For instance, the 'program' rule, includes function definition, the block rule does not.
// This is because you cannot define a function, within another function.
block :
    mathStatement |
    fnCall |
    assignment
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
ACCESSOR: '::';

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