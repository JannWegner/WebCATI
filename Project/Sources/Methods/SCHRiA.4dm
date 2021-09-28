//%attributes = {}
  //Schreibt in AntwortenASCII = $0
  //$1 Feld bzw FrageID in das geschrieben wird
  //$2 zu schreibender Wert 

AdressenLesenSchreiben 

$0:=Replace string:C233([TelefonNummer:4]AntwASCII:41;$1+"|"+LiA ($1)+"|";$1+"|"+$2+"|";1)
