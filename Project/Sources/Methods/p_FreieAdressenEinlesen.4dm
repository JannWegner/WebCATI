//%attributes = {}
  //Liest die Menge der freigegebenen Adressen aus [Variablen]QuotenIDBlob ein

ARRAY LONGINT:C221($alFreieAdressIDs;0)

MESSAGE:C88("Aktuelle Version von freigegebenen Adressen einlesen ...")
$vxArrayIDs:=[Variablen:5]QuotenIDBlob:34
BLOB TO VARIABLE:C533($vxArrayIDs;$alFreieAdressIDs)
CREATE SET FROM ARRAY:C641([TelefonNummer:4];$alFreieAdressIDs;"FreieAdressen")
viAktuelleQuotenVersion:=[Variablen:5]QuotenVersion:33
USE SET:C118("FreieAdressen")
