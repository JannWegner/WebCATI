//%attributes = {}
CONFIRM:C162("Für markierte Sätze oder alle mit Haken?";"Alle mit Haken";"Aktuell markierte")
If (OK=0)
	USE SET:C118("UserSet")
Else 
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
End if 
QUERY SELECTION:C341([Bogen:6];[Bogen:6]Zitate_Druck:23=True:C214;*)
QUERY SELECTION:C341([Bogen:6]; & [Bogen:6]FormNam:8="gen_Spez")
ORDER BY:C49([Bogen:6];[Bogen:6]ID:1)

$vStartDatum:=Date:C102(Request:C163("Ab welchem Datum (einschl.) drucken";"01.01.2000"))
$vEndeDatum:=Date:C102(Request:C163("Bis welchem Datum (einschl.) drucken";String:C10(Current date:C33)))

MESSAGE:C88("Fertige Interviews suchen")
QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Komplett")
vFertigeInts:=Records in selection:C76([TelefonNummer:4])

QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Ende am:25>=$vStartDatum;*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]Ende am:25<=$vEndeDatum)
ORDER BY:C49([TelefonNummer:4];[TelefonNummer:4]Ende am:25;[TelefonNummer:4]Ende um:26)
vFertigeIntsInZeitraum:=Records in selection:C76([TelefonNummer:4])

$viSollAnzahl:=Num:C11(Request:C163("Wieviele Interviews berücksichtigen?";String:C10(vFertigeIntsInZeitraum)))
REDUCE SELECTION:C351([TelefonNummer:4];$viSollAnzahl)
vFertigeIntsInZeitraum:=$viSollAnzahl

CREATE SET:C116([TelefonNummer:4];"$mFertigeInZeitraum")

FORM SET OUTPUT:C54([TelefonNummer:4];"Zitatenliste")
PRINT SETTINGS:C106

FIRST RECORD:C50([Bogen:6])
While (Not:C34(End selection:C36([Bogen:6])))
	$vBogenID:=Substring:C12([Bogen:6]ID:1;1;Length:C16([Bogen:6]ID:1)-5)
	If (Position:C15(".o";[Bogen:6]ID:1)#0)
		$vBogenID:=Substring:C12($vBogenID;1;Length:C16($vBogenID)-2)+"offen"
	End if 
	
	USE SET:C118("$mFertigeInZeitraum")
	  //ARRAY STRING(30;asSpezialBogen;1)
	  //asSpezialBogen{1}:=$vBogenID
	  //QUERY SELECTION BY FORMULA([TelefonNummer];p_SpezialDruckSuchen )
	QUERY SELECTION BY FORMULA:C207([TelefonNummer:4];Length:C16(LiA ($vBogenID))>2)
	vFertigeMitInhalt:=Records in selection:C76([TelefonNummer:4])
	vDruckfeld:=$vBogenID
	vFeld:=Substring:C12($vBogenID;3)
	DISPLAY SELECTION:C59([TelefonNummer:4];*)
	If (OK=1)
		Case of 
			: (Records in selection:C76([TelefonNummer:4])>0)
				PRINT SELECTION:C60([TelefonNummer:4];>)
			: (Records in selection:C76([TelefonNummer:4])=0)
				Print form:C5([TelefonNummer:4];"Zitatenliste";Form header:K43:3)
				Print form:C5([TelefonNummer:4];"Zitatenliste";Form footer:K43:2)
				PAGE BREAK:C6
		End case 
	End if 
	
	NEXT RECORD:C51([Bogen:6])
End while 

