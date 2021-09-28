//%attributes = {}
/*
p_Infofeld4HTML 
Jann Wegner
20210503
*/

C_COLLECTION:C1488($col_vPerson)
ARRAY TEXT:C222(at_vPerson;0)
$col_vPerson:=New collection:C1472

$col_vPerson:=Split string:C1554(vPerson;Char:C90(13);sk ignore empty strings:K86:1+sk trim spaces:K86:2)
COLLECTION TO ARRAY:C1562($col_vPerson;at_vPerson)