program triInsertion;

uses U_Element, U_Tableaux;

procedure echanger (var t : TABLEAU; const i, j : CARDINAL);
var
   tmp : ELEMENT;
begin
   tmp  := t[i];
   t[i] := t[j];
   t[j] := tmp;
end {echanger};

procedure inserer (var t : TABLEAU; const n : CARDINAL);
var
   i : CARDINAL;
begin
   i := n;
   while (i > low(t)) and (t[i-1] > t[i]) do begin
      echanger(t,i,i-1);
      dec(i);
   end {while};
end {inserer};

procedure trier (var t : TABLEAU);
var
   i : CARDINAL;
begin
   for i := low(t) + 1 to high(t) do begin
      inserer (t,i);
   end {for};
end {trier};

var
   t : TABLEAU;
begin
   t := tableauAleatoire(10);
   afficheTableau(t); writeln;
   trier(t);
   afficheTableau(t); writeln;
end {triInsertion}.

