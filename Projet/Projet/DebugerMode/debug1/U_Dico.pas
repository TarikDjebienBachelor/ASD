unit U_Dico;

interface

uses U_FichierTexte, U_Liste, SysUtils, U_Pile;

type
   
   (* exception si il y en a 
    ??exception = class(SysUtils.Exception);
   *)
 
(*============================================DICO===============================================*)
 
   
   // Pointeur de Cellule (pointeur de noeud de l'arbre)
   P_CELLULE = ^CELLULE;
   
   // type DICTIONNAIRE (un dictionnaire est un arbre)
   DICTIONNAIRE = P_CELLULE;
   
   // Une cellule est un enregistrement qui possede deux champs
   CELLULE = record
     // le premier indique la fin de mot *
     isMot : BOOLEAN; (* par default, en pascal, un booleen est initialisé à false*)
     // le second represente les 26 lettres de l'alphabet
     Contenu : ARRAY['a'..'z'] of P_CELLULE; (* par default, en pascal, un pointeur est initialisé à nil.*)
   end{CELLULE};

(*============================================MOT===============================================*)
   
   // type MOT = une chaine de caractere
   MOT = STRING;

(*============================================LISTE de P_CELLULE ===============================================*)
   ELEMENT = P_CELLULE;
   LISTE_P_CELLULE = ^NOEUD;
   NOEUD = record
      tete  : ELEMENT;
      reste : LISTE_P_CELLULE;
   end {NOEUD};
   ListePCelluleVide = class(SysUtils.Exception);

const
   LISTE_VIDE_PC : LISTE_P_CELLULE = NIL;

(*============================================Primitive Liste===============================================*)

   function ajouterEnTetePC(const l : LISTE_P_CELLULE; const x : ELEMENT): LISTE_P_CELLULE;
   
   function tetePC(l : LISTE_P_CELLULE) : ELEMENT;
   
   function restePC(l : LISTE_P_CELLULE) : LISTE_P_CELLULE;
   
   procedure modifierTetePC(var l : LISTE_P_CELLULE; x : ELEMENT);
   
   function estListeVidePC(l : LISTE_P_CELLULE): BOOLEAN;

// Ajout d'un mot dans le dictionnaire
procedure ajouter (mot : MOT);

// Construction du dictionnaire à partir d'un fichier
procedure construire(fichier : STRING);

// Construction d'une liste contenant tous les mots du dico.txt
//function tousLesMots : LISTE;

//(*
function  tousLesMots : LISTE;
procedure RechercheDesMots(noeud : P_CELLULE; out L : LISTE; var chaine : STRING; var profondeur : INTEGER; L_PC : LISTE_P_CELLULE);
//*)

implementation

var
   monDico : DICTIONNAIRE;
   i : integer;
   
procedure ajouter (mot : MOT);
var      i : integer;
       p,racine : P_CELLULE;
