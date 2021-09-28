//%attributes = {}
  // Wird vom Bogeneingabeformular
  //gewählten Formular Felder sichtbar/eingebbar
Case of 
	: ([Bogen:6]FormNam:8="gen_HalbOffen")
		OBJECT SET VISIBLE:C603(*;"THalboffen";True:C214)
		OBJECT SET VISIBLE:C603([Bogen:6]Halboffen:26;True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"THalboffen";False:C215)
		OBJECT SET VISIBLE:C603([Bogen:6]Halboffen:26;False:C215)
End case 