********************************************************************************************
* Insitucion:   	Banco Mundial 
* Autor: 		    Equipo de Trabajo 						  
* Version:		    1.0
********************************************************************************************

*- Contenido -*

    * Variable de Trabajo (Sexo)
    * Variable de Trabajo (Edad)
    * Variable de Trabajo (Escolaridad)
	* Variable de Trabajo (Profesional)

*- Variable de Trabajo (Sexo) -*
			
	gen sexo = .
		
        replace sexo = 0 if p6020 ==1 
		replace sexo = 1 if p6020 ==2
			
	label var sexo "Hombre / Mujer"
	label define sexo 0 "Hombre" 1 "Mujer"
	label values sexo sexo

*- Variable de Trabajo (Edad) -*

	gen edad = p6040
	
    label var edad "Edad de la persona"

*- Variable de Trabajo (Escolaridad) -*

    *- Consiliacion entre las preguntas -*
    *- p6210 = ¿Cuál es el nivel educativo más alto alcanzado por... y el último año o grado aprobado en este nivel?
    *- p6220 = Cuál es el título o diploma de mayor nivel educativo que usted ha recibido?
		
	gen escolaridad = .
			
		*- Ninguno
		replace escolaridad = 0 if p6210 == 1 & p6220 == 1				   
		replace escolaridad = 0 if p6210 == 1 & p6220 == .
		replace escolaridad = 0 if p6210 == 5 & p6220 == 1
			
		replace escolaridad = 0 if p6210 == 9 & p6220 == .			// Correccion de Personas que no responden
		replace escolaridad = 0 if p6210 == . & p6220 == 9			// Correccion de Personas que no responden
			
		replace escolaridad = 0 if p6210 == 5 & p6220 == 9
		replace escolaridad = 0 if p6210 == 6 & p6220 == 9
			
		*- Preescolar 
		replace escolaridad = 1 if p6210 == 2 & p6220 == .				
			
		*- Basica Primaria
		replace escolaridad = 2 if p6210 == 3 & p6220 == .				
			
		*- Basica Secundaria
		replace escolaridad = 3 if p6210 == 4 & p6220 == .
			
		*- Bachiller
		replace escolaridad = 4 if p6210 == 5 & p6220 == 2		// Se excluyen personas que no han finalizado
		replace escolaridad = 4 if p6210 == 6 & p6220 == 2
			
		*- Tecnologo
		replace escolaridad = 5 if p6210 == 6 & p6220 == 3		// Se excluyen personas que no han finalizado
		replace escolaridad = 5 if p6210 == 5 & p6220 == 3		// Ultima adicion (27 de Nov 2019)

		*- Universitario
		replace escolaridad = 6 if p6210 == 6 & p6220 == 4
		replace escolaridad = 6 if p6210 == 5 & p6220 == 4		// Ultima adicion (27 de Nov 2019)
			
		replace escolaridad = 6 if p6210 == 5 & p6220 == 4		// Correccion (4 de Dic de 2019)
			
		*- Universitario (Posgrado)
		replace escolaridad = 7 if p6210 == 6 & p6220 == 5
			
	label var escolaridad "Escolaridad Cruce entre p6210 y p6220"
	label define escolaridad 0 "Ninguno" 1 "Preescolar" 2 "Basica Primaria" 3"Basica Secundaria" 4 "Bachiller" 5"Tecnologo" 6 "Universitario" 7 "Posgrado"
	label values escolaridad escolaridad


*- Variable de Trabajo (Profesional) -*
		
		recode escolaridad (0/5=0) (6 7 = 1) (missing = .), gen(profesional_edu)
		
		label var profesional_edu "NO Profesional / Profesional (Edu)"
		label define profesional_edu 0 "NO Profesional" 1 "Profesional"
		label values profesional_edu profesional_edu
