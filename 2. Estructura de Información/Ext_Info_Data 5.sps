* Encoding: UTF-8.
* ----------------------- Data 5 - Informalidad --------------------------------

* LLamar la base de datos

GET 
  STATA FILE='F:\OneDrive - Universidad de los Andes\10. Banco Mundial\5. Power BI - WorldBank\2. Power BI\2. Indicadores_Colombia\Version 2\0. Do_Files\Data\DataPB_Wb_2020.dta'. 
DATASET NAME DataSet1 WINDOW=FRONT. 

* Aplicar el Factor de Expansion de los Datos    

WEIGHT BY fex_c_2011.

* Tabla personalizadas para extraer la información.

DATASET ACTIVATE DataSet1.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes total_nal sexo mig_ven g_etarios urbano ciudad13 ciudad23 rural Informalidad_Salud
    DISPLAY=LABEL
  /TABLE mes > (total_nal > sexo > mig_ven > g_etarios > Informalidad_Salud [COUNT F40.0] + urbano > sexo > mig_ven > 
    g_etarios > Informalidad_Salud [COUNT F40.0] + ciudad13 > sexo > mig_ven > g_etarios > Informalidad_Salud [COUNT F40.0] + ciudad23 > sexo > 
    mig_ven > g_etarios > Informalidad_Salud [COUNT F40.0] + rural > sexo > mig_ven > g_etarios > Informalidad_Salud [COUNT F40.0]) BY pobtot
  /CATEGORIES VARIABLES=mes ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=total_nal sexo mig_ven g_etarios urbano ciudad13 ciudad23 rural  Informalidad_Salud 
    ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes total_nal sexo mig_ven g_etarios urbano ciudad13 ciudad23 rural Informalidad_DANE
    DISPLAY=LABEL
  /TABLE mes > (total_nal > sexo > mig_ven > g_etarios > Informalidad_DANE [COUNT F40.0] + urbano > sexo > mig_ven > 
    g_etarios > Informalidad_DANE [COUNT F40.0] + ciudad13 > sexo > mig_ven > g_etarios > Informalidad_DANE [COUNT F40.0] + ciudad23 > sexo > 
    mig_ven > g_etarios > Informalidad_DANE [COUNT F40.0] + rural > sexo > mig_ven > g_etarios > Informalidad_DANE [COUNT F40.0]) BY pobtot
  /CATEGORIES VARIABLES=mes ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=total_nal sexo mig_ven g_etarios urbano ciudad13 ciudad23 rural  Informalidad_DANE 
    ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.


*--------------------------------------------------------------------------------------------------------------------


DATASET ACTIVATE DataSet1.
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes ciudad sexo mig_ven g_etarios Informalidad_Salud POB 
    DISPLAY=LABEL
  /TABLE mes > ciudad > sexo > mig_ven > g_etarios >Informalidad_Salud [COUNT F40.0] BY POB
  /CATEGORIES VARIABLES=mes ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=ciudad sexo mig_ven g_etarios Informalidad_Salud POB ORDER=A KEY=VALUE 
    EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.


DATASET ACTIVATE DataSet1.
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes ciudad sexo mig_ven g_etarios Informalidad_DANE POB 
    DISPLAY=LABEL
  /TABLE mes > ciudad > sexo > mig_ven > g_etarios > Informalidad_DANE [COUNT F40.0] BY POB
  /CATEGORIES VARIABLES=mes ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=ciudad sexo mig_ven g_etarios Informalidad_DANE POB ORDER=A KEY=VALUE 
    EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.
