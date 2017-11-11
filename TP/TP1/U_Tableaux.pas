unit U_Tableaux;

interface

uses U_Element, SysUtils;

const
   VALMAX  = 100;
   
type
   TABLEAU = array of ELEMENT;
   
   // retourne un tableau comprenant des valeurs entre 1 et VALMAX
   function tableauAleatoire (taille : CARDINAL) : TABLEAU;
   
   // retourne un tableau comprenant des valeurs entre 1 et taille tel que t[i] = i
   function tableauCroissant (taille : CARDINAL) : TABLEAU;
   
   // fait une copie de t
   function copieTableau (t : TABLEAU) : TABLEAU;
   
   // affiche le tableau
   procedure afficheTableau (const t : TABLEAU);
   
implementation

   function tableauCroissant (taille : CARDINAL) : TABLEAU;
   var
      t : TABLEAU;
      i : CARDINAL;
   begin
      setlength(t,taille);
      for i := low(t) to high(t) do begin
         t[i] := i;
      end {for};
      tableauCroissant := t;
   end {tableauCroissant};

   function tableauAleatoire (taille : CARDINAL) : TABLEAU;
   var
      t : TABLEAU;
      i : CARDINAL;
   begin
      setlength(t,taille);
      for i := low(t) to high(t) do begin
         t[i] := elementAleatoire(VALMAX);
      end {for};
      tableauAleatoire := t;
   end {tableauAleatoire};
   
   function copieTableau (t : TABLEAU) : TABLEAU;
   var
      tt : TABLEAU;
      i  : CARDINAL;
   begin
      setlength(tt,length(t));
      for i := low(t) to high(t) do
         tt[i] := t[i];
      copieTableau := tt;
   end {copieTableau};
   
   procedure afficheTableau (const t : TABLEAU);
   var
      i : CARDINAL;
   begin
      write('[');
      for i := low(t) to high(t) do begin
         write(t[i]);
         if i < high(t) then write(',');
      end {for};
      write(']');
   end {afficheTableau};
   
initialization
   
   // a commenter pour obtenir toujous les memes tableaux avec des
   // execution successives
   randomize;
   
end {U_Tableaux}.