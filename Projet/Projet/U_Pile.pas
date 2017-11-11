// auteur : Djebien Tarik
// date   : Mai 2010
// objet  : Unite pour la structure de donnée linéaire de PILE (LIFO).

UNIT U_Pile;

INTERFACE

uses SysUtils;

TYPE

(*===============================================================================================*)
(*============================= DEFINITION DU TYPE POINTEUR DE CELLULE===========================*) 
   
   // Pointeur de Cellule (pointeur de noeud de l'arbre)
   P_CELLULE = ^CELLULE;
   
   // Une cellule est un enregistrement qui possede deux champs
   CELLULE = record
     // le premier indique la fin de mot *
     isMot : BOOLEAN;
     // le second represente les 26 lettres de l'alphabet
     Contenu : ARRAY['a'..'z'] of P_CELLULE; (* par default, en pascal, un pointeur est initialisé à nil.*)
   end{CELLULE};

(*=============================== DEFINITION DU TYPE PILE =========================================*)
   
(*         _      __________________                
   PILE = |_|--->|______|___________|
				  valeur  en|dessous
                            |
				  __________v_______ 
				 |______|___________|
				            |
				  __________v_______ 
				 |______|___________|
				            |
				  __________v_______ 
				 |______|___________|
*)
   
   // Un element de la pile est un pointeur de noeud de l'arbre du dictionnaire
   ELEMENT_PILE = P_CELLULE;
   // Une PILE (LIFO) est 
   PILE = ^NIVEAU;
   // composé de plusieurs
   NIVEAU = record
   // contenant chacun 
      valeur : ELEMENT_PILE; // qui est un pointeur de noeud de l'arbre.
      endessous : PILE; // pour acceder au niveau situé sous le niveau au sommet de la PILE.
   end {record};

   PileVide = class(SysUtils.Exception);

const
   PILE_VIDE : PILE = NIL;

   // estPileVide(P) ssi P est vide
   function estPileVide(P : PILE) : BOOLEAN;

   // sommet(P) = element situe au sommet de P
   // declenche une exception si la pile est vide
   function sommet(P : PILE) : ELEMENT_PILE;

   // empile x au sommet de la pile P
   procedure empiler(const x : ELEMENT_PILE; var P : PILE);

   // depile x la pile P
   // declenche une exception si la pile est vide
   procedure depiler(var P : PILE);
   
IMPLEMENTATION

// estPileVide(P) ssi P est vide
function estPileVide(P : PILE) : BOOLEAN;
begin
   estPileVide := (p = PILE_VIDE);
end { estPileVide };

// sommet(P) = element situe au sommet de P
// CU : declenche une exception si la pile est vide
function sommet(P : PILE) : ELEMENT_PILE;
begin
   if estPileVide(p) then
      raise PileVide.create('Pile Vide')
   else
      sommet := p.valeur;
end {sommet};

// empile l'element x au sommet de la pile P
procedure empiler(const x : ELEMENT_PILE; var P : PILE);
var
   q : PILE;
begin
   new(q);
   q.valeur := x;
   q.endessous := p;
   p := q;
end {empiler};

// depile l'élement x au sommet de la pile P
// CU : declenche une exception si la pile est vide
procedure depiler(var P : PILE);
var
   q : PILE;
begin
   if estPileVide(p) then
      raise PileVide.create('Impossible de depiler : Pile Vide')
   else begin
      q := p;
      p := p.endessous;
      dispose(q);
   end {if};
end {depiler};

INITIALIZATION

(* UNITE MANIPULATION DE STRUCTURE DE DONNEE LINEAIRE DE PILE (LIFO) *)
(* ANNEXE : Prototypes *)
 
   
(* SELECTEURS
     
  function sommet(P : PILE) : ELEMENT_PILE;
     
(* PREDICATS 
  
  function estPileVide(P : PILE) : BOOLEAN;  
      
(* MODIFICATEURS 
  
  procedure empiler(const x : ELEMENT_PILE; var P : PILE);
  procedure depiler(var P : PILE);
  
*)

FINALIZATION
     
(* Auteur, Djebien Tarik  *)

END {U_Pile}.
