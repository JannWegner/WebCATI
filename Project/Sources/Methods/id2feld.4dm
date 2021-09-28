//%attributes = {}
  //$1 ist ein Wert in [Bogen]ID
  //Rückgabewert ist der Feldinhalt


$ID:=$1

$ArrayPos:=Find in array:C230(asBogenID;$ID)
If ($ArrayPos=-1)
	ALERT:C41("id2feld:"+Char:C90(13)+$ID+" aus AntwortenASCII nicht in den aktuellen BogenID's!"+Char:C90(13)+"Schwerer Fehler -> EDV melden!")
Else 
	  //Test, ob sich diese Antwort auch tatsaechlich auf dem aktuellen Weg befindet
	  //und nicht in einem toten Ast
	If (spezial_if )  //Bei Spezial ist es ganz einfach
		$0:=atAntworten{$ArrayPos}
	Else 
		If ((Position:C15($ID;vt_AktuellerWeg)#0) | ($ID="@Offen") | ($ID=".vs@"))
			$0:=atAntworten{$ArrayPos}
		Else 
			If (([TelefonNummer:4]WeiterMitFrage:7#"") & ([TelefonNummer:4]Wegspeicher:48=""))
				$0:=atAntworten{$ArrayPos}
			Else 
				$0:=""
			End if 
		End if 
	End if 
End if 