  //Originaltext übernehmen
  //20151123

COPY NAMED SELECTION:C331([Mapping:10];"$ns_Temp")
USE SET:C118("UserSet")
CONFIRM:C162(String:C10(Records in set:C195("userSet"))+" Originaltexte- und Positionen übernehmen?")
If (OK=1)
	APPLY TO SELECTION:C70([Mapping:10];[Mapping:10]NeueNr:4:=[Mapping:10]NrInStrukt:3)
	APPLY TO SELECTION:C70([Mapping:10];[Mapping:10]NeuerName:5:=[Mapping:10]NameInStrukt:6)
End if 
USE NAMED SELECTION:C332("$ns_Temp")
