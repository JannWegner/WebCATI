Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		Case of 
			: ((asDateiListe{asDateiliste}="d_@") | (asDateiListe{asDateiliste}="v_@"))
				  //Es soll tiefer in die Struktur gehen
				vsPfad:=vsPfad+Substring:C12(asDateiListe{asDateiliste};3)+":"
			: (asDateiListe{asDateiliste}="....")
				  //Es soll hoch in der Struktur gehen
				  //Ein Verzeichnis nach oben
				  //->von Rechts nach Doppelpunkt suchen
				$viPosDP:=Length:C16(vsPfad)-1
				While (vsPfad[[$viPosDP]]#":")
					$viPosDP:=$viPosDP-1
				End while 
				vsPfad:=Substring:C12(vsPfad;1;$viPosDP)
			Else 
				  //Eine Datei wurde doppelt geklickt
				vsDatei:=p_DateiWaehlen_DateiGewaehlt (vsPfad+asDateiListe{asDateiliste};viLesenSchreiben)
				If (vsDatei#"")
					ACCEPT:C269
				End if 
		End case 
		p_DateiWaehlen_FelderFuellen (vsPfad;vsFilter)
	: (Form event code:C388=On Clicked:K2:4)
		  //vsFilter:=asDateiListe{asDateiliste}
End case 