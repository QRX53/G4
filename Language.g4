grammar Language;

// Rules
program : ;

// Value, so an int, string, or variable, etc
value :
    IDENTIFIER |
    NUM |
    STRING |
    // Function return value. f(x)
    IDENTIFIER LPAREN ( params )? RPAREN |
    selfCall
      ;

// Variable assignment
// var x = 300;
assignment :
    ( VAR | CONST ) IDENTIFIER EQUALS value SEMICOLON |
    LET IDENTIFIER vType EQUALS value
    ;

// Function definition
// pub fn main(args) { // code }
// or
// priv fn retType() -> int { return int }
fnDefine :
    ( PUB | PRIV ) FN IDENTIFIER LPAREN params RPAREN ( MINUS GT vType )? LBRACE block RBRACE |
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
    value ( COMMA value )*?
    ;

// Function call
// addTwoNums(x, y);
// or the @ version, which doesn't require (), but can't take params.
// @printTheNumberOne
// Or call the parent class as well.
// std::coutln("Hello, World!");
fnCall :
    ( IDENTIFIER ACCESSOR )? IDENTIFIER LPAREN ( params )? RPAREN SEMICOLON |
    AT IDENTIFIER SEMICOLON
    ;

// Class definition.
// pub class Apple from Fruit { // code }
// or
// priv class Apple { // code }
classDef :
    ( PUB | PRIV ) CLASS IDENTIFIER ( FROM IDENTIFIER )? 
    ;

// Addition rule, not complicated, just x + y
add :
    term (PLUS term)*
    ;

// Subtraction rule
sub :
    term (MINUS term)*
    ;

// Multiplication, division, and modulus rule
term :
    value (STAR value | SLASH value | MOD value)*?
    ;

// Math statement, any operation can be wrapped in parentheses.
mathStatement :
    LPAREN sub RPAREN | sub
    ;


// A 'self' statement.
// Used to access members of a class, similar to 'this'
selfCall :
    SELF ACCESSOR IDENTIFIER
    ;

// Try/catch blocks. Error handling
// try { // code } catch (e) { // code }
// or without catch block, which will just destroy the error message and continue running the program.
// This method MAY CAUSE UNEXPECTED PROBLEMS
// try { // code }
tryCatch :
    TRY LBRACE block RBRACE (CATCH LPAREN IDENTIFIER RPAREN LBRACE block RBRACE)
    ;

// Conditional statements. Could just be a value, or could be:
// value > value
// Or similar
conditional :
    relationExpression | value
    ;

// Part of the conditional section above, this is to compare 2 values.
relationExpression :
    value relationalOperator value
    ;

// All comparison keywords/tokens in one rule, for use in the relationExpression rule.
relationalOperator :
    GTEQ | LTEQ | EQEQ | NOTEQ
    ;

// Very basic if statement
// if (cond) { // code } elif { // code } else { // code }
ifStatement :
    IF LPAREN conditional RPAREN LBRACE block RBRACE ( elifStatement )*? ( elseStatement )*?
    ;

// Elif statement.
// This is a seperate statement from 'ifStatement' for readability.
elifStatement :
    ELIF LPAREN conditional RPAREN LBRACE block RBRACE
    ;

// Else statement.
// This is a seperate statement from 'ifStatement' for readability.
elseStatement :
    ELSE LPAREN conditional RPAREN LBRACE block RBRACE
    ;

// Fairly basic while statement.
// while (x == 1) { // code }
whileStatement :
    WHILE LPAREN conditional RPAREN LBRACE block RBRACE
    ;

// An iterating for statement, very very similar to Java
// for (x in list) { // code }
enhancedForStatement :
    FOR LPAREN value IN value RPAREN LBRACE block RBRACE
    ;

// Regular for statement. Also very very similar to Java
// for (i = 0; i < 5; i++) { // code }
forStatement :
    FOR LPAREN
        IDENTIFIER EQUALS value SEMICOLON 
        relationExpression SEMICOLON 
        IDENTIFIER ( PLUSPLUS | MINMIN ) RPAREN
        LBRACE block RBRACE
    ;

// Block statement. This is used to define everything that can be used within something like a function.
// For instance, the 'program' rule, includes function definition, the block rule does not.
// This is because you cannot define a function, within another function.
block :
    mathStatement |
    fnCall |
    assignment |
    forStatement |
    whileStatement |
    enhancedForStatement |
    ifStatement |
    tryCatch
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
IN      : 'in';
CLASS   : 'class';
PUB     : 'pub' ;
PRIV    : 'priv';
INCLUDE : 'include';
MODULE  : 'mod';
DEF     : 'define' ;
SELF    : 'self';
RETURN  : 'return';
FROM    : 'from';
TRY     : 'try';
CATCH   : 'catch';
WHILE   : 'while';
FOR     : 'for';

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
GTEQ    : '>=';
LTEQ    : '<=';
EQEQ    : '==';
NOTEQ   : '!=';
SLASHEQ : '/=';
MULEQ   : '*=';
PLUSEQ  : '+=';
MINUSEQ : '-=';
PLUSPLUS: '++';
MINMIN  : '--';

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