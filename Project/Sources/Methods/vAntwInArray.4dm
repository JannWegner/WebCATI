//%attributes = {}
  //$Schreibt den Text aus $1 ins Element $2 von atAntworten

$Antwort:=$1
$ID:=$2

$ArrayPos:=Find in array:C230(asBogenID;$ID)
If ($ArrayPos=-1)
	ALERT:C41("vAntwInArray:"+Char:C90(13)+$ID+" aus AntwortenASCII nicht in den aktuellen BogenID's!"+Char:C90(13)+"Schwerer Fehler -> EDV melden!")
Else 
	atAntworten{$ArrayPos}:=$Antwort
End if 

