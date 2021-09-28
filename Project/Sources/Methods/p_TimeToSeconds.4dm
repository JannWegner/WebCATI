//%attributes = {}
  //Rechnet einen Zeitvariable im format "hh:mm:ss" in Sekunden um
  //Ruft seinerseits p_ZeitStringToSeconds auf
  //$1 muß Format ZEIT sein!

C_TIME:C306($1)

$0:=p_TimeStringToSeconds (String:C10($1;HH MM SS:K7:1))