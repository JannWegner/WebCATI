If (Form event code:C388=On Load:K2:1)
	arr_wms:=Find in array:C230(arr_wms;weitermit)
	If (arr_wms=-1)
		arr_wms:=1
	End if 
End if 