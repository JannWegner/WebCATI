//%attributes = {}
  //Schrift setzen
Case of 
	: ([Bogen:6]AvgSchrift:25=1)
		  //Arial (prop.), fett, 14pt 
		OBJECT SET FONT:C164(vavgtext;"Arial")
		OBJECT SET FONT STYLE:C166(vavgtext;Bold:K14:2)
		OBJECT SET FONT SIZE:C165(vavgtext;14)
	: ([Bogen:6]AvgSchrift:25=2)
		  //Monaco (monospaced), 12pt
		OBJECT SET FONT:C164(vavgtext;"Monaco")
		OBJECT SET FONT STYLE:C166(vavgtext;Plain:K14:1)
		OBJECT SET FONT SIZE:C165(vavgtext;12)
	: ([Bogen:6]AvgSchrift:25=3)
		  //Monaco (monospaced), 10pt
		OBJECT SET FONT:C164(vavgtext;"Monaco")
		OBJECT SET FONT STYLE:C166(vavgtext;Plain:K14:1)
		OBJECT SET FONT SIZE:C165(vavgtext;10)
	: ([Bogen:6]AvgSchrift:25=4)
		  //Monaco (monospaced), 9pt
		OBJECT SET FONT:C164(vavgtext;"Monaco")
		OBJECT SET FONT STYLE:C166(vavgtext;Plain:K14:1)
		OBJECT SET FONT SIZE:C165(vavgtext;9)
End case 

