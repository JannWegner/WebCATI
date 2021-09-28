CLOSE WINDOW:C154
vt_AntwASCII:=Replace string:C233(vt_AntwASCII;Char:C90(13);"|")
[TelefonNummer:4]AntwASCII:41:=Replace string:C233(vt_AntwASCII;"*****";Char:C90(13))
ALERT:C41("AntwASCII unbedingt überprüfen!!")