C_LONGINT:C283($l;$t;$r;$b;$fixed_wdth;$exact_hght;$wdth;$hght)
C_LONGINT:C283($final_pos)
C_LONGINT:C283($detail_pos;$header_pos;$hght_to_print;$hght_remaining)
Case of 
	: (vSprint_area="Detail")  //Printing of detail underway
		OBJECT GET COORDINATES:C663(vSpezial;$l;$t;$r;$b)
		$fixed_wdth:=$r-$l  //Calculation of the Actors text field size
		$exact_hght:=$b-$t
		OBJECT GET BEST SIZE:C717(vSpezial;$wdth;$hght;$fixed_wdth)
		  //Optimale Feldgrösse gemäss dessen Inhalt
		$movement:=$hght-$exact_hght
		
		If ($movement>0)
			$position:=Get print marker:C708(Form detail:K43:1)
			$final_pos:=$position+$movement
			  //Wir bewegen die Marke Detail und darauffolgende Marken
			SET PRINT MARKER:C709(Form detail:K43:1;$final_pos;*)
			  //Resizing of text areas
			OBJECT MOVE:C664(vSpezial;$l;$t;$r;$hght+$t;*)
		End if 
		
		  //Verfügbaren Platz berechnen
		$detail_pos:=Get print marker:C708(Form detail:K43:1)
		$header_pos:=Get print marker:C708(Form header:K43:3)
		$hght_to_print:=$detail_pos-$header_pos
		$hght_remaining:=vLprint_height-vLprinted_height
		If ($hght_remaining<$hght_to_print)  //Ungenügende Höhe
			  //CANCEL
			vBSeiteVoll:=True:C214  //Bewegt Formular zur nächsten Seite
			SET PRINT MARKER:C709(Form detail:K43:1;$hght_remaining+$header_pos;*)
			vSpezial:=""
		End if 
End case 