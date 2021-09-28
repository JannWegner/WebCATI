//%attributes = {}
/*
p_Hist4HTML 
Jann Wegner
20210503
*/

C_COLLECTION:C1488($col_Historie)
ARRAY TEXT:C222(at_Historie;0)
$col_Historie:=New collection:C1472

$col_Historie:=Split string:C1554([TelefonNummer:4]Historie:4;Char:C90(13);sk ignore empty strings:K86:1+sk trim spaces:K86:2)
COLLECTION TO ARRAY:C1562($col_Historie;at_Historie)