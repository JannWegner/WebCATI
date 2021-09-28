//%attributes = {}
ALL RECORDS:C47([Variablen:5])
SELECTION TO ARRAY:C260([Variablen:5]Umfrage:3;$at_Umfrage)
SORT ARRAY:C229($at_Umfrage)

$viFeldTrenner:=1
$viSatzTrenner:=2

For (lauf;1;Size of array:C274($at_Umfrage))
	QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=$at_Umfrage{lauf})
	$vt_Folder:="Wegner:Users:wegner:Documents:CATI-Proj_jwAlt:CATI_Exporte_Komplett:"+$at_Umfrage{lauf}+"_"+String:C10([Variablen:5]EingerichtetAm:40)
	CREATE FOLDER:C475($vt_Folder)
	
	QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=$at_Umfrage{lauf})
	$vs_Datei:=$vt_Folder+":"+$at_Umfrage{lauf}+"_Bog_"+Substring:C12(String:C10(Year of:C25(Current date:C33));3)+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00")+"_ENDE"
	p_Client_Standard_Export (->[Bogen:6];"ImpExp_040914";$viFeldTrenner;$viSatzTrenner;$vs_Datei)
	
	QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=$at_Umfrage{lauf})
	$vs_Datei:=$vt_Folder+":"+$at_Umfrage{lauf}+"_Var_"+Substring:C12(String:C10(Year of:C25(Current date:C33));3)+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00")+"_ENDE"
	p_Client_Standard_Export (->[Variablen:5];"ImportExport";$viFeldTrenner;$viSatzTrenner;$vs_Datei)
	
	QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=$at_Umfrage{lauf})
	If (Records in selection:C76([Quoten:7])>0)
		$vs_Datei:=$vt_Folder+":"+$at_Umfrage{lauf}+"_Qu_"+Substring:C12(String:C10(Year of:C25(Current date:C33));3)+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00")+"_ENDE"
		p_Client_Standard_Export (->[Quoten:7];"ImpExp_040914";$viFeldTrenner;$viSatzTrenner;$vs_Datei)
	End if 
	
	QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=$at_Umfrage{lauf})
	If (Records in selection:C76([TelefonNummer:4])>0)
		$vs_Datei:=$vt_Folder+":"+$at_Umfrage{lauf}+"_Adr_"+Substring:C12(String:C10(Year of:C25(Current date:C33));3)+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00")+"_ENDE"
		p_Client_Standard_Export (->[TelefonNummer:4];"ImportExport";$viFeldTrenner;$viSatzTrenner;$vs_Datei)
	End if 
	
	QUERY:C277([AktivLog:8];[AktivLog:8]Umfrage:1=$at_Umfrage{lauf})
	If (Records in selection:C76([AktivLog:8])>0)
		$vs_Datei:=$vt_Folder+":"+$at_Umfrage{lauf}+"_Pro_"+Substring:C12(String:C10(Year of:C25(Current date:C33));3)+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00")+"_ENDE"
		p_Client_Standard_Export (->[AktivLog:8];"ImportExport";$viFeldTrenner;$viSatzTrenner;$vs_Datei)
	End if 
	
	QUERY:C277([Hilfslisten:3];[Hilfslisten:3]Umfrage:1=$at_Umfrage{lauf})
	If (Records in selection:C76([Hilfslisten:3])>0)
		$vs_Datei:=$vt_Folder+":"+$at_Umfrage{lauf}+"_List_"+Substring:C12(String:C10(Year of:C25(Current date:C33));3)+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00")+"_ENDE"
		p_Client_Standard_Export (->[Hilfslisten:3];"ImportExport";$viFeldTrenner;$viSatzTrenner;$vs_Datei)
	End if 
End for 