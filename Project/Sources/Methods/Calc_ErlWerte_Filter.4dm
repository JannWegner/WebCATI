//%attributes = {}
$Eingabe:=$1+";"
$ErlWerteBedarf:=$2
$MaxAnzEingabe:=$3
$FormName:=$4
$Nachkommastellen:=$5

$Start:=""
$Ziel:=""
$Zahl:=""
$MW:=""
$Filter:=""
$MaxLaenge:=0

ARRAY TEXT:C222($a_Werte;0)
ARRAY INTEGER:C220($aiErlaubteWerte;0)
$faktor:=1
For ($lauf;1;$Nachkommastellen)
	$faktor:=$faktor*10
End for 
For ($lauf;1;Length:C16($Eingabe))
	Case of 
		: ($Eingabe[[$lauf]]=";")
			If ($Start="")
				$Start:=$Zahl
			End if 
			$Ziel:=$Zahl
			$Zahl:=""
		: ($Eingabe[[$lauf]]="-")
			$Start:=$Zahl
			$Zahl:=""
		Else 
			$Zahl:=$Zahl+$Eingabe[[$lauf]]
	End case 
	If ($Eingabe[[$lauf]]=";")
		For ($lauf2;Num:C11($Start)*$faktor;Num:C11($Ziel)*$faktor)
			If ($ErlWerteBedarf)
				INSERT IN ARRAY:C227($aiErlaubteWerte;1;1)
				$aiErlaubteWerte{1}:=$lauf2
				If (Length:C16(String:C10($lauf2))>$MaxLaenge)
					$MaxLaenge:=Length:C16(String:C10($lauf2))
				End if 
			End if 
			For ($Stelle;1;Length:C16(String:C10($lauf2)))
				If (Find in array:C230($a_Werte;String:C10($lauf2)[[$Stelle]])=-1)
					INSERT IN ARRAY:C227($a_Werte;1)
					$a_Werte{1}:=String:C10($lauf2)[[$Stelle]]
					If (Size of array:C274($a_Werte)=10)
						If (Not:C34($ErlWerteBedarf))
							$lauf2:=Num:C11($Ziel)
							$lauf:=Length:C16($Eingabe)
						End if 
					End if 
				End if 
			End for 
		End for 
		$Start:=""
		$Ziel:=""
	End if 
End for 
SORT ARRAY:C229($a_Werte)
For ($lauf;1;Size of array:C274($a_Werte))
	$Filter:=$Filter+";"+$a_Werte{$lauf}
End for 
If (($MaxAnzEingabe>1) | ($FormName="gen_Dezimal"))
	$Filter:=$Filter+";,"
End if 

$0:="&"+Char:C90(34)+Substring:C12($Filter;2)+Char:C90(34)+(($MaxAnzEingabe*$MaxLaenge)*"#")+(($MaxAnzEingabe-1)*"#")+"**"
If ($ErlWerteBedarf)
	SORT ARRAY:C229($aiErlaubteWerte)
	$0:=$0+","
	For ($lauf;1;Size of array:C274($aiErlaubteWerte))
		$0:=$0+String:C10($aiErlaubteWerte{$lauf})+","
	End for 
End if 
