//%attributes = {}
  //Erzeugt ein Array mit Quotenangaben
MESSAGE:C88("Initialisiere Quoten-Arrays ...")
QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=vUmfrage)

If (Records in selection:C76([Quoten:7])=1)
	  //Größe ermitteln
	C_LONGINT:C283(viAnzahlToepfe)
	viAnzahlToepfe:=[Quoten:7]AnzItemDim1:2*[Quoten:7]AnzItemDim2:3*[Quoten:7]AnzItemDim3:4*[Quoten:7]AnzItemDim4:5
	
	  //Arrays erzeugen
	ARRAY TEXT:C222(asQuTopfId;viAnzahlToepfe)
	ARRAY INTEGER:C220(aiQuSoll;viAnzahlToepfe)
	ARRAY INTEGER:C220(aiQuKomplett;viAnzahlToepfe)
	ARRAY INTEGER:C220(aiQuFix;viAnzahlToepfe)
	ARRAY INTEGER:C220(aiQuVar;viAnzahlToepfe)
	ARRAY INTEGER:C220(aiQuAuto;viAnzahlToepfe)
	ARRAY INTEGER:C220(aiQuNeu;viAnzahlToepfe)
	ARRAY INTEGER:C220(aiQuFrei;viAnzahlToepfe)
	
	ARRAY TEXT:C222(asQuItemDim1;[Quoten:7]AnzItemDim1:2)
	ARRAY TEXT:C222(asQuItemDim2;[Quoten:7]AnzItemDim2:3)
	ARRAY TEXT:C222(asQuItemDim3;[Quoten:7]AnzItemDim3:4)
	ARRAY TEXT:C222(asQuItemDim4;[Quoten:7]AnzItemDim4:5)
	
	p_QuotenArrayLeeren (->asQuItemDim1;"s")
	p_QuotenArrayLeeren (->asQuItemDim2;"s")
	p_QuotenArrayLeeren (->asQuItemDim3;"s")
	p_QuotenArrayLeeren (->asQuItemDim4;"s")
	
	p_QuotenDimItemsSetzen (->asQuItemDim1;[Quoten:7]TextDim1:6)
	p_QuotenDimItemsSetzen (->asQuItemDim2;[Quoten:7]TextDim2:7)
	p_QuotenDimItemsSetzen (->asQuItemDim3;[Quoten:7]TextDim3:8)
	p_QuotenDimItemsSetzen (->asQuItemDim4;[Quoten:7]TextDim4:9)
	
	
	  //TopfID bestücken
	$lauf:=1
	For ($LaufDim1;1;[Quoten:7]AnzItemDim1:2)
		For ($LaufDim2;1;[Quoten:7]AnzItemDim2:3)
			For ($LaufDim3;1;[Quoten:7]AnzItemDim3:4)
				For ($LaufDim4;1;[Quoten:7]AnzItemDim4:5)
					asQuTopfId{$lauf}:=String:C10($LaufDim1;"00")+String:C10($LaufDim2;"00")+String:C10($LaufDim3;"00")+String:C10($LaufDim4;"00")
					$lauf:=$lauf+1
				End for 
			End for 
		End for 
	End for 
	
Else 
	ALERT:C41("p_QuotenAnzeigen:"+Char:C90(13)+"Keine Quotenangaben gefunden!")
End if 
