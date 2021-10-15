********************************************************************************************
* Insitucion:   	Banco Mundial 
* Autor: 		    Equipo de Trabajo 						  
* Version:		    1.0
* Descripción:		Cargué de informacion tablero - Banco Mundial
*********************************************************************************************

* --------------- VARIABLES PARAMETRICAS -------------* 


	*- Caracteristicas generales
	
		* -- Creacion de la variable PobTot (Poblacion Total) -- *		
			
		gen pobtot = 1
		label var pobtot "Poblacion Total"
			
		* - Generacion de la variable sexo para la base [1 hombre - 2 Mujer ]--*
			
		gen sexo = .
		replace sexo = 1 if p6020 ==1 
		replace sexo = 2 if p6020 ==2
			
		label var sexo "Hombre / Mujer"
		label define sexo 1 "S1" 2 "S2"
		label values sexo sexo
		
		*- Edad de la persona	

		gen edad = p6040
		label var edad "Edad de la persona"
		
		* Definicion de Grupos Etarios
	
		gen g_etarios = 0  if edad <= 17							
		replace g_etarios =  1  if edad >=18 & edad <=28	// Ley 1622 DE 2013 Art. 5
		replace g_etarios = 2  if edad >=29 & edad <=59
		replace g_etarios = 3  if edad >=60 				// Ley 1276 de 2009 Art. 7 
		
		label variable g_etarios "Grupos Etarios"
		label define g_etarios 0 "GE_0" 1 "GE_1" 2 "GE_2" 3 "GE_3" 
		label values g_etarios g_etarios
	
* Identificar venezolanos por la permanecia en el pais (Mayor de 5 años)
		
		* Migrante Venezolano (Migracion Estadisticamente siginificativa) 
		
		gen mig_ven = 1 if (p756 == 3 & p755 == 4)
		replace mig_ven = 2 if mig_ven != 1
		
		label variable mig_ven "Migrante (Venezolano - DANE)"
		label define mig_ven 1 "M1" 2 "M2"
		label values mig_ven mig_ven

