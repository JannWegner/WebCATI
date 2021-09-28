  //Formatiert die RagTime Antwortvorgaben (mit Tab) in Proportional mit Punkten um
  //Falls schon Punkte drin sind (und nur Typ-Änderung) wird nur die Punktzahl geändert

$viCharPro100Punkt:=14
  //Test ob Tabs oder Punkte drin sind
OBJECT GET COORDINATES:C663([Bogen:6]AvgText:5;$viLinks;$viOben;$viRechts;$viUnten)
$viBreite:=$viRechts-$viLinks
$viAnzZeichen:=Round:C94($viBreite/100*$viCharPro100Punkt;0)
$vtAVNeu:=""

  //Doppelte Tabs eliminieren
$vtRestText:=Replace string:C233([Bogen:6]AvgText:5;Char:C90(9)+Char:C90(9);Char:C90(9))
$vtRestText:=Replace string:C233($vtRestText;Char:C90(9)+Char:C90(9);Char:C90(9))+Char:C90(13)

  //Text von Gremlins säubern
For ($lauf;1;Length:C16($vtRestText))
	If ((Character code:C91($vtRestText[[$lauf]])<32) & (Character code:C91($vtRestText[[$lauf]])#9) & (Character code:C91($vtRestText[[$lauf]])#13))
		ALERT:C41(String:C10(Character code:C91($vtRestText[[$lauf]])))
		$vtRestText[[$lauf]]:=" "
	End if 
End for 

  //Ggf. mehr als 3 Punkte durch Tab ersetzen
While (Position:C15("...";$vtRestText)#0)
	$viPunktPosStart:=Position:C15("...";$vtRestText)
	$viPunktPosStop:=$viPunktPosStart
	While ($vtRestText[[$viPunktPosStop+1]]=".")
		$viPunktPosStop:=$viPunktPosStop+1
	End while 
	$vtRestText:=Replace string:C233($vtRestText;("."*($viPunktPosStop-$viPunktPosStart+1));Char:C90(9);1)
	
End while 

Case of 
	: (Position:C15(Char:C90(9);$vtRestText)#0)
		  //Wir haben Tabs zum konvertieren
		ARRAY TEXT:C222($asText;0)
		ARRAY TEXT:C222($asAV;0)
		While (Position:C15(Char:C90(13);$vtRestText)#0)
			INSERT IN ARRAY:C227($asText;1)
			INSERT IN ARRAY:C227($asAV;1)
			$viZEPos:=Position:C15(Char:C90(13);$vtRestText)
			$viTabPos:=Position:C15(Char:C90(9);$vtRestText)
			  //Nur was machen, wenn TAB in der Zeile, sonst nur übernehmen
			If ($viTabPos#0)
				$asText{1}:=p_LoescheAnfEndeBlanks (Substring:C12($vtRestText;1;$viTabPos-1))
				$asAV{1}:=p_LoescheAnfEndeBlanks (Replace string:C233(Substring:C12($vtRestText;$viTabPos+1;$viZEPos-$viTabPos-1);Char:C90(9);""))
			Else 
				$asText{1}:=Substring:C12($vtRestText;1;$viZEPos-1)
				$asAV{1}:=""
			End if 
			$vtRestText:=Substring:C12($vtRestText;$viZEPos+1)
		End while 
		
		  //Längste Zeile suchen
		$viMaxLaenge:=0
		For ($lauf;1;Size of array:C274($asText))
			If ($asAV{$lauf}#"")
				  //Nur zerlegte Zeilen berücksichtigen
				$viAktLaenge:=Length:C16($asText{$lauf})
				If ($viAktLaenge>$viMaxLaenge)
					$viMaxLaenge:=$viAktLaenge
				End if 
			End if 
		End for 
		
		  //Notwendwendige Zeilenlänge berechnen (Längste Zeile soll 3 Punkte haben)
		$viSollLaenge:=$viMaxLaenge
		  //Eventuell begrenzen
		If (($viSollLaenge+8)>$viAnzZeichen)
			$viSollLaenge:=$viAnzZeichen-8
		End if 
		
		  //AV-Feld wieder zusammenbasteln (Rückwärts)
		For ($lauf;Size of array:C274($asText);1;-1)
			$vtAVNeu:=$vtAVNeu+$asText{$lauf}+" "+("."*($viSollLaenge-Length:C16($asText{$lauf})+3))+" "+$asAV{$lauf}+Char:C90(13)
		End for 
		
		  //Überzählige CR's am Ende rausschmeißen
		While ($vtAVNeu[[Length:C16($vtAVNeu)]]=Char:C90(13))
			$vtAVNeu:=Substring:C12($vtAVNeu;1;Length:C16($vtAVNeu)-1)
		End while 
		
		[Bogen:6]AvgText:5:=$vtAVNeu
		[Bogen:6]AvgSchrift:25:=2
		p_BogenAvgFormatSetzen 
	Else 
		ALERT:C41("Hier kann ich leider nix für Sie tun!")
End case 