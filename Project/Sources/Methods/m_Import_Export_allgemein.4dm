//%attributes = {}
C_LONGINT:C283($viAnzahl)

$viFeldTrenner:=1
$viSatzTrenner:=2
CONFIRM:C162("Import oder Export";"Import";"Export")
If (OK=1)
	CONFIRM:C162("Bogen importieren")
	If (OK=1)
		p_LogDatenAktualisieren ("Bogen importieren";vUmfrage;0;"")
		vsDatei:=p_DateiWaehlen (0;vsPfad;vUmfrage+"_Bog_@")
		If (vsDatei#"")
			p_Client_Standard_Import (->[Bogen:6];"ImpExp_040914";$viFeldTrenner;$viSatzTrenner;vsDatei)
		End if 
	End if 
	
	CONFIRM:C162("Variablen importieren")
	If (OK=1)
		p_LogDatenAktualisieren ("Variablen importieren";vUmfrage;0;"")
		vsDatei:=p_DateiWaehlen (0;vsPfad;vUmfrage+"_Var_@")
		If (vsDatei#"")
			p_Client_Standard_Import (->[Variablen:5];"ImportExport";$viFeldTrenner;$viSatzTrenner;vsDatei)
		End if 
	End if 
	
	CONFIRM:C162("Quoten importieren")
	If (OK=1)
		p_LogDatenAktualisieren ("Quoten importieren";vUmfrage;0;"")
		vsDatei:=p_DateiWaehlen (0;vsPfad;vUmfrage+"_Qu_@")
		If (vsDatei#"")
			p_Client_Standard_Import (->[Quoten:7];"ImpExp_040914";$viFeldTrenner;$viSatzTrenner;vsDatei)
		End if 
	End if 
	
	CONFIRM:C162("Adressen importieren")
	If (OK=1)
		p_LogDatenAktualisieren ("Adressen importieren";vUmfrage;0;"")
		vsDatei:=p_DateiWaehlen (0;vsPfad;vUmfrage+"_Adr_@")
		If (vsDatei#"")
			p_Client_Standard_Import (->[TelefonNummer:4];"ImportExport";$viFeldTrenner;$viSatzTrenner;vsDatei)
		End if 
	End if 
	
	CONFIRM:C162("Int.-Protokolle importieren")
	If (OK=1)
		p_LogDatenAktualisieren ("Int.-Protokolle importieren";vUmfrage;0;"")
		vsDatei:=p_DateiWaehlen (0;vsPfad;vUmfrage+"_Pro_@")
		If (vsDatei#"")
			p_Client_Standard_Import (->[AktivLog:8];"ImportExport";$viFeldTrenner;$viSatzTrenner;vsDatei)
		End if 
	End if 
	
	CONFIRM:C162("Hilfs-Listen importieren")
	If (OK=1)
		p_LogDatenAktualisieren ("Hilfs-Listen importieren";vUmfrage;0;"")
		vsDatei:=p_DateiWaehlen (0;vsPfad;vUmfrage+"_List_@")
		If (vsDatei#"")
			p_Client_Standard_Import (->[Hilfslisten:3];"ImportExport";$viFeldTrenner;$viSatzTrenner;vsDatei)
		End if 
	End if 
	
Else 
	
	CONFIRM:C162("Bogen der aktuellen Umfrage exportieren")
	If (OK=1)
		p_LogDatenAktualisieren ("Bogen exportieren";vUmfrage;0;"")
		QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
		UNLOAD RECORD:C212([Bogen:6])
		vsDatei:=p_DateiWaehlen (1;vsPfad;vUmfrage+"_Bog_"+Substring:C12(String:C10(Year of:C25(Current date:C33));3)+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00"))
		If (vsDatei#"")
			p_Client_Standard_Export (->[Bogen:6];"ImpExp_040914";$viFeldTrenner;$viSatzTrenner;vsDatei)
		End if 
	End if 
	
	CONFIRM:C162("Variablen der aktuellen Umfrage exportieren")
	If (OK=1)
		p_LogDatenAktualisieren ("Variablen exportieren";vUmfrage;0;"")
		QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)
		UNLOAD RECORD:C212([Variablen:5])
		vsDatei:=p_DateiWaehlen (1;vsPfad;vUmfrage+"_Var_"+Substring:C12(String:C10(Year of:C25(Current date:C33));3)+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00"))
		If (vsDatei#"")
			p_Client_Standard_Export (->[Variablen:5];"ImportExport";$viFeldTrenner;$viSatzTrenner;vsDatei)
		End if 
	End if 
	
	CONFIRM:C162("Quoten der aktuellen Umfrage  exportieren")
	If (OK=1)
		p_LogDatenAktualisieren ("Quoten exportieren";vUmfrage;0;"")
		QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=vUmfrage)
		UNLOAD RECORD:C212([Quoten:7])
		vsDatei:=p_DateiWaehlen (1;vsPfad;vUmfrage+"_Qu_"+Substring:C12(String:C10(Year of:C25(Current date:C33));3)+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00"))
		If (vsDatei#"")
			p_Client_Standard_Export (->[Quoten:7];"ImpExp_040914";$viFeldTrenner;$viSatzTrenner;vsDatei)
		End if 
	End if 
	
	CONFIRM:C162("Adressen der aktuellen Umfrage  exportieren")
	If (OK=1)
		p_LogDatenAktualisieren ("Adressen exportieren";vUmfrage;0;"")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$viAnzahl)
		QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ((Records in selection:C76([TelefonNummer:4])#0) & (Records in selection:C76([TelefonNummer:4])#$viAnzahl))
			CONFIRM:C162("Letzte Auswahl (n="+String:C10(Records in selection:C76([TelefonNummer:4]))+") oder alle?";"Alle";"Letzte Auswahl")
			If (OK=1)
				QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
			End if 
		End if 
		UNLOAD RECORD:C212([TelefonNummer:4])
		vsDatei:=p_DateiWaehlen (1;vsPfad;vUmfrage+"_Adr_"+Substring:C12(String:C10(Year of:C25(Current date:C33));3)+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00"))
		If (vsDatei#"")
			p_Client_Standard_Export (->[TelefonNummer:4];"ImportExport";$viFeldTrenner;$viSatzTrenner;vsDatei)
		End if 
	End if 
	
	CONFIRM:C162("Int.-Protokolle der aktuellen Umfrage  exportieren")
	If (OK=1)
		p_LogDatenAktualisieren ("Int.-Protokoll exportieren";vUmfrage;0;"")
		QUERY:C277([AktivLog:8];[AktivLog:8]Umfrage:1=vUmfrage)
		UNLOAD RECORD:C212([AktivLog:8])
		vsDatei:=p_DateiWaehlen (1;vsPfad;vUmfrage+"_Pro_"+Substring:C12(String:C10(Year of:C25(Current date:C33));3)+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00"))
		If (vsDatei#"")
			p_Client_Standard_Export (->[AktivLog:8];"ImportExport";$viFeldTrenner;$viSatzTrenner;vsDatei)
		End if 
	End if 
	
	CONFIRM:C162("Hilfs-Listen der aktuellen Umfrage  exportieren")
	If (OK=1)
		p_LogDatenAktualisieren ("Hilfs-Listen exportieren";vUmfrage;0;"")
		QUERY:C277([Hilfslisten:3];[Hilfslisten:3]Umfrage:1=vUmfrage)
		UNLOAD RECORD:C212([Hilfslisten:3])
		vsDatei:=p_DateiWaehlen (1;vsPfad;vUmfrage+"_List_"+Substring:C12(String:C10(Year of:C25(Current date:C33));3)+String:C10(Month of:C24(Current date:C33);"00")+String:C10(Day of:C23(Current date:C33);"00"))
		If (vsDatei#"")
			p_Client_Standard_Export (->[Hilfslisten:3];"ImportExport";$viFeldTrenner;$viSatzTrenner;vsDatei)
		End if 
	End if 
End if 

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")

