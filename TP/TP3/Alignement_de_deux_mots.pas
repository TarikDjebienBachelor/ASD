{
        Alignement_de_deux_mots.pas
        
        Copyright 2010 tarik User <tarik@ubuntu>
        
        This program is free software; you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation; either version 2 of the License, or
        (at your option) any later version.
        
        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.
        
        You should have received a copy of the GNU General Public License
        along with this program; if not, write to the Free Software
        Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
        MA 02110-1301, USA.
}

// auteur : Djebien Tarik
// date   : Mars 2010
// objet  : Alignement de deux mots.

PROGRAM Alignement_de_deux_mots;

USES crt;

TYPE 
     Matrice = array of array of CARDINAL;

VAR 
	 U,V : STRING;
	 Menu : Boolean;
	 c : char;
	 rec,dyn : CARDINAL;


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
// VERSION RECURSIVE.
function distance_recursive(u,v:STRING): CARDINAL;
begin
   // d(e,v)   = |v| 
   // (on fait |v| insertions )
   if ( u = '' ) then 
      distance_recursive:= length(v)
   // d(u,e)   = |u| 
   // (on fait |u| suppressions )
   else if ( v = '' ) then
      distance_recursive:= length(u)
   // d(ua,va) = d(u,v)
   else if ( u[length(u)] = v[length(v)] ) then
      distance_recursive:= distance_recursive(copy(u,1,length(u)-1),copy(v,1,length(v)-1))
   // d(ua,vb) = 1 + min(d(u,v),d(ua,v),d(u,vb))
   // (la derniere operation est une substitution de la lettre a en b,
   // ou une insertion de la lettre b, ou une suppression de la lettre a.)
   else
      distance_recursive:= 1 + min(distance_recursive(copy(u,1,length(u)-1),copy(v,1,length(v)-1)),
      							   distance_recursive(u,copy(v,1,length(v)-1)),
      							   distance_recursive(copy(u,1,length(u)-1),v)
      							   );
      							   
// ou a et b sont deux lettres quelconques distinctes,
// e est le mot vide et |u| représente la longueur du mot u.      							   
end{distance_recursive};

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

// Retourne la table des distances d'editions de deux chaines
// de caracteres apres sa construction par programmation dynamique.
function getTableDynamique(u,v:STRING): Matrice;
var
   table : Matrice;
   i,j : CARDINAL;   
begin
   // Meme Algorithme que precedemment
   setlength(table,length(u)+1,length(v)+1);
   for i:= 0 to length(u) do
     table[i,0]:= i;
   for j:= 0 to length(v) do
     table[0,j]:= j; 
   for i:= 1 to length(u) do
      for j:= 1 to length(v) do
   		begin
   		  if (u[i]= v[j]) then
   		     table[i,j]:= table[i-1,j-1]
   		  else
   		     table[i,j]:= 1 + min(table[i-1,j],table[i,j-1],table[i-1,j-1]);
   		end;//for
   
   // On retourne la table construite 
   getTableDynamique:= table;
end{getTableDynamique};

//procedure d'affichage de notre table dynamique 
procedure afficherTableau(const M: Matrice ; const u,v: STRING);
var 
    i,j: CARDINAL;
begin
  writeln('La table dynamique de ',u,' et ',v,' : ');
  writeln;
  
  write('   ');
  for i:= 1 to length(v) do
   write(v[i],'  ');writeln;
  for i:= 0 to length(v) do
   write('---');writeln;
  for i:= 0 to length(v) do
   write(i,'  ');writeln('|');
  for i:= 0 to length(v)+2 do
   write('---');writeln;
  
  for i:= 0 to length(u) do
    begin
	  for j:= 0 to length(v) do
	    write(M[i,j],'  ');
		write('| ',i,' |  ');
		if i <> 0 then write(u[i]);
		writeln;
	end;
end{afficherTableau};

procedure afficher(u,v: STRING);
var 
    t: Matrice;
    s1,s2,s3: STRING;
    i,j,k: CARDINAL;
