//%attributes = {}
// web_SessionUpdate
// Jann Wegner
// 20210930

// Macht ein Update auf den Session.storage

var $vi_ItemPos : Integer
var $1; $col_UpdateItems : Collection

$col_UpdateItems:=$1

$vi_ItemPos:=0

Use (Session:C1714.storage.Info)
	Repeat 
		Session:C1714.storage.Info[$col_UpdateItems[$vi_ItemPos]]:=$col_UpdateItems[$vi_ItemPos+1]
		If ($col_UpdateItems[$vi_ItemPos]="LetzteURL")
			Session:C1714.storage.History.push($col_UpdateItems[$vi_ItemPos+1])  // URL-History ergänzen
		End if 
		$vi_ItemPos:=$vi_ItemPos+2
	Until ($vi_ItemPos=$col_UpdateItems.length)
End use 
