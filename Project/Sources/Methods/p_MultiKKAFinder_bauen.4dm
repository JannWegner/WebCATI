//%attributes = {}
  //Baut einen Multi-KKA-Finder

MESSAGE:C88("Multi-KKA-Finder bauen ...")

QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
QUERY:C277([Bogen:6]; & [Bogen:6]FormNam:8="gen_Multi")

ARRAY TEXT:C222(tMultiKKAFinder;0)

FIRST RECORD:C50([Bogen:6])
While (Not:C34(End selection:C36([Bogen:6])))
	p_Multi_inArray ([Bogen:6]AvgText:5)
	
	  //Test, wo das kkA-Feld ist
	$kkAFeld:=-9
	Case of 
		: (ai_MultikkA{1}#-9)
			$Offset:=1
			$kkAFeld:=1
		: (ai_MultikkA{2}#-9)
			$Offset:=ai_MultiLaenge{1}+2
			$kkAFeld:=2
		: (ai_MultikkA{3}#-9)
			$Offset:=ai_MultiLaenge{1}+ai_MultiLaenge{2}+3
			$kkAFeld:=3
		: (ai_MultikkA{4}#-9)
			$Offset:=ai_MultiLaenge{1}+ai_MultiLaenge{2}+ai_MultiLaenge{3}+4
			$kkAFeld:=4
		: (ai_MultikkA{5}#-9)
			$Offset:=ai_MultiLaenge{1}+ai_MultiLaenge{2}+ai_MultiLaenge{3}+ai_MultiLaenge{4}+5
			$kkAFeld:=5
		: (ai_MultikkA{6}#-9)
			$Offset:=ai_MultiLaenge{1}+ai_MultiLaenge{2}+ai_MultiLaenge{3}+ai_MultiLaenge{4}+ai_MultiLaenge{5}+6
			$kkAFeld:=6
	End case 
	If ($kkAFeld#-9)
		INSERT IN ARRAY:C227(tMultiKKAFinder;1)
		tMultiKKAFinder{1}:=p_TextFormat ([Bogen:6]ID:1;"l";30)+";"+String:C10($Offset;"0000")+";"+String:C10(ai_MultiLaenge{$kkAFeld};"0000")+";"+String:C10(ai_MultikkA{$kkAFeld};"0000000000")
	End if 
	NEXT RECORD:C51([Bogen:6])
End while 