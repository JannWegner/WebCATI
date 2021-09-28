//%attributes = {}
  //init_id_arr 
init_wm_arr 
init_text_var 
READ ONLY:C145([Bogen:6])
C_BLOB:C604($vxAntwortBlob)
Repeat 
	EndeNummer:=amende (weitermit)
	vSprungmarke:=get_sprung_ziel (weitermit)
	init_frage (weitermit)
	Case of 
		: ((einmal_if (weitermit) | generisch_if (weitermit)))
			  //Echtes Input Form
			p_LogDatenAktualisieren ("Interviewen";vUmfrage;[TelefonNummer:4]AdrFBNr:20;weitermit)
			
			init_input_form (weitermit)
			MODIFY RECORD:C57([TelefonNummer:4])
		: (bedingung_if (weitermit))
			  // Nur Sprungziel - in [Bogen]Bedingung muß weitermit durch zB
			EXECUTE FORMULA:C63(get_bedingung )  // Alter 4D-Version nur "EXECUTE"
			  // Soll die Entscheidung dokumentiert werden?
			  // Fragetext besteht aus entweder aus write oder copy
			Case of 
				: ([Bogen:6]FText:3="write@")  // 1. Zeile write
					  // Folgezeilen immer: ID blank WERT 
					$Antwort:=Substring:C12([Bogen:6]FText:3;Position:C15(ex_res;[Bogen:6]FText:3)+Length:C16(ex_res)+1;1)
					var2feld (weitermit;$Antwort;"")
				: ([Bogen:6]FText:3="copy@")  // 1. Zeile copy
					  // Folgezeile ist eine ID, deren Antwort übernommen werden soll
					  // FText muss genau 2 Zeilen haben: 1.: "copy", 2.: ID - muss SinglePunch sein!!
					$vt_DummyText:=Replace string:C233(Replace string:C233([Bogen:6]FText:3;" ";"");"copy"+Char:C90(13);"")+Char:C90(13)
					$Antwort:=LiA (Substring:C12($vt_DummyText;1;Position:C15(Char:C90(13);$vt_DummyText)-1))
					var2feld (weitermit;$Antwort;"")
			End case 
			weitermit:=weitermit_neu (ex_res)
		: (do_if (weitermit))
			  // ActionFormular
			do_action 
		: (spezial_if (weitermit))
			If (vbSpezialMitSchluessel)
				  //Schlüsseln und gleichzeitiges Eingaben von Spezial
				
			Else 
				  //Normale Spezialeingabe: nur Eingeben, ohne zu Schlüsseln
				init_input_form (weitermit)
				  //Original-Antwort ermitteln und Länge testen
				vavgtext:=id2feld ([Bogen:6]AvgText:5+("Offen"*Num:C11([Bogen:6]ID:1="@.o_Spez")))
				If (Length:C16(vavgtext)<2)
					  //KKA
					  //Vorgelagert aus Formularmethode [Telefonnummer]gen_Spez (20.05.2008)
					vantw:=""
					WeiterButtonGedrueckt ("NoCheck")
				Else 
					MODIFY RECORD:C57([TelefonNummer:4])
				End if 
			End if 
	End case 
	VARIABLE TO BLOB:C532(atAntworten;$vxAntwortBlob)
	[TelefonNummer:4]AntwortArrayBlob:22:=$vxAntwortBlob
	sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
	
Until (EndeNummer)

Case of 
	: (weitermit="speichern")
		OK:=1
	: (weitermit="speichern_Ende")
		OK:=0
End case 
