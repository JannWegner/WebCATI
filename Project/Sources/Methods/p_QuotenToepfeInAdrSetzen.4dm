//%attributes = {}
  //'Erzeugt Eintrag im Feld QuotenTopf der Adressen anhand der Merkmale
QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=vUmfrage)


$viFeldNr1:=p_ListenfelderRechnen ([Quoten:7]AdrFeldDim1:14)
$viFeldNr2:=p_ListenfelderRechnen ([Quoten:7]AdrFeldDim2:15)
$viFeldNr3:=p_ListenfelderRechnen ([Quoten:7]AdrFeldDim3:16)
$viFeldNr4:=p_ListenfelderRechnen ([Quoten:7]AdrFeldDim4:17)

If ([Quoten:7]AnzItemDim1:2=1)
	$PartDim1:="01"
Else 
	$PartDim1:=String:C10(p_QuSuchInArray (1;Field:C253(4;$viFeldNr1)->);"00")
End if 
If ([Quoten:7]AnzItemDim2:3=1)
	$PartDim2:="01"
Else 
	$PartDim2:=String:C10(p_QuSuchInArray (2;Field:C253(4;$viFeldNr2)->);"00")
End if 
If ([Quoten:7]AnzItemDim3:4=1)
	$PartDim3:="01"
Else 
	$PartDim3:=String:C10(p_QuSuchInArray (3;Field:C253(4;$viFeldNr3)->);"00")
End if 
If ([Quoten:7]AnzItemDim4:5=1)
	$PartDim4:="01"
Else 
	$PartDim4:=String:C10(p_QuSuchInArray (4;Field:C253(4;$viFeldNr4)->);"00")
End if 

[TelefonNummer:4]QuotenTopf:46:=Find in array:C230(asQuTopfId;$PartDim1+$PartDim2+$PartDim3+$PartDim4)

  //[TelefonNummer]QuotenTopf:=Find in array(asQuTopfId;String(Find in array(asQuItemDim1;Field(4;$viFeldNr1)->);"00")+String(Find in array(asQuItemDim2;Field(4;$viFeldNr2)->);"00")+String(Find in array(asQuItemDim3;Field(4;$viFeldNr3)->);"00")+String(Find in array(asQuItemDim4;Field(4;$viFeldNr4)->);"00"))
