//%attributes = {}
p_LogDatenAktualisieren ("Altersmatrix";vUmfrage;0;"")

  //Berechnet eine Alter x Sex Matrix
If (([Variablen:5]Alter_x_Sex:37#"") & ([Variablen:5]Altersgruppen:39#""))
	C_TEXT:C284(vtStatistikMatrix)
	C_LONGINT:C283($viBreite;$viZeilenSumme;$viGesamtSumme)
	ARRAY TEXT:C222($asSex;0)
	ARRAY INTEGER:C220($aiAltersGruppe;0)
	vtAlterSexMatrix:=""
	$viBreite:=13
	$ptAlterFeld:=Field:C253(4;p_ListenfelderRechnen (Substring:C12([Variablen:5]Alter_x_Sex:37;1;2)))
	$ptSexFeld:=Field:C253(4;p_ListenfelderRechnen (Substring:C12([Variablen:5]Alter_x_Sex:37;3;2)))
	
	CONFIRM:C162("Alter x Sex für letzte Auswahl (n="+String:C10(Records in selection:C76([TelefonNummer:4]))+") oder alle fertigen Interviews?";"Alle";"Auswahl")
	If (OK=1)
		QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
		QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Komplett")
	End if 
	
	DISTINCT VALUES:C339($ptSexFeld->;$asSex)
	SORT ARRAY:C229($asSex)
	
	  //Altersgruppen aufdroeseln
	$vsAltersgruppen:=[Variablen:5]Altersgruppen:39+(Num:C11([Variablen:5]Altersgruppen:39[[Length:C16([Variablen:5]Altersgruppen:39)]]#"|")*"|")
	While (Position:C15("|";$vsAltersgruppen)#0)
		$viTrennPos:=Position:C15("|";$vsAltersgruppen)
		INSERT IN ARRAY:C227($aiAltersGruppe;Size of array:C274($aiAltersGruppe)+1)
		$aiAltersGruppe{Size of array:C274($aiAltersGruppe)}:=Num:C11(Substring:C12($vsAltersgruppen;1;$viTrennPos-1))
		$vsAltersgruppen:=Substring:C12($vsAltersgruppen;$viTrennPos+1)
	End while 
	SORT ARRAY:C229($aiAltersGruppe)
	
	ARRAY INTEGER:C220($aiSpaltenSumme;Size of array:C274($asSex))
	For ($lauf;1;Size of array:C274($asSex))
		$aiSpaltenSumme{$lauf}:=0
	End for 
	
	ARRAY INTEGER:C220($aiAlterSex;Size of array:C274($aiAltersGruppe);Size of array:C274($asSex))
	For ($lauf;1;Size of array:C274($asSex))
		For ($lauf2;1;Size of array:C274($aiAltersGruppe))
			$aiAlterSex{$lauf2}{$lauf}:=0
		End for 
	End for 
	
	
	
	$vbOK:=True:C214
	$viSatzZaehler:=0
	FIRST RECORD:C50([TelefonNummer:4])
	While ((Not:C34(End selection:C36([TelefonNummer:4]))) & $vbOK)
		$viLauf:=0
		$viSatzZaehler:=$viSatzZaehler+1
		If ($viSatzZaehler%10=0)
			MESSAGE:C88(String:C10($viSatzZaehler))
		End if 
		Repeat 
			$viLauf:=$viLauf+1
		Until (($aiAltersGruppe{$viLauf}>=Num:C11($ptAlterFeld->)) | ($viLauf>=Size of array:C274($aiAltersGruppe)))
		
		If ($aiAltersGruppe{$viLauf}>=Num:C11($ptAlterFeld->))
			$aiAlterSex{$viLauf}{Find in array:C230($asSex;$ptSexFeld->)}:=$aiAlterSex{$viLauf}{Find in array:C230($asSex;$ptSexFeld->)}+1
		Else 
			ALERT:C41("m_Alter_x_Sex:"+Char:C90(13)+"Alter von "+String:C10(Num:C11($ptAlterFeld->))+" bei Adresse "+String:C10([TelefonNummer:4]AdrFBNr:20)+" nicht zuzuordnen!"+Char:C90(13)+"Abbruch!")
			$vbOK:=False:C215
		End if 
		
		NEXT RECORD:C51([TelefonNummer:4])
	End while 
	
	
	If ($vbOK)
		vtStatistikMatrix:=p_TextFormat ("Geschlecht";"r";$viBreite)
		For ($lauf;1;Size of array:C274($asSex))
			vtStatistikMatrix:=vtStatistikMatrix+p_TextFormat ($asSex{$lauf};"r";$viBreite)
		End for 
		vtStatistikMatrix:=vtStatistikMatrix+Char:C90(13)+p_TextFormat ("Alter   ";"l";$viBreite)
		For ($laufAlter;1;Size of array:C274($aiAltersGruppe))
			$viZeilenSumme:=0
			vtStatistikMatrix:=vtStatistikMatrix+Char:C90(13)+p_TextFormat ("bis "+String:C10($aiAltersGruppe{$laufAlter});"r";$viBreite)
			For ($laufSex;1;Size of array:C274($asSex))
				vtStatistikMatrix:=vtStatistikMatrix+p_TextFormat (String:C10($aiAlterSex{$laufAlter}{$laufSex};"^^^^");"r";$viBreite)
				$viZeilenSumme:=$viZeilenSumme+$aiAlterSex{$laufAlter}{$laufSex}
				$aiSpaltenSumme{$laufSex}:=$aiSpaltenSumme{$laufSex}+$aiAlterSex{$laufAlter}{$laufSex}
			End for 
			vtStatistikMatrix:=vtStatistikMatrix+"     |"+p_TextFormat (String:C10($viZeilenSumme;"^^^^");"r";$viBreite)
		End for 
		vtStatistikMatrix:=vtStatistikMatrix+Char:C90(13)+Char:C90(13)+(" "*$viBreite)
		For ($lauf;1;Size of array:C274($asSex))
			vtStatistikMatrix:=vtStatistikMatrix+p_TextFormat (String:C10($aiSpaltenSumme{$lauf};"^^^^");"r";$viBreite)
			$viGesamtSumme:=$viGesamtSumme+$aiSpaltenSumme{$lauf}
		End for 
		vtStatistikMatrix:=vtStatistikMatrix+"     |"+p_TextFormat (String:C10($viGesamtSumme;"^^^^");"r";$viBreite)
		DIALOG:C40([Variablen:5];"d_StatistikMatrix")
	End if 
	
Else 
	ALERT:C41("Alter x Geschlecht nicht definiert für diese Umfrage!")
End if 

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
