  //[TelefonNummer]FixTermin wird in Layout-Proz Bevor-Phase zurückgesetzt

EinsZurueck:=weitermit
weitermit:=weitermit_neu ("Ende_Wieder")
[TelefonNummer:4]RefDatum:8:=Current date:C33
[TelefonNummer:4]RefZeit:9:=Current time:C178
If ([TelefonNummer:4]FixTermin:36)
	[TelefonNummer:4]Historie:4:=Replace string:C233([TelefonNummer:4]Historie:4;"Wiedervorlage/Termin";"Wiedervorlage/FIX-Termin";1)
End if 
sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)