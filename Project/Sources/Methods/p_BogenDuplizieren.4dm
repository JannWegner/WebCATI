//%attributes = {}
  //Stellt in einem Palettenfenster ein Menü zum Bogen duplizieren bereit

vsZielUmfrage:=$1
  //Open window (Links; Oben; Rechts; Unten{; Typ{; Titel{; Schließen}}}){ °Ê FensterRef }
Open window:C153(80;80;950;610;Palette window:K34:3;"Bogen duplizieren nach "+vsZielUmfrage)

DIALOG:C40([Bogen:6];"BogenDuplizieren")