//%attributes = {}
Case of 
	: ([Bogen:6]FormNam:8="gen_Zahl")
		$0:="Minimum:           "+[Bogen:6]MinWert:16+Char:C90(13)+"Maximum:           "+[Bogen:6]MaxWert:17+Char:C90(13)+"Keine Angabe:   "+[Bogen:6]KKA:18
	: ([Bogen:6]FormNam:8="gen_Dezimal")
		$VorkommaErlaubt:=Substring:C12([Bogen:6]Solo:19;1;Position:C15(".";[Bogen:6]Solo:19)-1)
		$NachkommaErlaubt:=Substring:C12([Bogen:6]Solo:19;Position:C15(".";[Bogen:6]Solo:19)+1)
		$0:="Minimum:           "+[Bogen:6]MinWert:16+Char:C90(13)+"Maximum:           "+[Bogen:6]MaxWert:17+Char:C90(13)+"Keine Angabe:   "+[Bogen:6]KKA:18+Char:C90(13)+"Maximale Stellenzahl: "+("#"*Num:C11($VorkommaErlaubt))+","+("#"*Num:C11($NachkommaErlaubt))
	Else 
		$0:=[Bogen:6]AvgText:5
End case 