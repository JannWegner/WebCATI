//%attributes = {}
$Eingabe:=$1
$FormName:=$2
$Filter:=$3
$ErlaubteWerte:=$4
$MaxAnzahl:=$5
$Solos:=$6
$Max:=$7
$Min:=$8
$KKA:=$9
$Halboffen:=$10
$AvgText:=$11

$EingabeOK:=True:C214

  //Werte fuer Standard-Checks setzen
$Check_EingabeDa:=True:C214
$Check_MaxAnzahlEingaben:=True:C214
$Check_WerteErlaubtKonkret:=True:C214
$Check_WerteErlaubtBereich:=False:C215
$Check_SoloWerte:=True:C214
$Check_8mitOffen:=False:C215
$Check_Halboffen:=False:C215
$Check_OffenText:=False:C215
$Check_Multi:=False:C215
$Check_Doublette:=True:C214
$Check_Dezimal:=False:C215


  //Werte für Ausnahme-Formulare setzen
Case of 
	: ($FormName="gen_Zahl")
		$Check_WerteErlaubtKonkret:=False:C215
		$Check_WerteErlaubtBereich:=True:C214
		
	: ($FormName="gen_Dezimal")
		$Check_WerteErlaubtKonkret:=False:C215
		$Check_WerteErlaubtBereich:=True:C214
		$Check_Dezimal:=True:C214
		$Check_SoloWerte:=False:C215
		$Check_Doublette:=False:C215
		  //Um die Komma-Abfrage zu erleichtern
		$MaxAnzahl:=2
		
	: ($FormName="gen_1b7m8off9kka")
		$Check_8mitOffen:=True:C214
		
	: ($FormName="gen_1bXm8off")
		$Check_8mitOffen:=True:C214
		
	: ($FormName="gen_Halboffen")
		$Check_Halboffen:=True:C214
		
	: ($FormName="gen_OffenText")
		$Check_MaxAnzahlEingaben:=False:C215
		$Check_WerteErlaubtKonkret:=False:C215
		$Check_SoloWerte:=False:C215
		$Check_OffenText:=True:C214
		$Check_Doublette:=False:C215
	: ($FormName="gen_Multi")
		$Check_MaxAnzahlEingaben:=False:C215
		$Check_WerteErlaubtKonkret:=False:C215
		$Check_SoloWerte:=False:C215
		$Check_Multi:=True:C214
		$Check_Doublette:=False:C215
	: ($FormName="NoCheck")
		$Check_EingabeDa:=False:C215
		$Check_MaxAnzahlEingaben:=False:C215
		$Check_WerteErlaubtKonkret:=False:C215
		$Check_SoloWerte:=False:C215
		$Check_Doublette:=False:C215
End case 

$v_Mehrfach:=$Eingabe

  //Eingabe auf Array verteilen
