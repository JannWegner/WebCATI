//%attributes = {}
vPerson:=[Variablen:5]InfoFeld:36

  //Ersetzen der Adressfelder
For ($lauf;1;16)
	vPerson:=Replace string:C233(vPerson;"#f"+String:C10($lauf;"00");Field:C253(4;p_ListenfelderRechnen (String:C10($lauf;"00")))->)
End for 

  //Einsetzen der Telefonnummer
vPerson:=Replace string:C233(vPerson;"#TelNr";[TelefonNummer:4]Telefon1:19)

  //Einsetzen der Fassung
vPerson:=Replace string:C233(vPerson;"#Fassung";[TelefonNummer:4]Fassung:39)

  //Einsetzen des Quotentopfs
vPerson:=Replace string:C233(vPerson;"#Topf";String:C10([TelefonNummer:4]QuotenTopf:46))

  //Einsetzen Eingetragen Ja/Nein
vPerson:=Replace string:C233(vPerson;"#TB";(Num:C11([TelefonNummer:4]EingetragenTB:12)*"Ja")+(Num:C11(Not:C34([TelefonNummer:4]EingetragenTB:12))*"Nein"))

vakt_AP:=[TelefonNummer:4]aktAnsprechp:38


