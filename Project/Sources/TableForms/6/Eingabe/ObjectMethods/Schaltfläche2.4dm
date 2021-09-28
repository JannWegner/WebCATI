ARRAY TEXT:C222(as_Formulare;0)
LIST TO ARRAY:C288("Formulare";as_Formulare)
$vi_ListSize:=Size of array:C274(as_Formulare)
INSERT IN ARRAY:C227(as_Formulare;$vi_ListSize+1;11)
as_Formulare{$vi_ListSize+1}:="Bedingung"
as_Formulare{$vi_ListSize+2}:="do: Dauer"
as_Formulare{$vi_ListSize+3}:="do: Wochentag"
as_Formulare{$vi_ListSize+4}:="do: Datum"
as_Formulare{$vi_ListSize+5}:="do: Alert"
as_Formulare{$vi_ListSize+6}:="do: Infofeld"
as_Formulare{$vi_ListSize+7}:="do: write"
as_Formulare{$vi_ListSize+8}:="do: do_command"
as_Formulare{$vi_ListSize+9}:="do: copy"
as_Formulare{$vi_ListSize+10}:="do: Fassung"
as_Formulare{$vi_ListSize+11}:="gen_Spez"

$vs_Suche:=""
Case of 
	: ([Bogen:6]FormNam:8="gen_@")
		$vs_Suche:=[Bogen:6]FormNam:8
	: ([Bogen:6]ID:1="@-bed")
		$vs_Suche:="Bedingung"
	: ([Bogen:6]ID:1="@-do")
		Case of 
			: ([Bogen:6]Bedingung:10="Dauer")
				$vs_Suche:="do: Dauer"
			: ([Bogen:6]Bedingung:10="Wochentag")
				$vs_Suche:="do: Wochentag"
			: ([Bogen:6]Bedingung:10="Datum")
				$vs_Suche:="do: Datum"
			: ([Bogen:6]Bedingung:10="alert@")
				$vs_Suche:="do: Alert"
			: ([Bogen:6]Bedingung:10="Infofeld")
				$vs_Suche:="do: Infofeld"
			: ([Bogen:6]Bedingung:10="write@")
				$vs_Suche:="do: write"
			: ([Bogen:6]Bedingung:10="do_command")
				$vs_Suche:="do: do_command"
			: ([Bogen:6]Bedingung:10="copy@")
				$vs_Suche:="do: copy"
			: ([Bogen:6]Bedingung:10="Fassung")
				$vs_Suche:="do: Fassung"
		End case 
End case 

as_Formulare:=Find in array:C230(as_Formulare;$vs_Suche)
If (as_Formulare=-1)
	ALERT:C41("Keine Konkrete Hilfe gefunden")
	as_Formulare:=1
End if 

$vi_FensterRef:=Open window:C153(100;100;900;600)
DIALOG:C40([Bogen:6];"d_Hilfe")
