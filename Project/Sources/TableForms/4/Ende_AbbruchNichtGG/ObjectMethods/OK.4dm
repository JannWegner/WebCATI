
  //Daten werden in Layout-Prozedur Bevor-Phase gesetzt
[TelefonNummer:4]Historie:4:=String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+" * "+vName+" * Ausfall/Ausfallgrund: 35"+Char:C90(13)+[TelefonNummer:4]Historie:4
sichere_DS (Table:C252(->[TelefonNummer:4]);DEBUG)
EinsZurueck:=weitermit
EndeNummer:=True:C214
