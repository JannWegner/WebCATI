  //Markierte rausnehmen
  //Jann Wegner
  //20151123

COPY NAMED SELECTION:C331([Mapping:10];"$ns_Temp")
USE SET:C118("UserSet")
CONFIRM:C162(String:C10(Records in set:C195("userSet"))+" Einträge rausnehmen?")
If (OK=1)
	APPLY TO SELECTION:C70([Mapping:10];[Mapping:10]NeueNr:4:=0)
	APPLY TO SELECTION:C70([Mapping:10];[Mapping:10]NeuerName:5:="")
End if 
USE NAMED SELECTION:C332("$ns_Temp")