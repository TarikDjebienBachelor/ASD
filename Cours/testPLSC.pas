// Jean-Stéphane Varré
// Info 204 - ASD - Université Lille 1
// Last modified: 2010-02-08
program testPLSC;

uses Math;

// nombre de comparaison de caracteres pour deux chaines de longueur n et m
function complexite (n,m : CARDINAL) : CARDINAL;
begin
   if (n = 0) or (m = 0) then
      complexite := 0
   else
      complexite := 1 + complexite(n,m-1) + complexite(n-1,m);
end {complexite};

// calcul recursif de la longueur de la PLSC
function plsc_recursive(u,v : STRING) : CARDINAL;
var
   x, y : CHAR;
   uu, vv : STRING;
begin
   if (length(u) = 0) or (length(v) = 0) then
      plsc_recursive := 0
   else begin
      x := u[length(u)];
      y := v[length(v)];
      uu := copy(u,low(u),length(u)-1);
      vv := copy(v,low(v),length(v)-1);
      if x = y then
         plsc_recursive := 1 + plsc_recursive(uu,vv)
      else
         plsc_recursive := max (plsc_recursive(u,vv), plsc_recursive(uu,v));
   end {if};
end {plsc_recursive};

// calcul par programmation dynamique de la longueur de la PLSC
function plsc_dynamique (u,v : STRING) : CARDINAL;
var
   table : array of array  of CARDINAL;
   i, j : CARDINAL;
begin
   setlength(table,length(u)+1);
   for i := 0 to length(u) do setlength(table[i],length(v)+1);
   // initialisation
   for i := 0 to length(u) do table[i][0] := 0;
   for j := 0 to length(v) do table[0][j] := 0;
   // remplissage
   for i := 1 to length(u) do
      for j := 1 to length(v) do
         if u[i] = v[j] then
            table[i][j] := table[i-1][j-1] + 1
         else
            table[i][j] := max (table[i-1][j],table[i,j-1]);
   // resultat
   plsc_dynamique := table[length(u)][length(v)];   
end {plsc_dynamique};

// obtention d'une chaine de caracteres correspondant a la PLSC
procedure plsc (u,v : STRING);
var
   table : array of array  of CARDINAL;
   i, j : CARDINAL;
   res : STRING;
   longueur : CARDINAL;
   
   function plsc_dynamique (u,v : STRING) : CARDINAL;  
   var
      i, j : CARDINAL;
   begin
      setlength(table,length(u)+1);
      for i := 0 to length(u) do setlength(table[i],length(v)+1);
      // initialisation
      for i := 0 to length(u) do table[i][0] := 0;
      for j := 0 to length(v) do table[0][j] := 0;
      // remplissage
      for i := 1 to length(u) do
         for j := 1 to length(v) do
            if u[i] = v[j] then
               table[i][j] := table[i-1][j-1] + 1
            else
               table[i][j] := max (table[i-1][j],table[i,j-1]);
      // resultat
      plsc_dynamique := table[length(u)][length(v)];   
   end {plsc_dynamique};
   
begin
   longueur := plsc_dynamique(u,v);
   res := '';
   i := length(u);
   j := length(v);
   while (i > 0) and (j > 0) do begin
      if u[i] = v[j] then begin
         res := u[i] + res;
         i := i - 1;;
         j := j - 1;;
      end else begin
         if table[i][j] = table[i-1][j] then begin
            i := i - 1;;
         end else begin
            j := j - 1;;
         end {if};
      end {if};
   end {while};
   writeln(res);   
end {plsc};


var
   i : CARDINAL;
begin
   writeln(plsc_recursive('abcabba','cbabac'));
   writeln(plsc_dynamique('abcabba','cbabac'));
   plsc('abcabba','cbabac');   
end {testPLSC}.
   