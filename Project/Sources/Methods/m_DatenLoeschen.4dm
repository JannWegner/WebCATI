//%attributes = {}
p_LogDatenAktualisieren ("Daten löschen";vUmfrage;0;"")

C_BOOLEAN:C305(vb_KomplettLoeschen)
vb_KomplettLoeschen:=False:C215
DIALOG:C40([Variablen:5];"d_DatenLoeschen")

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")

If (vb_KomplettLoeschen)
	p_UmfrageWählen 
End if 