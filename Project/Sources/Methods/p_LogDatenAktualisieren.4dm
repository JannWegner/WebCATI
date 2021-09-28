//%attributes = {}
  //LogDaten aktualisieren
  //$1 = Modul
  //$2 = Umfrage
  //$3 = FbNr
  //$4 = Frage

$vsModul:=$1
$vsUmfrage:=$2
$vlFbNr:=$3
$vsFrage:=$4

GOTO RECORD:C242([LogDaten:1];<>BenutzerNr)

[LogDaten:1]Modul:8:=$vsModul
[LogDaten:1]Umfrage:11:=$vsUmfrage
[LogDaten:1]FbNr:9:=$vlFbNr
[LogDaten:1]Frage:10:=$vsFrage

[LogDaten:1]AktDatum:12:=Current date:C33
[LogDaten:1]AktZeit:13:=Current time:C178

sichere_DS (Table:C252(->[LogDaten:1]);DEBUG)
