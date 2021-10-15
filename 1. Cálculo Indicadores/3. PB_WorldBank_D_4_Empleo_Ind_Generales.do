********************************************************************************************
* Insitucion:   	Banco Mundial 
* Autor: 		    Equipo de Trabajo 						  
* Version:		    1.0
* Descripción:		Cargué de informacion tablero - Banco Mundial
*********************************************************************************************

*- Indicadores de mercado de trabajo -*
	
		*- Ocupados -*

		gen OC = .
			
		replace OC = 1 if p6240 == 1
			replace OC = 1 if p6250 == 1
			replace OC = 1 if p6260 == 1
			replace OC = 1 if p6270 == 1
		   
		label var OC "Personas Ocupadas"
		label define OC 1"D_01"
		label values OC OC
		
		*- Desocupados -*

		gen DS = .
			
			replace DS = 1 if p6351 == 1

		label var DS "Personas Desocupadas"
		label define DS 1 "D_02"
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
		label define Ini 1 "D_03"
		label values Ini Ini

		*- Poblacion de Economicamente Activa (PEA) -*
			
		gen PEA =.
		
			replace PEA =1 if DS==1
			replace PEA =1 if OC==1 
					
		lab var PEA  "Poblacion Economicamente Activa"
		label define PEA  1 "D_04"
		label values PEA  PEA 
		
		*- Poblacion en edad de Trabajar (PET) -*
			
		gen PET =.						
		
			replace PET =1 if PEA ==1
			replace PET =1 if Ini==1

		lab var PET  "Poblacion Edad de Trabajar"
		label define PET 1 "D_05"
		label values PET PET
		
		gen PET_No = .
		
			replace PET_No = 1 if PET !=1
			
		lab var PET_No " NO Poblacion Edad de Trabajar	"
		label define PET_No 1 "D_06"
		label values PET_No PET_No
		
		gen POB = .
		
			replace POB = 1 
			
		lab var POB  "Poblacion"
		label define POB 1 "D_00"
		label values POB POB
			
*------- TIPOS DE OCUPADOS ---------------------------------------*

		**Tipos de Ocupados: Asalariados, Cuenta propia, empleados domesticos y otros....

		gen tip_ocu=1 if  p6430==1 | p6430==2 
		replace tip_ocu=2 if p6430==4 
		replace tip_ocu=3 if p6430==3 
		replace tip_ocu=4 if p6430!=. & tip_ocu==.
		 
		lab define tip_ocu 1 "POC_OC_0" 2 "POC_OC_1" 3 "POC_OC_2" 4 "POC_OC_3"
		lab values tip_ocu tip_ocu

*------- Tiene algun tipo de contrato ---------------------------------------*

		**Tipos de Ocupados: Asalariados, Cuenta propia, empleados domesticos y otros....

		gen cont_trab = .
		replace  cont_trab = 1 if p6440 == 1 
		
		lab var cont_trab "Contrato Laboral"
		lab define cont_trab 1 "Con contraro"
		lab values cont_trab cont_trab
		
*------- Calculo de los NINIS ---------------------------------------*
		
		gen ninis = .
		replace ninis = 1 if (dsi == 1 | ini == 1) & p6170==2

