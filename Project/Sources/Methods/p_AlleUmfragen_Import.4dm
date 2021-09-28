//%attributes = {}
$vt_RootPfad:="Mac HD Wegner:Users:wegner:Documents:CATI-Projekte:CATI_Exporte_Komplett"
$viFeldTrenner:=1
$viSatzTrenner:=2

FOLDER LIST:C473($vt_RootPfad;$at_Folders)

For (lauf;1;Size of array:C274($at_Folders))
	$vt_Pfad:=$vt_RootPfad+":"+$at_Folders{lauf}
	$vt_Umfrage:=Substring:C12($at_Folders{lauf};1;Length:C16($at_Folders{lauf})-11)
	
	DOCUMENT LIST:C474($vt_Pfad;$at_Files)
	For (lauf2;1;Size of array:C274($at_Files))
		$vsDatei:=$vt_Pfad+":"+$at_Files{lauf2}
		MESSAGES ON:C181
		MESSAGE:C88($vsDatei)
		MESSAGES OFF:C175
		Case of 
			: ($at_Files{lauf2}=($vt_Umfrage+"_Adr_@"))
				p_Client_Standard_Import (->[TelefonNummer:4];"ImportExport";$viFeldTrenner;$viSatzTrenner;$vsDatei)
			: ($at_Files{lauf2}=($vt_Umfrage+"_Bog_@"))
				p_Client_Standard_Import (->[Bogen:6];"ImpExp_040914";$viFeldTrenner;$viSatzTrenner;$vsDatei)
			: ($at_Files{lauf2}=($vt_Umfrage+"_Pro_@"))
				p_Client_Standard_Import (->[AktivLog:8];"ImportExport";$viFeldTrenner;$viSatzTrenner;$vsDatei)
			: ($at_Files{lauf2}=($vt_Umfrage+"_Qu_@"))
				p_Client_Standard_Import (->[Quoten:7];"ImpExp_040914";$viFeldTrenner;$viSatzTrenner;$vsDatei)
			: ($at_Files{lauf2}=($vt_Umfrage+"_Var_@"))
				p_Client_Standard_Import (->[Variablen:5];"ImportExport";$viFeldTrenner;$viSatzTrenner;$vsDatei)
			: ($at_Files{lauf2}=($vt_Umfrage+"_List_@"))
				p_Client_Standard_Import (->[Hilfslisten:3];"ImportExport";$viFeldTrenner;$viSatzTrenner;$vsDatei)
		End case 
	End for 
End for 