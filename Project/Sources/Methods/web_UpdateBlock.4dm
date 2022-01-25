//%attributes = {}
// web_UpdateBlock
// Jann Wegner
// 20220125

// Checkt ob für diese IP ein (aktueller) Block-Eintrag vorhanden ist und aktualisiert diesen ggf. bzw. legt ihn neu an
// $1: Aktion, kann sein Block/Free

var $1; $vt_Aktion : Text
var $e_AktBlock : Object
var $vl_Warten : Integer

$vt_Aktion:=$1
$e_AktBlock:=ds:C1482.WebBlock.query("IP = :1 & Aktiv =:2"; vt_IP; True:C214).first()

Case of 
	: (($vt_Aktion="Free") & ($e_AktBlock#Null:C1517))
		$e_AktBlock.Aktiv:=False:C215
		$e_AktBlock.save()
		
	: (($vt_Aktion="Block") & ($e_AktBlock=Null:C1517))  // Es gibt keinen aktiven Eintrag -> erzeugen
		$e_AktBlock:=ds:C1482.WebBlock.new()
		$e_AktBlock.IP:=vt_IP
		$e_AktBlock.ErsterBlock:=p_timestampD
		$e_AktBlock.Versuche:=1
		$e_AktBlock.Aktiv:=True:C214
		$e_AktBlock.LetzterBlock:=p_timestampD
		$e_AktBlock.save()
		
	: (($vt_Aktion="Block") & ($e_AktBlock#Null:C1517))
		$e_AktBlock.Versuche:=$e_AktBlock.Versuche+1
		$e_AktBlock.LetzterBlock:=p_timestampD
		$e_AktBlock.save()
End case 


If ($e_AktBlock#Null:C1517)  // Gibt es aktiven Block?
	If ($e_AktBlock.Versuche>3)  // Müssen wir bremsen?
		web_NewLog("Block")
		Case of 
			: ($e_AktBlock.Versuche=4)
				$vl_Warten:=5
			: ($e_AktBlock.Versuche=5)
				$vl_Warten:=10
			: ($e_AktBlock.Versuche=6)
				$vl_Warten:=30
			: ($e_AktBlock.Versuche=7)
				$vl_Warten:=60
			Else 
				$vl_Warten:=300
		End case 
		DELAY PROCESS:C323(Current process:C322; $vl_Warten*60)
	End if 
End if 