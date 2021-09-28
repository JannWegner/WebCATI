//%attributes = {}
CONFIRM:C162(String:C10(Records in selection:C76([TelefonNummer:4]))+" Interviews drucken?";"Drucken";"Abbrechen")
If (OK=1)
	
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
	QUERY:C277([Bogen:6]; & [Bogen:6]Spezial_Druck:21=True:C214)
	ORDER BY:C49([Bogen:6];[Bogen:6]ID:1)
	  //Die gewünschte BogenID ist die ursprüngliche Frage (ohne "_Spez")
	ARRAY TEXT:C222(asSpezialBogen;0)
	FIRST RECORD:C50([Bogen:6])
	While (Not:C34(End selection:C36([Bogen:6])))
		INSERT IN ARRAY:C227(asSpezialBogen;1)
		asSpezialBogen{1}:=Substring:C12([Bogen:6]ID:1;1;Length:C16([Bogen:6]ID:1)-5)
		If (asSpezialBogen{1}="@.o")
			asSpezialBogen{1}:=Substring:C12(asSpezialBogen{1};1;Length:C16(asSpezialBogen{1})-2)+"Offen"
		End if 
		NEXT RECORD:C51([Bogen:6])
	End while 
	
	
	QUERY SELECTION BY FORMULA:C207([TelefonNummer:4];p_SpezialDruckSuchen )
	
	ORDER BY:C49([TelefonNummer:4];[TelefonNummer:4]AdrFBNr:20)
	
	C_LONGINT:C283(vLprint_height;$vLheight;vLprinted_height)
	C_TEXT:C284(vSprint_area)
	C_BOOLEAN:C305(vBSeiteVoll)
	C_TEXT:C284(vSpezial)
	
	_O_PAGE SETUP:C299([TelefonNummer:4];"Spezial-Druck")
	PRINT SETTINGS:C106(2)
	CONFIRM:C162("Aktueller Drucker ist"+Char:C90(13)+Get current printer:C788+Char:C90(13)+"(Ggf. im PrintCenter wechseln)";"Drucken";"Abbrechen")
	If (OK=1)
		If (OK=1)
			GET PRINTABLE AREA:C703(vLprint_height)
			vLprint_height:=vLprint_height
			
			  //$TrennerLang:=Char(13)+"______________________________________________________________________________"
			$TrennerLang:=Char:C90(13)+"_____________________________________________________________"
			$TrennerKurz:=Char:C90(13)+"------------------------------------------"+Char:C90(13)
			$TrennerMini:=Char:C90(13)+"                                                      ---------------------------"+"-"+Char:C90(13)
			
			vBSeiteVoll:=False:C215
			$AnzahlFB:=String:C10(Records in selection:C76([TelefonNummer:4]))
			$SatzZaehler:=1
			QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
			QUERY:C277([Bogen:6]; & [Bogen:6]Spezial_Druck:21=True:C214)
			ORDER BY:C49([Bogen:6];[Bogen:6]ID:1)
			
			ARRAY TEXT:C222($tBogenID;Records in selection:C76([Bogen:6]))
			ARRAY TEXT:C222($tFilterBogenID;Records in selection:C76([Bogen:6]))
			ARRAY TEXT:C222($tFragenr;Records in selection:C76([Bogen:6]))
			ARRAY TEXT:C222($tFilterFragenr;Records in selection:C76([Bogen:6]))
			ARRAY TEXT:C222($t8offen;Records in selection:C76([Bogen:6]))
			
			MESSAGE:C88("1. Durchgang Bögen")
			$lauf:=1
			FIRST RECORD:C50([Bogen:6])
			While (Not:C34(End selection:C36([Bogen:6])))
				$tBogenID{$lauf}:=[Bogen:6]AvgText:5
				$tFilterBogenID{$lauf}:=[Bogen:6]FText:3
				$lauf:=$lauf+1
				NEXT RECORD:C51([Bogen:6])
			End while 
			
			MESSAGE:C88("2. Durchgang Bögen")
			For ($lauf;1;Size of array:C274($tBogenID))
				QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20="Universell!!";*)
				QUERY:C277([Bogen:6]; | [Bogen:6]Umfrage:20=vUmfrage;*)
				QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=$tBogenID{$lauf})
				  //$tKurztext{$lauf}:=[Bogen]kurzText
				$tFragenr{$lauf}:=[Bogen:6]Fragenummer:2
				If (([Bogen:6]FormNam:8="gen_1b@") | ([Bogen:6]FormNam:8="gen_Halboffen"))
					$t8offen{$lauf}:="offen"
				End if 
				If ($tFilterBogenID{$lauf}#"")
					QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20="Universell!!";*)
					QUERY:C277([Bogen:6]; | [Bogen:6]Umfrage:20=vUmfrage;*)
					QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=$tFilterBogenID{$lauf})
					  //$tFilterKurztext{$lauf}:=[Bogen]kurzText
					$tFilterFragenr{$lauf}:=[Bogen:6]Fragenummer:2
				End if 
			End for 
			
			FIRST RECORD:C50([TelefonNummer:4])
			OPEN PRINTING JOB:C995  // Damit der Job beisammen bleibt ...
			While (Not:C34(End selection:C36([TelefonNummer:4])))
				AntwortArray_Init 
				AntwortArray_Lesen 
				vt_AktuellerWeg:=[TelefonNummer:4]Wegspeicher:48
				
				MESSAGE:C88(String:C10($SatzZaehler)+" / "+$AnzahlFB)
				
				vEnde:=[TelefonNummer:4]Ende am:25
				vDruck:=Current date:C33
				vSeite:=1
				
				vLprinted_height:=0
				
				vSprint_area:="Header"  //Kopfbereich drucken
				$vLheight:=Print form:C5([TelefonNummer:4];"Spezial-Druck";Form header:K43:3)
				$vLheight:=38  //Feste Höhe lt Formular
				vLprinted_height:=vLprinted_height+$vLheight
				
				For ($lauf;1;Size of array:C274($tBogenID))
					  //If (LiA ($tBogenID{$lauf}+$t8offen{$lauf})#"")
					If (Length:C16(LiA ($tBogenID{$lauf}+$t8offen{$lauf}))>2)
						vSpezial:=""
						If ($tFilterBogenID{$lauf}#"")
							  //vSpezial:="                 Filterfrage "+$tFilterFragenr{$lauf}+"  ............  "+id2feld ($tFilterBogenID{$lauf})
							vSpezial:="                 Filterfrage "+$tFilterFragenr{$lauf}+"  ............  "+LiA ($tFilterBogenID{$lauf})
							vSpezial:=vSpezial+$TrennerKurz
						End if 
						vSpezial:=vSpezial+"                 "
						If ($t8offen{$lauf}#"")
							vSpezial:=vSpezial+"(Strichelliste): "
						End if 
						vSpezial:=vSpezial+"Frage "+$tFragenr{$lauf}
						  //vSpezial:=vSpezial+Char(13)+id2feld ($tBogenID{$lauf}+$t8offen{$lauf})
						  //ALERT(String([TelefonNummer]AdrFBNr)+Char(13)+$tFragenr{$lauf}+Char(13)+LiA ($tBogenID{$lauf}+$t8offen{$lauf}))
						vSpezial:=vSpezial+Char:C90(13)+LiA ($tBogenID{$lauf}+$t8offen{$lauf})
						vSpezial:=vSpezial+$TrennerLang
						$vSpezialKopie:=vSpezial
						
						vSprint_area:="Detail"  //Detailbereich drucken
						$vLheight:=Print form:C5([TelefonNummer:4];"Spezial-Druck";Form detail:K43:1)
						
						  //Detailberechnung wird in Formularmethode ausgeführt
						vLprinted_height:=vLprinted_height+$vLheight
						If (vBSeiteVoll)
							vSpezial:=$vSpezialKopie
							vLprinted_height:=0
							vSeite:=vSeite+1
							vSprint_area:="Header"  //Kopfbereich erneut drucken
							$vLheight:=Print form:C5([TelefonNummer:4];"Spezial-Druck";Form header:K43:3)
							$vLheight:=38
							vLprinted_height:=vLprinted_height+$vLheight
							vSprint_area:="Detail"
							$vLheight:=Print form:C5([TelefonNummer:4];"Spezial-Druck";Form detail:K43:1)
							vLprinted_height:=vLprinted_height+$vLheight
							vBSeiteVoll:=False:C215
						End if 
					End if 
				End for 
				PAGE BREAK:C6
				[TelefonNummer:4]SpezialDruck:45:=Current date:C33
				sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
				$SatzZaehler:=$SatzZaehler+1
				NEXT RECORD:C51([TelefonNummer:4])
			End while 
		End if 
		CLOSE PRINTING JOB:C996  // und jetzt los ...
	End if 
Else 
	ALERT:C41("Nix passiert")
End if 