*- Identificacion de filtro de Coberturas
				
		* -- Creacion de la variable Total Nacional -- *		

		gen total_nal = 1
		label var total_nal "Total Nacional"
		label define total_nal 1 "C001"
		label values total_nal total_nal
		
		* -- Urbano -- *		

		gen urbano = 1 if clase == "1"
		label var urbano "Zonas Urbanas"
		label define urbano 1 "C002"
		label values urbano urbano
		
		
		* -- Rural -- *		

		gen rural = 1 if clase == "2"
		label var rural "Zonas Rurales"
		label define rural 1 "C005"
		label values rural rural
				
		*- Dummy 10 ciuades
				
		gen ciudad10 = 1 if area == "15" | area == "18" | area == "19" | area == "20" | area == "27" | ///
		area == "41" | area == "44" | area == "47" | area == "63" | area == "70"
		
		replace ciudad10 = 0 if ciudad10! = 1 
		label var ciudad10 "10 ciudades"
			
		*- Dummy 13 ciuades 
				
		gen ciudad13=1 if area == "05" | area == "08" | area == "11" | area == "13" | area == "17" | ///
		area == "23" | area == "50" | area == "52" | area == "54" | area == "66" | area == "68" | area == "73" | area == "76"
		*replace ciudad13 = 0 if ciudad13 != 1
		label var ciudad13 "Areas Metropolitanas"
		label define ciudad13 1 "C003"
		label values ciudad13 ciudad13
		
		*- Dummy 23 ciuades
		
		generate ciudad23 = 1 if area == "05" | area == "08" | area == "11" | area == "13" | area == "15" | area == "17" | area == "18" | area == "19" | area == "20" ///
		| area == "23" | area == "27" | area == "41" | area == "44" | area == "47" | area == "50" | area == "52" | area == "54" | area == "63" | area == "66" | area == "68" ///
		| area == "70" | area == "73" | area == "76" |area == "81" | area == "85" | area == "86" | area == "88" | area == "91" | area == "94" | area == "95" | area == "97" ///
		| area == "99"
				
		*replace ciudad23 = 0 if ciudad23 != 1
		label var ciudad23 "23 ciudades"	
		label define ciudad23 1 "C004"
		label values ciudad23 ciudad23

		*- Dummy Bogotá DC (Capital)
				
		gen capital=1 if area == "11" 
		replace capital = 0 if capital != 1
		label var capital "Bogotá D.C."
						
		*- Dummy Otas Cabeceras (La resta del total de Cabeceras, menos las 23 principales ciudades)
				
		gen otras_cabeceras = 1 if clase == "1" & ciudad23 != 1	
		replace otras_cabeceras = 0 if otras_cabeceras != 1
		label var otras_cabeceras "Otras Cabeceras - DANE"
		
		*- Areas metropolitanas -*
							
				gen ciudad= .
				replace ciudad=1 if area=="05"
				replace ciudad=2 if area=="08"
				replace ciudad=3 if area=="11"
				replace ciudad=4 if area=="13"
				replace ciudad=5 if area=="15"
				replace ciudad=6 if area=="17"
				replace ciudad=7 if area=="18"
				replace ciudad=8 if area=="19"
				replace ciudad=9 if area=="20"
				replace ciudad=10 if area=="23"
				replace ciudad=11 if area=="27"
				replace ciudad=12 if area=="41"
				replace ciudad=13 if area=="44"
				replace ciudad=14 if area=="47"
				replace ciudad=15 if area=="50"
				replace ciudad=16 if area=="52"
				replace ciudad=17 if area=="54"
				replace ciudad=18 if area=="63"
				replace ciudad=19 if area=="66"
				replace ciudad=20 if area=="68"
				replace ciudad=21 if area=="70"
				replace ciudad=22 if area=="73"
				replace ciudad=23 if area=="76"
				replace ciudad=24 if area=="81"
				replace ciudad=25 if area=="85"
				replace ciudad=26 if area=="86"
				replace ciudad=27 if area=="88"
				replace ciudad=28 if area=="91"
				replace ciudad=29 if area=="94"
				replace ciudad=30 if area=="95"
				replace ciudad=31 if area=="97"
				replace ciudad=32 if area=="99"

		
		label var ciudad "Areas GEIH"
		label define ciudad 1 "A_05" 2 "A_08" 3 "A_11" 4 "A_13" 5 "A_15" 6 "A_17" 7 "A_18" 8 "A_19" 9 "A_20" 10 "A_23" 11 "A_27" 12 "A_41" 13 "A_44" 14 "A_47" 15 "A_50" 16 "A_52" 17 "A_54" 18 "A_63" 19 "A_66" 20 "A_68" 21 "A_70" 22 "A_73" 23 "A_76" 24 "A_81" 25 "A_85" 26 "A_86" 27 "A_88" 28 "A_91" 29 "A_94" 30 "A_95" 31 "A_97" 32 "A_99"
		label values ciudad ciudad
				
		*- Parametros de temproralidad
		
			gen str2 trimestre = "."
			label var trimestre "Trimestre de la base"
			replace trimestre ="01" if mes =="01" | mes=="02" | mes=="03"
			replace trimestre ="02" if mes =="04" | mes=="05" | mes=="06"
			replace trimestre ="03" if mes =="07" | mes=="08" | mes=="09"
			replace trimestre ="04" if mes =="10" | mes=="11" | mes=="12"
			
			gen str2 semestre = "."
			label var semestre "Semestre de la Base"
			replace semestre ="01" if mes=="01" | mes=="02" | mes=="03" | mes=="04" | mes=="05" | mes=="06"
			replace semestre ="02" if mes=="07" | mes=="08" | mes=="09" | mes=="10" | mes=="11" | mes=="12"
			
			