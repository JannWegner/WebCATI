  //Multi-Antwort mit Komma getrennt und Nullen aufgefüllt abspeichern

vantw:=String:C10(Num:C11(vantwMulti1);"0"*ai_MultiLaenge{1})
vantw:=vantw+","+String:C10(Num:C11(vantwMulti2);"0"*ai_MultiLaenge{2})
vantw:=vantw+","+String:C10(Num:C11(vantwMulti3);"0"*ai_MultiLaenge{3})
vantw:=vantw+","+String:C10(Num:C11(vantwMulti4);"0"*ai_MultiLaenge{4})
vantw:=vantw+","+String:C10(Num:C11(vantwMulti5);"0"*ai_MultiLaenge{5})
vantw:=vantw+","+String:C10(Num:C11(vantwMulti6);"0"*ai_MultiLaenge{6})

WeiterButtonGedrueckt ([Bogen:6]FormNam:8)