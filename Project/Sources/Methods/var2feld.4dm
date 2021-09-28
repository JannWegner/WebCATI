//%attributes = {}
  //$1 = weitermit
  //$2 = vantw
  //$3 = FormName

$WeiterMit:=$1
$vAntwort:=$2
$FormName:=$3

  //Normale Antworten in das AntwortenArray schreiben lassen
vAntwInArray ($vAntwort;$WeiterMit)

  //Bei Fragen mit offener Ergänzung auch diese schreiben
If (([Bogen:6]FormNam:8="gen_1b@") | ([Bogen:6]FormNam:8="gen_Halboffen"))
	vAntwInArray (vAntwOffen;$WeiterMit+"Offen")
End if 


