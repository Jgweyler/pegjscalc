/*
 * Classic example grammar, which recognizes simple arithmetic expressions like
 * "2*(3+4)". The parser generated from this grammar then AST.
 */

{
  var tree = function(f, r) {
    if (r.length > 0) {
      var last = r.pop();
      var result = {
        type:  last[0],
        left: tree(f, r),
        right: last[1]
      };
    }
    else {
      var result = f;
    }
    return result;
  }
}

prog   = b:block DOT { return { type: 'program', block: b } }

block  = VAR v:var p:proc s:st 
           { 
             
             return { 
               type: 'block',
               vars: v,
               procs: p,
               st: s
             }        
           }
       / CONST c:cons VAR v:var p:proc s:st 
           {         
             
             return { 
               type: 'block',
               consts: c,
               vars: v,
               procs: p,
               st: s
             }        
           }
       / CONST c:cons p:proc s:st 
           { 
             
             return { 
               type: 'block',
               consts: c,
               procs: p,
               st: s
             }        
           }
       / p:proc s:st 
           { 
             
             return { 
               type: 'block',
               procs: p,
               st: s
             }        
           }

cons   = i:ID ASSIGN n:NUMBER c:(COMA ID ASSIGN NUMBER)* PYC 
           {     
             
             var result = [{type: '=', left: i, right: n}];
             for (var x = 0; x < c.length; x++)
               result.push({type: '=', left: c[x][1], right: c[x][3]});
             
             return result;
           }

var    = i:ID v:(COMA ID)* PYC
           {     
             
             var ids = [i];
             for (var x = 0; x < v.length; x++)
               ids.push(v[x][1]);
             
             return ids;
           }
           
proc   = p:(PROCEDURE ID args? PYC block PYC)*
           {
                  
             var result = [];
             for (var x = 0; x < p.length; x++)
               result.push({type: 'procedure', id: p[x][1], arguments: p[x][2], block: p[x][4]});
             
             return result;
           }
           
args   = LEFTPAR i:ID is:(COMA ID)* RIGHTPAR
           {
     
             var result = [i];
             for (var x = 0; x < is.length; x++)
               result.push(is[x][1]);
             
             return result;
           }
           
st     = i:ID ASSIGN e:exp            
            { return { type: '=', left: i, right: e }; }
       / CALL i:ID a:args? 
           { 
             return { type: 'call', id: i, arguments: a }; 
           }
       / BEGIN l:st r:(PYC st)* END
           { 
             var result = [l];
               for (var i = 0; i < r.length; i++)
                 result.push(r[i][1]);
         
               return result;
           }
       / IF c:cond THEN st:st ELSE sf:st
           {
             return {
               type: 'IFELSE',
               condition:  e,
               true_st: st,
               false_st: sf,
             };
           }
       / IF c:cond THEN st:st    
           {
             return {
               type: 'IF',
               condition:  c,
               st: st
             };
           }
       / WHILE c:cond DO st:st    
           {
             return {
               type: 'IF',
               condition:  c,
               st: st
             };
           }

cond   = o:ODD e:exp { return { type: o, expression: e }; }
       / e1:exp c:COND e2:exp { return { type: c, left: e1, right: e2 }; }
exp    = t:term   r:(ADD term)*   { return tree(t,r); }
term   = f:factor r:(MUL factor)* { return tree(f,r); }

factor = NUMBER
       / ID
       / LEFTPAR t:exp RIGHTPAR   { return t; }

_ = $[ \t\n\r]*

ASSIGN   = _ op:'=' _  { return op; }
ADD      = _ op:[+-] _ { return op; }
MUL      = _ op:[*/] _ { return op; }
COND     = _ op:$([<>=!][=]/[<>]) _ { return op; }
LEFTPAR  = _"("_
RIGHTPAR = _")"_
PYC      = _";"_
COMA     = _","_
DOT      = _"."_
CALL     = _ "call" _
BEGIN    = _ "begin" _
END      = _ "end" _
PROCEDURE = _ "procedure" _
CONST    = _ "const" _
VAR      = _ "var" _
IF       = _ "if" _
THEN     = _ "then" _
ELSE     = _ "else" _
WHILE    = _ "while" _
DO       = _ "do" _
ODD      = _ "odd" _
ID       = _ id:$([a-zA-Z_][a-zA-Z_0-9]*) _ 
            { 
              return { type: 'ID', value: id }; 
            }
NUMBER   = _ digits:$[0-9]+ _ 
            { 
              return { type: 'NUM', value: parseInt(digits, 10) }; 
            }
