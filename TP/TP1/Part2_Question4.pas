// auteur : Djebien Tarik
// date   : Janvier 2010
// objet  : Compter les opérations dans un algorithme 

(* Question 4 *)


PROGRAM TP1_partie2;
uses U_Tableaux,
	 U_Element;
	 
// Nombre de test pour une taille fixée	 
const Nb_Test=10;


var tab : TABLEAU;
	m : ELEMENT;
	
	nb_comp,
	nbc_max,
	nbc_min,
	taille,i: CARDINAL;
	nbc_moy : REAL;
	

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


For taille:=10 to 100 do 
begin
   nbc_min:= high(CARDINAL); // + infinity
   nbc_max:= low(CARDINAL);  // - infinity
   nbc_moy:= 0.0;
   
     for i:=1 to Nb_Test do
     begin
       tab:= tableauAleatoire(taille);
       nb_comp:=0;
       m:= max(tab);
       
       if nb_comp < nbc_min then
          nbc_min:= nb_comp;
       if nb_comp > nbc_max then
          nbc_max:= nb_comp;
          
       nbc_moy:= nbc_moy + (nb_comp/ Nb_Test); 
     end;//for 

writeln('taille = ', taille,', nbc_min = ',nbc_min,', nbc_max = ',nbc_max,', nbc_moy = ',nbc_moy,'.');
   
end;//For

END.
