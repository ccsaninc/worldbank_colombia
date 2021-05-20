********************************************************************************************
* Insitucion:   Banco Mundial 
* Autor: 		Equipo de Trabajo 						  
* Fecha: 		20 de Mayo de 2021
* Version:		1.0
********************************************************************************************

* Indicadores de Mercado de Trabajo *

    *- Ocupados -*

    gen oci_ver = .
		
		replace oci_ver = 1 if p6240 == 1
        replace oci_ver = 1 if p6250 == 1
        replace oci_ver = 1 if p6260 == 1
        replace oci_ver = 1 if p6270 == 1
       
   label var oci_ver "Personas Ocupadas (Verificación)"
   label define oci_ver 1 "Personas ocupadas"
   label values oci_ver oci_ver
    
    *- Desocupados -*

    gen dsi_ver = .
		
		replace dsi_ver = 1 if p6351 == 1

   label var dsi_ver "Personas Desocupadas (Verificación)"
   label define dsi_ver 1 "Personas desocupadas"
   label values dsi_ver dsi_ver

    *- Inactivos -*

    gen ini_ver = .
		
        replace ini_ver = 1 if p6240 == 5 
		replace ini_ver = 1 if p6300 == 2
		replace ini_ver = 1 if p6310 == 9 | p6310 == 10 | p6310 == 11 | p6310 == 12 | p6310 == 13
		replace ini_ver = 1 if p6330 == 2
		replace ini_ver = 1 if p6340 == 2
		replace ini_ver = 1 if p6351 == 2    

   label var ini_ver "Personas Inactivas (Verificación)"
   label define ini_ver 1 "Personas inactivos"
   label values ini_ver ini_ver

    *- Poblacion de Economicamente Activa (PEA) -*
		
	gen pea_ver=.
	
        replace pea_ver=1 if dsi_ver==1
	    replace pea_ver=1 if oci_ver==1 
				
	lab var pea_ver "Poblacion Economicamente Activa"
    label define pea_ver 1 "Personas economicamente activa"
    label values pea_ver pea_ver
	
    *- Poblacion en edad de Trabajar (PET) -*
		
	gen pet_ver=.						
	
		replace pet_ver=1 if pea_ver==1
		replace pet_ver=1 if ini_ver==1

    lab var pet_ver "Poblacion Edad de Trabajar"
    label define pet_ver 1 "Personas en edad de trabajar"
    label values pet_ver pet_ver
			 