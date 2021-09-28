//%attributes = {"publishedWeb":true}
p_LogDatenAktualisieren ("Adressen zeigen";vUmfrage;0;"")
QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
p_FensterAnpassen (100;100)

C_TEXT:C284(vt_KommentarSpeicher)
vt_KommentarSpeicher:=""

  //Listenfelder berechnen
vListenFeldNummer1:=p_ListenfelderRechnen (Substring:C12([Variablen:5]ListenFelder:22;1;2))
vListenFeldNummer2:=p_ListenfelderRechnen (Substring:C12([Variablen:5]ListenFelder:22;3;2))
vListenFeldNummer3:=p_ListenfelderRechnen (Substring:C12([Variablen:5]ListenFelder:22;5;2))
vListenFeldNummer4:=p_ListenfelderRechnen (Substring:C12([Variablen:5]ListenFelder:22;7;2))

p_QuotenFreigabenLesen 

FORM SET OUTPUT:C54([TelefonNummer:4];"Ausgabe_Reduziert")
FORM SET INPUT:C55([TelefonNummer:4];"Eingabe_Reduziert")
UNLOAD RECORD:C212([TelefonNummer:4])
MODIFY SELECTION:C204([TelefonNummer:4];*)

SET WINDOW TITLE:C213("CATI-Allensbach: "+vUmfrageAnzeige+"             v"+Replace string:C233(Structure file:C489;"cati_";""))
p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
