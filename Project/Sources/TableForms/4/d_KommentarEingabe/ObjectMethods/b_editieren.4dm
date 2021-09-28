vt_AktuellerKommentar:=Substring:C12(vt_KommentarSpeicher;Position:C15(Char:C90(13);vt_KommentarSpeicher)+1)
vt_AktuellerKommentar:=Replace string:C233(vt_AktuellerKommentar;Char:C90(13)+"______________________________________"+Char:C90(13);"")
vb_Editieren:=True:C214
OBJECT SET VISIBLE:C603(*;"t_Warntext";True:C214)
