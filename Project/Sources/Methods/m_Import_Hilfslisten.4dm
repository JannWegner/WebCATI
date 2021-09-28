//%attributes = {}
START TRANSACTION:C239
HilfslistenLesenSchreiben 
$vb_ImportOK:=True:C214
CONFIRM:C162("Hilfsliste für aktuelle Umfrage importieren?")
CONFIRM:C162("Datei muss folgende Felder enthalten: ID, Label, Textfeld_1 bis 4")
If (OK=1)
	$vs_ListenID:=Request:C163("Wie soll die Liste heißen?")
	If (OK=1)
		vsDatei:=p_DateiWaehlen (0;vsPfad;vUmfrage+"@")
		If (vsDatei#"")
			FldDelimit:=9
			RecDelimit:=13
			FORM SET INPUT:C55([Hilfslisten:3];"Import_Text")
			USE CHARACTER SET:C205("MacRoman";1)
			IMPORT TEXT:C168([Hilfslisten:3];vsDatei)
			If (OK=1)
				APPLY TO SELECTION:C70([Hilfslisten:3];[Hilfslisten:3]Umfrage:1:=vUmfrage)
				If (OK=1)
					APPLY TO SELECTION:C70([Hilfslisten:3];[Hilfslisten:3]ListenID:2:=$vs_ListenID)
					If (OK=0)
						$vb_ImportOK:=False:C215
					End if 
				Else 
					$vb_ImportOK:=False:C215
				End if 
			Else 
				$vb_ImportOK:=False:C215
			End if 
		Else 
			$vb_ImportOK:=False:C215
		End if 
	End if 
End if 

If ($vb_ImportOK)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
	ALERT:C41("Import hat nicht geklappt!")
End if 