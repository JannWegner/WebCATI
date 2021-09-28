//%attributes = {}
  //Zählt die antworten der angezeigten und kompletten Bögen aus
$AnzahlSätze:=Records in selection:C76([TelefonNummer:4])
CONFIRM:C162(String:C10($AnzahlSätze)+" Datensätze auszählen?")
If (OK=1)
	QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Komplett")
	If (Records in selection:C76([TelefonNummer:4])#$AnzahlSätze)
		$AnzahlSätze:=Records in selection:C76([TelefonNummer:4])
		ALERT:C41("Nach Bereinigung bleiben nur "+String:C10($AnzahlSätze)+" übrig!")
	End if 
	ORDER BY:C49([TelefonNummer:4]AdrFBNr:20)
	
	  //Array mit den BogenDaten aufbauen
	ARRAY TEXT:C222($asBogenID_Exp;0)
	ARRAY TEXT:C222($asNextID;0)
	ARRAY TEXT:C222($atBedingung;0)
	ARRAY TEXT:C222($asFormName;0)
	ARRAY TEXT:C222($asKKA;0)
	ARRAY TEXT:C222($asSpalte;0)
	ARRAY TEXT:C222($atFText;0)
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
	SELECTION TO ARRAY:C260([Bogen:6]ID:1;$asBogenID_Exp;[Bogen:6]nextID:6;$asNextID;[Bogen:6]Bedingung:10;$atBedingung;[Bogen:6]FormNam:8;$asFormName;[Bogen:6]FText:3;$atFText;[Bogen:6]KKA:18;$asKKA;[Bogen:6]Spalte:12;$asSpalte;[Bogen:6]AnzahlSpalten:24;$ai_AnzahlSpalten;[Bogen:6]Solo:19;$as_Format)
	
	C_LONGINT:C283($vi_lauf1;$vi_lauf2;$viBreite)
	
	  //Zähl-Arrays aufbauen - für jede FBID und mögliche Eingabe eine Zeile
	ARRAY TEXT:C222($asBogenID_Zaehlen;0)
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
	QUERY SELECTION:C341([Bogen:6];[Bogen:6]FormTyp:7="gen";*)
	QUERY SELECTION:C341([Bogen:6]; | [Bogen:6]FormTyp:7="spez";*)
	QUERY SELECTION:C341([Bogen:6]; | [Bogen:6]Bedingung:10="write(@";*)
	QUERY SELECTION:C341([Bogen:6]; | [Bogen:6]FText:3="write"+Char:C90(13)+"@")
	FIRST RECORD:C50([Bogen:6])
	While (Not:C34(End selection:C36([Bogen:6])))
		MESSAGE:C88("Zählarray aufbauen ...  "+[Bogen:6]ID:1)
		  //Sonderfälle besetzen
		Case of 
			: ([Bogen:6]FormNam:8="gen_OffenText")
				INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
				$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+"TEXT"
			: ([Bogen:6]FormNam:8=("gen_Multi"))
				INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
				$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+"TEXT"
				INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
				$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+" KKA"
				
				  //-- Code obsolet / Ersetzt durch gen_Multi / Nur für Rückwärtskompatibilität / 08.05.2007
			: (([Bogen:6]FormNam:8=("gen_"+"@"+"MoJa")) | ([Bogen:6]FormNam:8=("gen_WoMo")))
				INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
				$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+"TEXT"
				INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
				$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+" KKA"
				  // -- Ende Code obslolet / Ersetzt durch gen_Multi / 08.05.2007
				
			: (([Bogen:6]FormNam:8="gen_Zahl") | ([Bogen:6]FormNam:8="gen_Dezimal"))
				INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
				$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+" KKA"
				INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
				$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+"TEXT"
				  //Fuer jede benutzte Spalte und die Zahlen 0-9 ein Feld einrichten
				For ($vi_lauf1;sp2off ([Bogen:6]Spalte:12)-[Bogen:6]AnzahlSpalten:24+1;sp2off ([Bogen:6]Spalte:12))
					For ($vi_lauf2;0;9)
						INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
						$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+String:C10($vi_lauf1;"0000")+"-"+String:C10($vi_lauf2)
					End for 
				End for 
			: ([Bogen:6]FText:3=("write"+Char:C90(13)+"@"))
				$vt_Fragetext:=Substring:C12([Bogen:6]FText:3;7)
				While (Position:C15(" ";$vt_Fragetext)#0)
					INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
					$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+"000"+Substring:C12($vt_Fragetext;Position:C15(" ";$vt_Fragetext)+1;1)
					$vt_Fragetext:=Substring:C12($vt_Fragetext;Position:C15(" ";$vt_Fragetext)+3)
				End while 
			: ([Bogen:6]Bedingung:10=("write("+Char:C90(34)+"AdrFeld"+Char:C90(34)+")"))
				  //Maximale Länge des Adressfelds bestimmen
				FIRST RECORD:C50([TelefonNummer:4])
				$vi_MaxLength:=0
				While (Not:C34(End selection:C36([TelefonNummer:4])))
					$vi_Laenge:=Length:C16(LiA ([Bogen:6]ID:1))
					If ($vi_Laenge>$vi_MaxLength)
						$vi_MaxLength:=$vi_Laenge
					End if 
					NEXT RECORD:C51([TelefonNummer:4])
				End while 
				  //Fuer jede benutzte Spalte und die Zahlen 0-9 ein Feld einrichten
				For ($vi_lauf1;sp2off ([Bogen:6]Spalte:12)-$vi_MaxLength+1;sp2off ([Bogen:6]Spalte:12))
					For ($vi_lauf2;0;9)
						INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
						$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+String:C10($vi_lauf1;"0000")+"-"+String:C10($vi_lauf2)
					End for 
				End for 
				  //Anzahl Spalten noch in BogenArray schreiben
				$ai_AnzahlSpalten{Find in array:C230($asBogenID_Exp;[Bogen:6]ID:1)}:=$vi_MaxLength
				INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
				$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+" Err"
			: ([Bogen:6]Bedingung:10="write(@")
				INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
				$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+String:C10(Num:C11(Substring:C12([Bogen:6]Bedingung:10;Position:C15(Char:C90(34);[Bogen:6]Bedingung:10)+1;Length:C16([Bogen:6]Bedingung:10)-1));"0000")
		End case 
		
		  //Zähler für Anzahl Bögen einrichten
		INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
		$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+"xINT"
		
		  //Berechnete Werte abklappern
		Case of 
			: (([Bogen:6]FormNam:8="gen_Zahl") | ([Bogen:6]FormNam:8="gen_Dezimal"))
				  //Hier gibt's nix zu tun
			: ([Bogen:6]FormNam:8=("gen_"+"@"+"MoJa"))
				  //Hier gibt's nix zu tun
			: ([Bogen:6]FormNam:8="gen_MoJa")
				  //Hier gibt's nix zu tun
			: ([Bogen:6]Bedingung:10="write(@")
				  //Hier gibt's nix zu tun
			: ([Bogen:6]FText:3=("write"+Char:C90(13)+"@"))
				  //Hier gibt's nix zu tun
			Else 
				$vtRestText:=Substring:C12([Bogen:6]ErlaubteWerte:15;2)
				$viKommPos:=Position:C15(",";$vtRestText)
				While ($viKommPos#0)
					INSERT IN ARRAY:C227($asBogenID_Zaehlen;1)
					$asBogenID_Zaehlen{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+"|"+String:C10(Num:C11(Substring:C12($vtRestText;1;$viKommPos-1));"0000")
					$vtRestText:=Substring:C12($vtRestText;$viKommPos+1)
					$viKommPos:=Position:C15(",";$vtRestText)
				End while 
		End case 
		
		NEXT RECORD:C51([Bogen:6])
	End while 
	
	SORT ARRAY:C229($asBogenID_Zaehlen)
	
	ARRAY INTEGER:C220($aiZaehler;Size of array:C274($asBogenID_Zaehlen))
	
	  //kkA-Finder für Multi-Formulare bauen
	p_MultiKKAFinder_bauen 
	
	  //Alle Interviews durchgehen
	FIRST RECORD:C50([TelefonNummer:4])
	$lauf:=1
	$viParkPos:=-1
	While (Not:C34(End selection:C36([TelefonNummer:4])))
		MESSAGE:C88("Adress-/FB-Nr "+String:C10([TelefonNummer:4]AdrFBNr:20)+":   Satz "+String:C10($lauf)+" von "+String:C10($AnzahlSätze))
		  //Antworten einlesen
		AntwortArray_Init 
		AntwortArray_Lesen 
		
		vt_AktuellerWeg:=""
		WeiterMit:=[Variablen:5]ErsteFrage:23
		Repeat 
			$PosInBogen:=Find in array:C230($asBogenID_Exp;WeiterMit)
			  //Um tote Zweige im Fragebogenverlauf auszuklammern, wird der Interviewverlauf rekonstruiert
			vt_AktuellerWeg:=vt_AktuellerWeg+WeiterMit+Char:C90(13)
			Case of 
				: ($PosInBogen=-1)
					ALERT:C41("m_GA:"+Char:C90(13)+WeiterMit+" gibt's in Adress-/FB-Nr "+String:C10([TelefonNummer:4]AdrFBNr:20)+" nicht!")
					ABORT:C156
				: ((WeiterMit="@-bed") & ($atFText{$PosInBogen}#("write"+Char:C90(13)+"@")))  // Bedingung ohne Doku
					EXECUTE FORMULA:C63($atBedingung{$PosInBogen})
					weitermit:=ex_res
				: ((WeiterMit="@-do") & ($atBedingung{$PosInBogen}="copy(@"))
					  //Bei "copy" muß das Kopierziel manuell in vt_AktuellerWeg eingetragen werden
					$vsText:=Substring:C12($atBedingung{$PosInBogen};Position:C15("copy(";$atBedingung{$PosInBogen})+6)
					$viSemikolon:=Position:C15(";";$vsText)
					$Ziel:=Substring:C12($vsText;$viSemikolon+2;Length:C16($vsText)-$viSemikolon-3)
					vt_AktuellerWeg:=vt_AktuellerWeg+$Ziel+Char:C90(13)
					
					WeiterMit:=$asNextID{$PosInBogen}
				: ((WeiterMit="@-do") & ($atBedingung{$PosInBogen}#"write(@"))
					  //Do-Feld, aber nicht "write" oder "copy"
					WeiterMit:=$asNextID{$PosInBogen}
				Else 
					$vsAntwort:=id2feld (WeiterMit)+","
					Case of 
						: ($asFormName{$PosInBogen}="gen_OffenText")
							If (Length:C16($vsAntwort)>2)
								$vsAntwort:="TEXT,"
							End if 
						: (($asFormName{$PosInBogen}=("gen_"+"@"+"MoJa")) | ($asFormName{$PosInBogen}=("gen_WoMo")))
							If (Substring:C12($vsAntwort;1;1)="9")
								$vsAntwort:=" KKA,"
							Else 
								$vsAntwort:="TEXT,"
							End if 
						: ($asFormName{$PosInBogen}="gen_Multi")
							$kkaFinderPos:=Find in array:C230(tMultiKKAFinder;$asBogenID_Exp{$PosInBogen}+"@")
							Case of 
								: ($kkaFinderPos=-1)
									$vsAntwort:="TEXT,"
								: (Num:C11(Substring:C12($vsAntwort;Num:C11(Substring:C12(tMultiKKAFinder{$kkaFinderPos};32;4));Num:C11(Substring:C12(tMultiKKAFinder{$kkaFinderPos};37;4))))=Num:C11(Substring:C12(tMultiKKAFinder{$kkaFinderPos};42;10)))
									$vsAntwort:=" KKA,"
								Else 
									$vsAntwort:="TEXT,"
							End case 
						: (($asFormName{$PosInBogen}="gen_Zahl") | ($asFormName{$PosInBogen}="gen_Dezimal"))
							If ($vsAntwort=($asKKA{$PosInBogen}+","))
								$vsAntwort:=" KKA,"
							Else 
								If ($asFormName{$PosInBogen}="gen_Zahl")
									$vs_AntwStringAufgefuellt:=String:C10(Num:C11($vsAntwort);"0"*$ai_AnzahlSpalten{$PosInBogen})
								Else   //FormName ist Dezimal
									$vi_AnzVorkomma:=Num:C11(Substring:C12($as_Format{$PosInBogen};1;Position:C15(".";$as_Format{$PosInBogen})-1))
									$vi_AnzNachkomma:=Num:C11(Substring:C12($as_Format{$PosInBogen};Position:C15(".";$as_Format{$PosInBogen})+1))
									$vs_AntwStringAufgefuellt:=String:C10(Num:C11(Substring:C12($vsAntwort;1;Position:C15(",";$vsAntwort)-1));"0"*$vi_AnzVorkomma)  //Vorkomma-Teil
									$vs_AntwNachkomma:=Replace string:C233(Substring:C12($vsAntwort;Position:C15(",";$vsAntwort)+1);",";"")
									$vs_AntwStringAufgefuellt:=$vs_AntwStringAufgefuellt+$vs_AntwNachkomma+("0"*($vi_AnzNachkomma-Length:C16($vs_AntwNachkomma)))  //Nachkomma-Teil
								End if 
								$vsAntwort:=""
								For ($vi_Lauf1;1;$ai_AnzahlSpalten{$PosInBogen})
									$vsAntwort:=$vsAntwort+String:C10(sp2off ($asSpalte{$PosInBogen})-$ai_AnzahlSpalten{$PosInBogen}+$vi_Lauf1;"0000")+"-"+$vs_AntwStringAufgefuellt[[$vi_Lauf1]]+","
								End for 
								
								
							End if 
						: ($atBedingung{$PosInBogen}=("write("+Char:C90(34)+"AdrFeld"+Char:C90(34)+")"))
							If ($vsAntwort#"")
								$vs_AntwStringAufgefuellt:=(" "*($ai_AnzahlSpalten{$PosInBogen}-Length:C16($vsAntwort)+1))+$vsAntwort
								$vsAntwort:=""
								For ($vi_Lauf1;1;$ai_AnzahlSpalten{$PosInBogen})
									If ($vs_AntwStringAufgefuellt[[$vi_Lauf1]]=" ")
										$vsAntwort:=" Err,"
									Else 
										$vsAntwort:=$vsAntwort+String:C10(sp2off ($asSpalte{$PosInBogen})-$ai_AnzahlSpalten{$PosInBogen}+$vi_Lauf1;"0000")+"-"+$vs_AntwStringAufgefuellt[[$vi_Lauf1]]+","
									End if 
								End for 
							End if 
							
						: ($atBedingung{$PosInBogen}="write(@")
							$vsAntwort:=String:C10(Num:C11(Substring:C12($atBedingung{$PosInBogen};Position:C15(Char:C90(34);$atBedingung{$PosInBogen})+1;Length:C16($atBedingung{$PosInBogen})-1));"0000")+","
					End case 
					
					  //Antwort zerlegen und Zähler updaten
					$viKommPos:=Position:C15(",";$vsAntwort)
					While ($viKommPos#0)
						$vsAntwortElement:=Substring:C12($vsAntwort;1;$viKommPos-1)
						If (($vsAntwortElement#"TEXT") & ($vsAntwortElement#" KKA") & ($vsAntwortElement#"  mA") & ($vsAntwortElement#"  oA") & ($asFormName{$PosInBogen}#"gen_Zahl") & ($asFormName{$PosInBogen}#"gen_Dezimal") & ($atBedingung{$PosInBogen}#("write("+Char:C90(34)+"AdrFeld"+Char:C90(34)+")")))
							$vsAntwortElement:=String:C10(Num:C11($vsAntwortElement);"0000")
						End if 
						
						$viSuchPos:=Find in array:C230($asBogenID_Zaehlen;p_TextFormat (WeiterMit;"l";30)+"|"+$vsAntwortElement)
						If ($viSuchPos>0)
							$aiZaehler{$viSuchPos}:=$aiZaehler{$viSuchPos}+1
						Else 
							ALERT:C41("p_GA:"+Char:C90(13)+"Antwort "+$vsAntwortElement+" bei Frage "+WeiterMit+" in FB-Nr "+String:C10([TelefonNummer:4]AdrFBNr:20)+" nicht vorgesehen!")
						End if 
						$vsAntwort:=Substring:C12($vsAntwort;$viKommPos+1)
						$viKommPos:=Position:C15(",";$vsAntwort)
					End while 
					
					  //InterviewZähler hochzählen
					$viSuchPos:=Find in array:C230($asBogenID_Zaehlen;p_TextFormat (WeiterMit;"l";30)+"|xINT")
					If ($viSuchPos>0)
						$aiZaehler{$viSuchPos}:=$aiZaehler{$viSuchPos}+1
					Else 
						ALERT:C41("p_GA:"+Char:C90(13)+"Antwort xINT in Frage "+WeiterMit+" nicht vorgesehen!")
					End if 
					
					  //Spezial mit Einbauen
					Case of 
						: (($asFormName{$PosInBogen}="gen_OffenText") & (Position:C15(WeiterMit+"_Spez";[TelefonNummer:4]AntwASCII:41)#0))
							  //Es gibt ne Spezialantwort zur aktuellen Frage => auf Spezial ausweichen
							$viParkPos:=$PosInBogen
							WeiterMit:=WeiterMit+"_Spez"
						: ((($asFormName{$PosInBogen}="gen_1b@") | ($asFormName{$PosInBogen}="gen_Halboffen")) & (Position:C15(WeiterMit+".o_Spez";[TelefonNummer:4]AntwASCII:41)#0))
							  //Es gibt ne Spezialantwort zur aktuellen Frage => auf Spezial ausweichen
							$viParkPos:=$PosInBogen
							WeiterMit:=WeiterMit+".o_Spez"
						: ($viParkPos#-1)
							  //Das letzte war ne Spezialfrage => wieder zurück auf den "normalen" Fragebogen
							WeiterMit:=$asNextID{$viParkPos}
							$viParkPos:=-1
						: (WeiterMit="@-bed")
							EXECUTE FORMULA:C63($atBedingung{$PosInBogen})
							weitermit:=ex_res
						Else 
							  //Nix mit Spezial am Hut
							WeiterMit:=$asNextID{$PosInBogen}
					End case 
			End case 
		Until (WeiterMit="Ende_Int")
		$lauf:=$lauf+1
		NEXT RECORD:C51([TelefonNummer:4])
	End while 
	
	MESSAGE:C88("GA aufbereiten ...")
	ARRAY TEXT:C222(atGA;1)
	$viBlock:=1
	atGA{1}:=""
	$viBlocklaenge:=63
	$vsBIDAlt:=""
	$viBreite:=20
	$viSumme:=0
	$viZeile:=0
	$vbBIDSchreiben:=True:C214
	For ($lauf;1;Size of array:C274($asBogenID_Zaehlen))
		If (($aiZaehler{$lauf}>0) | ($asBogenID_Zaehlen{$lauf}[[Length:C16($asBogenID_Zaehlen{$lauf})-2]]#"-"))
			$vsNeueZeile:=""
			$vsBID:=Replace string:C233(Substring:C12($asBogenID_Zaehlen{$lauf};1;Position:C15("|";$asBogenID_Zaehlen{$lauf})-1);" ";"")
			$vsBID:=p_TextFormat ($vsBID+" * "+$asSpalte{Find in array:C230($asBogenID_Exp;$vsBID)};"l";$viBreite)
			$vsWert:=Substring:C12($asBogenID_Zaehlen{$lauf};Position:C15("|";$asBogenID_Zaehlen{$lauf})+1)
			Case of 
				: (Position:C15("-";$vsWert)#0)
					  //Nix machen
				: ((Num:C11($vsWert)#0) | ($vsWert="0000"))
					$vsWert:=String:C10(Num:C11($vsWert);"^^^0")
			End case 
			
			If ($vbBIDSchreiben)
				$vsNeueZeile:=$vsBID
				$vbBIDSchreiben:=False:C215
			Else 
				$vsNeueZeile:=" "*$viBreite
			End if 
			
			If ($vsWert#"xINT")
				atGA{$viBlock}:=atGA{$viBlock}+$vsNeueZeile+"   "+$vsWert+"    "+String:C10($aiZaehler{$lauf};"^^^0")+Char:C90(13)
				$viZeile:=$viZeile+1
				$viSumme:=$viSumme+$aiZaehler{$lauf}
			Else 
				atGA{$viBlock}:=atGA{$viBlock}+p_TextFormat ("Interviews";"r";$viBreite)+String:C10($aiZaehler{$lauf};"^^^^0")+Char:C90(13)
				If ($aiZaehler{$lauf}<$viSumme)
					atGA{$viBlock}:=atGA{$viBlock}+p_TextFormat ("Antworten";"r";$viBreite)+String:C10($viSumme;"^^^^0")+Char:C90(13)
					$viZeile:=$viZeile+1
				End if 
				atGA{$viBlock}:=atGA{$viBlock}+("-"*($viBreite+16))+Char:C90(13)
				$viZeile:=$viZeile+2
				$viSumme:=0
				$vbBIDSchreiben:=True:C214
			End if 
			
			If ($viZeile>$viBlocklaenge)
				$viBlock:=$viBlock+1
				INSERT IN ARRAY:C227(atGA;$viBlock)
				atGA{$viBlock}:=""
				$viZeile:=1
				$vbBIDSchreiben:=True:C214
			End if 
		End if 
	End for 
	
	  //Ergaenzt am 10.10.2014
	  //Nach der Bogen-ID noch die Spalte andrucken
	
	DIALOG:C40([TelefonNummer:4];"GA")
	
Else 
	ALERT:C41("Nix passiert!")
End if 