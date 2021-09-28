CONFIRM:C162("Wollen Sie wirklich die Daten der Umfrage "+vUmfrage+" anonymisieren?";"Abbrechen";"Anonymisieren")
If (OK=0)
	CONFIRM:C162("Achtung: Daten werden nach Vorgabe unwiderruflich vernichtet!";"Abbrechen";"! VERNICHTEN !")
	If (OK=0)
		QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
		QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]AdrBehalten:47=False:C215)
		CREATE SET:C116([TelefonNummer:4];"$mLoeschSet")
		START TRANSACTION:C239
		READ WRITE:C146([TelefonNummer:4])
		MESSAGES OFF:C175
		vbOK:=True:C214
		
		If (vbOK & (vbTel1=1))
			MESSAGE:C88("Verkürzen der Telefonnummer 1...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Telefon1:19#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]Telefon1:19:=(Substring:C12([TelefonNummer:4]Telefon1:19;1;Length:C16([TelefonNummer:4]Telefon1:19)-4)+"XXXX"))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbTel2=1))
			MESSAGE:C88("Verkürzen der Telefonnummer 2 ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Telefon2:1#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]Telefon2:1:=(Substring:C12([TelefonNummer:4]Telefon2:1;1;Length:C16([TelefonNummer:4]Telefon2:1)-4)+"XXXX"))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbAP=1))
			MESSAGE:C88("Anonymisieren des Ansprechpartners ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]aktAnsprechp:38#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]aktAnsprechp:38:="AP_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbKommentar=1))
			MESSAGE:C88("Anonymisieren des Kommentars ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Kommentar:6#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]Kommentar:6:="Kommentar_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA01=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 01: "+[Variablen:5]AdrFeld01:6+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld01:14#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld01:14:="A01_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA02=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 02: "+[Variablen:5]AdrFeld02:7+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld02:16#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld02:16:="A02_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA03=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 03: "+[Variablen:5]AdrFeld03:8+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld03:13#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld03:13:="A03_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA04=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 04: "+[Variablen:5]AdrFeld04:9+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld04:15#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld04:15:="A04_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA05=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 05: "+[Variablen:5]AdrFeld05:10+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld05:18#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld05:18:="A05_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA06=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 06: "+[Variablen:5]AdrFeld06:11+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld06:34#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld06:34:="A06_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA07=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 07: "+[Variablen:5]AdrFeld07:12+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld07:35#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld07:35:="A07_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA08=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 08: "+[Variablen:5]AdrFeld08:13+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld08:33#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld08:33:="A08_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA09=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 09: "+[Variablen:5]AdrFeld09:14+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld09:17#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld09:17:="A09_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA10=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 10: "+[Variablen:5]AdrFeld10:15+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld10:21#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld10:21:="A10_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA11=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 11: "+[Variablen:5]AdrFeld11:16+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld11:27#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld11:27:="A11_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA12=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 12: "+[Variablen:5]AdrFeld12:17+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld12:28#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld12:28:="A12_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA13=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 13: "+[Variablen:5]AdrFeld13:18+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld13:31#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld13:31:="A13_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA14=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 14: "+[Variablen:5]AdrFeld14:19+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld14:42#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld14:42:="A14_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA15=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 15: "+[Variablen:5]AdrFeld15:20+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld15:43#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld15:43:="A15_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		If (vbOK & (vbA16=1))
			MESSAGE:C88("Anonymisieren von Adressfeld 16: "+[Variablen:5]AdrFeld16:21+" ...")
			USE SET:C118("$mLoeschSet")
			QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]AdrFeld16:44#"")
			APPLY TO SELECTION:C70([TelefonNummer:4];[TelefonNummer:4]AdrFeld16:44:="A16_"+String:C10(Record number:C243([TelefonNummer:4])))
			vbOK:=(Records in set:C195("LockedSet")=0)
		End if 
		
		If (vbOK)
			VALIDATE TRANSACTION:C240
			ALERT:C41("Erfolgreich anonymisiert!")
			ACCEPT:C269
		Else 
			USE SET:C118("LockedSet")
			LOCKED BY:C353([TelefonNummer:4];$x1;$x2;$x3;$x4)
			ALERT:C41("[TelefonNummer] gesperrt durch "+$x2+"/"+$x3)
			CANCEL TRANSACTION:C241
			ALERT:C41("Anonymisieren wurde abgebrochen!")
		End if 
		READ ONLY:C145([TelefonNummer:4])
	Else 
		ALERT:C41("Nix passiert")
	End if 
Else 
	ALERT:C41("Nix passiert")
End if 
