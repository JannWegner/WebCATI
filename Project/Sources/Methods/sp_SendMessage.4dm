//%attributes = {}
  //$1: Empfaenger
  //$2: Text
  //$3: Endedatum
  //$4: Endezeit

C_TEXT:C284($1;$2;$vs_Empfaenger;$vs_Text)
C_DATE:C307($3;$vd_EndeDatum)
C_TIME:C306($4;$vz_EndeZeit)
C_BOOLEAN:C305(vb_MessageOK)

$vs_Empfaenger:=$1
$vs_Text:=$2
$vd_EndeDatum:=$3
$vz_EndeZeit:=$4
vb_MessageOK:=False:C215

Repeat 
	EXECUTE ON CLIENT:C651($vs_Empfaenger;"p_MeldungAnzeigen";$vs_Text;Current process:C322)
	DELAY PROCESS:C323(Current process:C322;1800)
Until ((($vd_EndeDatum<=Current date:C33) & ($vz_EndeZeit<=Current time:C178)) | vb_MessageOK)
