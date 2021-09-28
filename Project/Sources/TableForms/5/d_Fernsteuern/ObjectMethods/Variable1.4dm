C_LONGINT:C283($vi_PositionStart;$vi_PositionEnde)
GET HIGHLIGHT:C209(vt_SendText;$vi_PositionStart;$vi_PositionEnde)
If ($vi_PositionStart#$vi_PositionEnde)
	vs_SendeText:=Substring:C12(vt_SendText;$vi_PositionStart;$vi_PositionEnde-$vi_PositionStart)
Else 
	vs_SendeText:=""
End if 
