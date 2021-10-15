********************************************************************************************
* Insitucion:   	Banco Mundial 
* Autor: 		    Equipo de Trabajo 						  
* Version:		    1.0
* Descripción:		Cargué de informacion tablero - Banco Mundial
*********************************************************************************************

* --------------- VARIABLES PARAMETRICAS -------------* 

*- Base de trabajo paa el calculo de variables -*

*- Base de trabajo -*

cd "F:\OneDrive - Universidad Externado de Colombia\1. Observatorio ML\1. Bases de Datos\5. GEIH_Modulo_Migracion\3. GEIH_Mig"
  
        local f_i 2016
        local f_f 2021
		
*- Variables de Trabajo
		
global var_t "directorio secuencia_p orden fex_c_2011 mes pobtot sexo edad g_etarios mig_ven total_nal urbano rural ciudad10 ciudad13 ciudad23 capital otras_cabeceras POB OC DS Ini PEA PET PET_No area quin_DANE Informalidad_DANE Informalidad_AFP Informalidad_Salud tip_ocu total_horas_trabajadas tp_contrato ing_laboral act_eco_r4_DANE cont_trab ing_total_hora total_horas_trabajadas_semana trimestre semestre ciudad"

*- Procedimiento

    forvalues i = `f_i' / `f_f' {
        
        use "GEIH_Mig_`i'", clear 
		
		*merge 1:1 directorio secuencia_p orden using "F:\OneDrive - Universidad Externado de Colombia\1. Observatorio ML\1. Bases de Datos\1. GEIH\3. CIIUr4\CIIU_`i'.dta"

        dis "-------------------------------------"
        dis "GEIH_Mig_`i'"
        dis "-------------------------------------"

* - Variables parametricas -*

	global ruta_do "F:\OneDrive - Universidad de los Andes\10. Banco Mundial\5. Power BI - WorldBank\2. Power BI\2. Indicadores_Colombia\Version 2\0. Do_Files"
	
		
		do "$ruta_do\1. PB_WorldBank_Variables_Parametricas.do"
		
		do "$ruta_do\2. PB_WorldBank_D_1_Ind_Demograficos.do"
		
		do "$ruta_do\3. PB_WorldBank_D_4_Empleo_Ind_Generales.do"
		
		do "$ruta_do\4. PB_WorldBank_D_4_Informalidad.do"

	
*--------- BASE FINAL PARA CARGAR ---------------------------------*

 keep $var_t
 
 save "F:\OneDrive - Universidad de los Andes\10. Banco Mundial\5. Power BI - WorldBank\2. Power BI\2. Indicadores_Colombia\Version 2\0. Do_Files\Data\DataPB_Wb_`i'.dta", replace
 
     }
	 
/*
	 
	global l_mes "01"


    forvalues i = `f_i' / `f_f' {
		
		foreach mes in $l_mes {
			
			cd "F:\OneDrive - Universidad de los Andes\10. Banco Mundial\5. Power BI - WorldBank\2. Power BI\2. Indicadores_Colombia\Version 2\0. Do_Files\Data"
			use "DataPB_Wb_`i'.dta" , clear	 
			
			keep $var_t if mes == `mes'
			
			save "DataPB_Wb_`i'_$mes.dta" , replace
	
	}  

} 
	 
