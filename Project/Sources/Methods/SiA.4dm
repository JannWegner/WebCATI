//%attributes = {}
  //SiA - Suche in Antworten
  //$1 Suchstring
  //$2 Feld
  //$3 Operator ("=", "#" oder "&" für "enthält")

$vsSuchString:=$1
$vsFeld:=$2
$vsOperator:=$3
$0:=False:C215

$vtAntwort:=LiA ($vsFeld)

If ($vtAntwort#"")
	Case of 
		: ($vsOperator="=")
			$0:=($vsSuchString=$vtAntwort)
		: ($vsOperator="#")
			$0:=($vsSuchString#$vtAntwort)
		: ($vsOperator="&")
			$0:=(Position:C15(","+$vsSuchString+",";","+$vtAntwort+",")#0)
	End case 
End if 
