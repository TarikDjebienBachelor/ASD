// Exercice 1

PROGRAM Exercice1;
uses U_Tableaux, U_Element, SysUtils;


function recherche_naive(t : TABLEAU; e: CARDINAL): INTEGER;
var i,position : INTEGER;
begin
  position := -1;
  for i:= low(t) to high(t) do
  begin
  if t[i] = e then
     position := i;
  end;//for
  recherche_naive := position;
end{recherche_naive};

procedure tri_bulle(var t: TABLEAU);
var i,j,k: INTEGER;
begin
  for j:= 1 to 9 do
    for i:= 1 to 9 do
      if t[i] > t[i+1] then
	begin
	  k:=t[i];
	  t[i]:= t[i+1];
	  t[i+1] := k;
	end;
end{tri_bulle};

function dichotomie(t: TABLEAU; debut,fin,e:INTEGER):INTEGER;
var milieu : INTEGER;
begin
   milieu := (debut + fin) div 2;
   if t[milieu] = e then
      dichotomie:= milieu
   else 
     if t[milieu] < e then 
      dichotomie:= dichotomie(t,t[milieu],high(t),e)
   else if if t[milieu] > e then 
      dichotomie:= dichotomie(t,low(t),t[milieu],e)
   else
 ,    dichotomie:= -1;
end{dichotomie};

function recherche_trie(t : TABLEAU; e: CARDINAL): INTEGER;
var tab : TABLEAU;
begin
   tab:= copieTableau(t);
   recherche_trie:= dichotomie(tab,low(tab),high(tab),e); 
end{recherche_trie};

BEGIN

END.