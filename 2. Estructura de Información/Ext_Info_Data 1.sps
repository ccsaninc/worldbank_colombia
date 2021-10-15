* Encoding: UTF-8.

* ----------------------- Data 1 --------------------------------

GET 
  STATA FILE='F:\OneDrive - Universidad de los Andes\10. Banco Mundial\5. Power BI - WorldBank\2. Power BI\2. Indicadores_Colombia\Version 2\0. Do_Files\Data\DataPB_Wb_2021.dta'. 
DATASET NAME DataSet1 WINDOW=FRONT. 


* Aplicar el Factor de Expansion de los Datos    

WEIGHT BY fex_c_2011.


* Tabla personalizadas para extraer la información.

DATASET ACTIVATE DataSet1.
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes total_nal sexo mig_ven g_etarios urbano ciudad13 ciudad23 rural pobtot quin_DANE POB PET PET_No PEA OC DS Ini 
    DISPLAY=LABEL
  /TABLE mes > total_nal > sexo > mig_ven > g_etarios >  quin_DANE > (POB [C][COUNT F40.0] + PET [C][COUNT F40.0] + PET_No [C][COUNT F40.0] + PEA [C][COUNT F40.0] + OC [C][COUNT F40.0] + DS 
    [C][COUNT F40.0] + Ini [C][COUNT F40.0])  + mes > urbano > sexo > mig_ven > g_etarios >  quin_DANE > (POB [C][COUNT F40.0] + PET [C][COUNT F40.0] + PET_No [C][COUNT F40.0] + PEA [C][COUNT F40.0] + OC [C][COUNT F40.0] + DS 
    [C][COUNT F40.0] + Ini [C][COUNT F40.0]) +  mes > ciudad13 > sexo > mig_ven > g_etarios >  quin_DANE > (POB [C][COUNT F40.0] + PET [C][COUNT F40.0] + PET_No [C][COUNT F40.0] + PEA [C][COUNT F40.0] + OC [C][COUNT F40.0] + DS 
    [C][COUNT F40.0] + Ini [C][COUNT F40.0])  + mes > ciudad23 > sexo > mig_ven > g_etarios >  quin_DANE > (POB [C][COUNT F40.0] + PET [C][COUNT F40.0] + PET_No [C][COUNT F40.0] + PEA [C][COUNT F40.0] + OC [C][COUNT F40.0] + DS 
    [C][COUNT F40.0] + Ini [C][COUNT F40.0])  +  mes > rural > sexo > mig_ven > g_etarios >  quin_DANE > (POB [C][COUNT F40.0] + PET [C][COUNT F40.0] + PET_No [C][COUNT F40.0] + PEA [C][COUNT F40.0] + OC [C][COUNT F40.0] + DS 
    [C][COUNT F40.0] + Ini [C][COUNT F40.0])  BY pobtot  
   /CATEGORIES VARIABLES=mes ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=total_nal sexo mig_ven g_etarios urbano ciudad13 ciudad23 rural quin_DANE 
    ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.


* Tabla personalizadas para extraer la información.

DATASET ACTIVATE DataSet1.
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes ciudad sexo mig_ven g_etarios pobtot quin_DANE POB PET PET_No PEA OC DS Ini 
    DISPLAY=LABEL
  /TABLE mes > ciudad > sexo > mig_ven > g_etarios >  quin_DANE > (POB [C][COUNT F40.0] + PET [C][COUNT F40.0] + PET_No [C][COUNT F40.0] + PEA [C][COUNT F40.0] + OC [C][COUNT F40.0] + DS 
    [C][COUNT F40.0] + Ini [C][COUNT F40.0]) BY pobtot  
   /CATEGORIES VARIABLES=mes ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=ciudad sexo mig_ven g_etarios quin_DANE 
    ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.


DATASET ACTIVATE DataSet1.
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes ciudad sexo mig_ven g_etarios quin_DANE POB PET PET_No PEA OC DS Ini 
    DISPLAY=LABEL
  /TABLE mes > ciudad > sexo > mig_ven > g_etarios > quin_DANE > (POB [COUNT F40.0] + PET [COUNT 
    F40.0] + PET_No [COUNT F40.0] + PEA [COUNT F40.0] + OC [COUNT F40.0] + DS [COUNT F40.0] + Ini 
    [COUNT F40.0])
  /CATEGORIES VARIABLES=mes ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=ciudad sexo mig_ven g_etarios quin_DANE POB PET PET_No PEA OC DS Ini 
    ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.
