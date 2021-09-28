//%attributes = {}
/*
p_timestampD
Jann Wegner
20210422

Erzeugt einen Timestamp in deutscher Zeit im Format
YYYY-MM-DDTHH-MM-SS
*/

C_DATE:C307($vd_Datum)
$vd_Datum:=Current date:C33

$0:=String:C10(Year of:C25($vd_Datum))+"-"+String:C10(Month of:C24($vd_Datum);"00")+"-"+String:C10(Day of:C23($vd_Datum);"00")+"T"+Replace string:C233(String:C10(Current time:C178);":";"-")
