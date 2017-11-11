// auteur : Djebien Tarik
// date   : Mars 2010
// objet  : Unité pour Alignement de deux mots.

UNIT U_Edition;

INTERFACE

TYPE 
     Matrice = array of array of CARDINAL;

function min(x,y,z:CARDINAL): CARDINAL;

function distance_dynamique(u,v:STRING): CARDINAL;
 

IMPLEMENTATION


// min(x,y,z) renvoie le plus petit élement 
// parmi les trois en parametres.
function min(x,y,z:CARDINAL): CARDINAL;
var min1 : CARDINAL;
begin
  if ( x >= y ) then
      min1:= y
  else 
  	  min1:= x;
  if (min1 >= z) then
      min:= z
  else
      min:= min1;
end{min};


// Calcule la distance d'edition de deux chaines
// de caracteres.
// VERSION DYNAMIQUE.
function distance_dynamique(u,v:STRING): CARDINAL;
var
   table : Matrice;
   i,j : CARDINAL;   
begin 
   
   // table indexee par u'first-1..u'last et v'first-1..v'last.
   setlength(table,length(u)+1,length(v)+1);
   
   // d(u,e)   = |u|
   for i:= 0 to length(u) do
     table[i,0]:= i;    
   // d(e,v)   = |v|
   for j:= 0 to length(v) do
     table[0,j]:= j;
   
   // Parcours de la table
   // sens de remplissage
   for i:= 1 to length(u) do
      for j:= 1 to length(v) do
   		begin
   		  // d(ua,va) = d(u,v)
   		  if (u[i]= v[j]) then
   		     table[i,j]:= table[i-1,j-1]
   		  else
   		  // d(ua,vb) = 1 + min(d(u,v),d(ua,v),d(u,vb))
   		     table[i,j]:= 1 + min(table[i-1,j],table[i,j-1],table[i-1,j-1]);
   		end;//for
  
  // le resultat est D(u'last,v'last)
   distance_dynamique:= table[length(u),length(v)];
end{distance_dynamique};


INITIALIZATION

(* Unité permettant de calculer la distance d' édition entre deux chaines de caractères. *)

FINALIZATION

(* Auteur, Djebien Tarik  *)

END {U_Edition}.
