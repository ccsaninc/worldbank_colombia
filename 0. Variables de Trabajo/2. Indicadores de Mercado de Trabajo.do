********************************************************************************************
* Insitucion:   	Banco Mundial 
* Autor: 		    Equipo de Trabajo 						  
* Version:		    1.0
*********************************************************************************************

*- Contenido -*

    * Calculo de Ocupados
    * Calculo de Desocupados
    * Calculo de Inactivos
    * Calculo de Poblacion de Economicamente Activa
    * Calculo de Poblacion en edad de Trabajar
   
* Indicadores de Mercado de Trabajo *

    *- Ocupados -*

    gen OC = .
		
	replace OC = 1 if p6240 == 1
        replace OC = 1 if p6250 == 1
        replace OC = 1 if p6260 == 1
        replace OC = 1 if p6270 == 1
       
    label var OC "Personas Ocupadas"
    label define OC 1 "Personas ocupadas"
    label values OC
    
    *- Desocupados -*

    gen DS = .
		
	    replace DS = 1 if p6351 == 1

    label var DS "Personas Desocupadas"
    label define DS 1 "Personas desocupadas"
    label values DS DS

    *- Inactivos -*

    gen Ini = .
		
        replace Ini = 1 if p6240 == 5 
	    replace Ini = 1 if p6300 == 2
	    replace Ini = 1 if p6310 == 9 | p6310 == 10 | p6310 == 11 | p6310 == 12 | p6310 == 13
	    replace Ini = 1 if p6330 == 2
	    replace Ini = 1 if p6340 == 2
	    replace Ini = 1 if p6351 == 2    

    label var Ini "Personas Inactivas"
    label define Ini 1 "Personas inactivas"
    label values Ini Ini

    *- Poblacion de Economicamente Activa (PEA) -*
		
    gen PEA =.
	
        replace PEA =1 if DS==1
	    replace PEA =1 if OC==1 
				
    lab var PEA  "Poblacion Economicamente Activa"
    label define PEA  1 "Personas economicamente activa"
    label values PEA  PEA 
	
    *- Poblacion en edad de Trabajar (PET) -*
		
    gen PET =.						
	
	    replace PET =1 if PEA ==1
	    replace PET =1 if Ini==1

    lab var PET  "Poblacion Edad de Trabajar"
    label define PET  1 "Personas en edad de trabajar"
    label values PET  PET 
			 
