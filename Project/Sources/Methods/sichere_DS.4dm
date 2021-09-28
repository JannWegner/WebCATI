//%attributes = {}
C_LONGINT:C283($1)
$gesichert:=False:C215
Repeat 
	LOCKED BY:C353(Table:C252($1)->;$Prozessnr;$Anwender;$Arbeitsstation;$Prozessname)
	If (($Prozessnr=0) | ($Prozessnr=ProzNr))
		SAVE RECORD:C53(Table:C252($1)->)
		LOAD RECORD:C52(Table:C252($1)->)
		$gesichert:=True:C214
	Else 
		If ($Prozessnr>0)
			CONFIRM:C162("Der DS von "+Table name:C256($1)+" wird bereits bearbeitet"+Char:C90(13)+"U: "+$Anwender+" S: "+$Arbeitsstation+" P: "+$Prozessname+" Nochmal!")
			If (OK=0)
				ABORT:C156
			End if 
		Else 
			CONFIRM:C162("Der DS von "+Table name:C256($1)+" wurde gelöscht"+Char:C90(13)+"U: "+$Anwender+" S: "+$Arbeitsstation+" P: "+$Prozessname+" Nochmal!")
			If (OK=0)
				ABORT:C156
			End if 
		End if 
		MESSAGE:C88("DS von: "+Table name:C256($1)+" wird gesichert - bitte kurz warten...")
		For ($i;1;50000)
		End for 
	End if 
Until ($gesichert)