//%attributes = {}
  //sp_ServerQuit
  //Jann Wegner
  //20130813
  //Stoppt den Server zu einer bestimmten Uhrzeit

  //$1: Stoppzeit

C_TIME:C306($1;$vz_Stoppzeit)
C_LONGINT:C283($vl_StoppZeitInSek;$vl_AktZeitInSek;$vl_WarteTicks)

$vz_Stoppzeit:=$1
  //Zeiten in Sek. nach Mitternacht umrechnen
$vl_StoppZeitInSek:=$vz_Stoppzeit+0
$vl_AktZeitInSek:=Current time:C178+0

  //Wartezeit ist Differenz zwischen akt. Zeit und Stoppzeit
If ($vl_AktZeitInSek<=$vl_StoppZeitInSek)
	$vl_WarteTicks:=($vl_StoppZeitInSek-$vl_AktZeitInSek)*60
Else 
	$vl_WarteTicks:=(86400-($vl_AktZeitInSek-$vl_StoppZeitInSek))*60
End if 

DELAY PROCESS:C323(Current process:C322;$vl_WarteTicks)
QUIT 4D:C291(1)