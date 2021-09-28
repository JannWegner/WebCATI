//%attributes = {}
MESSAGE:C88("Zählen von "+$1)
C_TEXT:C284($vtText)
CREATE SET:C116([TelefonNummer:4];"$mZeile")
$viZeile:=Records in selection:C76([TelefonNummer:4])
If (viGesamt#0)
	$viZeilePr:=Round:C94($viZeile/viGesamt*100;1)
Else 
	$viZeilePr:=0
End if 

QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]EingetragenTB:12=True:C214)
$viZeileTB:=Records in selection:C76([TelefonNummer:4])
If ($viZeile#0)
	$viZeileTBHPr:=Round:C94($viZeileTB/$viZeile*100;1)
Else 
	$viZeileTBHPr:=0
End if 
If (viTBGesamt#0)
	$viZeileTBVPr:=Round:C94($viZeileTB/viTBGesamt*100;1)
Else 
	$viZeileTBVPr:=0
End if 

USE SET:C118("$mZeile")
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]EingetragenTB:12=False:C215)
$viZeileNTB:=Records in selection:C76([TelefonNummer:4])
If ($viZeile#0)
	$viZeileNTBHPr:=Round:C94($viZeileNTB/$viZeile*100;1)
Else 
	$viZeileNTBHPr:=0
End if 
If (viNTBGesamt#0)
	$viZeileNTBVPr:=Round:C94($viZeileNTB/viNTBGesamt*100;1)
Else 
	$viZeileNTBVPr:=0
End if 

$vtText:=Char:C90(13)+$1+String:C10($viZeile;"^^^^^0")+"  | "+String:C10($viZeileTB;"^^^^^0")+"  "+String:C10($viZeileTBHPr;"^^0,0")+" %   |  "+String:C10($viZeileNTB;"^^^^^0")+"  "+String:C10($viZeileNTBHPr;"^^0,0")+" %"
$vtText:=$vtText+Char:C90(13)+(" "*16)+String:C10($viZeilePr;"^^0,0")+" %  |         "+String:C10($viZeileTBVPr;"^^0,0")+" %       |      "+String:C10($viZeileNTBVPr;"^^0,0")+" %"

$0:=$vtText+vsHTrenner
