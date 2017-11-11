// auteur : Djebien Tarik
// date   : Janvier 2010
// objet  : Compter les opérations dans un algorithme 

PROGRAM TP1_partie2;
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
writeln;
writeln('*****COMPTER LES OPERATIONS DANS UN ALGORITHME*****');
writeln;writeln;

(* Questions 1/2/3 *)

i:=10;
while i <= 50 do 
begin
 //Initialisation
 Tab:= tableauAleatoire(i);
 write('Tab[] = ');afficheTableau(Tab);writeln;
 writeln('Longueur(Tab[]) = ',i);
 nb_comp:= 0;
 //Recherche de l'élement max de Tab
 m:= max(Tab);
 writeln('max(Tab) = ',m);
 writeln('Nombre de comparaisons d''élements dans la recherche de max(tab) = ',nb_comp);
 
 i:=i+10;
 writeln;
end;//for

(* Remarque *)
writeln('On remarque que :');
writeln('Nb_comp = Longueur(Tab[]) - 1 .');
writeln;

END.
