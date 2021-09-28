//%attributes = {}
  // p_ClearFieldName
  // Jann Wegner
  // 20180509

  // $1: Feldname

C_TEXT:C284($0;$1;$vt_Feldname)

$vt_Feldname:=$1

$vt_Feldname:=Replace string:C233($vt_Feldname;"(";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;")";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"+";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"-";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"*";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;Char:C90(34);"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;";";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"=";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"&";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"|";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"#";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"<";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;">";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"^";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"'";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"{";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"}";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"%";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;",";"_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"$";"Doll_")
$vt_Feldname:=Replace string:C233($vt_Feldname;"/";"_")

$0:=$vt_Feldname
