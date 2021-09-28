//%attributes = {}
p_LogDatenAktualisieren ("Interviewerstatistik";vUmfrage;0;"")

ARRAY TEXT:C222(tInterviewer;0)

C_LONGINT:C283($lauf;vKompletteInterviews;vScreeningInterviews;vIN;vSC)

QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Status:5="Komplett";*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Umfrage:30=vUmfrage)
COPY NAMED SELECTION:C331([TelefonNummer:4];"$ns_alle")

ORDER BY:C49([TelefonNummer:4];[TelefonNummer:4]Interviewer:10)
DISTINCT VALUES:C339([TelefonNummer:4]Interviewer:10;tInterviewer)

ARRAY INTEGER:C220(tSC;Size of array:C274(tInterviewer))
ARRAY INTEGER:C220(tIN;Size of array:C274(tInterviewer))

vKompletteInterviews:=0
vScreeningInterviews:=0

For ($lauf;1;Size of array:C274(tInterviewer))
	USE NAMED SELECTION:C332("$ns_alle")
	QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Interviewer:10=tInterviewer{$lauf};*)
	QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]StatusErklärung:11="Interview")
	tIN{$lauf}:=Records in selection:C76([TelefonNummer:4])
	vKompletteInterviews:=vKompletteInterviews+tIN{$lauf}
	
	USE NAMED SELECTION:C332("$ns_alle")
	QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Interviewer:10=tInterviewer{$lauf};*)
	QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]AdrFeld13:31="$$")
	tSC{$lauf}:=Records in selection:C76([TelefonNummer:4])
	vScreeningInterviews:=vScreeningInterviews+tSC{$lauf}
	
End for 

vIN:=vKompletteInterviews
vSC:=vScreeningInterviews


DIALOG:C40([Variablen:5];"Statistik")

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
