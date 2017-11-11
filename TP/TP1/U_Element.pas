unit U_Element;

interface

type
   ELEMENT = CARDINAL;
   
   // ecriture du paramètre e sur la sortie standard
   procedure ecrireElement(const e : ELEMENT);
   
   // saisie de la valeur paramètre e sur la sortie standard
   procedure lireElement(out e : ELEMENT);
   
   // egal(e1, e2) = VRAI si et seulement si e1 = e2
   function egal(e1,e2 : ELEMENT) : BOOLEAN;
                                                
   // inferieur(e1, e2) = VRAI si et seulement si e1 < e2
   function inferieur(e1,e2 : ELEMENT) : BOOLEAN;
   
   // inferieurOuEgal(e1, e2) = VRAI si et seulement si e1 <= e2
   function inferieurOuEgal(e1,e2 : ELEMENT) : BOOLEAN;
   
   // renvoie un element aleatoire entre 1 et max
   function elementAleatoire (max : ELEMENT) : ELEMENT;
   
implementation

// egal(e1, e2) = VRAI si et seulement si e1 = e2
function egal(e1,e2 : ELEMENT) : BOOLEAN;
begin
   egal := e1 = e2;
end {egal};
                                                
// inferieur(e1, e2) = VRAI si et seulement si e1 < e2
function inferieur(e1,e2 : ELEMENT) : BOOLEAN;
begin
   inferieur := e1 < e2;
end {inferieur};
   
// inferieurOuEgal(e1, e2) = VRAI si et seulement si e1 <= e2
function inferieurOuEgal(e1,e2 : ELEMENT) : BOOLEAN;
begin
   inferieurOuEgal := e1 <= e2;
end {inferieurOuEgal};

   // ecriture du paramètre e sur la sortie standard
   procedure ecrireElement(const e : ELEMENT);
   begin
      write(e);
   end { ecrireElement };


   // saisie de la valeur paramètre e sur la sortie standard
   procedure lireElement(out e : ELEMENT);
   begin
      read(e);
   end {lireElement};
   
      // renvoie un element aleatoire entre 1 et max
   function elementAleatoire (max : ELEMENT) : ELEMENT;
   begin
      elementAleatoire := random(max);
   end {elementAleatoire};
   
end.
