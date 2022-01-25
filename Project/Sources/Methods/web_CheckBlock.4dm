//%attributes = {}
// web_CheckBlock
// Jann Wegner
// 20220125

// Überprüft, ob für diese IP ein Block vorliegt

var $e_AktBlock : Object

$e_AktBlock:=ds:C1482.WebBlock.query("IP = :1 & Aktiv =:2"; vt_IP; True:C214).first()

Case of 
	: ($e_AktBlock=Null:C1517)  // Es gibt keinen aktiven Eintrag -> Alles gut!
		//
	: ($e_AktBlock.FreiAb<=p_timestampD)  // Es gibt aktiven Eintrag, der ist aber abgelaufen -> Alles gut
		$e_AktBlock.Aktiv:=False:C215
		
		
End case 
