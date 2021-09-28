//%attributes = {}
/*
p_Komm4HTML 
Jann Wegner
20210503
*/

C_COLLECTION:C1488($col_Komm)
ARRAY TEXT:C222(at_Kommentar;0)
$col_Komm:=New collection:C1472

$col_Komm:=Split string:C1554([TelefonNummer:4]Kommentar:6;Char:C90(13);sk ignore empty strings:K86:1+sk trim spaces:K86:2)
COLLECTION TO ARRAY:C1562($col_Komm;at_Kommentar)