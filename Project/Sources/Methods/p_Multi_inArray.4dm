//%attributes = {}
  //Kopiert bei gen_Multi-Formularen den Text aus AvgText in ein Array
  //Erwartet [Bogen]AvgText in $1 

ARRAY TEXT:C222(as_MultiLabel;6)
ARRAY LONGINT:C221(ai_MultiMin;6)
ARRAY LONGINT:C221(ai_MultiMax;6)
ARRAY LONGINT:C221(ai_MultikkA;6)
ARRAY INTEGER:C220(ai_MultiLaenge;6)
C_TEXT:C284($vt_dummy;$vs_kkA)
C_LONGINT:C283($vi_lauf)
$vt_dummy:=$1

For ($vi_lauf;1;6)
	as_MultiLabel{$vi_lauf}:=""
	ai_MultiMin{$vi_lauf}:=0
	ai_MultiMax{$vi_lauf}:=0
	ai_MultikkA{$vi_lauf}:=-9
	ai_MultiLaenge{$vi_lauf}:=0
End for 

$vi_lauf:=0
While (Not:C34(Position:C15(";";$vt_dummy)=0))
	$vi_lauf:=$vi_lauf+1
	as_MultiLabel{$vi_lauf}:=Substring:C12($vt_dummy;1;Position:C15(";";$vt_dummy)-1)
	$vt_dummy:=Substring:C12($vt_dummy;Position:C15(";";$vt_dummy)+1)
	ai_MultiMin{$vi_lauf}:=Num:C11(Substring:C12($vt_dummy;1;Position:C15(";";$vt_dummy)-1))
	$vt_dummy:=Substring:C12($vt_dummy;Position:C15(";";$vt_dummy)+1)
	ai_MultiMax{$vi_lauf}:=Num:C11(Substring:C12($vt_dummy;1;Position:C15(";";$vt_dummy)-1))
	$vt_dummy:=Substring:C12($vt_dummy;Position:C15(";";$vt_dummy)+1)
	$vs_kkA:=Substring:C12($vt_dummy;1;Position:C15(";";$vt_dummy)-1)
	ai_MultikkA{$vi_lauf}:=(Num:C11($vs_kkA)*Num:C11($vs_kkA#""))+(-9*Num:C11($vs_kkA=""))
	$vt_dummy:=Substring:C12($vt_dummy;Position:C15(";";$vt_dummy)+2)
	ai_MultiLaenge{$vi_lauf}:=((Length:C16(String:C10(ai_MultiMax{$vi_lauf})))*(Num:C11(ai_MultiMax{$vi_lauf}>ai_MultikkA{$vi_lauf})))+((Length:C16(String:C10(ai_MultikkA{$vi_lauf})))*(Num:C11(ai_MultiMax{$vi_lauf}<ai_MultikkA{$vi_lauf})))
End while 
