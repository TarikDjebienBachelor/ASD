// auteur : Jean-Stéphane Varré
// date   : 2010
// objet  : Unite pour la lecture de fichier texte en pascal.
// UE     : Info 204 - ASD - Université Lille 1

unit U_FichierTexte;

interface

uses SysUtils;

type
   FinDeFichier = class(SysUtils.Exception);

procedure ouvrir (nom : STRING);

function lireMotSuivant : STRING;

function lectureTerminee : BOOLEAN;

procedure fermer;

implementation

var
   fic : TEXT;
   ligne : STRING;
   
   function lectureTerminee : BOOLEAN;
   begin
      lectureTerminee := eof(fic);
   end {lectureTerminee};
   
   procedure ligneSuivante;
   begin
      if eof(fic) then
         raise FinDeFichier.create('Fin de fichier');
      readln(fic,ligne);
   end {ligneSuivante};
   
   procedure ouvrir (nom : STRING);
   begin
      assign(fic, nom);
      reset(fic);
   end {ouvrir};
   
   function lireMotSuivant : STRING;
   var
      mot : STRING;
      p : CARDINAL;
   begin
      if length(ligne) = 0 then
         ligneSuivante;
      p := pos(' ',ligne);
      if p <> 0 then begin
         mot := trim(copy(ligne,1,p));
         delete(ligne,1,p);
         ligne := trim(ligne);
      end else begin
         mot := ligne;
         ligne := '';
      end;
      if length(mot) = 0 then
         lireMotSuivant := lireMotSuivant
      else
         lireMotSuivant := mot;
   end {lireMotSuivant};
   
   procedure fermer;
   begin
      ligne := '';
      close(fic);
   end {fermer};
   
initialization
   
   ligne := '';
   
end {U_FichierTexte}.
