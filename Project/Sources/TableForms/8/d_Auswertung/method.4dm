Case of 
	: (Form event code:C388=On Load:K2:1)
		C_DATE:C307(vs_IA_Datum)
		MESSAGE:C88("Umfragen werden zusammengestellt - bitte kurz warten ...")
		ALL RECORDS:C47([Variablen:5])
		If (Not:C34(User in group:C338(Current user:C182;"AlleUmfragen")))
			QUERY SELECTION:C341([Variablen:5];[Variablen:5]FuerAlleOffen:30=True:C214)
		End if 
		ORDER BY:C49([Variablen:5];[Variablen:5]EingerichtetAm:40;<)
		SELECTION TO ARRAY:C260([Variablen:5]Umfrage:3;taUmfragen)
		INSERT IN ARRAY:C227(taUmfragen;1)
		taUmfragen{1}:="@"
		taUmfragen:=Find in array:C230(taUmfragen;vUmfrage)
		
		QUERY:C277([AktivLog:8];[AktivLog:8]Umfrage:1=taUmfragen{taUmfragen})
		DISTINCT VALUES:C339([AktivLog:8]DBNutzer:4;tsUserList)
		SORT ARRAY:C229(tsUserList)
		INSERT IN ARRAY:C227(tsUserList;1)
		tsUserList{1}:="@"
		tsUserList:=1
		
		
		ARRAY TEXT:C222(as_rbZeit;0)
		tsUserList:=1
		vs_IA_Datum:=Current date:C33
End case 
Case of 
	: ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4))
		C_LONGINT:C283($h;$m;$s)
		
		QUERY:C277([AktivLog:8];[AktivLog:8]Umfrage:1=taUmfragen{taUmfragen};*)
		If (String:C10(vs_IA_Datum)#"00.00.00")
			QUERY:C277([AktivLog:8]; & [AktivLog:8]Datum:2=vs_IA_Datum;*)
		End if 
		QUERY:C277([AktivLog:8]; & [AktivLog:8]DBNutzer:4=tsUserList{tsUserList})
		ORDER BY:C49([AktivLog:8];[AktivLog:8]Datum:2;<;[AktivLog:8]Zeit:3;<)
		SELECTION TO ARRAY:C260([AktivLog:8]Umfrage:1;vs_rbUmfrage;[AktivLog:8]DBNutzer:4;vs_rbInterviewer;[AktivLog:8]Datum:2;vs_rbDatum;[AktivLog:8]Zeit:3;vs_rbZeit;[AktivLog:8]AdrFbNr:5;vs_rbFbNr;[AktivLog:8]Status:6;vs_rbStatus;[AktivLog:8]StatusErklärung:7;vs_rbStatusErklaerung)
		ARRAY TEXT:C222(as_rbZeit;Size of array:C274(vs_rbZeit))
		For ($lauf;1;Size of array:C274(vs_rbZeit))
			$h:=Trunc:C95(vs_rbZeit{$lauf}/3600;0)
			$m:=Trunc:C95((vs_rbZeit{$lauf}-($h*3600))/60;0)
			$s:=vs_rbZeit{$lauf}-($m*60)-($h*3600)
			as_rbZeit{$lauf}:=String:C10($h;"00")+":"+String:C10($m;"00")+":"+String:C10($s;"00")
		End for 
End case 

