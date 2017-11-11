unit U_FacturesCheques;

interface

uses U_Element, U_Tableaux;

// cree un tableau avec les numeros de factures de 1  nombre
// chaque numero est present une seule fois
function factures (nombre : CARDINAL) : TABLEAU;

// cree un tableau de cheques a partir du tableau factures dans lequel nb_impayes numeros de factures sont supprimes
function cheques (factures : TABLEAU; nb_impayes : CARDINAL) : TABLEAU;


implementation

procedure echanger (var t : TABLEAU; const i, j : CARDINAL);
var
   tmp : ELEMENT;
begin
   tmp  := t[i];
   t[i] := t[j];
   t[j] := tmp;
end {echanger};

procedure melanger (var t : TABLEAU);
var
   i, j : CARDINAL;
begin
   for i := low(t) to high(t) do begin
      j := random(high(t));
      echanger(t,i,j);
   end {for};
end {melanger};

function factures (nombre : CARDINAL) : TABLEAU;
var
   t : TABLEAU;
begin
   t := tableauCroissant(nombre);
   melanger(t);
   factures := t;
end {factures};
   

function cheques (factures : TABLEAU; nb_impayes : CARDINAL) : TABLEAU;
var
   indices : TABLEAU;
   i : CARDINAL;
begin
   indices := tableauCroissant(length(factures) - nb_impayes);
   melanger(indices);
   for i := low(indices) to high(indices) do
      indices[i] := factures[indices[i]];
   cheques := indices;
end {cheques};

initialization
   
   randomize;
   
end {U_FacturesCheques}.