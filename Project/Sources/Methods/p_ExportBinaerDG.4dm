//%attributes = {}
  //Exportiert die angezeigten Datensätze im Binärformat für die DG
AnzahlAntworten:=9999  // Muss gesetzt sein, falls Hilfslisten zur Definition von Antwortvorgaben benutzt wurden ...
$AnzahlSätze:=Records in selection:C76([TelefonNummer:4])
CONFIRM:C162(String:C10($AnzahlSätze)+" Datensätze für DG exportieren?")
If (OK=1)
	QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Komplett")
	If (Records in selection:C76([TelefonNummer:4])#$AnzahlSätze)
		$AnzahlSätze:=Records in selection:C76([TelefonNummer:4])
		ALERT:C41("Nach Bereinigung bleiben nur "+String:C10($AnzahlSätze)+" übrig!")
	End if 
	
	CONFIRM:C162("Mit oder ohne Spezial exportieren?";"Mit Spezial";"Ohne Spezial")
	If (OK=1)
		$ExportMitSpezial:=True:C214
	Else 
		$ExportMitSpezial:=False:C215
	End if 
	ORDER BY:C49([TelefonNummer:4]AdrFBNr:20)
	
	  //Array mit den BogenDaten aufbauen
	ARRAY TEXT:C222($asBogenID_Exp;0)
	ARRAY TEXT:C222($asNextID;0)
	ARRAY TEXT:C222($atBedingung;0)
	ARRAY TEXT:C222($asFormName;0)
	ARRAY TEXT:C222($asSpalte;0)
	ARRAY TEXT:C222($asKKA;0)
	ARRAY INTEGER:C220($aiSpaltenAnz;0)
	ARRAY TEXT:C222($atFText;0)
	ARRAY BOOLEAN:C223($abSpezialEin;0)
	ARRAY TEXT:C222($asSolo;0)
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
	SELECTION TO ARRAY:C260([Bogen:6]ID:1;$asBogenID_Exp;[Bogen:6]nextID:6;$asNextID;[Bogen:6]Bedingung:10;$atBedingung;[Bogen:6]FormNam:8;$asFormName;[Bogen:6]Spalte:12;$asSpalte;[Bogen:6]AnzahlSpalten:24;$aiSpaltenAnz;[Bogen:6]FText:3;$atFText;[Bogen:6]KKA:18;$asKKA;[Bogen:6]Spezial_Eingabe:22;$abSpezialEin;[Bogen:6]Solo:19;$asSolo)
	
	  //ExportArray aufbauen
	ARRAY TEXT:C222(atExport;1)
	ARRAY TEXT:C222(atExport;$AnzahlSätze)
	
	  //Konvertiertabelle für offene Fragen
	p_Spezial_Konverter_bauen 
	
	  //kkA-Finder für Multi-Formulare bauen
	p_MultiKKAFinder_bauen 
	
	  //Alle Interviews durchgehen
	FIRST RECORD:C50([TelefonNummer:4])
	$lauf:=1
	While (Not:C34(End selection:C36([TelefonNummer:4])))
		MESSAGE:C88("Adress-/FB-Nr "+String:C10([TelefonNummer:4]AdrFBNr:20)+":   Satz "+String:C10($lauf)+" von "+String:C10($AnzahlSätze))
		  //Antworten einlesen
		AntwortArray_Init 
		AntwortArray_Lesen 
		
		  //ExportElement initialisieren
		Init_Export (->atExport{$lauf})
		
		  //Um tote Zweige im Fragebogenverlauf auszuklammern, wird der Interviewverlauf rekonstruiert
		$vbHuepfen:=False:C215
		$vsWeiterMitMerken:=""
		
		
		WeiterMit:=[Variablen:5]ErsteFrage:23
		Repeat 
			  //Hier kann statt "xxxxx" ein "weitermit" eingesetzt werden, um zu tracen ... 
			If (WeiterMit="xxxxx")
				TRACE:C157
			End if 
			  //MESSAGE("Adress-/FB-Nr "+String([TelefonNummer]AdrFBNr)+":   Satz "+String($lauf)+" von "+String($AnzahlSätze)+Char(13)+WeiterMit)
			vt_AktuellerWeg:=vt_AktuellerWeg+WeiterMit+Char:C90(13)
			$PosInBogen:=Find in array:C230($asBogenID_Exp;WeiterMit)
			Case of 
				: ($PosInBogen=-1)
					ALERT:C41("p_ExportBinaerDG:"+Char:C90(13)+WeiterMit+" gibt's in Adress-/FB-Nr "+String:C10([TelefonNummer:4]AdrFBNr:20)+" nicht!")
					ABORT:C156
				: (WeiterMit="@-bed")
					EXECUTE FORMULA:C63($atBedingung{$PosInBogen})
					  // Soll die Entscheidung dokumentiert werden?
					Case of 
						: (($atFText{$PosInBogen}="write@") | ($atFText{$PosInBogen}="copy@"))
							BinaerSchreiben (->atExport{$lauf};id2feld (WeiterMit);sp2off ($asSpalte{$PosInBogen}))
					End case 
					weitermit:=ex_res
				: (Position:C15("copy";$atBedingung{$PosInBogen})#0)
					$vbHuepfen:=True:C214
					$vsWeiterMitMerken:=$asNextID{$PosInBogen}
					  //Ziel festlegen festelegen
					$vsText:=Substring:C12($atBedingung{$PosInBogen};Position:C15("copy(";$atBedingung{$PosInBogen})+6)
					$viSemikolon:=Position:C15(";";$vsText)
					WeiterMit:=Substring:C12($vsText;$viSemikolon+2;Length:C16($vsText)-$viSemikolon-3)
				: (WeiterMit="@-do")
					Case of 
						: (Position:C15("Fassung";$atBedingung{$PosInBogen})#0)
							If (Position:C15(WeiterMit;[TelefonNummer:4]AntwASCII:41)=0)
								ALERT:C41("p_ExportBinaerDG:"+Char:C90(13)+"FB "+String:C10([TelefonNummer:4]AdrFBNr:20)+" Antwort "+WeiterMit+" nicht in AntwASCII!"+Char:C90(13)+"Schwerer Fehler -->> EDV melden!")
							Else 
								BinaerSchreiben (->atExport{$lauf};id2feld (WeiterMit);sp2off ($asSpalte{$PosInBogen}))
							End if 
						: (Position:C15("write";$atBedingung{$PosInBogen})+Position:C15("Dauer";$atBedingung{$PosInBogen})+Position:C15("Datum";$atBedingung{$PosInBogen})+Position:C15("Wochentag";$atBedingung{$PosInBogen})+Position:C15("AdrFeld";$atBedingung{$PosInBogen})>0)
							If (Position:C15(WeiterMit;[TelefonNummer:4]AntwASCII:41)=0)
								ALERT:C41("p_ExportBinaerDG:"+Char:C90(13)+"FB "+String:C10([TelefonNummer:4]AdrFBNr:20)+" Antwort "+WeiterMit+" nicht in AntwASCII!"+Char:C90(13)+"Schwerer Fehler -->> EDV melden!")
							Else 
								$Antwort:=id2feld (WeiterMit)
								$viAntwortLaenge:=Length:C16($Antwort)
								For ($lauf2;1;$viAntwortLaenge)
									BinaerSchreiben (->atExport{$lauf};Substring:C12($Antwort;$lauf2;1);sp2off ($asSpalte{$PosInBogen})-$viAntwortLaenge+$lauf2)
								End for 
							End if 
						: (Position:C15("do_command";$atBedingung{$PosInBogen})>0)
							  //IST doch schon in "do_action" passiert?!?! = AUSKOMMENTIERT!!
							  //Variablen setzen...
							  //EXECUTE($atFText{$PosInBogen})
						: ($atBedingung{$PosInBogen}="p_Xtra_UmfrSpez_w")
							  //Nur interessant bei Umfragsspezifisch, das auch in die Interviewdaten geschrieben werden soll
							p_ExportBinaerDGProz (->atExport{$lauf};p_Xtra_UmfrSpez ;sp2off ($asSpalte{$PosInBogen});"gen_Zahl";Length:C16(p_Xtra_UmfrSpez );$asKKA{$PosInBogen};$asSolo{$PosInBogen})
					End case 
					WeiterMit:=$asNextID{$PosInBogen}
				Else 
					  //Wert in ExportArray schreiben
					  //Feststellen des BogenTyps
					$NormalExport:=False:C215
					$OffenExport:=False:C215
					$OffenZusatz:=""
					$Antwort:=id2feld (WeiterMit)
					
					Case of 
						: ($asFormName{$PosInBogen}="gen_Multi")
							$kkaFinderPos:=Find in array:C230(tMultiKKAFinder;$asBogenID_Exp{$PosInBogen}+"@")
							Case of 
								: ($kkaFinderPos=-1)
									  //Nix zu tun
								: (Num:C11(Substring:C12($Antwort;Num:C11(Substring:C12(tMultiKKAFinder{$kkaFinderPos};32;4));Num:C11(Substring:C12(tMultiKKAFinder{$kkaFinderPos};37;4))))=Num:C11(Substring:C12(tMultiKKAFinder{$kkaFinderPos};42;10)))
									$Antwort:="Y"
							End case 
							$NormalExport:=True:C214
						: ($asFormName{$PosInBogen}="gen_offenText")
							$OffenExport:=True:C214
							$WahrOffen_Falsch1b8:=True:C214
						: (($asFormName{$PosInBogen}="gen_1b@") | ($asFormName{$PosInBogen}="gen_Halboffen"))
							$NormalExport:=True:C214
							$OffenExport:=True:C214
							$WahrOffen_Falsch1b8:=False:C215
						Else 
							$NormalExport:=True:C214
					End case 
					If ($OffenExport)
						$OffenZusatz:=("_Spez"*Num:C11($WahrOffen_Falsch1b8))+(".o_Spez"*Num:C11(Not:C34($WahrOffen_Falsch1b8)))
					End if 
					
					If ($NormalExport)
						If ($Antwort#"")
							p_ExportBinaerDGProz (->atExport{$lauf};$Antwort;sp2off ($asSpalte{$PosInBogen});$asFormName{$PosInBogen};$aiSpaltenAnz{$PosInBogen};$asKKA{$PosInBogen};$asSolo{$PosInBogen})
						Else 
							ALERT:C41("FbNr: "+String:C10([TelefonNummer:4]AdrFBNr:20)+" BogenID: "+WeiterMit+Char:C90(13)+"Antwort ist LEER!")
						End if 
					End if 
					
					If ($OffenExport & $ExportMitSpezial)
						$PosInBogen:=Find in array:C230($asBogenID_Exp;WeiterMit+$OffenZusatz)
						vt_AktuellerWeg:=vt_AktuellerWeg+WeiterMit+$OffenZusatz+Char:C90(13)
						Case of 
							: (Not:C34($abSpezialEin{$PosInBogen}))
								  //Diese Spezialfrage interessiert niemanden -> einfach überspringen
							: ($PosInBogen=-1)
								ALERT:C41("p_ExportBinaerDG:"+Char:C90(13)+WeiterMit+$OffenZusatz+" gibt's in Adress-/FB-Nr "+String:C10([TelefonNummer:4]AdrFBNr:20)+" nicht!")
								ABORT:C156
							: (($WahrOffen_Falsch1b8) & (Length:C16(id2feld (WeiterMit))<2))
								  //Offene Frage mit Kurzantwort
								$Text:=Substring:C12(id2feld (WeiterMit);1;1)
								$KonvPos:=Find in array:C230(tBogenID;(WeiterMit+$OffenZusatz+"#"+$Text))
								If ($KonvPos=-1)
									ALERT:C41("p_ExportBinaerDG:"+Char:C90(13)+"Spezial-Konvertierung Bogen-ID "+WeiterMit+" # "+$Text+" bei FB "+String:C10([TelefonNummer:4]AdrFBNr:20)+" fehlgeschlagen!")
								Else 
									p_ExportBinaerDGProz (->atExport{$lauf};tKonvWert{$KonvPos};sp2off ($asSpalte{$PosInBogen});$asFormName{$PosInBogen};$aiSpaltenAnz{$PosInBogen};$asSolo{$PosInBogen})
								End if 
							Else 
								$Antwort:=id2feld (WeiterMit+$OffenZusatz)
								If ($Antwort#"")
									p_ExportBinaerDGProz (->atExport{$lauf};$Antwort;sp2off ($asSpalte{$PosInBogen});$asFormName{$PosInBogen};$aiSpaltenAnz{$PosInBogen};$asSolo{$PosInBogen})
								End if 
						End case 
					End if 
					WeiterMit:=$asNextID{Find in array:C230($asBogenID_Exp;WeiterMit)}
			End case 
			If ($vbHuepfen & (Position:C15("copy";$atBedingung{$PosInBogen})=0))
				$vbHuepfen:=False:C215
				WeiterMit:=$vsWeiterMitMerken
				$vsWeiterMitMerken:=""
			End if 
		Until (WeiterMit="Ende_Int")
		$lauf:=$lauf+1
		NEXT RECORD:C51([TelefonNummer:4])
	End while 
	
	  //Datei schreiben
	C_TIME:C306(vhDocRef)
	USE CHARACTER SET:C205("ISO-8859-1";0)
	vhDocRef:=Create document:C266("")  // Erstelle neues Dokument 
	If (OK=1)
		$Blocklaenge:=160
		  //Das ganze Export-Array durchgehen
		For ($lauf;1;Size of array:C274(atExport))
			For ($vl_AktKarte;1;[Variablen:5]AnzahlKarten:28)
				$Block:=Substring:C12(atExport{$lauf};(($vl_AktKarte-1)*$Blocklaenge)+1;$Blocklaenge)
				SEND PACKET:C103(vhDocRef;$Block)  // Schreibe ein Wort in das Dokument
			End for 
		End for 
		CLOSE DOCUMENT:C267(vhDocRef)  // Schließe Dokument
		USE CHARACTER SET:C205(*;0)
	End if 
Else 
	ALERT:C41("Nix passiert!")
End if 