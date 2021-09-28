//%attributes = {}
  //Führt Aktionen aus, die in einem do-Formular definiert sind

$WeiterMit_NeuArgument:=""

Case of 
		  //Meldungen auf den Schirm bringen
	: ([Bogen:6]Bedingung:10="alert")
		ALERT:C41(Substring:C12([Bogen:6]FText:3;1;255))
		
		  //Antwort aus Liste bestätigen lassen
	: ([Bogen:6]Bedingung:10="alert(@")
		$vsParameter:=Substring:C12([Bogen:6]FText:3;Position:C15("$$";[Bogen:6]FText:3)+4)+" "
		$vsParameter:=Replace string:C233(Substring:C12($vsParameter;1;Position:C15(" ";$vsParameter)-3);Char:C90(34);"")
		$vsFrage:=Substring:C12($vsParameter;1;Position:C15(";";$vsParameter)-1)
		$vsListe:=Substring:C12($vsParameter;Position:C15(";";$vsParameter)+1)
		QUERY:C277([Hilfslisten:3];[Hilfslisten:3]Umfrage:1=vUmfrage;*)
		QUERY:C277([Hilfslisten:3]; & [Hilfslisten:3]ListenID:2=$vsListe)
		If (Records in selection:C76([Hilfslisten:3])=0)
			ALERT:C41("do_action(alert):"+Char:C90(13)+"Keine Liste '"+$vsListe+"' gefunden!")
		Else 
			QUERY SELECTION:C341([Hilfslisten:3];[Hilfslisten:3]LabelID:3=Num:C11(id2feld ($vsFrage)))
			$WeiterMit_NeuArgument:=Substring:C12([Bogen:6]Bedingung:10;8;Length:C16([Bogen:6]Bedingung:10)-9)
			Case of 
				: (Records in selection:C76([Hilfslisten:3])=0)
					ALERT:C41("do_action(alert):"+Char:C90(13)+"Keine Listenelement '"+id2feld ($vsFrage)+"' in '"+$vsListe+"' gefunden!")
				: (Records in selection:C76([Hilfslisten:3])>1)
					ALERT:C41("do_action(alert):"+Char:C90(13)+"Listenelement '"+id2feld ($vsFrage)+"' in '"+$vsListe+"' mehrfach gefunden!")
				Else 
					CONFIRM:C162(Replace string:C233([Bogen:6]FText:3;"$$("+Char:C90(34)+$vsFrage+Char:C90(34)+";"+Char:C90(34)+$vsListe+Char:C90(34)+")";"'"+[Hilfslisten:3]Label:4+"'");"Korrekt";"Falsch zurück!")
					If (OK=1)
						$WeiterMit_NeuArgument:=""
					End if 
			End case 
		End if 
		
		  //Infofeld neu basteln und Töpfe setzen
	: (Position:C15("Infofeld";[Bogen:6]Bedingung:10)#0)
		p_Infofeld_Bauen 
		p_QuotenSuchArrayBauen 
		p_QuotenToepfeInAdrSetzen 
		
		
		  //Wert schreiben wie Antwort im Interview schreiben
	: (Position:C15("write(";[Bogen:6]Bedingung:10)#0)
		  //Start festelegen
		$Antwort:=Substring:C12([Bogen:6]Bedingung:10;Position:C15("write(";[Bogen:6]Bedingung:10)+7)
		  //Ende festlegen
		$Antwort:=Substring:C12($Antwort;1;Position:C15(")";$Antwort)-2)
		  //Wenn $Antwort=AdrFeld, dann den Wert des AdrFeldes in FText nehmen
		If ($Antwort="AdrFeld")
			$Antwort:=p_AdrFeldNachInt ([Bogen:6]FText:3)
		End if 
		var2feld (weitermit;$Antwort;"")
		
		  //Antwort von einer Frage in die andere ziehen (wie Antwort im Interview schreiben)
	: (Position:C15("copy(";[Bogen:6]Bedingung:10)#0)
		  //Quelle/Ziel festlegen festelegen
		$vsText:=Substring:C12([Bogen:6]Bedingung:10;Position:C15("copy(";[Bogen:6]Bedingung:10)+6)
		$viSemikolon:=Position:C15(";";$vsText)
		$Quelle:=Substring:C12($vsText;1;$viSemikolon-2)
		$Ziel:=Substring:C12($vsText;$viSemikolon+2;Length:C16($vsText)-$viSemikolon-3)
		var2feld ($Ziel;id2feld ($Quelle);"")
		vt_AktuellerWeg:=vt_AktuellerWeg+$Ziel+Char:C90(13)
		
		
		  //4D-Kommando ausführen
	: (Position:C15("do_command";[Bogen:6]Bedingung:10)#0)
		vbAlleZeilen:=False:C215
		
		If ([Bogen:6]FText:3#"")
			Case of 
				: (Substring:C12([Bogen:6]FText:3;1;7)="Routine")
					$vtFText:=Substring:C12([Bogen:6]FText:3;Position:C15(Char:C90(13);[Bogen:6]FText:3)+1)
					ARRAY TEXT:C222($atAction;0)
					While ($vtFText#"end@")
						INSERT IN ARRAY:C227($atAction;Size of array:C274($atAction)+1)
						$atAction{Size of array:C274($atAction)}:=Substring:C12($vtFText;1;Position:C15(Char:C90(13);$vtFText)-1)
						$vtFText:=Substring:C12($vtFText;Position:C15(Char:C90(13);$vtFText)+1)
					End while 
					For ($viLauf;1;Size of array:C274($atAction))
						EXECUTE FORMULA:C63($atAction{$viLauf})
					End for 
				Else 
					$vtFText:=Substring:C12(((("case"+Char:C90(13)+"1=1"+Char:C90(13))*Num:C11(Not:C34(Substring:C12([Bogen:6]FText:3;1;4)="case")))+[Bogen:6]FText:3);6)+Char:C90(13)+"endcase"
					If (Substring:C12($vtFText;1;4)="alle")
						$vtFText:=Substring:C12($vtFText;6)
						vbAlleZeilen:=True:C214
					End if 
					ARRAY TEXT:C222($atCase;0)
					ARRAY TEXT:C222($atAction;0)
					While ($vtFText#"endcase@")
						INSERT IN ARRAY:C227($atCase;Size of array:C274($atCase)+1)
						INSERT IN ARRAY:C227($atAction;Size of array:C274($atAction)+1)
						$atCase{Size of array:C274($atCase)}:="vbCaseAnt:=("+Substring:C12($vtFText;1;Position:C15(Char:C90(13);$vtFText)-1)+")"
						$vtFText:=Substring:C12($vtFText;Position:C15(Char:C90(13);$vtFText)+1)
						$atAction{Size of array:C274($atAction)}:=Substring:C12($vtFText;1;Position:C15(Char:C90(13);$vtFText)-1)
						$vtFText:=Substring:C12($vtFText;Position:C15(Char:C90(13);$vtFText)+1)
					End while 
					
					For ($viLauf;1;Size of array:C274($atCase))
						vbCaseAnt:=False:C215
						EXECUTE FORMULA:C63($atCase{$viLauf})
						If (vbCaseAnt)
							EXECUTE FORMULA:C63($atAction{$viLauf})
							If (Not:C34(vbAlleZeilen))
								$viLauf:=Size of array:C274($atCase)
							End if 
						End if 
					End for 
					
					
			End case 
		Else 
			ALERT:C41("do_action:"+Char:C90(13)+[Bogen:6]ID:1+" Nix zu tun bei do_command: FText ist leer!")
		End if 
		sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
		
	: (Position:C15("p_Xtra_UmfrSpez_w";[Bogen:6]Bedingung:10)#0)
		$Antwort:=p_Xtra_UmfrSpez 
		var2feld (weitermit;$Antwort;"")
		sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
		
		
	: ([Bogen:6]Bedingung:10="p_Xtra_UmfrSpez")
		p_Xtra_UmfrSpez 
		sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
		
		
		  //Fassung setzen
	: (Position:C15("Fassung";[Bogen:6]Bedingung:10)#0)
		  //Fassung in die Adresse und in die Daten schreiben, falls noch nicht geschehen
		If ([TelefonNummer:4]Fassung:39="")
			[TelefonNummer:4]Fassung:39:=viFassung
			var2feld (weitermit;viFassung;"")
			sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
		End if 
		
		
		  //Wochentag berechnen
	: (Position:C15("Wochentag";[Bogen:6]Bedingung:10)#0)
		  //4D rechnet mit Sonntag=1 bis Samstag=7
		  //Umbiegen auf CATI-Standard Montag=1 bis Sonntag=7
		$viTag:=Day number:C114(Current date:C33)-1
		If ($viTag=0)
			$viTag:=7
		End if 
		var2feld (weitermit;String:C10($viTag);"")
		
		
		  //Datum setzen
	: (Position:C15("Datum";[Bogen:6]Bedingung:10)#0)
		$viTag:=Day of:C23(Current date:C33)
		$viMonat:=Month of:C24(Current date:C33)
		var2feld (weitermit;String:C10($viTag;"00")+String:C10($viMonat;"00");"")
		
		  //Dauer setzen
	: (Position:C15("Dauer";[Bogen:6]Bedingung:10)#0)
		  //$viDauer:=Round((Current time-[TelefonNummer]Start um)/60;0)
		$viDauer:=p_CalcDauerGesamt ([TelefonNummer:4]wmProto:37)
		var2feld (weitermit;String:C10($viDauer;"00");"")
		
		
End case 
weitermit:=weitermit_neu ($WeiterMit_NeuArgument)
