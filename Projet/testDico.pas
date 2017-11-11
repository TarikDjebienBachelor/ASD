// auteur : Djebien Tarik
// date   : Mai 2010
// objet  : Programme Test de l'unité U_Dico.

Program testDico;

uses U_Dico, U_Liste;

var L : LISTE;
    

begin
   L := LISTE_VIDE;
   L := tousLesMots;
   
   // On affiche la liste de tous les mots du dictionnaire : monDico
   writeln;writeln('Mon Dictionnaire : ');
   AfficherListe(L);writeln;
   writeln;
   
end.
