If (Form event code:C388=On Load:K2:1)
	vVorgaben:="Befragter hat keine Zeit mehr................................................."
	vVorgaben:=vVorgaben+Char:C90(13)+Char:C90(13)+"Befragter hat keine Lust mehr, da Interview zu lang ............."
	vVorgaben:=vVorgaben+Char:C90(13)+Char:C90(13)+"Befragter hat keine Lust mehr, da Interview uninteressant ..."
	vVorgaben:=vVorgaben+Char:C90(13)+Char:C90(13)+"Befragter legt einfach auf ......................................................"
	vVorgaben:=vVorgaben+Char:C90(13)+Char:C90(13)+"Quote bereits erfüllt ..........................................................."+"...."
	vVorgaben:=vVorgaben+Char:C90(13)+Char:C90(13)+"Abbruch durch Interviewer ...................................................."
	vVorgaben:=vVorgaben+Char:C90(13)+Char:C90(13)+"Abbruch durch entsprechende Antwort im Bogen ................."
	vCodes:="1"+Char:C90(13)+Char:C90(13)+"2"+Char:C90(13)+Char:C90(13)+"3"+Char:C90(13)+Char:C90(13)+"4"+Char:C90(13)+Char:C90(13)
	vCodes:=vCodes+"5"+Char:C90(13)+Char:C90(13)+"6"+Char:C90(13)+Char:C90(13)+"7"
	[TelefonNummer:4]StatusErklärung:11:=""
	vantw:=id2feld (".vs5_Abbruch")
	GOTO OBJECT:C206(vantw)
End if 