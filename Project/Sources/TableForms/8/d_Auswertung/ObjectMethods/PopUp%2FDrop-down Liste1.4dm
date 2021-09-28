Case of 
	: (Form event code:C388=On Clicked:K2:4)
		QUERY:C277([AktivLog:8];[AktivLog:8]Umfrage:1=taUmfragen{taUmfragen})
		DISTINCT VALUES:C339([AktivLog:8]DBNutzer:4;tsUserList)
		SORT ARRAY:C229(tsUserList)
		INSERT IN ARRAY:C227(tsUserList;1)
		tsUserList{1}:="@"
		tsUserList:=1
		
End case 