begin
  // Initialisation
  s1:='';
  s2:='';
  s3:=''; 
  i:=length(u);
  j:=length(v);
  t:= getTableDynamique(u,v);
  
  while ((i>0) and (j>0)) do begin 
  
  // Dans le cas ou :
  
  // On a une identite 
  if ((t[i][j] = t[i-1][j-1]) and (u[i] = v[j])) then begin
	s1:=u[i]+s1;
	s2:='|'+s2;
	s3:=v[j]+s3;
	i:=i-1; 
	j:=j-1; 
  end else begin
  
  // On a une substitution
  if ((t[i][j] = t[i-1][j-1]+1) and (u[i] <> v[j])) then begin
	  s1:=u[i]+s1;
	  s2:=' '+s2;
	  s3:=v[j]+s3;
	  i:=i-1;
	  j:=j-1;
  end else begin
  
  // On a une suppression
  if (t[i][j]=t[i-1][j]+1) then begin
	    s1:=u[i]+s1;
	    s2:=' '+s2;
	    s3:='-'+s3;
	    i:=i-1;  
  end else begin
  
  //si on a une insertion 
  if (t[i][j]=t[i][j-1]+1) then begin
	    s1:='-'+s1;
	    s2:=' '+s2;
	    s3:=v[j]+s3;
	    j:=j-1;
	    end;
	  end;
	end;
   end;
  end;


 // Dans le cas ou i=1 mais j>1 
 // i.e : le deuxieme mot est plus grand 
 // => insertion du surplus dans le deuxieme mot 
 if (i<=0) and (j>0) then begin
   for k:=j downto 1 do begin
	s1:='-'+s1;
	s2:=' '+s2;
	s3:=v[k]+s3;
   end;
 end;

 // Dans le cas ou j=1 mais i>1 
 // i.e : le premier mot est plus grand 
 // => insertion du surplus dans le premier mot 
 if (i>0) and (j<=0) then begin
  for k:=i downto 1 do begin 
	s1:=u[k]+s1;
	s2:=' '+s2;
	s3:='-'+s3;
 end;
 end;

// Affichage sur la sortie standard      
writeln;	                       // Exemple :
writeln('                    ',s1);// a l - u m i n i u m
writeln('                    ',s2);// | |   | | | |
writeln('                    ',s3);// a l b u m i n e - -
end{afficher};

(* PROGRAMME PRINCIPAL *)

BEGIN
clrscr;
Menu:= true;	
	
	writeln('        Algorithmique et Structure de Donnees');
	writeln('            TP3: Programmation dynamique');
	writeln('                     Exercice 2');
	writeln;
	
	repeat
	
	begin
	// Saisie des deux mots sur l'entree standard
	write('Entrer le premier mot : ');readln(U);
	write('Entrer le deuxieme mot : ');readln(V);
	writeln;
	
	// Affichage de la Table
	afficherTableau(getTableDynamique(U,V),U,V);
	
	writeln;
	writeln('   VERSION RECURSIVE : ');writeln;

	rec:= distance_recursive(U,V);
	writeln('distance_recursive(',U,',',V,') = ',rec);
	writeln('La distance d''edition entre ',U,' et ',V,' vaut : ',rec);
    
    writeln;
    writeln('   VERSION DYNAMIQUE : ');writeln;
 
	dyn:= distance_dynamique(U,V);
	writeln('distance_dynamique(',U,',',V,') = ',dyn);
	writeln('La distance d''edition entre ',U,' et ',V,' vaut : ',dyn);
		
	// Affichage de la suite des operations
	writeln;
	writeln('   Affichage de la suite des operations : ');
	writeln;
	writeln('   Notation : ');
	writeln(' - l''identite,      que l''on note   | ');
	writeln(' - la substitution, que l''on note  '' '' ');
	writeln(' - l''insertion,     que l''on note   -  sur le mot de depart');
	writeln(' - la suppression,  que l''on note   -  sur le mot d''arrivee');
	writeln;
	writeln('Schema de visualisation des transformations : ');
	afficher(U,V);
	writeln;
	
	// Nouveau Test
	writeln('Souhaiteriez vous reiterer le test ? (Y = oui, N = non )');
	write('Reponse : ');readln(c);
	if ((c = 'N') or (c = 'n')) then Menu := false else clrscr;
	end;
	
	until Menu = false;
	
	writeln;
	writeln('               Author : Djebien Tarik ');
	writeln;
	writeln('                  END OF EXECUTION,');
	write('           PRESS ANY KEY TO EXIT THIS PROGRAM.');
	
repeat until keypressed;
clrscr;
END.
