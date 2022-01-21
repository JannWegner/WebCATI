//%attributes = {}
// web_Webdate2Date
// Jann Wegner
// 20220119

// Prüft das Datumsformat aus einem Eingabeformular und macht ein 4D-Datum daraus

var $1; $vt_Date : Text
var $0; $vd_Date : Date
var $vb_DatOK : Boolean


$vt_Date:=$1
$vb_DatOK:=True:C214

Case of 
	: (((Length:C16($vt_Date)=10) | (Length:C16($vt_Date)=8)) & ($vt_Date[[3]]=".") & ($vt_Date[[6]]="."))  //Safari-Format
		$vd_Date:=Date:C102($vt_Date)
	: ((Length:C16($vt_Date)=10) & ($vt_Date[[5]]="-") & ($vt_Date[[8]]="-"))  // Firefox/Chrome-Format
		$vd_Date:=Date:C102(Substring:C12($vt_Date; 9; 2)+"."+Substring:C12($vt_Date; 6; 2)+":"+Substring:C12($vt_Date; 1; 4))
	Else 
		$vb_DatOK:=False:C215  // falsches Format
End case 

If ($vb_DatOK)
	$vb_DatOK:=($vd_Date>=Current date:C33)  // Datum muss größer oder = heute sein
End if 


$0:=Choose:C955($vb_DatOK; $vd_Date; Date:C102("31.12.2999"))