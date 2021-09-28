//%attributes = {}
  // $1 ist eine Spaltenposition wie zB C23 oderCB17
  //$0 gibt den Offset wie zB 23 oder 2*80+17=177 zurück

$vsDG_Spalte:=Uppercase:C13($1)

If ($vsDG_Spalte[[1]]#"C")
	ALERT:C41("'"+$vsDG_Spalte+"': Erwarte 'C' als erstes Zeichen (sp2off) - Abbruch!")
	ABORT:C156
Else 
	If (Length:C16($vsDG_Spalte)=3)
		If (istzahl ($vsDG_Spalte[[2]]) & istzahl ($vsDG_Spalte[[3]]))
			$i:=Num:C11(Substring:C12($vsDG_Spalte;2))
			If (($i>=1) & ($i<=80))
				$0:=$i
			Else 
				ALERT:C41("'"+$vsDG_Spalte+"': 1<= Spalte <= 80  (sp2off) - Abbruch!")
				ABORT:C156
			End if 
		Else 
			ALERT:C41("'"+$vsDG_Spalte+"': Erwarte zweistellige Zahl  (sp2off) - Abbruch!")
			ABORT:C156
		End if 
	Else 
		If (Length:C16($vsDG_Spalte)=4)
			If (istAZ ($vsDG_Spalte[[2]]) & istzahl ($vsDG_Spalte[[3]]) & istzahl ($vsDG_Spalte[[4]]))
				$i:=Num:C11(Substring:C12($vsDG_Spalte;3))
				If (($i>=1) & ($i<=80))
					$0:=$i
				Else 
					ALERT:C41("'"+$vsDG_Spalte+"': 1<= Spalte <= 80  (sp2off) - Abbruch!")
					ABORT:C156
				End if 
				$j:=Character code:C91($vsDG_Spalte[[2]])-Character code:C91("A")+1
				$0:=$j*80+$i
			Else 
				ALERT:C41("'"+$vsDG_Spalte+"': Erwarte Buchstabe und zweistellige Zahl  (sp2off) - Abbruch!")
				ABORT:C156
			End if 
		Else 
			ALERT:C41("'"+$vsDG_Spalte+"': Zu lang  (sp2off) - Abbruch!")
			ABORT:C156
		End if 
	End if 
End if 