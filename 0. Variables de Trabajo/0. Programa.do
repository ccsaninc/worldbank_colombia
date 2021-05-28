********************************************************************************************
* Insitucion:   	Banco Mundial 
* Autor: 		    Equipo de Trabajo 						  
* Version:		    1.0
********************************************************************************************

*- Contenido -*

    * Fuente de Información (GEIH) *

    https://drive.google.com/drive/folders/1ty1Ru6ew7cK_RQLJQsLsChTipVI3iBYf?usp=sharing

*- Programa para el trabajo de las Bases -*

    set more off
    cls 

    *- Directori de Trabajo -*

    cd "F:\OneDrive - Universidad Externado de Colombia\1. Observatorio ML\1. Bases de Datos\1. GEIH\1. Stata" 	
        
        local f_i 2008
        local f_f 2020

    * Procedimiento

    forvalues i = `f_i' / `f_f' {
        
        use "GEIH_`i'", clear 

    }




