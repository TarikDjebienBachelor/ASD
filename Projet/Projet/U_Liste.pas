// auteur : Djebien Tarik
// date   : Mai 2010
// objet  : Unite pour la structure de donnée linéaire de LISTE SIMPLEMENT CHAINEE.

UNIT U_Liste;

INTERFACE

uses
   SysUtils;
   
(*=============================== DEFINITION DU TYPE LISTE =========================================*)


(*          _      _____________      _            *)            
(* LISTE = |_|--->|______|______|--->|_| = LISTE   *)
(*                  info  suivant                  *)

TYPE
   // Un element de la liste est un mot du dictionnaire
   ELEMENT = STRING; // donc une chaine de caractere.
   // Une LISTE est un pointeur de CELLULE
   LISTE = ^CELLULE;
   // Chaque CELLULE possedant
   CELLULE = record 
      // une tete contenant le mot
      tete  : ELEMENT;
      // et un reste contenant un pointeur sur la cellule suivante.
      reste : LISTE;
   end {CELLULE};
   
   
   ListeVide = class(SysUtils.Exception);
   
  
   
const
   // Une liste Vide est un pointeur initialisé à NIL.
   LISTE_VIDE : LISTE = NIL;

(* Constructeur *)
   
   // ajouteEnTete(l,x) = < l;x >
   // ajoute un nouvel élément x au debut de la liste l
   function ajouterEnTete(const l : LISTE; const x : ELEMENT): LISTE;

(* Sélecteurs *)
   
   // tete(l) = le premier élement de la liste l
   // CU : leve une exception si la liste l est vide.
   function tete(l : LISTE) : ELEMENT;
   
   // reste(l) = la liste qui suit le premier élement de la liste l
   // CU : leve une exception si la liste l est vide.
   function reste(l : LISTE) : LISTE;

(* Opérations modificatrices *)
 
   // modifierTete(l,x) modifie la valeur de l'element en tete de l
   // CU : leve une exception si la liste l est vide.
   procedure modifierTete(var l : LISTE; x : ELEMENT);
   
   // modifierReste(l,ll) modifie la valeur du reste de la liste l 
   // en lui attribuant la liste ll
   // CU : leve une exception si la liste l est vide.
   procedure modifierReste(var l : LISTE; const ll : LISTE);

(* Prédicat *)
   
   // estListeVide(l) <=> l est vide
   function estListeVide(l : LISTE): BOOLEAN;

(* Afficheur *)

   // Affiche les élements de la liste L avec les parentheses
   // exemple : (babar,ane,barbe...)
   procedure AfficherListe(const L: LISTE);

(* Constructeur de copie *)   

   // cloner(L) duplique la liste L  
   function cloner(L: LISTE): LISTE;
   
IMPLEMENTATION

   function ajouterEnTete(const l : LISTE; const x : ELEMENT): LISTE;
   var
      res : LISTE = NIL;
   begin
      new(res);
      res.tete := x;
      res.reste := l;
      ajouterEnTete := res;
   end {ajouterEnTete};
   
   function tete(l : LISTE) : ELEMENT;
   begin
      if l = LISTE_VIDE then
         raise ListeVide.create('Impossible d acceder a la tete');
      tete := l.tete;
   end {tete};
   
   function reste(l : LISTE) : LISTE;
   begin
      if l = LISTE_VIDE then
         raise ListeVide.create('Impossible d acceder a la tete');
      reste := l.reste;
   end {reste};
   
   function estListeVide(l : LISTE): BOOLEAN;
   begin
      estListeVide := l = LISTE_VIDE;
   end {estListeVide};
     
   procedure modifierTete(var l : LISTE; x : ELEMENT);
   begin
      if l = LISTE_VIDE then
         raise ListeVide.create('Impossible d acceder a la tete');
      l.tete := x;
   end {modifierTete};
   
   procedure modifierReste(var l : LISTE; const ll : LISTE);
   begin
      if l = LISTE_VIDE then
         raise ListeVide.create('Impossible d acceder a la tete');
      l.reste := ll;
   end {modifierReste};
   
   // Affiche les élements de la liste sans les parentheses
   procedure afficherElementListe(const L: LISTE);
   begin
     if not(estListeVide(L)) then
       begin
         write(tete(L));
         if not(estListeVide(reste(L))) then
           begin
             write(',');
             afficherElementListe(reste(L));
           end{if};
     end{if};
   end{afficherElementListe};

   // Affiche les élements de la liste avec les parentheses
   procedure AfficherListe(const L: LISTE);
   begin
      write('(');
      AfficherElementListe(L);
      write(')');
   end{AfficherListe};
   
    // constructeur de copie de la liste L
    function cloner(L: LISTE): LISTE;
    var
    anc,nouv,debut: LISTE;
    begin
      if estListeVide(L) then 
         cloner:= nil
      else 
        begin
        new(debut);
        debut^.tete := L^.tete;
        anc:= debut;
        anc^.reste:= nil;
        L:= L^.reste;
        while ( not estListeVide(L) ) do begin
          new(nouv);
          nouv^.tete:= L^.tete;
          nouv^.reste:= nil;
          anc^.reste:= nouv;
          anc:= nouv;
          L:= L^.reste;
        end;
      cloner:= debut;
      end;
    end{cloner};

INITIALIZATION

(* UNITE MANIPULATION DE LISTE SIMPLEMENT CHAINEE *)
(* ANNEXE : Prototypes *)


(* CONSTRUCTEURS
    
  function ajouteEnTete(l: LISTE ; const x : ELEMENT): LISTE;
  
(* CONSTRUCTEUR DE COPIE   
 
  function cloner(L: LISTE): LISTE;
   
(* SELECTEURS
     
  function tete(l: LISTE): ELEMENT;  
  function reste(l: LISTE): LISTE;
     
(* PREDICATS 
  
  function estListeVide(l: LISTE): BOOLEAN;  
      
(* MODIFICATEURS 
  
  procedure modifierTete(const l: LISTE ; const x : ELEMENT);  
  procedure modifierReste(const l: LISTE ; const ll: LISTE); 

(* AFFICHEUR 

  procedure AfficherListe(const L: LISTE);
   
*)
FINALIZATION
     
(* Auteur, Djebien Tarik  *)

END {U_Liste}.
