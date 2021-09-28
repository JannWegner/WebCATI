//%attributes = {}
CONFIRM:C162("Wollen Sie das Interview wirklich zu einem späteren Zeitpunkt fortsetzen?";"Nein, weitermachen";"Ja, später weiter")
If (OK=0)
	[TelefonNummer:4]WeiterMitFrage:7:=weitermit
	weitermit:=weitermit_neu ("Später")
	[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+vName+" * Wiedervorlage/Termin"+Char:C90(13)+[TelefonNummer:4]Historie:4
	[TelefonNummer:4]StatusErklärung:11:="Termin/Fortsetzung"
	sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
End if 