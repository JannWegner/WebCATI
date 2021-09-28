//%attributes = {}
  //Prüft, ob in allen Datensätzen der Auswahl bei allen (Halb-) Offenen Fragen auch Spezial
  //eingegeben wurde. Berücksichtigt alle Fragen, die einen Haken bei Spezial-Eingabe haben

C_TEXT:C284(vt_Fehleranzeige)
C_LONGINT:C283($vi_lauf;$vi_Anz1;$vi_Anz2)

CREATE EMPTY SET:C140([TelefonNummer:4];"$m_Fehlende")

QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Komplett")
CREATE SET:C116([TelefonNummer:4];"$m_Fertige")
$vs_dummy1:="@-bed"
$vs_dummy2:="@-do"

QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
QUERY:C277([Bogen:6]; & [Bogen:6]Spezial_Eingabe:22=True:C214;*)
QUERY:C277([Bogen:6]; & [Bogen:6]ID:1#$vs_dummy1;*)
QUERY:C277([Bogen:6]; & [Bogen:6]ID:1#$vs_dummy2)
ORDER BY:C49([Bogen:6]ID:1)

CONFIRM:C162("Spezial-Konsistenz von "+String:C10(Records in selection:C76([TelefonNummer:4]))+" Interviews in "+String:C10(Records in selection:C76([Bogen:6]))+" Fragen testen?")
If (OK=1)
	
	SELECTION TO ARRAY:C260([Bogen:6]ID:1;$as_SpezBogenID)
	
	vt_Fehleranzeige:=""
	For ($vi_lauf;1;Size of array:C274($as_SpezBogenID))
		MESSAGE:C88(String:C10($vi_lauf)+" von "+String:C10(Size of array:C274($as_SpezBogenID))+": Frage "+$as_SpezBogenID{$vi_lauf})
		USE SET:C118("$m_Fertige")
		
		QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage;*)
		If ($as_SpezBogenID{$vi_lauf}="@.o_Spez")
			$vs_NormalBogenID:=Replace string:C233($as_SpezBogenID{$vi_lauf};".o_Spez";"")
			QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=$vs_NormalBogenID)
			$vs_Halboffen:=","+[Bogen:6]Halboffen:26+","
			  //QUERY SELECTION BY FORMULA([TelefonNummer];(","+LiA ($vs_NormalBogenID)+",")=("@,"+[Bogen]Halboffen+",@"))
			QUERY SELECTION BY FORMULA:C207([TelefonNummer:4];(","+LiA ($vs_NormalBogenID)+",")%$vs_Halboffen)
			  //QUERY SELECTION BY FORMULA([TelefonNummer]; | LiA ($vs_NormalBogenID)=("@,"+[Bogen]Halboffen);*)
			  //QUERY SELECTION BY FORMULA([TelefonNummer]; | LiA ($vs_NormalBogenID)=([Bogen]Halboffen+",@");*)
			  //QUERY SELECTION BY FORMULA([TelefonNummer];| LiA ($vs_NormalBogenID)=[Bogen]Halboffen)
		Else 
			$vs_NormalBogenID:=Replace string:C233($as_SpezBogenID{$vi_lauf};"_Spez";"")
			QUERY:C277([Bogen:6]; & [Bogen:6]ID:1=$vs_NormalBogenID)
			QUERY SELECTION BY FORMULA:C207([TelefonNummer:4];Length:C16(LiA ($vs_NormalBogenID))>2)
		End if 
		
		$vi_Anz1:=Records in selection:C76([TelefonNummer:4])
		MESSAGE:C88(String:C10($vi_lauf)+" von "+String:C10(Size of array:C274($as_SpezBogenID))+": Frage "+$as_SpezBogenID{$vi_lauf}+" / "+String:C10($vi_Anz1)+" offene Antworten")
		QUERY SELECTION BY FORMULA:C207([TelefonNummer:4];Length:C16(LiA ($as_SpezBogenID{$vi_lauf}))=0)
		$vi_Anz2:=Records in selection:C76([TelefonNummer:4])
		MESSAGE:C88(String:C10($vi_lauf)+" von "+String:C10(Size of array:C274($as_SpezBogenID))+": Frage "+$as_SpezBogenID{$vi_lauf}+" / "+String:C10($vi_Anz1)+" offene Antworten"+" / "+String:C10($vi_Anz2)+" Fehler")
		If (Records in selection:C76([TelefonNummer:4])#0)
			vt_Fehleranzeige:=vt_Fehleranzeige+(40*"*")+Char:C90(13)
			vt_Fehleranzeige:=vt_Fehleranzeige+"Frage "+$as_SpezBogenID{$vi_lauf}+Char:C90(13)
			ORDER BY:C49([TelefonNummer:4];[TelefonNummer:4]AdrFBNr:20)
			FIRST RECORD:C50([TelefonNummer:4])
			While (Not:C34(End selection:C36([TelefonNummer:4])))
				If ([TelefonNummer:4]Wegspeicher:48=("@"+$vs_NormalBogenID+"@"))
					vt_Fehleranzeige:=vt_Fehleranzeige+String:C10([TelefonNummer:4]AdrFBNr:20)+"/"
					ADD TO SET:C119([TelefonNummer:4];"$m_Fehlende")
				End if 
				NEXT RECORD:C51([TelefonNummer:4])
			End while 
			vt_Fehleranzeige:=vt_Fehleranzeige+Char:C90(13)+Char:C90(13)
		End if 
	End for 
	
	If (Length:C16(vt_Fehleranzeige)=0)
		ALERT:C41("Alles in Butter!")
	Else 
		ALL RECORDS:C47([Bogen:6])
		DIALOG:C40([Bogen:6];"d_Fehleranzeige")
		CONFIRM:C162("Fehlerhafte anzeigen?";"Anzeigen";"Nein - Danke!")
		If (OK=1)
			USE SET:C118("$m_Fehlende")
		End if 
	End if 
End if 