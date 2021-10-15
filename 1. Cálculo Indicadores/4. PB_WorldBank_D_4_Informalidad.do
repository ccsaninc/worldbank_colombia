********************************************************************************************
* Insitucion:   	Banco Mundial 
* Autor: 		    Equipo de Trabajo 						  
* Version:		    1.0
* Descripción:		Cargué de informacion tablero - Banco Mundial
*********************************************************************************************
*------------------ VARIABLES DE INFORMALIDAD ------------------------------------*
	
	*- Definicion de Informalidad DANE -*

		*- Definicion de profesionales -*

		destring oficio, replace

		gen profesional = .
		replace profesional = 0 if oficio >= 21 | oficio == 0 
		replace profesional = 1 if oficio >= 1 & oficio <= 20
		replace profesional = . if oficio == .

		lab var profesional "Profesionales / No profesionales"
		label define profesional 0 "NO Profesional" 1 "Profesional" 
		label values profesional profesional
		
		*----- Definicion del numero de personas por empresa ---*

		gen empresas_5 = .
		replace empresas_5 = 0 if p6870 >= 1 & p6870 <= 3
		replace empresas_5 = 1 if p6870 >= 4 & p6870 <= 9
		replace empresas_5 = . if p6870 == .

		lab var empresas_5 "Empresas con menor de 5 personas"
		label define empresas_5 0 "Menos de 5" 1 "Mas de 5"
		label values empresas_5 empresas_5
		
		*----- Definicion de variable asalariados privados de 5 o menos trabajadores ----*

		gen poc_ocu_infor_DANE = .
		replace poc_ocu_infor_DANE = 1 if empresas_5 ==0 & p6430 == 1 						// Empleado particular 
		replace poc_ocu_infor_DANE = 2 if empresas_5 ==0 & p6430 == 3 						// Empleado domestico
		replace poc_ocu_infor_DANE = 3 if empresas_5 ==0 & p6430 == 4 & profesional != 1 	// Cuenta propia con 5 trabajadores o menos con exepcion de los profesionales
		replace poc_ocu_infor_DANE = 4 if empresas_5 ==0 & p6430 == 5  						// Patron 
		replace poc_ocu_infor_DANE = 5 if empresas_5 ==0 & p6430 == 6 						// Trabajador familiar sin remuneracion
		replace poc_ocu_infor_DANE = 6 if empresas_5 ==0 & p6430 == 7						// Trabajador sin remuneracion 
		replace poc_ocu_infor_DANE = 7 if empresas_5 ==0 & p6430 == 8						// Peon
				
		*---- Categorias especiales --------*
	
		replace poc_ocu_infor_DANE = 8 if empresas_5 ==0 & p6430 == 2
		replace poc_ocu_infor_DANE = 9 if empresas_5 ==0 & p6430 == 9
	
		*--- Fin Categorias Especiales -----*
		
		replace poc_ocu_infor_DANE = . if empresas_5 == . & p6430 == .

		lab var poc_ocu_infor_DANE "Informalidad deficion DANE por Ocupacion"
		label define poc_ocu_infor_DANE 1 "Asalariado" 2 "Empleado Domestico" 3 "Cuenta Propia" 4 "Patron" 5 "TFSR" 6 "TFR" 7 "Peon" 8 "Empelado Gobierno" 9 "Otro"
		label values poc_ocu_infor_DANE poc_ocu_infor_DANE 

		* ----- Definicion de la informalidad total ----*

		gen infor_DANE_total = .
		replace infor_DANE_total = 1 if poc_ocu_infor_DANE ==1 | poc_ocu_infor_DANE ==2 | poc_ocu_infor_DANE ==3 | poc_ocu_infor_DANE ==4 | poc_ocu_infor_DANE ==5 | poc_ocu_infor_DANE ==6 | poc_ocu_infor_DANE ==7

		lab var infor_DANE_total "Informalidad total deficion DANE "
		label define infor_DANE_total 1 "Informal" 0 "Formal" 
		label values infor_DANE_total infor_DANE_total 
		
		* ----- Definicion de formales y no formales -----*

		gen Informalidad_DANE = .
		replace Informalidad_DANE = 0 if oci == 1 & infor_DANE_total != 1 
		replace Informalidad_DANE = 1 if oci == 1 & infor_DANE_total == 1
				
		lab var Informalidad_DANE "Formales y No Formales"
		label define Informalidad_DANE 0 "For_DANE_0" 1 "Inf_DANE_1" 
		label values Informalidad_DANE Informalidad_DANE
		
	
*- Definicion de Informalidad deaceurdo a las AFP -*

		*- Definion de Formales y no Formales por pension -*

		gen Informalidad_AFP = .
		replace Informalidad_AFP = 0 if p6920 == 1 
		replace Informalidad_AFP = 1 if p6920 == 2
		replace Informalidad_AFP = . if p6920 == .
		
		lab var Informalidad_AFP "Informalidad deficion AFP" 
		label define Informalidad_AFP 0 "For_SS_0" 1 "Inf_SS_1"
		label values Informalidad_AFP Informalidad_AFP
		
*- Definicion de Informalidad deaceurdo a las Salud -*

		*- Definion de Formales y no Formales por pension -*

			gen no_salud=1 if (p6100==9 | p6100==.)
			recode no_salud .=0

			gen no_pension=1 if (p6920==2 | p6920==.)
			recode no_pension .=0

			gen Informalidad_Salud = 1 if no_salud==1 & no_pension==1 & oci==1
			replace Informalidad_Salud = 0 if no_salud==0 & no_pension==0 & oci==1
			replace Informalidad_Salud = 1 if (no_salud==1 & oci==1) | (no_pension==1 & oci==1)

		lab var Informalidad_Salud "Informalidad deficion Salud" 
		label define Informalidad_Salud 0 "For_Salud_0" 1 "Inf_Salud_1" 
		label values Informalidad_Salud Informalidad_Salud	
		
		

	