SET WINDOW TITLE:C213(vUmfrageAnzeige+": "+String:C10(Records in selection:C76([TelefonNummer:4]))+" Adressen in der Auswahl")
$Farbe:=1
_O_OBJECT SET COLOR:C271(*;"Kasten";-$Farbe)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
	: (Form event code:C388=On Load:K2:1)
		QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)
		vListenTitel1:=Field:C253(5;Num:C11(Substring:C12([Variablen:5]ListenFelder:22;1;2))+5)->+"  *|*  "+Field:C253(5;Num:C11(Substring:C12([Variablen:5]ListenFelder:22;3;2))+5)->
		vListenTitel2:=Field:C253(5;Num:C11(Substring:C12([Variablen:5]ListenFelder:22;5;2))+5)->+"  *|*  "+Field:C253(5;Num:C11(Substring:C12([Variablen:5]ListenFelder:22;7;2))+5)->
		
		If (User in group:C338(Current user:C182;"Entwickler"))
			OBJECT SET VISIBLE:C603(*;"EDV@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"EDV@";False:C215)
		End if 
	: (Form event code:C388=On Display Detail:K2:22)
		QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)
		vListenZeile1:=Substring:C12(Field:C253(4;vListenfeldNummer1)->+"  *|*  "+Field:C253(4;vListenfeldNummer2)->;1;80)
		vListenZeile2:=Substring:C12(Field:C253(4;vListenfeldNummer3)->+"  *|*  "+Field:C253(4;vListenfeldNummer4)->;1;80)
End case 