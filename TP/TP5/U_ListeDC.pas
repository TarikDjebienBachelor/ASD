unit U_ListeDC;
   
interface

uses SysUtils;

type
   ListeVide = class(SysUtils.Exception);
   IterateurFin = class(SysUtils.Exception);
   IterateurDebut = class(SysUtils.Exception);
      
   ELEMENT = CARDINAL;
   
   P_CELLULE = ^CELLULE;
   CELLULE = record 
      elt  : ELEMENT;
      suiv : P_CELLULE;
      prec : P_CELLULE;
   end {CELLULE};
   
   P_LISTE = ^LISTE;
   LISTE = record
      deb : P_CELLULE;
      fin : P_CELLULE;
   end {record};   
   
   ITERATEUR = record
     courant : P_CELLULE;
     plst    : P_LISTE;
   end{ITERATEUR};
   
   function nouvelleListe : LISTE;
   
   // CU : la liste a du etre initialisee avec nouvelleListe
   function estListeVide (l : LISTE) : BOOLEAN;
   
   // CU : la liste a du etre initialisee avec nouvelleListe
   procedure ajouterEnTete(const x : ELEMENT; var l : LISTE);
   
   // CU : la liste a du etre initialisee avec nouvelleListe
   procedure ajouterEnQueue(const x : ELEMENT; var l : LISTE);
   
   // CU : la liste doit contenir au moins un element
   function iterateurEnDebut (l : P_LISTE) : ITERATEUR;  
   
   // CU : la liste doit contenir au moins un element
   function iterateurEnFin (l : P_LISTE)   : ITERATEUR;
   
   // CU : l'iterateur a du etre initialise avec iterateurEnFin ou
   // iterateurEnDebut
   function estEnFin (it : ITERATEUR) : BOOLEAN;
   
   // CU : l'iterateur a du etre initialise avec iterateurEnFin ou
   // iterateurEnDebut
   function estEnDebut (it : ITERATEUR) : BOOLEAN;
   
   // CU : l'iterateur a du etre initialise avec iterateurEnFin ou
   // iterateurEnDebut
   procedure avancer (var it : ITERATEUR);
   
   // CU : l'iterateur a du etre initialise avec iterateurEnFin ou
   // iterateurEnDebut
   procedure reculer (var it : ITERATEUR);
   
   // CU : l'iterateur a du etre initialise avec iterateurEnFin ou
   // iterateurEnDebut
   function valeur (it : ITERATEUR) : ELEMENT;
   
   // CU : l'iterateur a du etre initialise avec iterateurEnFin ou
   // iterateurEnDebut
   procedure insererAvant (var it : ITERATEUR; const x : ELEMENT);
   
   // CU : l'iterateur a du etre initialise avec iterateurEnFin ou
   // iterateurEnDebut
   procedure insererApres (var it : ITERATEUR; const x : ELEMENT);

   procedure insererTrie(const x: ELEMENT; var l: LISTE);
   
   procedure afficherEndroit(l: LISTE);
   
   procedure afficherEnvers(l: LISTE);
   
   procedure afficherIterateur(it: ITERATEUR);
      
implementation

function nouvelleListe : LISTE;
var
   l : LISTE;
begin
   l.deb := NIL;
   l.fin := NIL;
   nouvelleListe := l;
end {nouvelleListe};

function estListeVide(l : LISTE): BOOLEAN;
begin
   estListeVide := (l.deb = NIL) and (l.fin = NIL);
end {estListeVide};


procedure ajouterEnTete (const x : ELEMENT; var l : LISTE);
var
   c : P_CELLULE;
begin
   new(c);
   c.elt := x;
   c.suiv := l.deb;
   c.prec := NIL;
   try
      // leve une exception si la liste est vide avant l'insertion
      l.deb.prec := c;
   except
      l.fin := c;
   end;
   l.deb := c;
end {ajouterEnTete};

procedure ajouterEnQueue(const x : ELEMENT; var l : LISTE);
var
   c : P_CELLULE;
begin
   new(c);
   c.elt := x;
   c.suiv := NIL;
   c.prec := l.fin;
   try
      // leve une exception si la liste est vide avant l'insertion
      l.fin^.suiv := c;
   except
      l.deb := c;
   end;
   l.fin := c;
end {ajouterEnQueue};

   
function iterateurEnDebut (l : P_LISTE) : ITERATEUR;  
var res: ITERATEUR;
begin
   res.plst:= l;
   if (not(estListeVide(l^))) then begin
      res.courant:= l^.deb;
      iterateurEnDebut:= res;
   end else 
      raise ListeVide.create('la liste est vide.');
