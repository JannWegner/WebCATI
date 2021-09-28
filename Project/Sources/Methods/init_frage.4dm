//%attributes = {}
QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20="Universell!!";*)
QUERY:C277([Bogen:6]; | [Bogen:6]Umfrage:20=vUmfrage;*)
QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=$1)
If (Records in selection:C76([Bogen:6])#1)
	ALERT:C41("init_frage (FB "+String:C10([TelefonNummer:4]AdrFBNr:20)+"):"+Char:C90(13)+"ID '"+$1+"' nicht zu identifizieren - Anzahl DS = "+String:C10(Records in selection:C76([Bogen:6]))+"!")
	TRACE:C157
End if 