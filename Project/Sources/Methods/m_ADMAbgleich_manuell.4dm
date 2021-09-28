//%attributes = {}
C_BOOLEAN:C305(vb_AbgleichFertig;vb_AbgleichSterben)

vb_AbgleichFertig:=False:C215
vb_AbgleichSterben:=False:C215

If (Semaphore:C143("ADM-Abgleich"))
	ALERT:C41("Es läuft gerade ein anderer ADM-Abgleich!")
	
Else 
	  // Starte Serverprozedur
	$spProcessID:=Execute on server:C373("sp_ADM_Abgleich";3*16000;"ADM-Abgleich";Current system user:C484)
	
	DELAY PROCESS:C323(Current process:C322;7000)
	While (Not:C34(vb_AbgleichFertig))
		DELAY PROCESS:C323(Current process:C322;600)
		GET PROCESS VARIABLE:C371($spProcessID;vb_AbgleichFertig;vb_AbgleichFertig)
	End while 
	
	
	vb_AbgleichSterben:=True:C214
	SET PROCESS VARIABLE:C370($spProcessID;vb_AbgleichSterben;vb_AbgleichSterben)
	
	ALERT:C41("ADM-Abgleich beendet!")
	CLEAR SEMAPHORE:C144("ADM-Abgleich")
End if 