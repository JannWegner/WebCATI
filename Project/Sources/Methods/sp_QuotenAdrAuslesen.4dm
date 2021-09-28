//%attributes = {}
  //Liest den aktuellen Stand aus den Adressen als ServerProz aus

C_BLOB:C604(vbArrayBlob)
C_LONGINT:C283(spErrCode)
C_TEXT:C284($1)
C_TEXT:C284($vUmfrage)
$vUmfrage:=$1

ARRAY INTEGER:C220(aiQuKomplett;0)
ARRAY INTEGER:C220(aiQuFix;0)
ARRAY INTEGER:C220(aiQuVar;0)
ARRAY INTEGER:C220(aiQuAuto;0)
ARRAY INTEGER:C220(aiQuNeu;0)

spErrCode:=2

Repeat 
	DELAY PROCESS:C323(Current process:C322;150)
	If (Undefined:C82(spErrCode))
		spErrCode:=2
	End if 
Until (spErrCode=3)


p_QuotenArrayLeeren (->aiQuKomplett;"n")
p_QuotenArrayLeeren (->aiQuNeu;"n")
p_QuotenArrayLeeren (->aiQuFix;"n")
p_QuotenArrayLeeren (->aiQuVar;"n")
p_QuotenArrayLeeren (->aiQuAuto;"n")

MESSAGE:C88("Adressen auslesen ...")
QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=$vUmfrage;*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]QuotenTopf:46>0)
FIRST RECORD:C50([TelefonNummer:4])
While (Not:C34(End selection:C36([TelefonNummer:4])))
	If ([TelefonNummer:4]Status:5="Komplett")
		aiQuKomplett{[TelefonNummer:4]QuotenTopf:46}:=aiQuKomplett{[TelefonNummer:4]QuotenTopf:46}+1
	Else 
		If ([TelefonNummer:4]Status:5="neu")
			aiQuNeu{[TelefonNummer:4]QuotenTopf:46}:=aiQuNeu{[TelefonNummer:4]QuotenTopf:46}+1
		Else 
			If ([TelefonNummer:4]Status:5="Wiedervorlage")
				If ([TelefonNummer:4]FixTermin:36=True:C214)
					aiQuFix{[TelefonNummer:4]QuotenTopf:46}:=aiQuFix{[TelefonNummer:4]QuotenTopf:46}+1
				Else 
					If ([TelefonNummer:4]StatusErklärung:11="Termin")
						aiQuVar{[TelefonNummer:4]QuotenTopf:46}:=aiQuVar{[TelefonNummer:4]QuotenTopf:46}+1
					Else 
						aiQuAuto{[TelefonNummer:4]QuotenTopf:46}:=aiQuAuto{[TelefonNummer:4]QuotenTopf:46}+1
					End if 
				End if 
			End if 
		End if 
	End if 
	
	NEXT RECORD:C51([TelefonNummer:4])
End while 


VARIABLE TO BLOB:C532(aiQuKomplett;vbArrayBlob)
VARIABLE TO BLOB:C532(aiQuNeu;vbArrayBlob;*)
VARIABLE TO BLOB:C532(aiQuFix;vbArrayBlob;*)
VARIABLE TO BLOB:C532(aiQuVar;vbArrayBlob;*)
VARIABLE TO BLOB:C532(aiQuAuto;vbArrayBlob;*)
COMPRESS BLOB:C534(vbArrayBlob)

spErrCode:=4

Repeat 
	DELAY PROCESS:C323(Current process:C322;150)
Until (spErrCode<0)

