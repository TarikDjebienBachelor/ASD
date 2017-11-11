// auteur : Djebien Tarik
// date   : Mai 2010
// objet  : Programme Test Correcteur orthographique VERSION BASIQUE.

Program verificateurBasique;

uses U_Dico, U_Liste, U_Edition, U_FichierTexte;

var L : LISTE;
    unMot : MOT;
    plusProche : MOT;
    presence : BOOLEAN;

// procedure de description de l'usage du programme
// utilisee uniquement si usage incorrect
// i.e : si l'utilisateur ne rentre pas de paramètre à l'exécution.
procedure usage(const s : STRING);
   begin
      writeln(stderr,'Nombre de parametres incorrect !');
      writeln(stderr,'Usage : ');
      writeln(stderr,s+' <F> ');
      writeln(stderr,' <F> = nom du fichier.txt contenant le texte a analyser.');
      halt(1);
end {usage};

// procedure qui etant donné un mot à tester et une liste de mots, indique si le mot
// est dans la liste et sinon donne le mot le plus proche au sens de la distance d'édition :
procedure verifier(const m : MOT; const L : LISTE; out estPresent: BOOLEAN; out motLePlusProche : String);
var distanceMinimal,distanceCourante : CARDINAL;
    ll : LISTE;
begin
  // On clone la liste en parametre car elle est en const
  ll := cloner(L);
  distanceCourante := distance_dynamique(m,tete(ll));
  distanceMinimal  := distanceCourante;
  while not(estListeVide(ll)) do begin
    if (distanceCourante = 0) then
    begin
       estPresent := TRUE;
       motLePlusProche := m;
    end
    else 
    begin
    estPresent := FALSE;
    distanceCourante := distance_dynamique(m,tete(ll));
       if ( distanceCourante <= distanceMinimal ) then begin
         distanceMinimal := distanceCourante;
         motLePlusProche := tete(ll);
       end;//if
    end;//if
  ll:= reste(ll);
  end;//while  
end{verifier};    

BEGIN
// Si l'utilisateur oubli le parametre à l'execution
if paramcount() <> 1 then
      usage(paramstr(0))
else

begin      

// Construction du Dictionnaire à partir de dicotest.txt dans une Liste
L := LISTE_VIDE;
L := tousLesMots;

// On affiche les mots du Dictionnaire contenu dans la liste
writeln;
writeln('MON DICTIONNAIRE :');
AfficherListe(L);writeln;
writeln;

// Le fichier textetest.txt est ouvert en paramètre à l'éxécution
// c'est le fichier dont nous allons verifier les fautes d'orthographes.
ouvrir(paramStr(1));

// Verification orthographique pour chaques mots du textetest.txt grâce à notre dicotest.txt.
while (not(lectureTerminee)) do begin
unMot := lireMotSuivant ;
verifier(unMot,L,presence,plusProche);
// Si le mot n'est pas reconnu par le dictionnaire
 if not(presence) then
// alors on propose le mot le plus proche à celui ci dans le dictionnaire dicotest.txt. 
  begin
 write(unMot);
 write(' -> ');
 writeln(plusProche);
  end;//if
end;//while


// On referme le fichier textetest.txt en fin d'éxécution aprés avoir terminé son analyse.
fermer;
end;//PROGRAMME PRINCIPAL
writeln;
END.{verificateurBasique}
