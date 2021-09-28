//%attributes = {}
$Orginaltext:=$1

While (Position:C15("$$$";$Orginaltext)#0)
	$DollarPos:=Position:C15("$$$";$Orginaltext)
	$ErsetzungsTyp:=Substring:C12($Orginaltext;$DollarPos+3;1)
	$DummyText:=Substring:C12($Orginaltext;$DollarPos+5)+" "  //Vorsichtshalber noch einen Blank an $DummyText anhängen, falls der Ersetzungstext ganz am Ende steht (damit $Blank dann stimmt) 
	$Blank:=Position:C15(" ";$DummyText)
	$Argument:=Substring:C12($DummyText;1;$Blank-1)
	If ($Argument="exec@")
		EXECUTE FORMULA:C63(Substring:C12($Argument;6;Length:C16($Argument)-1))
		$Argument:=ex_res
	End if 
	Case of 
		: ($ErsetzungsTyp="A")
			  //Eine Antwort (meist offener Text) soll eingesetzt werden
			$Ersetzungstext:=id2feld ($Argument)
		: ($ErsetzungsTyp="F")
			  //Ein (Adress-) Feld soll eingesetzt werden
			  // Vorsichtshalber auf zwei Zeichen abschneiden
			$Argument:=Substring:C12($Argument;1;2)
			Case of 
				: ($Argument="01")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld01:14
				: ($Argument="02")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld02:16
				: ($Argument="03")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld03:13
				: ($Argument="04")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld04:15
				: ($Argument="05")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld05:18
				: ($Argument="06")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld06:34
				: ($Argument="07")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld07:35
				: ($Argument="08")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld08:33
				: ($Argument="09")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld09:17
				: ($Argument="10")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld10:21
				: ($Argument="11")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld11:27
				: ($Argument="12")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld12:28
				: ($Argument="13")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld13:31
				: ($Argument="14")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld14:42
				: ($Argument="15")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld15:43
				: ($Argument="16")
					$Ersetzungstext:=[TelefonNummer:4]AdrFeld16:44
			End case 
		: ($ErsetzungsTyp="V")
			  //Eine Variable soll eingesetzt werden
			If (Num:C11($Argument)>Size of array:C274(atVar))
				ALERT:C41("TextErsetzen:"+Char:C90(13)+"Variable "+$Argument+" ist nicht definiert! - Text unvollständig!")
				$Ersetzungstext:="## ERSETZUNGSFEHLER ##"
			Else 
				$Ersetzungstext:=atVar{Num:C11($Argument)}
			End if 
		: ($ErsetzungsTyp="L")
			  //Für Antwortvorgaben: Vorgaben kommen aus einem Datensatz aus einer Hilfsliste
			  // Eintrag in AVG muss sein z.B. $$$L_2_LISTENNAME
			  // Antwortvorgaben im Textfeld muss sein: AnzahlAntworten;Antworttext1;Info1;Antworttext2;Info2;...
			$Listenname:=Substring:C12($Argument;3)
			$Argument:=Substring:C12($Argument;1;1)
			QUERY:C277([Hilfslisten:3];[Hilfslisten:3]Umfrage:1=vUmfrage;*)
			QUERY:C277([Hilfslisten:3]; & [Hilfslisten:3]ListenID:2=$Listenname;*)
			QUERY:C277([Hilfslisten:3]; & [Hilfslisten:3]LabelID:3=[TelefonNummer:4]AdrFBNr:20)
			If (Records in selection:C76([Hilfslisten:3])#1)
				ALERT:C41("Kein Datensatz in Hilfsliste gefunden!")
			Else 
				Case of 
					: ($Argument="1")
						$Listeneintrag:=[Hilfslisten:3]Textfeld_1:5
					: ($Argument="2")
						$Listeneintrag:=[Hilfslisten:3]Textfeld_2:6
					: ($Argument="3")
						$Listeneintrag:=[Hilfslisten:3]Textfeld_3:7
					: ($Argument="4")
						$Listeneintrag:=[Hilfslisten:3]Textfeld_4:8
				End case 
				$SemiPos:=Position:C15(";";$Listeneintrag)
				AnzahlAntworten:=Num:C11(Substring:C12($Listeneintrag;1;$SemiPos-1))
				$Listeneintrag:=Substring:C12($Listeneintrag;$SemiPos+1)
				ARRAY TEXT:C222(at_Antwort;AnzahlAntworten)
				ARRAY TEXT:C222(at_AntwortInfo;AnzahlAntworten)
				$MaxLaenge:=0
				For ($lauf;1;AnzahlAntworten)
					$SemiPos:=Position:C15(";";$Listeneintrag)
					at_Antwort{$lauf}:=Substring:C12($Listeneintrag;1;$SemiPos-1)
					If (Length:C16(at_Antwort{$lauf})>$MaxLaenge)
						$MaxLaenge:=Length:C16(at_Antwort{$lauf})
					End if 
					$Listeneintrag:=Substring:C12($Listeneintrag;$SemiPos+1)
					$SemiPos:=Position:C15(";";$Listeneintrag)
					at_AntwortInfo{$lauf}:=Substring:C12($Listeneintrag;1;$SemiPos-1)
					$Listeneintrag:=Substring:C12($Listeneintrag;$SemiPos+1)
				End for 
				$Ersetzungstext:=""
				For ($lauf;1;AnzahlAntworten)
					$Ersetzungstext:=$Ersetzungstext+at_Antwort{$lauf}+" "+("."*($MaxLaenge-Length:C16(at_Antwort{$lauf})))+"... "+String:C10($lauf)+Char:C90(13)
				End for 
				  //TRACE
			End if 
			$Argument:=$Argument+"_"+$Listenname
		Else 
			ALERT:C41("TextErsetzen:"+Char:C90(13)+"Ersetzungstyp "+$ErsetzungsTyp+" ist nicht definiert! -Text unvollständig!")
			$Ersetzungstext:="## ERSETZUNGSFEHLER ##"
	End case 
	
	$Orginaltext:=Replace string:C233($Orginaltext;"$$$"+$ErsetzungsTyp+"_"+$Argument;$Ersetzungstext)
End while 

$0:=$Orginaltext
