//%attributes = {}
  //$1: Text
  //$2: ServerPID

C_TEXT:C284($1;$vs_Text)
C_LONGINT:C283($2;$vi_SPID)

$vs_Text:=$1
$vi_SPID:=$2

SET PROCESS VARIABLE:C370($vi_SPID*(-1);vb_MessageOK;True:C214)
ALERT:C41($vs_Text)
