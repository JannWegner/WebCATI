//%attributes = {}
  //Berechnet aus den Einträgen in einer Textvariablen im Format
  //Frage-ID;Datum;Uhrzeit (wmproto) die kummulierte Dauer des Interviews
  //in Minuten (auch über mehrere Sitzungen hinweg)
  //Start ist immer beim Eintrag "Start", Ende immer bei einem Endeformular oder
  //Ende der Eingabevariablen

  //$1 enhält den Textstring (normalerweise [TelefonNummer]wmProto)

C_TEXT:C284($vt_AuswertString;$1)
C_TEXT:C284($vs_StartString)
C_TIME:C306($vr_KummZeit)
C_LONGINT:C283($vi_Zeit)

$vt_AuswertString:=$1
$vr_KummZeit:=Time:C179("00:00:00")
$vs_StartString:=""
While (Not:C34($vt_AuswertString=""))
	Case of 
		: (Position:C15("Start";Substring:C12($vt_AuswertString;1;Position:C15(Char:C90(13);$vt_AuswertString)))#0)
			  //Ein neuer Start ...
			$vs_StartString:=Substring:C12($vt_AuswertString;1;8)
			
		: ((Position:C15("Ende";Substring:C12($vt_AuswertString;1;Position:C15(Char:C90(13);$vt_AuswertString)))#0) & ($vs_StartString#""))
			  //(Zwischen-) Zeit nehmen
			$vr_KummZeit:=$vr_KummZeit+Time:C179(Substring:C12($vt_AuswertString;1;8))-Time:C179($vs_StartString)
			$vs_StartString:=""
	End case 
	
	  //Nächste Zeile
	$vt_AuswertString:=Substring:C12($vt_AuswertString;Position:C15(Char:C90(13);$vt_AuswertString)+1)
End while 
If ($vs_StartString)#""
	$vr_KummZeit:=$vr_KummZeit+Current time:C178-Time:C179($vs_StartString)
End if 

$vi_Zeit:=Round:C94(p_TimeToSeconds ($vr_KummZeit)/60;0)
If ($vi_Zeit>99)
	$0:=99
	[TelefonNummer:4]Dauer:51:=99
Else 
	$0:=$vi_Zeit
	[TelefonNummer:4]Dauer:51:=$vi_Zeit
End if 
