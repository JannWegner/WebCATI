//%attributes = {}
  //Unterscheidet nach Formulartypen und beschreibt danach die Codespalten
  //Codespalte ist bereits numerisch!

$Ziel:=$1
$Antwort:=$2
$Spalte:=$3
$FormName:=$4
$SpaltenAnzahl:=$5
$KKA:=$6
$Solos:=$7

Case of 
	: ($FormName="gen_Zahl")
		If ($Antwort=$KKA)
			BinaerSchreiben ($Ziel;"Y";$Spalte-$SpaltenAnzahl+1)
		Else 
			If ($Antwort[[Length:C16($Antwort)]]#" ")
				$Antwort:=String:C10(Num:C11($Antwort);("0"*$SpaltenAnzahl))
				For ($lauf;1;$SpaltenAnzahl)
					BinaerSchreiben ($Ziel;Substring:C12($Antwort;$lauf;1);$Spalte-$SpaltenAnzahl+$lauf)
				End for 
			End if 
		End if 
	: ($FormName="gen_Dezimal")
		If ($Antwort=$KKA)
			BinaerSchreiben ($Ziel;"Y";$Spalte-$SpaltenAnzahl+1)
		Else 
			If ($Antwort[[Length:C16($Antwort)]]#" ")
				$VorkommaErlaubt:=Num:C11(Substring:C12($Solos;1;Position:C15(".";$Solos)-1))
				$NachkommaErlaubt:=Num:C11(Substring:C12($Solos;Position:C15(".";$Solos)+1))
				If (Position:C15(",";$Antwort)=0)
					$Antwort:=$Antwort+","
				End if 
				$Vorkomma:=Substring:C12($Antwort;1;Position:C15(",";$Antwort)-1)
				$Nachkomma:=Substring:C12($Antwort;Position:C15(",";$Antwort)+1)
				$Antwort:=String:C10(Num:C11($Vorkomma);("0"*$VorkommaErlaubt))+$Nachkomma+("0"*($NachkommaErlaubt-Length:C16($Nachkomma)))
				For ($lauf;1;$SpaltenAnzahl)
					BinaerSchreiben ($Ziel;Substring:C12($Antwort;$lauf;1);$Spalte-$SpaltenAnzahl+$lauf)
				End for 
			End if 
		End if 
	: ($FormName="gen_Multi")
		  //Antwort wurde beim Speichern im Format mit Komma getrennt abgelegt
		  //Test, ob kkA-Feld vorhanden
		If ($Antwort="Y")
			BinaerSchreiben ($Ziel;$Antwort;$Spalte-$SpaltenAnzahl+1)
		Else 
			$Antwort:=Replace string:C233($Antwort;",";"")
			For ($lauf;1;$SpaltenAnzahl)
				BinaerSchreiben ($Ziel;$Antwort[[$lauf]];($Spalte-$SpaltenAnzahl+$lauf))
			End for 
		End if 
		
	: (($FormName="gen_FA") | ($FormName="gen_kFgA") | ($FormName="gen_gFkA") | ($FormName="gen_gggFkA") | ($FormName="gen_Spez") | ($FormName="gen_1b@") | ($FormName="gen_Halboffen"))
		$Antwort:=$Antwort+","
		ARRAY INTEGER:C220(aiZehnerstelle;0)
		ARRAY TEXT:C222(asZehnerstellenWert;0)
		While (Length:C16($Antwort)>1)
			$KommaPos:=Position:C15(",";$Antwort)
			$Einzelantwort:=String:C10(Num:C11(Substring:C12($Antwort;1;$KommaPos-1));"00")
			$Zehner:=Num:C11(Substring:C12($Einzelantwort;1;1))
			$Einer:=Substring:C12($Einzelantwort;2;1)
			If (($Einer="0") & ($Zehner>0))
				$Zehner:=$Zehner-1
			End if 
			$ZehnerStellenPos:=Find in array:C230(aiZehnerstelle;$Zehner)
			If ($ZehnerStellenPos=-1)
				INSERT IN ARRAY:C227(aiZehnerstelle;1;1)
				INSERT IN ARRAY:C227(asZehnerstellenWert;1;1)
				aiZehnerstelle{1}:=$Zehner
				$ZehnerStellenPos:=1
			End if 
			asZehnerstellenWert{$ZehnerStellenPos}:=asZehnerstellenWert{$ZehnerStellenPos}+","+$Einer
			$Antwort:=Substring:C12($Antwort;$KommaPos+1)
		End while 
		
		For ($lauf;1;Size of array:C274(aiZehnerstelle))
			BinaerSchreiben ($Ziel;Substring:C12(asZehnerstellenWert{$lauf};2);$Spalte-$SpaltenAnzahl+aiZehnerstelle{$lauf}+1)
		End for 
	Else 
		ALERT:C41("p_ExportBinaerDGProz:"+Char:C90(13)+"Formular '"+$FormName+"' gibt es nicht!")
End case 
