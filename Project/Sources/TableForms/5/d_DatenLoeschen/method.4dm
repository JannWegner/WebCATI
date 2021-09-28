Case of 
	: (Form event code:C388=On Load:K2:1)
		vbSaetzeLoeschen:=False:C215
		vb_KomplettLoeschen:=False:C215
	Else 
		Case of 
			: (vbSaetzeLoeschen)
				CONFIRM:C162("Wollen Sie wirklich alle "+Table name:C256(vpFeldPointer)+" löschen?";"Nein!";"Löschen")
				If (OK=0)
					ALL RECORDS:C47(Table:C252(Table:C252(vpFeldPointer))->)
					QUERY:C277(Table:C252(Table:C252(vpFeldPointer))->;Field:C253(Table:C252(vpFeldPointer);Field:C253(vpFeldPointer))->=vUmfrage)
					CONFIRM:C162("Wirklich alle "+String:C10(Records in selection:C76(Table:C252(Table:C252(vpFeldPointer))->))+" Datensätze in "+Table name:C256(vpFeldPointer)+" von "+vUmfrage+" löschen?";"Nein!";"Löschen")
					If (OK=0)
						$vbLoeschOK:=True:C214
						If (Table name:C256(vpFeldPointer)="Variablen")
							QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
							UNLOAD RECORD:C212([Bogen:6])
							QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
							UNLOAD RECORD:C212([TelefonNummer:4])
							QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=vUmfrage)
							UNLOAD RECORD:C212([Quoten:7])
							QUERY:C277([Hilfslisten:3];[Hilfslisten:3]Umfrage:1=vUmfrage)
							UNLOAD RECORD:C212([Quoten:7])
							If (Records in selection:C76([Bogen:6])+Records in selection:C76([TelefonNummer:4])+Records in selection:C76([Quoten:7])+Records in selection:C76([Hilfslisten:3])#0)
								ALERT:C41("Zuerst alle Bogen/Quoten/Adressen/Listen löschen - sonst sägen Sie den Ast ab, au"+"f dem S"+"ie sitzen!")
								$vbLoeschOK:=False:C215
							End if 
						End if 
						
						If ($vbLoeschOK)
							READ WRITE:C146(Table:C252(Table:C252(vpFeldPointer))->)
							DELETE SELECTION:C66(Table:C252(Table:C252(vpFeldPointer))->)
							QUERY:C277(Table:C252(Table:C252(vpFeldPointer))->;Field:C253(Table:C252(vpFeldPointer);Field:C253(vpFeldPointer))->=vUmfrage)
							If (Records in selection:C76(Table:C252(Table:C252(vpFeldPointer))->)>0)
								ALERT:C41("Da hat was nicht geklappt! - Bitte überprüfen!")
							Else 
								ALERT:C41("Alles klar - Daten sind weg!")
							End if 
							READ ONLY:C145(Table:C252(Table:C252(vpFeldPointer))->)
						End if 
					Else 
						ALERT:C41("Nix passiert!")
					End if 
				End if 
				vbSaetzeLoeschen:=False:C215
				
			: (vb_KomplettLoeschen)
				CONFIRM:C162("Wollen Sie wirklich die komplette Umfrage '"+vUmfrage+"' löschen?")
				If (OK=1)
					CONFIRM:C162("Wollen Sie wirklich, WIRKLICH unwiderruflich die komplette Umfrage '"+vUmfrage+"' löschen?")
					If (OK=1)
						$vb_OK:=True:C214
						Var_LesenSchreiben 
						AdressenLesenSchreiben 
						Quoten_LesenSchreiben 
						BogenLesenSchreiben 
						READ WRITE:C146([AktivLog:8])
						
						UNLOAD RECORD:C212([TelefonNummer:4])
						UNLOAD RECORD:C212([AktivLog:8])
						UNLOAD RECORD:C212([Bogen:6])
						UNLOAD RECORD:C212([Quoten:7])
						UNLOAD RECORD:C212([Hilfslisten:3])
						UNLOAD RECORD:C212([Variablen:5])
						START TRANSACTION:C239
						MESSAGE:C88("Lösche Adressen ...")
						QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
						DELETE SELECTION:C66([TelefonNummer:4])
						QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
						$vb_OK:=(Records in selection:C76([TelefonNummer:4])=0)
						If (Not:C34($vb_OK))
							ALERT:C41("Konnte nicht alle Adressen löschen!"+Char:C90(13)+"Abbruch!")
						End if 
						If ($vb_OK)
							MESSAGE:C88("Lösche Int.-Protokolle ...")
							QUERY:C277([AktivLog:8];[AktivLog:8]Umfrage:1=vUmfrage)
							DELETE SELECTION:C66([AktivLog:8])
							QUERY:C277([AktivLog:8];[AktivLog:8]Umfrage:1=vUmfrage)
							$vb_OK:=$vb_OK & ((Records in selection:C76([AktivLog:8])=0))
							If (Not:C34($vb_OK))
								ALERT:C41("Konnte nicht alle Int.-Protokolle löschen!"+Char:C90(13)+"Abbruch!")
							End if 
						End if 
						If ($vb_OK)
							MESSAGE:C88("Lösche Bögen ...")
							QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
							DELETE SELECTION:C66([Bogen:6])
							QUERY:C277([Bogen:6];[Bogen:6]Umfrage:20=vUmfrage)
							$vb_OK:=$vb_OK & ((Records in selection:C76([Bogen:6])=0))
							If (Not:C34($vb_OK))
								ALERT:C41("Konnte nicht alle Bögen löschen!"+Char:C90(13)+"Abbruch!")
							End if 
						End if 
						If ($vb_OK)
							MESSAGE:C88("Lösche Quoten ...")
							QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=vUmfrage)
							DELETE SELECTION:C66([Quoten:7])
							QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=vUmfrage)
							$vb_OK:=$vb_OK & ((Records in selection:C76([Quoten:7])=0))
							If (Not:C34($vb_OK))
								ALERT:C41("Konnte Quoten nicht löschen!"+Char:C90(13)+"Abbruch!")
							End if 
						End if 
						If ($vb_OK)
							MESSAGE:C88("Lösche Hilfslisten ...")
							QUERY:C277([Hilfslisten:3];[Hilfslisten:3]Umfrage:1=vUmfrage)
							DELETE SELECTION:C66([Hilfslisten:3])
							QUERY:C277([Quoten:7];[Quoten:7]Umfrage:1=vUmfrage)
							$vb_OK:=$vb_OK & ((Records in selection:C76([Hilfslisten:3])=0))
							If (Not:C34($vb_OK))
								ALERT:C41("Konnte nicht alle Hilfslisten löschen!"+Char:C90(13)+"Abbruch!")
							End if 
						End if 
						If ($vb_OK)
							MESSAGE:C88("Lösche Variablen ...")
							QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)
							DELETE SELECTION:C66([Variablen:5])
							QUERY:C277([Variablen:5];[Variablen:5]Umfrage:3=vUmfrage)
							$vb_OK:=$vb_OK & ((Records in selection:C76([Variablen:5])=0))
							If (Not:C34($vb_OK))
								ALERT:C41("KonnteVariablenn löschen!"+Char:C90(13)+"Abbruch!")
							End if 
						End if 
						If ($vb_OK)
							VALIDATE TRANSACTION:C240
							ALERT:C41("Umfrage '"+vUmfrage+"' gelöscht"+Char:C90(13)+"Bitte anschließend eine neue Umfrage wählen!")
							CANCEL:C270
						Else 
							CANCEL TRANSACTION:C241
							vb_KomplettLoeschen:=False:C215
						End if 
					End if 
				End if 
		End case 
End case 