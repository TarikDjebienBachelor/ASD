// auteur : Djebien Tarik
// date   : Mai 2010
// objet  : Programme Test Correcteur orthographique VERSION EVOLUE.

Program verificateurEvolue;

uses U_Dico, U_Edition, U_FichierTexte;

var 
  mot : STRING;

// procedure de description de l'usage du programme
// utilisee uniquement si usage incorrect
procedure usage(const s : STRING);
   begin
      writeln(stderr,'Nombre de parametres incorrect !');
      writeln(stderr,'Usage : ');
      writeln(stderr,s+' <F> ');
      writeln(stderr,' <F> = nom du fichier.txt contenant le texte a analyser.');
      halt(1);
end {usage};

  

BEGIN
(*
if paramcount() <> 1 then
      usage(paramstr(0))
else
begin      
// Construction du Dictionnaire à partir de dicotest.txt
construire('dicotest.txt');

// Le fichier textetest.txt est ouvert en paramètre à l'éxécution
ouvrir(paramStr(1));

// Verification orthographique pour chaques mots du textetest.txt
while (not(lectureTerminee)) do begin
unMot := lireMotSuivant ;
// verifier(unMot,monDico,presence,plusProche);
// write(unMot);
// write(' -> ');
// writeln(plusProche);
end;//while

// On referme le fichier textetest.txt en fin d'éxécution.
fermer;

end;//PROGRAMME PRINCIPAL
*)

writeln;
initialiserParcours;
mot := motSuivant;
writeln('function motSuivant : ',mot);
writeln;
END.{verificateurEvolue}