end{iterateurEnDebut};
   

function iterateurEnFin (l : P_LISTE)   : ITERATEUR;
var res: ITERATEUR;
begin
   res.plst:= l;
   if (not(estListeVide(l^))) then begin
      res.courant:= l^.fin;
      iterateurEnFin:= res;
   end else 
      raise ListeVide.create('la liste est vide.');
end{iterateurEnFin};
   
function estEnFin (it : ITERATEUR) : BOOLEAN;
begin
   estEnFin:= (it.courant = it.plst^.fin);
end{estEnFin};
   
function estEnDebut (it : ITERATEUR) : BOOLEAN;
begin
   estEnDebut:= (it.courant = it.plst^.deb);
end{estEnDebut};

procedure avancer (var it : ITERATEUR);
begin
   if (not(estEnFin(it))) then
     it.courant:= it.courant^.suiv
   else 
     raise IterateurFin.create('iterateur en fin.');
end{avancer};
   
procedure reculer (var it : ITERATEUR);
begin
   if (not(estEnDebut(it))) then
     it.courant:= it.courant^.prec
   else 
     raise IterateurDebut.create('iterateur en debut.');
end{reculer};

function valeur (it : ITERATEUR) : ELEMENT;
begin
   valeur:= it.courant^.elt;
end{valeur};

procedure insererAvant (var it : ITERATEUR ; const x : ELEMENT);
var 
   c : P_CELLULE;
begin
  TRY 
    new(c);
    c^.elt:= x;
    c^.suiv:= it.courant;
    c^.prec:= it.courant^.prec;
    it.courant^.prec^.suiv:= c;
    it.courant^.prec:= c;
    it.courant:= c;
  EXCEPT // si la liste ne contient que un seul élement
    ajouterEnTete(x,it.plst^);
    reculer(it);
  END;
end{insererAvant};
   
procedure insererApres (var it : ITERATEUR; const x : ELEMENT);
var 
   c : P_CELLULE;
begin
  TRY 
    new(c);
    c^.elt:= x;
    c^.prec:= it.courant;
    c^.suiv:= it.courant^.suiv;
    it.courant^.suiv^.prec:= c;
    it.courant^.suiv:= c;
    it.courant:= c;
  EXCEPT // si la liste ne contient que un seul élement
    ajouterEnQueue(x,it.plst^);
    avancer(it);
  END;
end{insererApres};

procedure insererTrie(const x: ELEMENT; var l: LISTE);
var 
  it: ITERATEUR;
  trouve: BOOLEAN;
begin
  it:= iterateurEnDebut(@l);
  trouve:= false;
  while ((not(estEnFin(it))) AND not(trouve)) do begin
    if (valeur(it) <= x) then
       avancer(it)
    else begin
       insererAvant(it,x);
       trouve:= true;
    end;
  end;
  if not(trouve) then begin
  if (valeur(it) <= x) then
     insererApres(it,x)
  else
     insererAvant(it,x);
  end;
end{insererTrie};

procedure afficherEndroit(l: LISTE);
var 
   it: ITERATEUR;
begin
  TRY
    write('[');
    it:= iterateurEnDebut(@l);
    while (not(estEnFin(it))) do begin
       write(valeur(it),',');
       avancer(it);
    end;
    write(valeur(it),']');
  EXCEPT
    on ListeVide do writeln('La liste est vide.');
  END;
end{afficherEndroit};

procedure afficherEnvers(l: LISTE);
var 
   it: ITERATEUR;
begin
  TRY
    write('[');
    it:= iterateurEnFin(@l);
    while (not(estEnDebut(it))) do begin
       write(valeur(it),',');
       reculer(it);
    end;
    write(valeur(it),']');
  EXCEPT
    on ListeVide do writeln('La liste est vide.');
  END;
end{afficherEnvers};

procedure afficherIterateur(it: ITERATEUR);
var 
   it2: ITERATEUR;
   fini: boolean = false;
begin
  TRY
    write(' ');
    it2:= iterateurEnDebut(it.plst);
    while (not(estEnFin(it2))) and not(fini) do begin
       if (it2.courant = it.courant) then
       begin
       write('^');
       fini:= true;
       end
       else begin
       if valeur(it2) >=10 then
       write('  ')
       else
       write(' ');
       avancer(it2);
       end;
       write(' ');
    end;
    if ((it2.courant = it.courant) and not(fini)) then write('^') else write(' ');
  EXCEPT
    on ListeVide do writeln('La liste est vide.');
  END;
end{afficherIterateur};

end {U_ListeDC}.
