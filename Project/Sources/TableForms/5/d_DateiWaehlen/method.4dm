  //Braucht als Parameter
  //vsText:                    Text fuer Anwender (Titel)
  //viLesenSchreiben:     0=Lesen, 1=Schreiben
  //vsPfad:                     das aktuelle Verzeichnis
  //vsFilter:                   Filter bzw. Dateinamen

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (vsPfad="")
			VOLUME LIST:C471($asVolumes)
			vsPfad:=$asVolumes{1}+":"
		End if 
		p_DateiWaehlen_FelderFuellen (vsPfad;vsFilter)
End case 