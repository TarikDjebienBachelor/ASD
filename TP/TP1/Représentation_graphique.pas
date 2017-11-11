// auteur : Djebien Tarik
// date   : Janvier 2010
// objet  : Représentation graphique du nombre d'opérations

PROGRAM TP1_partie3;
uses U_Tableaux,U_Element;

var Tab : TABLEAU;
	nb_comp,i: CARDINAL;
	m : ELEMENT;

//Fonction max qui calcule la valeur maximale d'un tableau
//d'élements passé en paramètre.
function max(var t: TABLEAU): ELEMENT;
var i: CARDINAL;
	m: ELEMENT;
begin
  m:= t[low(t)];
	for i:= low(t)+1 to high(t) do
	begin
	  nb_comp:= nb_comp + 1;
	  if inferieur(m,t[i]) then
	      m:= t[i];
	end;//for
  max:= m;	
end{max};

//Programme Principal
BEGIN
 

(* Questions 5 *)

 

for i:= 1 to 100 do 
begin
 //Initialisation
 Tab:= tableauAleatoire(i);
 nb_comp:= 0;
 //Recherche de l'élement max de Tab
 m:= max(Tab);
 writeln(i,' ',nb_comp);
end;//for

END.
