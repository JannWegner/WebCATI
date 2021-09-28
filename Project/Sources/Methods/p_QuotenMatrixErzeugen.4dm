//%attributes = {}
  //Schleife zum Setzen der Matrix
  //Die Zeilen laufen über Dim2 (grob) und Dim4 (fein), innerhalb die Spalten über Dim1 (grob) und Dim3 (fein)
MESSAGE:C88("Matrix bestücken ...")
C_TEXT:C284(vtQuotenMatrix;$vtQuotenMatrixKS;$vtQuotenMatrixTerm;$vtQuotenMatrixNeu;$vtQuotenMatrixNrFrei)
C_TEXT:C284($vsQuTopfId)
C_LONGINT:C283($viBreiteVorspalte)
$viBreiteVorspalte:=15
QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)

vtQuotenMatrix:=""
$vtQuotenMatrixKS:=""
$vtQuotenMatrixTerm:=""
$vtQuotenMatrixNeu:=""
$vtQuotenMatrixNrFrei:=""
$vtTrenner:="-"*(([Quoten:7]SpaltenBreite:13*[Quoten:7]AnzItemDim1:2*[Quoten:7]AnzItemDim3:4)+([Quoten:7]AnzItemDim1:2*[Quoten:7]AnzItemDim3:4*3)+$viBreiteVorspalte+6)

  //Kopfzeilen schreiben
$vtKopfzeile1:=""
$vtKopfzeile2:=""
$vtKopfzeile3:=""
$vtKopfzeile4:=""
If ([Quoten:7]AnzItemDim1:2=1)
	$Kopf1:=""
Else 
	$Kopf1:=Field:C253(5;Num:C11([Quoten:7]AdrFeldDim1:14)+5)->
End if 
If ([Quoten:7]AnzItemDim2:3=1)
	$Kopf2:=""
Else 
	$Kopf2:=Field:C253(5;Num:C11([Quoten:7]AdrFeldDim2:15)+5)->
End if 
If ([Quoten:7]AnzItemDim3:4=1)
	$Kopf3:=""
Else 
	$Kopf3:=Field:C253(5;Num:C11([Quoten:7]AdrFeldDim3:16)+5)->
End if 
If ([Quoten:7]AnzItemDim4:5=1)
	$Kopf4:=""
Else 
	$Kopf4:=Field:C253(5;Num:C11([Quoten:7]AdrFeldDim4:17)+5)->
End if 
For ($LaufDim1;1;[Quoten:7]AnzItemDim1:2)
	$vtKopfzeile1:=$vtKopfzeile1+((p_TextFormat ($Kopf1;"c";[Quoten:7]SpaltenBreite:13)+" | ")*[Quoten:7]AnzItemDim3:4)
	$vtKopfzeile2:=$vtKopfzeile2+((p_TextFormat (asQuItemDim1{$LaufDim1};"c";[Quoten:7]SpaltenBreite:13)+" | ")*[Quoten:7]AnzItemDim3:4)
	For ($LaufDim3;1;[Quoten:7]AnzItemDim3:4)
		$vtKopfzeile3:=$vtKopfzeile3+(p_TextFormat ($Kopf3;"c";[Quoten:7]SpaltenBreite:13)+" | ")
		$vtKopfzeile4:=$vtKopfzeile4+(p_TextFormat (asQuItemDim3{$LaufDim3};"c";[Quoten:7]SpaltenBreite:13)+" | ")
	End for 
End for 
vtQuotenMatrix:=(" "*$viBreiteVorspalte)+"  ||  "+$vtKopfzeile1+Char:C90(13)+(" "*$viBreiteVorspalte)+"  ||  "+$vtKopfzeile2+Char:C90(13)
If ([Quoten:7]AnzItemDim3:4#1)
	vtQuotenMatrix:=vtQuotenMatrix+(" "*$viBreiteVorspalte)+"  ||  "+$vtKopfzeile3+Char:C90(13)+(" "*$viBreiteVorspalte)+"  ||  "+$vtKopfzeile4+Char:C90(13)
End if 
vtQuotenMatrix:=vtQuotenMatrix+$vtTrenner+Char:C90(13)

For ($LaufDim2;1;[Quoten:7]AnzItemDim2:3)
	For ($LaufDim4;1;[Quoten:7]AnzItemDim4:5)
		For ($LaufDim1;1;[Quoten:7]AnzItemDim1:2)
			For ($LaufDim3;1;[Quoten:7]AnzItemDim3:4)
				$vsQuTopfId:=String:C10($LaufDim1;"00")+String:C10($LaufDim2;"00")+String:C10($LaufDim3;"00")+String:C10($LaufDim4;"00")
				$TopfNr:=Find in array:C230(asQuTopfId;$vsQuTopfId)
				
				$vtQuotenMatrixKS:=$vtQuotenMatrixKS+p_TextFormat ((String:C10(aiQuKomplett{$TopfNr};"^^0")+"/"+String:C10(aiQuSoll{$TopfNr};"^^0"));"r";[Quoten:7]SpaltenBreite:13)+" | "
				$vtQuotenMatrixTerm:=$vtQuotenMatrixTerm+p_TextFormat ((String:C10(aiQuAuto{$TopfNr};"^^0")+"/"+String:C10(aiQuVar{$TopfNr};"^^0")+"/"+String:C10(aiQuFix{$TopfNr};"^^0"));"r";[Quoten:7]SpaltenBreite:13)+" | "
				$vtQuotenMatrixNeu:=$vtQuotenMatrixNeu+p_TextFormat (String:C10(aiQuNeu{$TopfNr};"^^^0");"r";[Quoten:7]SpaltenBreite:13)+" | "
				$vtQuotenMatrixNrFrei:=$vtQuotenMatrixNrFrei+p_TextFormat ((("OO "*Num:C11((aiQuFrei{$TopfNr}=1)))+("•• "*Num:C11((aiQuFrei{$TopfNr}=0))+"|"+String:C10($TopfNr;"^^^^0")));"l";[Quoten:7]SpaltenBreite:13)+" | "
			End for 
		End for 
		vtQuotenMatrix:=vtQuotenMatrix+p_TextFormat ($Kopf2;"l";$viBreiteVorspalte)+"  ||  "+$vtQuotenMatrixKS+Char:C90(13)
		vtQuotenMatrix:=vtQuotenMatrix+p_TextFormat (asQuItemDim2{$LaufDim2};"r";$viBreiteVorspalte)+"  ||  "+$vtQuotenMatrixTerm+Char:C90(13)
		vtQuotenMatrix:=vtQuotenMatrix+p_TextFormat ($Kopf4;"l";$viBreiteVorspalte)+"  ||  "+$vtQuotenMatrixNeu+Char:C90(13)
		vtQuotenMatrix:=vtQuotenMatrix+p_TextFormat (asQuItemDim4{$LaufDim4};"r";$viBreiteVorspalte)+"  ||  "+$vtQuotenMatrixNrFrei+Char:C90(13)
		vtQuotenMatrix:=vtQuotenMatrix+$vtTrenner+Char:C90(13)
		
		$vtQuotenMatrixKS:=""
		$vtQuotenMatrixTerm:=""
		$vtQuotenMatrixNeu:=""
		$vtQuotenMatrixNrFrei:=""
	End for 
End for 
[Quoten:7]Dummy:19:=vtQuotenMatrix
