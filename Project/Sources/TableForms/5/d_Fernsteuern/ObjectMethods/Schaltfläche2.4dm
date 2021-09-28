If (vt_SendText#"")
	If (vs_SendeText="")
		vs_SendeText:=vt_SendText
	End if 
	$vi_pause:=Num:C11(Request:C163("Pause in Ticks (60/sec)";"10"))
	If (OK=1)
		$vb_Stop:=False:C215
		For ($lauf;1;Length:C16(vs_SendeText))
			BRING TO FRONT:C326(vi_ZielPID)
			Case of 
				: (vs_SendeText[[$lauf]]="#")
					$vb_Stop:=True:C214
				: (vs_SendeText[[$lauf]]="*")
					$vi_SendChar:=9
				Else 
					$vi_SendChar:=Character code:C91(vs_SendeText[[$lauf]])
			End case 
			If (Not:C34($vb_Stop))
				POST KEY:C465($vi_SendChar;0;vi_ZielPID)
				  //ALERT(String(Ascii(vs_SendeText≤$lauf≥)))
				DELAY PROCESS:C323(Current process:C322;$vi_pause)
				POST OUTSIDE CALL:C329(vi_ZielPID)
			End if 
			If (Character code:C91(vs_SendeText[[$lauf]])=13)
				$vb_Stop:=False:C215
			End if 
		End for 
	End if 
Else 
	ALERT:C41("Nix zu senden!")
End if 