begin
//writeln('appel de ajouter(',mot,')');
    racine := monDico;
    //writeln('adresse racine =',cardinal(racine));
    //writeln('isMot du noeud courant = ',monDico^.isMot);
    //writeln;
    for i:=1 to length(mot) do begin
    //writeln('For i = ',i);
	//writeln('length(',mot,') = ',length(mot));
      // Si il n'existe pas de fils pour la lettre mot[i] :
      if (monDico^.contenu[mot[i]]=NIL) then begin 
		// On cree une nouvelle cellule :
		new(p);
		// On passe la valeur par default de true à false du champ isMot
		p^.isMot := false;
		//writeln('la valeur par default de isMot du noeud cree :',p^.isMot);
		//writeln('adresse de la nouvelle cellule creer : ',cardinal(p));
		// On fait le chainage vers la cellule crée :
		//writeln('procedure ajouter : ',mot[i]);
		monDico^.contenu[mot[i]]:= p;
		//writeln('adresse de monDico^.contenu[mot[i]] : ',cardinal(monDico^.contenu[mot[i]]) );
		// On passe au fils suivant :
		//writeln('ajouter / 1.on passe au fils suivant');	
		monDico := p ;
		//writeln('On se retrouve à l''adresse de monDico : ',cardinal(monDico));writeln;
		//writeln('isMot du noeud courant = ',monDico^.isMot);
		// Si on se trouve en fin de mot
	    if( i = length(mot))then
	      begin
	      monDico^.isMot := true;
	      //writeln('isMot du noeud courant = ',monDico^.isMot);
	      //writeln('On se retrouve à l''adresse de monDico : ',cardinal(monDico));writeln;
	      monDico := racine;
	      end;
      end else begin
	    //Sinon le fils existe et on passe au fils suivant :
	    //writeln('ajouter / 2.on passe au fils suivant');	    
	    monDico:= monDico^.contenu[mot[i]];
	    //writeln('On se retrouve à l''adresse de monDico : ',cardinal(monDico));writeln;
	    //writeln('isMot du noeud courant = ',monDico^.isMot);
	    //writeln('i = ',i);
	    //writeln('length(',mot,') = ',length(mot));
	    if( i = length(mot))then
	      monDico^.isMot := true; 
        //writeln('if / isMot du noeud courant = ',monDico^.isMot);
      end;//if
    end;//for
//writeln('fin de l''appel de ajouter(',mot,')');
monDico := racine;
//writeln('adresse de monDico final =',cardinal(monDico));
end{ajouter};

procedure construire(fichier : STRING);
begin
   ouvrir(fichier);
   while (not(lectureTerminee)) do begin
     ajouter(lireMotSuivant);
   end;//while
   fermer;
end{construire};

(*
function tousLesMots : LISTE;
var L : LISTE;
begin
L:= LISTE_VIDE;
L:=ajouterEnTete(L,'babar');
L:=ajouterEnTete(L,'ane');
L:=ajouterEnTete(L,'barbe');
L:=ajouterEnTete(L,'bar');
L:=ajouterEnTete(L,'zut');
L:=ajouterEnTete(L,'presque');
L:=ajouterEnTete(L,'pittoresque');
L:=ajouterEnTete(L,'une');
tousLesMots:= L;
end{tousLesMots};
*)

function tousLesMots : LISTE;
var L : LISTE;
    mot : STRING;
    prof : INTEGER;
    L_PC : LISTE_P_CELLULE;
begin
  L := LISTE_VIDE;
  L_PC :=  LISTE_VIDE_PC;
  mot := '';
  prof := 0;
  
  writeln('adresse de monDico avant fonction tousLesMots : ',cardinal(monDico));
  RechercheDesMots(monDico,L,mot,prof,L_PC);
  writeln('adresse de monDico apres fonction tousLesMots : ',cardinal(monDico));
  tousLesMots := L;
end{tousLesMots};

procedure RechercheDesMots(noeud : P_CELLULE; out L : LISTE; var chaine : STRING; var profondeur : INTEGER; L_PC : LISTE_P_CELLULE);
var i,j : INTEGER;