ARRAY TEXT:C222($t_MehrfachPos;1)
While (Position:C15(",";$v_Mehrfach)#0)
	$t_MehrfachPos{Size of array:C274($t_MehrfachPos)}:=Substring:C12($v_Mehrfach;1;Position:C15(",";$v_Mehrfach)-1)
	$v_Mehrfach:=Substring:C12($v_Mehrfach;Position:C15(",";$v_Mehrfach)+1)
	INSERT IN ARRAY:C227($t_MehrfachPos;Size of array:C274($t_MehrfachPos)+1)
End while 
$t_MehrfachPos{Size of array:C274($t_MehrfachPos)}:=$v_Mehrfach

If ($EingabeOK & $Check_EingabeDa)
	  //Check, ob überhaupt eine Eingabe gemacht wurde
	If ((Size of array:C274($t_MehrfachPos)=0) | ($t_MehrfachPos{1}=""))
		$EingabeOK:=False:C215
		ALERT:C41("Irgendwas sollten Sie schon eintippen!")
	End if 
End if 

  //Doubletten-Kontrolle
If ($EingabeOK & $Check_Doublette)
	  //Check, ob ein Wert doppelt eingegeben wurde
	If (Size of array:C274($t_MehrfachPos)>1)
		For ($lauf;1;Size of array:C274($t_MehrfachPos)-1)
			If (Find in array:C230($t_MehrfachPos;$t_MehrfachPos{$lauf};$lauf+1)#-1)
				$EingabeOK:=False:C215
				ALERT:C41("'"+$t_MehrfachPos{$lauf}+"' wurde doppelt eingegeben!")
			End if 
		End for 
	End if 
End if 

If ($EingabeOK & $Check_MaxAnzahlEingaben)
	  //Check, ob Maximale Anzahl von Eingaben eingehalten wurde
	If (Size of array:C274($t_MehrfachPos)>$MaxAnzahl)
		$EingabeOK:=False:C215
		ALERT:C41("Maximal erlaubte Anzahl von "+String:C10($MaxAnzahl)+" überschritten!")
	End if 
End if 

If ($EingabeOK & $Check_WerteErlaubtBereich)
	  //Bereichs-Werte auf Gültigkeit prüfen
	If (($Eingabe#$KKA) & ((Num:C11($Eingabe)<Num:C11($Min)) | (Num:C11($Eingabe)>Num:C11($Max))))
		$EingabeOK:=False:C215
		ALERT:C41("Minimum/Maximum/kkA beachten!")
	End if 
End if 

If ($EingabeOK & $Check_WerteErlaubtKonkret)
	  //Konkrete Werte auf Gültigkeit prüfen
	For ($lauf;1;Size of array:C274($t_MehrfachPos))
		If (Position:C15((","+$t_MehrfachPos{$lauf}+",");$ErlaubteWerte)=0)
			$EingabeOK:=False:C215
			ALERT:C41($t_MehrfachPos{$lauf}+" ist hier nicht erlaubt!")
		End if 
	End for 
End if 


If ($EingabeOK & $Check_SoloWerte & ($Solos#""))
	  //Solo-Werte abchecken
	$Solos:=$Solos+","
	Repeat 
		$SoloWert:=Substring:C12($Solos;1;Position:C15(",";$Solos)-1)
		If ((Find in array:C230($t_MehrfachPos;$Solowert)#-1) & (Size of array:C274($t_MehrfachPos)>1))
			$EingabeOK:=False:C215
			ALERT:C41($Solowert+" darf nur alleine stehen!")
		End if 
		$Solos:=Substring:C12($Solos;Position:C15(",";$Solos)+1)
	Until (Position:C15(",";$Solos)=0)
End if 

  //Anderes nur mit OffenAntwort
If ($EingabeOK & $Check_8mitOffen)
	Case of 
		: ((Find in array:C230($t_MehrfachPos;"8")#-1) & (vAntwOffen=""))
			ALERT:C41("Bei 8=Anderes muß auch Freitext-Antwort vorhanden sein!")
			$EingabeOK:=False:C215
		: ((Find in array:C230($t_MehrfachPos;"8")=-1) & (vAntwOffen#""))
			ALERT:C41("Freitext-Antwort nur in Verbindung mit 8=Anderes zulässig!")
			$EingabeOK:=False:C215
	End case 
End if 

If ($EingabeOK & $Check_Halboffen)
	Case of 
		: ((Find in array:C230($t_MehrfachPos;$Halboffen)#-1) & (Length:C16(vAntwOffen)<=2))
			ALERT:C41("Bei "+$Halboffen+"=Anderes muß auch Freitext-Antwort mit mind. 3 Zeichen vorhanden sein!")
			$EingabeOK:=False:C215
		: ((Find in array:C230($t_MehrfachPos;$Halboffen)=-1) & (vAntwOffen#""))
			ALERT:C41("Freitext-Antwort nur in Verbindung mit "+$Halboffen+"=Anderes zulässig!")
			$EingabeOK:=False:C215
	End case 
End if 

  //Freie Textangabe
If ($EingabeOK & $Check_OffenText)
	Case of 
		: ((Length:C16($Eingabe)=1) & (Position:C15(","+$Eingabe+",";$ErlaubteWerte)#0))
			  //Alles OK, nix zu tun
		: ((Length:C16($Eingabe)=1) & (Position:C15(","+$Eingabe+",";$ErlaubteWerte)=0))
			$EingabeOK:=False:C215
			ALERT:C41($Eingabe+" ist hier als Einzelwert nicht erlaubt!")
		: (Length:C16($Eingabe)<=2)
			$EingabeOK:=False:C215
			ALERT:C41("1 oder 2 Zeichen sind eine etwas kurze Eingabe!")
	End case 
End if 

  //Dezimal-Eingabe
If ($EingabeOK & $Check_Dezimal)
	$VorkommaErlaubt:=Num:C11(Substring:C12($Solos;1;Position:C15(".";$Solos)-1))
	$NachkommaErlaubt:=Num:C11(Substring:C12($Solos;Position:C15(".";$Solos)+1))
	$Eingabe:=String:C10(Num:C11($Eingabe))
	If (Position:C15(",";$Eingabe)=0)
		$Eingabe:=$Eingabe+","
	End if 
	Case of 
		: (Length:C16(Substring:C12($Eingabe;1;Position:C15(",";$Eingabe)-1))>$VorkommaErlaubt)
			ALERT:C41("Es sind nur "+String:C10($VorkommaErlaubt)+" Vorkomma-Stellen erlaubt!")
			$EingabeOK:=False:C215
		: (Length:C16(Substring:C12($Eingabe;Position:C15(",";$Eingabe)+1))>$NachkommaErlaubt)
			ALERT:C41("Es sind nur "+String:C10($NachkommaErlaubt)+" Nachkomma-Stellen erlaubt!")
			$EingabeOK:=False:C215
	End case 
End if 




  //Multi
If ($EingabeOK & $Check_Multi)
	p_Multi_inArray ($AvgText)
	If ((Num:C11($t_MehrfachPos{1})+Num:C11($t_MehrfachPos{2})+Num:C11($t_MehrfachPos{3})+Num:C11($t_MehrfachPos{4})+Num:C11($t_MehrfachPos{5})+Num:C11($t_MehrfachPos{6}))=0)
		ALERT:C41("Irgendwas müssen Sie schon eingeben!")
		$EingabeOK:=False:C215
	Else 
		$kkAPos:=0
		For ($lauf;1;6)
			Case of 
				: ((Num:C11($t_MehrfachPos{$lauf})<(ai_MultiMin{$lauf})) & (Num:C11($t_MehrfachPos{$lauf})#ai_MultikkA{$lauf}))
					ALERT:C41("Wert '"+$t_MehrfachPos{$lauf}+"' in Feld "+String:C10($lauf)+" ist zu klein!")
					$EingabeOK:=False:C215
				: ((Num:C11($t_MehrfachPos{$lauf})>(ai_MultiMax{$lauf})) & (Num:C11($t_MehrfachPos{$lauf})#ai_MultikkA{$lauf}))
					ALERT:C41("Wert '"+$t_MehrfachPos{$lauf}+"' in Feld "+String:C10($lauf)+" ist zu groß!")
					$EingabeOK:=False:C215
			End case 
			$kkAPos:=$kkAPos+($lauf*(Num:C11(ai_MultikkA{$lauf}#-9)))
		End for 
		If ((Num:C11($t_MehrfachPos{$kkAPos})=ai_MultikkA{$kkAPos}) & ((Num:C11($t_MehrfachPos{1})+Num:C11($t_MehrfachPos{2})+Num:C11($t_MehrfachPos{3})+Num:C11($t_MehrfachPos{4})+Num:C11($t_MehrfachPos{5})+Num:C11($t_MehrfachPos{6}))#ai_MultikkA{$kkAPos}))
			ALERT:C41("kkA darf nur alleine stehen!")
			$EingabeOK:=False:C215
		End if 
	End if 
End if 

$0:=$EingabeOK