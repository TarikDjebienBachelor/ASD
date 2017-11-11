// auteur : Djebien Tarik
// date   : Mai 2010
// objet  : Unité pour representation d'un dictionnaire dans une implementation arborescente.

(*============================================================================================*)
(*================== UNITE POUR L' IMPLEMENTATION D'UN DICTIONNAIRE ==========================*)
(*============================================================================================*)

UNIT U_Dico;

INTERFACE


USES 
   U_FichierTexte,
   U_Liste, 
   U_Pile,
   SysUtils;
   
TYPE

   
(*============================================================================================*)
(*==============================  DEFINITION D'UN DICTIONNAIRE  ==============================*)
(*============================================================================================*)
   
(* 
                   _      ___________________________                              
   DICTIONNAIRE = |_|--->|______|a_b_c_d_e_f...x_y_z_|  = CELLULE
                           isMot |   Contenu[a..z]                   
				     			 |
				                 v_______________________________
				                 |______|a_._._.n_._._.________z_|     
				                          isMot |   Contenu[a..z]                   
				     			                |
				                                v_____________________________
				                                |______|a_._._.e_._._.______z_|
				                                         isMot | Contenu[a..z]                   
				     			                               |
				                                               v________________________
				                                               |__*__|/_/_/_/_/_/_/_/_/|
				                                                 isMot   Contenu[a..z]                   

*)
   
   // Pointeur de Cellule (pointeur de noeud de l'arbre)
   P_CELLULE = ^CELLULE;
   
   // type DICTIONNAIRE (un dictionnaire est un arbre)
   DICTIONNAIRE = P_CELLULE;
   
   // Une cellule est un enregistrement qui possede deux champs
   CELLULE = record
     // le premier indique la fin de mot *
     isMot : BOOLEAN; 
     // le second represente les 26 lettres de l'alphabet
     Contenu : ARRAY['a'..'z'] of P_CELLULE; (* par default, en pascal, un pointeur est initialisé à nil.*)
   end{CELLULE};

   // Exception déclenchée dans la fonction motSuivant
   DictionnaireVide = class(SysUtils.Exception);

(*============================================================================================*)
(*================================ DEFINITION D'UN MOT  ======================================*)
(*============================================================================================*)

   
   // type MOT = une chaine de caractere
   MOT = STRING;
   
   
   
(*============================================================================================*)
(*============ DEFINITION D'UNE LISTE DE POINTEUR DE NOEUD DE L'ARBRE ========================*)
(*============================================================================================*)



(*                    _      _____________      _____________      _ _                   
   LISTE_P_CELLULE = |_|--->|______|____--|--->|______|____--|--->|_/_| = LISTE_VIDE_PC   
                              tete  reste        tete   reste          
*)
   
   // Les elements de la liste sont des pointeurs de noeud de l'arbre
   ELEMENT = P_CELLULE;
   
   LISTE_P_CELLULE = ^NOEUD;
   NOEUD = record
      tete  : ELEMENT;
      reste : LISTE_P_CELLULE;
   end {NOEUD};
   
   ListePCelluleVide = class(SysUtils.Exception);

const
   LISTE_VIDE_PC : LISTE_P_CELLULE = NIL;



(*============================================================================================*)
(*============= Definition de Primitive sur les Liste chainée de pointeur de noeud ===========*)
(*============================================================================================*)



(* Constructeur *)
   
   // ajouteEnTetePC(l,x) = < l;x >
   // ajoute un nouvel élement x (qui est une adresse) au debut de la liste l
   function ajouterEnTetePC(const l : LISTE_P_CELLULE; const x : ELEMENT): LISTE_P_CELLULE;

(* Sélecteurs *)
   
   // tetePC(l) = le premier élement de la liste l
   // CU : leve une exception si la liste l est vide.   
   function tetePC(l : LISTE_P_CELLULE) : ELEMENT;
   
   // restePC(l) = la liste qui suit le premier élement de la liste l
   // CU : leve une exception si la liste l est vide.
   function restePC(l : LISTE_P_CELLULE) : LISTE_P_CELLULE;

(* Opérations modificatrices *)
 
   // modifierTetePC(l,x) modifie la valeur de l'element en tete de l
   // CU : leve une exception si la liste l est vide.   
   procedure modifierTetePC(var l : LISTE_P_CELLULE; x : ELEMENT);

(* Prédicat *)
   
   // estListeVidePC(l) <=> l est vide   
   function estListeVidePC(l : LISTE_P_CELLULE): BOOLEAN;


(*============================================================================================*)
(*============= Definition de Primitive sur la manipulation du dictionnaire ==================*)
(*============================================================================================*)


// Ajout d'un mot dans le dictionnaire
procedure ajouter (mot : MOT);

// Construction du dictionnaire à partir d'un fichier
procedure construire(fichier : STRING);

// Construction d'une liste contenant tous les mots du dico.txt
function  tousLesMots : LISTE;

// Procedure auxiliaire utilisé dans la fonction tousLesMots.
procedure RechercheDesMots(dico : P_CELLULE; var L : LISTE;  chaine : STRING; L_PC : LISTE_P_CELLULE);

// Initialise la pile pour le parcours dans le verificateurEvolué :
procedure initialiserParcours;

// Accéder au mot suivant dans le dictionnaire.
// CU : Declenche une exception lorsqu'on a parcouru tous les mots du dictionnaire.
function motSuivant : MOT;

// Procedure auxiliaire utilisé dans la fonction motSuivant.
procedure RechercheUnMot(dico : P_CELLULE; var chaine : STRING; var P : PILE);


IMPLEMENTATION

var
   // Dans tout le projet le dictionnaire est UNIQUE 
   // On le notera :
   monDico : DICTIONNAIRE;
   racineDico : P_CELLULE;
   pileUnique : PILE;
   i : integer;

(*================= procedure ajouter ( mot : MOT ) ======================*)

// Ajout d'un mot dans le dictionnaire  
procedure ajouter (mot : MOT);
var      
   i :          INTEGER;
   p,racine : P_CELLULE;

begin
  
  // On sauvegarde l'adresse de la racine de l'arbre pour pouvoir y remonter.
  racine := monDico;
  
  // On repete autant de fois qu'il y a de lettres dans le mot à ajouter. 
  for i:=1 to length(mot) do begin
  
    // Si il n'existe pas de fils pour la lettre mot[i] :
    if (monDico^.contenu[mot[i]]=NIL) then 
    // Alors
    begin 
		
		// On cree une nouvelle cellule :
		new(p);
		// On passe la valeur par default de true à false du champ isMot
		p^.isMot := false;
		// On fait le chainage vers la cellule crée :
		monDico^.contenu[mot[i]]:= p;
 		// On passe au fils suivant :
		monDico := p ;
		
 		// Si on se trouve en fin de mot
	    if( i = length(mot))then
	    begin
	      // on passe le booleen a VRAI (schematiquement on ajoute l'étoile)
	      monDico^.isMot := true;
	      // on remonte à la racine de l'arbre
  	      monDico := racine;
	    end;
	      
    end else
    // SINON le fils existe deja dans l'arbre 
    begin
	    
	    // et alors on passe directement au fils suivant :
 	    monDico:= monDico^.contenu[mot[i]];
		
		// Si on se retrouve en fin de mot
	    if ( i = length(mot)) then
	    // alors on passe le booleen a VRAI (schematiquement on ajoute l'étoile)
	      monDico^.isMot := true; // Remarque : il est probable que l'étoile existe deja dans certain cas.
    
    end;//if then else
  
  end;//for
 
// Une fois le mot ajouté on retourne en racine de l'arbre 
monDico := racine;
end{ajouter};


(*================= procedure construire ( fichier : STRING ) ======================*)

// Construction du dictionnaire à partir d'un fichier
procedure construire(fichier : STRING);
begin
   
   // on ouvre le fichier dico.txt contenant la liste des mots du dictionnaire
   ouvrir(fichier);
   
   // Tant que l'on a pas lu tous les mots du dico.txt
   while (not(lectureTerminee)) do begin
     // on ajoute le mot lu dans dico.txt dans l'arbre representant le dictionnaire
     ajouter(lireMotSuivant);
   end;//while
   
   // On ferme dico.txt lorsque tous les mots ont été ajouté.
   fermer;

end{construire};

(*============================= procedure tousLesMots : LISTE  ======================*)

// Construction d'une liste contenant tous les mots contenu dans l'arbre representant le dictionnaire.
function tousLesMots : LISTE;
var 
	L : LISTE; // la liste où l'on stockera tout nos mots
    mot : STRING; // le mot à stocker dans la liste.
    L_PC : LISTE_P_CELLULE; // la liste où l'on stockera les adresses des noeuds de l'arbre pour memoriser les parcours.

begin

  // INITIALISATION DES VARIABLES
  L := LISTE_VIDE;
  L_PC :=  LISTE_VIDE_PC;
  mot := '';
  
  // Appel de la Procedure qui recherche tous les mots et construit la liste.
  RechercheDesMots(monDico,L,mot,L_PC);
  
  // On retourne la liste contenant tous les mots,
  // celle ci fut construite par la procedure RechercheDesMots.
  tousLesMots := L;

end{tousLesMots};


(*= procedure RechercheDesMots ( dico : P_CELLULE ; L : LISTE ; var chaine : STRING ; L_PC : LISTE_P_CELLULE) =*)

// Procedure qui recherche tous les mots contenu dans l'arbre representant le dictionnaire.
// et qui modifie la liste L en entrée.
procedure RechercheDesMots(dico : P_CELLULE; var L : LISTE; chaine : STRING; L_PC : LISTE_P_CELLULE);
var 
   i : INTEGER; // l'indice pour la boucle for i 

begin  
   
   // POUR chaques cases du tableau contenu
   for i:= ord('a') to ord('z') do 
   begin
   
     // Si la case courante pointe vers un fils existant
     if (monDico^.contenu[char(i)] <> NIL) then 
     begin
       // On enregistre l'adresse du noeud dans la liste de pointeur L_PC
       L_PC := ajouterEnTetePC(L_PC,monDico);
       // On peut alors à ce moment la passer au fils pointé par cette case
       // car le noeud courant est sauvegardé.
       monDico := monDico^.contenu[char(i)];
           
       // Si on se retrouve sur un noeud etoilé dans l'arbre
       if (monDico^.isMot) then 
       // Alors
       begin
         // on ajoute la chaine qui contient les lettres du mot que l'on a concaténé dans notre Liste.
         L := ajouterEnTete(L,chaine + char(i));
       end;
       
       { !! Attention !! :
         
         A cet instant précis on s'apprete à rentrer dans l'appel recursif.
         On rappelle que l'appel n'est effectué que lors de la descente de la racine vers une feuille de l'arbre.
         A chaque appel, le compilateur empile les appels recursifs.
         Concretement, ici un appel recursif représente le saut dans le parcours en profondeur de l'arbre de noeud en noeud
         du sens : 
         
                             racine => fils = > fils => ....=> feuilles
         
         Propriétés :
         - monDico représente à cet instant l'adresse du noeud à l'instant où l'on se trouve dans l'arbre lors de l'appel.
         - L represente la liste chainée qui contient les mots trouvées dans l'arbre et qui se construit au fur et à mesure du parcours
           de celui-ci.
         - la chaine représente la concaténation de l'ensemble des lettres que l'on a rencontré sur chaque noeud 
           au cours de notre parcours en profondeur de l'arbre.
         - L_PC représente la liste chainnée contenant les adresses des noeuds où nous sommes passés durant le parcours
           en profondeur de l'arbre, on memorise ainsi les branches de l'arbre par lequelles nous sommes passés.
           Ceci permet de revenir sur son chemin par la suite. 
       }
       RechercheDesMots(monDico,L,chaine + char(i),L_PC);
       { !! Attention !! :
         
         A cet instant précis on s'apprete à sortir de l'appel recursif.
         On rappelle que la sortie n'est effectué que lors de la rencontre avec une feuille terminale de l'arbre sans aucun fils.
         A cet instant, le compilateur depile les appels recursifs.
         Concretement, ici un depilement représente le saut inverse dans le parcours en profondeur de l'arbre de noeud en noeud
         dans le sens : 
         
                             racine <= fils <= fils <= ....<= feuilles
         
	   }
	   
	   // Ici pour remonter dans l'arbre à la sortie de l'appel recursif, on utilise notre liste de stockage des noeuds.
	   // En effet, la tete de cette liste nous donne l'adresse du noeud par lequel nous sommes passés précedemment.
	   // C'est pourquoi, on affecte celle-ci au noeud courant pour remonter dans l'arbre :
       monDico := tetePC(L_PC);
       // Ceci etant fait nous pouvons supprimer celle ci dans notre liste de stockage d'adresse.
       L_PC := restePC(L_PC);
     
     end;// FINSI la case de contenu à un fils existant.
   
   end;// FINPOUR  chaques cases du tableau contenu
     
end{RechercheDesMots};

(*===================================== procedure initialiserParcours =========================================*)

// Initialise la pile pour le parcours dans le verificateurEvolué :
procedure initialiserParcours;
begin
   monDico:= racineDico;
   pileUnique := PILE_VIDE;
end {initialiserParcours};

(*===================================== function motSuivant : MOT =============================================*)

// Retourne le mot suivant dans le dictionnaire
// leve une exception lorsqu'on a parcouru tous les mots du dictionnaire.
function motSuivant : MOT;
var 
  motTrouve : MOT;
begin
  motTrouve := '';
  RechercheUnMot(monDico,motTrouve,pileUnique);
  motSuivant:= motTrouve;
end;

(*============ procedure RechercheUnMot(dico : P_CELLULE; var chaine : STRING; var P : PILE) ===================*)

// Procedure qui recherche un mot contenu dans l'arbre representant le dictionnaire.
// et qui modifie la Pile P en entrée.
procedure RechercheUnMot(dico : P_CELLULE; var chaine : STRING; var P : PILE);
var 
   i : INTEGER; // l'indice pour la boucle for i 

begin
   // POUR chaques cases du tableau contenu
   for i:= ord('a') to ord('z') do 
   begin
      // Si la case courante pointe vers un fils existant
      if (monDico^.contenu[char(i)] <> NIL) then 
      begin
       // On empile le noeud courant.
       empiler(U_Pile.P_CELLULE(monDico),P);
       // On peut alors à ce moment la passer au fils pointé par cette case
       // car le noeud courant est sauvegardé dans la pile.
       monDico := monDico^.contenu[char(i)];
       // On ajoute alors la lettre
       chaine := chaine + char(i);
       // Si on se retrouve sur un noeud etoilé dans l'arbre
       if (monDico^.isMot) then 
       begin
          // alors c'est un mot . . .comment interrompre la procedure et la quitter ?
       end
       // Sinon
       else
       begin
       RechercheUnMot(monDico,chaine,P);
       end;//finsi ismot
      end;// FINSI la case de contenu à un fils existant.
   end;// FINPOUR  chaques cases du tableau contenu
 end{RechercheDesMots};

(*============================================================================================*)
(*======= Fin de l'implementation des Primitives sur la manipulation du dictionnaire =========*)
(*============================================================================================*)


(*============================================================================================*)
(*======= Implementation des Primitives sur les Liste chainée de pointeur de noeud ===========*)
(*============================================================================================*)



function ajouterEnTetePC(const l : LISTE_P_CELLULE; const x : ELEMENT): LISTE_P_CELLULE;
var
      res : LISTE_P_CELLULE = NIL;
begin
      new(res);
      res.tete := x;
      res.reste := l;
      ajouterEnTetePC := res;
end {ajouterEnTetePC};
   
function tetePC(l : LISTE_P_CELLULE) : ELEMENT;
   begin
      if l = LISTE_VIDE_PC then
         raise ListePCelluleVide.create('Impossible d acceder a la tete');
      tetePC := l.tete;
end {tetePC};
   
function restePC(l : LISTE_P_CELLULE) : LISTE_P_CELLULE;
   begin
      if l = LISTE_VIDE_PC then
         raise ListePCelluleVide.create('Impossible d acceder a la tete');
      restePC := l.reste;
end {restePC};
   
function estListeVidePC(l : LISTE_P_CELLULE): BOOLEAN;
   begin
      estListeVidePC := l = LISTE_VIDE_PC;
end {estListeVidePC};
     
procedure modifierTetePC(var l : LISTE_P_CELLULE; x : ELEMENT);
   begin
      if l = LISTE_VIDE_PC then
         raise ListePCelluleVide.create('Impossible d acceder a la tete');
      l.tete := x;
end {modifierTete};
   
(*============================================================================================*)
(*=== Fin de l'implementation des Primitives sur les Liste chainée de pointeur de noeud ======*)
(*============================================================================================*)


INITIALIZATION


// Creation d'un dictionnaire Vide :
   new(monDico);
// dont la racine n'est pas etoilé :
   monDico^.isMot := FALSE;
// et ne possède encore aucun fils :
   for i:= ord('a') to ord('z') do begin
     monDico^.Contenu[char(i)] := NIL;
   end;//for
// et dont son adresse est sauvegardé :
   racineDico := monDico;

// La Pile utilisé dans le verificateur evolué est unique et globale :
   pileUnique := PILE_VIDE;

// C'est ici que l'on place le nom du fichier texte contenant le dictionnaire.
// Dans le cadre de notre projet, nous avons dicotest.txt et dico.txt.
// Ceci nous evite alors de reconstruire le dictionnaire dans chaque programme de test.
// En effet, lorsque l'unité est chargé dans le programme de test, elle construit automatiquement
// l'arbre représentant le dictionnaire avec tous les mots contenu dans le fichier texte placé 
// en parametre ici :
   construire('dicotest.txt');


FINALIZATION
     
(* Auteur, Djebien Tarik  *)

(* UNITE IMPLEMENTATION ARBORESCENTE D'UN DICTIONNAIRE *)
(* ANNEXE : Prototypes *)

(* Primitives sur la manipulation du dictionnaire
 
procedure ajouter (mot : MOT);
procedure construire(fichier : STRING);
function  tousLesMots : LISTE;
procedure initialiserParcours;
function motSuivant : MOT;

(* Primitives sur les listes contenant les adresses des noeuds de l'arbre.
   
function ajouterEnTetePC(const l : LISTE_P_CELLULE; const x : ELEMENT): LISTE_P_CELLULE;   
function tetePC(l : LISTE_P_CELLULE) : ELEMENT;
function restePC(l : LISTE_P_CELLULE) : LISTE_P_CELLULE;
procedure modifierTetePC(var l : LISTE_P_CELLULE; x : ELEMENT);    
function estListeVidePC(l : LISTE_P_CELLULE): BOOLEAN;

*)

END {U_Dico}.
