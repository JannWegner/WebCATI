//%attributes = {}
p_LogDatenAktualisieren ("Ausschöpfung";vUmfrage;0;"")

C_TEXT:C284(vtAusschoepfung;$vsVTrenner;vsHTrenner)
vtAusschoepfung:=""
$vsVTrenner:=(" "*25)+"|"+(" "*19)+"|"
vsHTrenner:=Char:C90(13)+("_"*68)+Char:C90(13)

QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage)
vtAusschoepfung:=vUmfrage
vtAusschoepfung:=vtAusschoepfung+Char:C90(13)+Char:C90(13)+String:C10(Current date:C33)+"    /    "+String:C10(Current time:C178)
vtAusschoepfung:=vtAusschoepfung+Char:C90(13)+Char:C90(13)+"Gesamtzahl Adressen: "+String:C10(Records in selection:C76([TelefonNummer:4]);"^^^^^^")

QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Abbruch";*)
QUERY SELECTION:C341([TelefonNummer:4]; | [TelefonNummer:4]Status:5="Ausfall";*)
QUERY SELECTION:C341([TelefonNummer:4]; | [TelefonNummer:4]Status:5="In Arbeit";*)
QUERY SELECTION:C341([TelefonNummer:4]; | [TelefonNummer:4]Status:5="Komplett";*)
QUERY SELECTION:C341([TelefonNummer:4]; | [TelefonNummer:4]Status:5="Wiedervorlage")
CREATE SET:C116([TelefonNummer:4];"$mAngefasst")

  //Tabellenüberschrift
vtAusschoepfung:=vtAusschoepfung+Char:C90(13)+Char:C90(13)+Char:C90(13)+(" "*17)+"Gesamt  |    Eingetragen    |  Nicht eingetragen"
vtAusschoepfung:=vtAusschoepfung+vsHTrenner

  //Zeile 'Neu'
QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Neu")
viGesamt:=Records in selection:C76([TelefonNummer:4])
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]EingetragenTB:12=True:C214)
viTBGesamt:=Records in selection:C76([TelefonNummer:4])
$viTBGesamtPr:=Round:C94(viTBGesamt/viGesamt*100;1)
QUERY:C277([TelefonNummer:4];[TelefonNummer:4]Umfrage:30=vUmfrage;*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]Status:5="Neu";*)
QUERY:C277([TelefonNummer:4]; & [TelefonNummer:4]EingetragenTB:12=False:C215)
viNTBGesamt:=Records in selection:C76([TelefonNummer:4])
$viNTBGesamtPr:=Round:C94(viNTBGesamt/viGesamt*100;1)
vtAusschoepfung:=vtAusschoepfung+Char:C90(13)+"Noch 'Neu'       "+String:C10(viGesamt;"^^^^^0")+"  | "+String:C10(viTBGesamt;"^^^^^0")+"  "+String:C10($viTBGesamtPr;"^^0,0")+" %   |  "+String:C10(viNTBGesamt;"^^^^^0")+"  "+String:C10($viNTBGesamtPr;"^^0,0")+" %"
vtAusschoepfung:=vtAusschoepfung+vsHTrenner

  //Zeile 'Angefasst'
USE SET:C118("$mAngefasst")
viGesamt:=Records in selection:C76([TelefonNummer:4])
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]EingetragenTB:12=True:C214)
viTBGesamt:=Records in selection:C76([TelefonNummer:4])
$viTBGesamtPr:=Round:C94(viTBGesamt/viGesamt*100;1)
USE SET:C118("$mAngefasst")
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]EingetragenTB:12=False:C215)
viNTBGesamt:=Records in selection:C76([TelefonNummer:4])
$viNTBGesamtPr:=Round:C94(viNTBGesamt/viGesamt*100;1)
vtAusschoepfung:=vtAusschoepfung+Char:C90(13)+"Angefasst        "+String:C10(viGesamt;"^^^^^0")+"  | "+String:C10(viTBGesamt;"^^^^^0")+"  "+String:C10($viTBGesamtPr;"^^0,0")+" %   |  "+String:C10(viNTBGesamt;"^^^^^0")+"  "+String:C10($viNTBGesamtPr;"^^0,0")+" %"
vtAusschoepfung:=vtAusschoepfung+vsHTrenner+("_"*68)+Char:C90(13)



USE SET:C118("$mAngefasst")
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Komplett")
vtAusschoepfung:=vtAusschoepfung+p_Ausschoepfung ("Interviews       ")

USE SET:C118("$mAngefasst")
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Wiedervorlage")
vtAusschoepfung:=vtAusschoepfung+p_Ausschoepfung ("Wiedervorlage    ")

USE SET:C118("$mAngefasst")
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Abbruch";*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]StatusErklärung:11="Kein Anschluß")
vtAusschoepfung:=vtAusschoepfung+p_Ausschoepfung ("Kein Anschluß    ")

USE SET:C118("$mAngefasst")
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Ausfall";*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]StatusErklärung:11="Ausfallgrund: 35")
vtAusschoepfung:=vtAusschoepfung+p_Ausschoepfung ("Ausfall nicht GG ")

USE SET:C118("$mAngefasst")
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Ausfall";*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]StatusErklärung:11#"Ausfallgrund: 35")
vtAusschoepfung:=vtAusschoepfung+p_Ausschoepfung ("and. Ausfälle    ")

USE SET:C118("$mAngefasst")
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Abbruch";*)
QUERY SELECTION:C341([TelefonNummer:4]; & [TelefonNummer:4]StatusErklärung:11="Fax/Modem")
vtAusschoepfung:=vtAusschoepfung+p_Ausschoepfung ("Fax/Modem        ")

USE SET:C118("$mAngefasst")
QUERY SELECTION:C341([TelefonNummer:4];[TelefonNummer:4]Status:5="Abgebrochen")
vtAusschoepfung:=vtAusschoepfung+p_Ausschoepfung ("Int. abgebrochen ")


DIALOG:C40([TelefonNummer:4];"d_Ausschoepfung")

p_LogDatenAktualisieren ("Startbildschirm";vUmfrage;0;"")
