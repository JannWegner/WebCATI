Case of 
	: (Form event code:C388=On Load:K2:1)
		If ([Bogen:6]ID:1="")
			[Bogen:6]MaxAnzEingabe:13:=1
			[Bogen:6]Umfrage:20:=vUmfrage
			[Bogen:6]AvgSchrift:25:=1
		End if 
		If ([Bogen:6]FormTyp:7="")
			[Bogen:6]FormTyp:7:="gen"
		End if 
		If ([Bogen:6]FormNam:8="gen_Multi")
			OBJECT SET VISIBLE:C603(*;[Bogen:6]Halboffen:26;True:C214)
			OBJECT SET VISIBLE:C603(*;"THalboffen";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;[Bogen:6]Halboffen:26;False:C215)
			OBJECT SET VISIBLE:C603(*;"THalboffen";False:C215)
		End if 
		p_BogenAvgFormatSetzen 
		p_BogenEingabeFelderSichtbar 
	: (Form event code:C388=On Validate:K2:3)
		C_TEXT:C284($Ergebnis)
		
		Case of 
			: ([Bogen:6]Filter_Eingabe:9#"")
				If (([Bogen:6]FormNam:8#"gen_Zahl") & ([Bogen:6]FormNam:8#"gen_Dezimal") & (([Bogen:6]FormTyp:7="gen") | ([Bogen:6]FormTyp:7="Spez")))
					$ErlWerteBedarf:=True:C214
				Else 
					$ErlWerteBedarf:=False:C215
				End if 
				
				  //Filter und erlaubte Werte berechnen
				$Blank:=Position:C15(" ";[Bogen:6]Filter_Eingabe:9)
				If ($Blank=0)
					$BereichEnde:=Length:C16([Bogen:6]Filter_Eingabe:9)
				Else 
					$BereichEnde:=$Blank-1
				End if 
				If ([Bogen:6]FormNam:8="gen_Dezimal")
					If (Position:C15("F=";[Bogen:6]Filter_Eingabe:9)#0)
						[Bogen:6]Solo:19:=Substring:C12([Bogen:6]Filter_Eingabe:9;Position:C15("F=";[Bogen:6]Filter_Eingabe:9)+2)
					Else 
						[Bogen:6]Solo:19:=""
					End if 
					$Vorkommastellen:=Num:C11(Substring:C12([Bogen:6]Solo:19;1;(Position:C15(".";[Bogen:6]Solo:19)-1)))
					$Nachkommastellen:=Num:C11(Substring:C12([Bogen:6]Solo:19;(Position:C15(".";[Bogen:6]Solo:19)+1)))
					$Ergebnis:=Calc_ErlWerte_Filter (Substring:C12([Bogen:6]Filter_Eingabe:9;1;$BereichEnde);$ErlWerteBedarf;[Bogen:6]MaxAnzEingabe:13;[Bogen:6]FormNam:8;$Nachkommastellen)
				Else 
					$Ergebnis:=Calc_ErlWerte_Filter (Substring:C12([Bogen:6]Filter_Eingabe:9;1;$BereichEnde);$ErlWerteBedarf;[Bogen:6]MaxAnzEingabe:13;[Bogen:6]FormNam:8;0)
				End if 
				[Bogen:6]Filter_generiert:14:=Substring:C12($Ergebnis;1;Position:C15("**";$Ergebnis)-1)
				[Bogen:6]ErlaubteWerte:15:=Substring:C12($Ergebnis;Position:C15("**";$Ergebnis)+2)
				
				  //kka, MaxWert und MinWert berechnen
				If (([Bogen:6]FormNam:8="gen_Zahl") | ([Bogen:6]FormNam:8="gen_Dezimal"))
					$Ergebnis:=Calc_KkaMinMax ([Bogen:6]Filter_Eingabe:9)
					$Trenner1:=Position:C15("**";$Ergebnis)
					$Trenner2:=Position:C15("**";Substring:C12($Ergebnis;$Trenner1+2))
					[Bogen:6]MinWert:16:=Substring:C12($Ergebnis;1;$Trenner1-1)
					[Bogen:6]MaxWert:17:=Substring:C12($Ergebnis;$Trenner1+2;$Trenner2-1)
					[Bogen:6]KKA:18:=Substring:C12($Ergebnis;$Trenner1+$Trenner2+3)
					
					  //Filter nachbessern
					Case of 
						: ([Bogen:6]FormNam:8="gen_Zahl")
							If (Num:C11([Bogen:6]KKA:18)>Num:C11([Bogen:6]MaxWert:17))  //Problem, wenn kkA mehr Stellen hat wie Max
								[Bogen:6]Filter_generiert:14:=Substring:C12([Bogen:6]Filter_generiert:14+(Length:C16([Bogen:6]KKA:18)*"#");1;80)
							Else 
								[Bogen:6]Filter_generiert:14:=Substring:C12([Bogen:6]Filter_generiert:14+(Length:C16([Bogen:6]MaxWert:17)*"#");1;80)
							End if 
						: ([Bogen:6]FormNam:8="gen_Dezimal")
							  //Dezimalformat generieren
							[Bogen:6]Filter_generiert:14:=Substring:C12([Bogen:6]Filter_generiert:14+(($Vorkommastellen+$Nachkommastellen+1)*"#");1;80)
					End case 
				Else 
					[Bogen:6]MinWert:16:=""
					[Bogen:6]MaxWert:17:=""
					[Bogen:6]KKA:18:=""
				End if 
				
				  //Solos generieren
				Case of 
					: (Position:C15("S=";[Bogen:6]Filter_Eingabe:9)#0)
						[Bogen:6]Solo:19:=Calc_Solowerte ([Bogen:6]Filter_Eingabe:9)
					: ([Bogen:6]FormNam:8#"gen_Dezimal")
						[Bogen:6]Solo:19:=""
				End case 
				
				  //Anzahl Spalten berechnen
				Case of 
					: (([Bogen:6]FormNam:8="gen_FA") | ([Bogen:6]FormNam:8="gen_kFgA") | ([Bogen:6]FormNam:8="gen_gFkA") | ([Bogen:6]FormNam:8="gen_gggFkA") | ([Bogen:6]FormNam:8="gen_Spez") | ([Bogen:6]FormNam:8="gen_1b@") | ([Bogen:6]FormNam:8="gen_Halb@"))
						  //Höchsten Werte aus erlaubten Werten ziehen
						$lauf:=2
						While (Substring:C12([Bogen:6]ErlaubteWerte:15;Length:C16([Bogen:6]ErlaubteWerte:15)-$lauf;1)#",")
							$lauf:=$lauf+1
						End while 
						$MaxWert:=String:C10(Num:C11(Substring:C12([Bogen:6]ErlaubteWerte:15;Length:C16([Bogen:6]ErlaubteWerte:15)-$lauf+1;$lauf-1));"00")
						[Bogen:6]AnzahlSpalten:24:=Num:C11(Substring:C12($MaxWert;1;1))+1
						If (Substring:C12($MaxWert;2;1)="0")
							[Bogen:6]AnzahlSpalten:24:=[Bogen:6]AnzahlSpalten:24-1
						End if 
						
					: ([Bogen:6]FormNam:8="gen_Zahl")
						[Bogen:6]AnzahlSpalten:24:=Length:C16([Bogen:6]MaxWert:17)
					: ([Bogen:6]FormNam:8="gen_Dezimal")
						[Bogen:6]AnzahlSpalten:24:=$Vorkommastellen+$Nachkommastellen
					Else 
						[Bogen:6]AnzahlSpalten:24:=0
				End case 
			: ([Bogen:6]FormNam:8="gen_Multi")
				p_Multi_inArray ([Bogen:6]AvgText:5)
				[Bogen:6]AnzahlSpalten:24:=ai_MultiLaenge{1}+ai_MultiLaenge{2}+ai_MultiLaenge{3}+ai_MultiLaenge{4}+ai_MultiLaenge{5}+ai_MultiLaenge{6}
		End case 
		ALERT:C41("")
End case 