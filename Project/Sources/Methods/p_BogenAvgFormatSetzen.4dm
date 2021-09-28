//%attributes = {}
  //Setzt im Bogen-Eingabe-Formular das Format für das
  //AvgRechteck abhängig vom Fragetyp

  //Groesse setzen
OBJECT GET COORDINATES:C663([Bogen:6]AvgText:5;$viLinks;$viOben;$viRechts;$viUnten)
$viNegBreite:=$viLinks-$viRechts
$viNegHoehe:=$viOben-$viUnten
Case of 
	: ([Bogen:6]FormNam:8="gen_1b7m8off9kka")
		OBJECT MOVE:C664([Bogen:6]AvgText:5;0;0;$viNegBreite+468;$viNegHoehe+112)
	: ([Bogen:6]FormNam:8="gen_1bXm8off")
		OBJECT MOVE:C664([Bogen:6]AvgText:5;0;0;$viNegBreite+335;$viNegHoehe+240)
	: ([Bogen:6]FormNam:8="gen_FA")
		OBJECT MOVE:C664([Bogen:6]AvgText:5;0;0;$viNegBreite+454;$viNegHoehe+160)
	: ([Bogen:6]FormNam:8="gen_gFkA")
		OBJECT MOVE:C664([Bogen:6]AvgText:5;0;0;$viNegBreite+454;$viNegHoehe+96)
	: ([Bogen:6]FormNam:8="gen_gggFkA")
		OBJECT MOVE:C664([Bogen:6]AvgText:5;0;0;$viNegBreite+454;$viNegHoehe+96)
	: ([Bogen:6]FormNam:8="gen_kFgA")
		OBJECT MOVE:C664([Bogen:6]AvgText:5;0;0;$viNegBreite+454;$viNegHoehe+260)
	: ([Bogen:6]FormNam:8="gen_HalbOffen")
		OBJECT MOVE:C664([Bogen:6]AvgText:5;0;0;$viNegBreite+328;$viNegHoehe+208)
	Else 
		OBJECT MOVE:C664([Bogen:6]AvgText:5;0;0;$viNegBreite+454;$viNegHoehe+256)
End case 

  //Schrift setzen
Case of 
	: ([Bogen:6]AvgSchrift:25=1)
		  //Arial (prop.), fett, 14pt 
		fArial:=1
		fMono:=0
		fMono10pt:=0
		fMono9pt:=0
		OBJECT SET FONT:C164([Bogen:6]AvgText:5;"Arial")
		OBJECT SET FONT STYLE:C166([Bogen:6]AvgText:5;Bold:K14:2)
		OBJECT SET FONT SIZE:C165([Bogen:6]AvgText:5;14)
	: ([Bogen:6]AvgSchrift:25=2)
		  //Monaco (monospaced), 12pt
		fArial:=0
		fMono:=1
		fMono10pt:=0
		fMono9pt:=0
		OBJECT SET FONT:C164([Bogen:6]AvgText:5;"Monaco")
		OBJECT SET FONT STYLE:C166([Bogen:6]AvgText:5;Plain:K14:1)
		OBJECT SET FONT SIZE:C165([Bogen:6]AvgText:5;12)
	: ([Bogen:6]AvgSchrift:25=3)
		  //Monaco (monospaced), 10pt
		fArial:=0
		fMono:=0
		fMono10pt:=1
		fMono9pt:=0
		OBJECT SET FONT:C164([Bogen:6]AvgText:5;"Monaco")
		OBJECT SET FONT STYLE:C166([Bogen:6]AvgText:5;Plain:K14:1)
		OBJECT SET FONT SIZE:C165([Bogen:6]AvgText:5;10)
	: ([Bogen:6]AvgSchrift:25=4)
		  //Monaco (monospaced), 8pt
		fArial:=0
		fMono:=0
		fMono10pt:=0
		fMono9pt:=1
		OBJECT SET FONT:C164([Bogen:6]AvgText:5;"Monaco")
		OBJECT SET FONT STYLE:C166([Bogen:6]AvgText:5;Plain:K14:1)
		OBJECT SET FONT SIZE:C165([Bogen:6]AvgText:5;9)
End case 