begin  
  writeln('debut procedure adresse de monDico : ',cardinal(monDico));
  for j:= ord('a') to ord('z') do begin
  writeln('on est ds for de j ');
  writeln(char(j),' : ', cardinal(monDico^.contenu[char(j)]) );
  end;
  writeln('on sort du for de j ');
  
  writeln('on rentre dans for de i');
  for i:= ord('a') to ord('z') do begin
  writeln('on est ds for de i ');
  writeln(char(i));
  writeln('profondeur actuelle : ',profondeur);
  writeln('avant IF monDico^.contenu[char(i)] <> NIL = ',monDico^.contenu[char(i)] <> NIL);
    if (monDico^.contenu[char(i)] <> NIL) then begin
      writeln('aprés IF monDico^.contenu[char(i)] <> NIL = ',monDico^.contenu[char(i)] <> NIL);
      writeln('chaine avant modif :',chaine);
      chaine  := chaine + char(i);
      writeln('chaine aprés modif :',chaine);
      L_PC := ajouterEnTetePC(L_PC,monDico);
      monDico := monDico^.contenu[char(i)];
      profondeur:= profondeur + 1;
      
      writeln('on descend dans l''arbre');
      writeln('adresse de monDico : ',cardinal(monDico));
      writeln('profondeur actuelle : ',profondeur);
      if (monDico^.isMot) then 
      begin
      L := ajouterEnTete(L,chaine);
      chaine := copy(chaine,profondeur,0);
      writeln('la tete de L vaut : ',tete(L));
      AfficherListe(L);writeln;
      end;
      writeln('avant appel recursif adresse de monDico : ',cardinal(monDico));
      RechercheDesMots(monDico,L,chaine,profondeur,L_PC);
      monDico := tetePC(L_PC);
      L_PC := restePC(L_PC);
      writeln('aprés appel recursif adresse de monDico : ',cardinal(monDico));
      profondeur:= profondeur - 1;
      writeln('on remonte dans l''arbre');
      writeln('adresse de monDico : ',cardinal(monDico));
    end;//if
  end;//for
  writeln('on sort du for de i ');
  (*
    racine := monDico;
    while (monDico^.isMot = false) do begin
      
      // Si il n'existe pas de fils pour la lettre mot[i] :
      if (monDico^.contenu[mot[i]]=NIL) then begin 
		// On cree une nouvelle cellule :
		//new(p);
		// On passe la valeur par default de true à false du champ isMot
		//p^.isMot := false;
		 
		// On fait le chainage vers la cellule crée :
	 
		//monDico^.contenu[mot[i]]:= p;
		 
		// On passe au fils suivant :
		 
		monDico := p ;
		 
		// Si on se trouve en fin de mot
	    if( i = length(mot))then
	      begin
	      monDico^.isMot := true;
	      
	      monDico := racine;
	      end;
      end else begin
	    //Sinon le fils existe et on passe au fils suivant :
	       
	    monDico:= monDico^.contenu[mot[i]];
	  
	    if( i = length(mot))then
	      monDico^.isMot := true; 
       
      end;//if
    end;//while
 
monDico := racine;
 *)
  
  
end{RechercheDesMots};





function ajouterEnTetePC(const l : LISTE_P_CELLULE; const x : ELEMENT): LISTE_P_CELLULE;
   var
      res : LISTE_P_CELLULE = NIL;
   begin
      new(res);
      res.tete := x;
      res.reste := l;
      ajouterEnTetePC := res;
   end {ajouterEnTete};
   
   function tetePC(l : LISTE_P_CELLULE) : ELEMENT;
   begin
      if l = LISTE_VIDE_PC then
         raise ListePCelluleVide.create('Impossible d acceder a la tete');
      tetePC := l.tete;
   end {tete};
   
   function restePC(l : LISTE_P_CELLULE) : LISTE_P_CELLULE;
   begin
      if l = LISTE_VIDE_PC then
         raise ListePCelluleVide.create('Impossible d acceder a la tete');
      restePC := l.reste;
   end {reste};
   
   function estListeVidePC(l : LISTE_P_CELLULE): BOOLEAN;
   begin
      estListeVidePC := l = LISTE_VIDE_PC;
   end {estListeVide};
     
   procedure modifierTetePC(var l : LISTE_P_CELLULE; x : ELEMENT);
   begin
      if l = LISTE_VIDE_PC then
         raise ListePCelluleVide.create('Impossible d acceder a la tete');
      l.tete := x;
   end {modifierTete};
   





initialization

   // Creation d'un dictionnaire Vide.
   new(monDico);
   monDico^.isMot := FALSE;
   for i:= ord('a') to ord('z') do begin
     monDico^.Contenu[char(i)] := NIL;
   end;//for
   
   construire('dicotest.txt');
   
end {U_Dico}.