*------- CALCULO DE INGRESOS ------------------------------------*

	**Remuneraciones-Ingresos**
	*El ingreso laboral se compone del ingreso por la primera actividad + el ingreso por la segunda actividad. Para el cálculo debes tener en cuenta si son asalariados o independientes. 
	*Ingreso laboral de los independientes es: Ingreso primera actividad + (P550/12) + P7070

			*Ingreso asalariado
			
			destring  p6500 p6585s1a1 p6585s2a1 p6585s3a1 p6585s4a1 p6510s1 p6630s4a1 p6580s1 p7070, replace 
			gen salario=p6500
			replace p6585s1a1=. if p6585s1a1==98
			replace p6585s2a1=. if p6585s2a1==98
			replace p6585s3a1=. if p6585s3a1==98
			replace p6585s4a1=. if p6585s4a1==98

			egen subsidios=rowtotal(p6585s1a1 p6585s2a1 p6585s3a1 p6585s4a1)
			gen horasextras=p6510s1 if  p6510s2==2
			replace horasextras=. if horasextras==98
			replace horasextras=. if horasextras==99

			*Ingreso Final Asalariados correspondiente a la ocupacion primaria
			
			egen ing_asalariado= rowtotal(salario subsidios horasextras)
			
			*Ingreso cuenta propia
			
			gen salariocc=p6750/p6760 
			gen ganancia=p550/12 
			egen ing_cuentapropia= rowtotal(salariocc ganancia)

				/*
				gen salario2cc=p7070 if cuenta_propia==1
				*/


			*Ingreso laboral final ocupados
			gen ing_laboral=ing_cuentapropia
			replace ing_laboral=ing_asalariado if ing_laboral==0 

			*- Libreria de variables usadas para el calculo de ingresos -*
			
				*P6760 corresponde al número de meses al que correspnde el ingreso recibido
				*p6500 P6500 Antes de descuento cuanto gano el mes pasado en este empleo?
				*p6750 P6750 Cual fue la ganancia neta o los honorarios netos de...esa actividad o negocio
				*p550 P550 Cual fue la ganancia neta del negocio o de la cosecha durante los últimos 12 meses
				*p7070 P7070 Cuanto recibió el mes pasado en su segundo trabajo?
				*p6590 además del salario en dinero, el mes pasado recibió alimentos como parte de pago?
				*p6590s1 P6590S1 Cuanto estima que recibio?
				*P6600 Además del salario en dinero, el mes pasado recibió vivienda como parte de pago
				*p6600s1 P6600S1 cuanto estima q recibió
				*P6620 Además del salario, el mes pasado recibió otros ingresos en especie?
				*p6620s1 P6620S1  cuanto estima q recibió
				*p6510s1 Ingresos Horas Extras 
				*p7472 Reció el mes pasado ingresos por concepto de trabajo
				*p7472s1 Cuanto?
				*p7422Reció el mes pasado ingresos por concepto de trabajo
				*p7472s1 Cuanto?


			*Haras laboradas por asalariados y/o cuenta propia
			
			**Horas totales 
				
				destring p6800, replace
				gen horas_totales=p6800*4
				replace horas_totales=0 if horas_totales==. | horas_totales<0 | horas_totales>600
			
			*horas extras
			
				destring p6640s1, replace
				replace p6640s1=0 if p6640s1>100
				gen horas_extras=p6640s1*4
				replace horas_extras=0 if horas_extras==. | horas_extras<0 | horas_extras>100 
				egen total_horas_trabajadas=rowtotal(horas_totales horas_extras)
				*672 horas es lo máximo que podrías trabajar una persona al mes (24*7*4) por lo tanto se hará el supuesto de que el máximo de horas que una persona puede trabajar al día no supera las 20 horas.
				gen horas_diarias=total_horas_trabajadas/30
				keep if horas_diarias<=20
				
				gen total_horas_trabajadas_semana = total_horas_trabajadas/4
				

			*Ingreso por hora trabajada
			
				gen ing_total_hora=ing_laboral/total_horas_trabajadas
				replace ing_total_hora=0 if ing_total_hora==.
				
			
			*- Tipo de Contrato -*
		
				gen per_contrato = .
				replace per_contrato = 1 if p6450 == 1 
				replace per_contrato = 2 if p6450 == 2
				
				label var per_contrato "Contrato a termino indefinido o definido"
				label define per_contrato 1 "Indefinido" 2 "Fijo"
				label values per_contrato per_contrato
							
			*- Tipo de Contrato -*
		
				gen tp_contrato = .
				replace tp_contrato = 1 if p6460 == 1 
				replace tp_contrato = 2 if p6460 == 2
				
				label var tp_contrato "Tipo de contrato (verbal / escrito)"
				label define tp_contrato 1 "Verbal" 2 "Escrito"
				label values tp_contrato tp_contrato
			
			******* Generar la variable de actividad economica - Documentos DANE Rev 4 *****************
				
			destring rama2d_r4, replace
		
			gen act_eco_r4 = .
			
			replace act_eco_r4 = 0 if rama2d_r4 == 0
			replace act_eco_r4 = 1 if rama2d_r4 >= 1 & rama2d_r4 <= 3
			replace act_eco_r4 = 2 if rama2d_r4 >= 5 & rama2d_r4 <= 9
			replace act_eco_r4 = 3 if rama2d_r4 >= 10 & rama2d_r4 <= 33
			replace act_eco_r4 = 4 if rama2d_r4 == 35
			replace act_eco_r4 = 5 if rama2d_r4 >= 36 & rama2d_r4 <= 39
			replace act_eco_r4 = 6 if rama2d_r4 >= 41 & rama2d_r4 <= 43
			replace act_eco_r4 = 7 if rama2d_r4 >= 45 & rama2d_r4 <= 47
			replace act_eco_r4 = 8 if rama2d_r4 >= 49 & rama2d_r4 <= 53
			replace act_eco_r4 = 9 if rama2d_r4 >= 55 & rama2d_r4 <= 56
			replace act_eco_r4 = 10 if rama2d_r4 >= 58 & rama2d_r4 <= 63
			replace act_eco_r4 = 11 if rama2d_r4 >= 64 & rama2d_r4 <= 66
			replace act_eco_r4 = 12 if rama2d_r4 == 68
			replace act_eco_r4 = 13 if rama2d_r4 >= 69 & rama2d_r4 <= 75
			replace act_eco_r4 = 14 if rama2d_r4 >= 77 & rama2d_r4 <= 82
			replace act_eco_r4 = 15 if rama2d_r4 == 84
			replace act_eco_r4 = 16 if rama2d_r4 == 85
			replace act_eco_r4 = 17 if rama2d_r4 >= 86 & rama2d_r4 <= 88
			replace act_eco_r4 = 18 if rama2d_r4 >= 90 & rama2d_r4 <= 93
			replace act_eco_r4 = 19 if rama2d_r4 >= 94 & rama2d_r4 <= 96
			replace act_eco_r4 = 20 if rama2d_r4 >= 97 & rama2d_r4 <= 98
			replace act_eco_r4 = 21 if rama2d_r4 == 99
			
			replace act_eco_r4 = . if rama2d_r4 == .
			
			lab var act_eco_r4 "Actividad economica Rev. 4" 
			
			label define act_eco_r4 0 "No informa" 1 "SECCIÓN A - Agricultura, Ganadería, Caza, Silvicultura Y Pesca" 2 "SECCIÓN B - Explotación De Minas Y Canteras" 3 "SECCIÓN C - Industrias Manufactureras" 4 "SECCIÓN D - Suministro De Electricidad, Gas, Vapor Y Aire Acondicionado" 5 "SECCIÓN E - Distribución De Agua; Evacuación Y Tratamiento De Aguas Residuales, Gestión De Desechos Y Actividades De Saneamiento Ambiental" 6 "SECCIÓN F - Construcción" 7 "SECCIÓN G - Comercio Al Por Mayor Y Al Por Menor; Reparación De Vehículos Automotores Y Motocicletas" 8 "SECCIÓN H - Transporte Y Almacenamiento" 9 "SECCIÓN I - Alojamiento Y Servicios De Comida" 10 "SECCIÓN J - Información Y Comunicaciones" 11 "SECCIÓN K - Actividades Financieras Y De Seguros" 12 "SECCIÓN L - Actividades Inmobiliarias" 13 "SECCIÓN M - Actividades Profesionales, Científicas Y Técnicas" 14 "SECCIÓN N - Actividades De Servicios Administrativos Y De Apoyo" 15 "SECCIÓN O - Administración Pública Y Defensa; Planes De Seguridad Social De Afiliación Obligatoria" 16 "SECCIÓN P - Educación" 17 "SECCIÓN Q - Actividades De Atención De La Salud Humana Y De Asistencia Social" 18 "SECCIÓN R  - Actividades Artísticas, De Entretenimiento Y Recreación" 19 "SECCIÓN S - Otras Actividades De Servicios" 20 "SECCIÓN T  - Actividades De Los Hogares Individuales En Calidad De Empleadores; Actividades No Diferenciadas De Los Hogares Individuales Como Productores De Bienes Y Servicios Para Uso Propio" 21 "SECCIÓN U - Actividades De Organizaciones Y Entidades Extraterritoriales "
			label values act_eco_r4 act_eco_r4
			
			
			*- Agrupacion de actividades DANE
			
			gen act_eco_r4_DANE = .
			
			replace act_eco_r4_DANE = 0 if act_eco_r4 == 0
			replace act_eco_r4_DANE = 1 if act_eco_r4 == 1
			replace act_eco_r4_DANE = 2 if act_eco_r4 == 2
			replace act_eco_r4_DANE = 3 if act_eco_r4 == 3
			replace act_eco_r4_DANE = 4 if act_eco_r4 == 4 | act_eco_r4 == 5
			
			replace act_eco_r4_DANE = 5 if act_eco_r4 == 6
			replace act_eco_r4_DANE = 6 if act_eco_r4 == 7
			replace act_eco_r4_DANE = 7 if act_eco_r4 == 9
			replace act_eco_r4_DANE = 8 if act_eco_r4 == 8
			replace act_eco_r4_DANE = 9 if act_eco_r4 == 10
			replace act_eco_r4_DANE = 10 if act_eco_r4 == 11
			replace act_eco_r4_DANE = 11 if act_eco_r4 == 12
			replace act_eco_r4_DANE = 12 if act_eco_r4 == 13 | act_eco_r4 == 14
			replace act_eco_r4_DANE = 13 if act_eco_r4 == 15 | act_eco_r4 == 16 | act_eco_r4 == 17
			replace act_eco_r4_DANE = 14 if act_eco_r4 == 18 | act_eco_r4 == 19 | act_eco_r4 == 20 | act_eco_r4 == 21
			
			lab var act_eco_r4_DANE "Actividad economica Rev. 4 Clasf. DANE"
			
			label define act_eco_r4_DANE 0 "AE_1" 1 "AE_2" 2 "AE_3" 3 "AE_4" 4 "AE_5" 5 "AE_6" 6 "AE_7" 7 "AE_8" 8 "AE_9" 9 "AE_10" 10  "AE_11" 11 "AE_12" 12 "AE_13" 13 "AE_14" 14 "AE_15"

			label values act_eco_r4_DANE act_eco_r4_DANE