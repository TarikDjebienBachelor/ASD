PROGRAM testListeDc;
uses U_ListeDC;

var L: LISTE;
    c: char;
    e: ELEMENT;
    itdeb,itfin: ITERATEUR;
    
BEGIN
// nouvelleListe
L:=nouvelleListe;
// estListeVide
writeln('la liste est vide ?',estListeVide(L));
// ajouteEnTete
repeat
writeln('Entrez l''element à ajouter en tete de liste :');
readln(e);
ajouterEnTete(e,L);
writeln('voulez-vous ajouter un autre element en tete? oui: o non : n');readln(c);
until c <> 'o';
// ajouteEnQueue
repeat
writeln('Entrez l''element à ajouter en queue de liste :');
readln(e);
ajouterEnQueue(e,L);
writeln('voulez-vous ajouter un autre element en queue? oui: o non : n');readln(c);
until c <> 'o';
// iterateurEnDebut
itdeb:= iterateurEnDebut(@L);
// iterateurEnFin
itfin:= iterateurEnFin(@L);
// estEnDebut
afficherEndroit(L);writeln;
afficherIterateur(itdeb);writeln;
writeln('itdeb est il en debut? ',estEnDebut(itdeb));
writeln('itdeb est il en fin? ',estEnFin(itdeb));
// estEnFin
afficherEndroit(L);writeln;
afficherIterateur(itfin);writeln;
writeln('itfin est il en debut? ',estEnDebut(itfin));
writeln('itfin est il en fin? ',estEnFin(itfin));
// valeur
writeln('valeur(itdeb):',valeur(itdeb));
writeln('valeur(itfin):',valeur(itfin));
// reculer
try
reculer(itdeb);
except
  on IterateurDebut do writeln('itdeb est au debut impossible de reculer.');
end;
afficherEndroit(L);writeln;
afficherIterateur(itdeb);writeln;
// avancer
try
avancer(itfin);
except 
  on IterateurFin do writeln('itfin est deja en fin impossible d''avancer.');
end;
afficherEndroit(L);writeln;
afficherIterateur(itfin);writeln;
// valeur
writeln('avancer itdeb');
avancer(itdeb);
afficherEndroit(L);writeln;
afficherIterateur(itdeb);writeln;
writeln('valeur(itdeb):',valeur(itdeb));
writeln('reculer itfin');
reculer(itfin);
afficherEndroit(L);writeln;
afficherIterateur(itfin);writeln;
writeln('valeur(itfin):',valeur(itfin));
// affichage
writeln('afficherEnvers(L)');
afficherEnvers(L);writeln;
// insertion
afficherEndroit(L);writeln;
afficherIterateur(itfin);writeln;
writeln('insertionAvant de 3 a itfin');
insererAvant(itfin,3);
afficherEndroit(L);writeln;
afficherEndroit(L);writeln;
afficherIterateur(itdeb);writeln;
writeln('insertionApres de 3 a itdeb');
insererApres(itdeb,3);
afficherEndroit(L);writeln;
writeln('insererTrie de 0,5,7 et 9 ');
insererTrie(0,L);
afficherEndroit(L);writeln;
afficherIterateur(itdeb);writeln;
afficherIterateur(itfin);writeln;
insererTrie(5,L);
afficherEndroit(L);writeln;
afficherIterateur(itdeb);writeln;
afficherIterateur(itfin);writeln;
insererTrie(7,L);
afficherEndroit(L);writeln;
afficherIterateur(itdeb);writeln;
afficherIterateur(itfin);writeln;
insererTrie(9,L);
afficherEndroit(L);writeln;
afficherIterateur(itdeb);writeln;
afficherIterateur(itfin);writeln;
writeln('la liste est vide ?',estListeVide(L));
END.
