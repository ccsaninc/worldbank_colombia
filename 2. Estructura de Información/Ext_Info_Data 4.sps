* Encoding: UTF-8.

* ----------------------- Data 4 Empleo Indicadores --------------------------------

GET 
  STATA FILE='F:\OneDrive - Universidad de los Andes\10. Banco Mundial\5. Power BI - WorldBank\2. Power BI\2. Indicadores_Colombia\Version 2\0. Do_Files\Data\DataPB_Wb_2016.dta'. 
DATASET NAME DataSet1 WINDOW=FRONT. 

* Aplicar el Factor de Expansion de los Datos    

WEIGHT BY fex_c_2011.

* Tabla personalizadas para extraer la información.
DATASET ACTIVATE DataSet1.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes total_nal sexo mig_ven g_etarios urbano ciudad13 ciudad23 rural pobtot OC
    DS Ini
    DISPLAY=LABEL
  /TABLE mes [C] > total_nal [C] > sexo [C] > mig_ven [C] > g_etarios [C][COUNT F40.0] + mes [C] >
    urbano [C] > sexo [C] > mig_ven [C] > g_etarios [C][COUNT F40.0] + mes [C] > ciudad13 [C] > sexo
    [C] > mig_ven [C] > g_etarios [C][COUNT F40.0] + mes [C] > ciudad23 [C] > sexo [C] > mig_ven [C] >
    g_etarios [C][COUNT F40.0] + mes [C] > rural [C] > sexo [C] > mig_ven [C] > g_etarios [C][COUNT
    F40.0] BY pobtot + OC + DS + Ini
  /CATEGORIES VARIABLES=mes OC ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=total_nal sexo mig_ven g_etarios urbano ciudad13 ciudad23 rural DS Ini
    ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes ciudad sexo mig_ven g_etarios POB OC DS Ini
    DISPLAY=LABEL
  /TABLE mes > ciudad > sexo > mig_ven > g_etarios [COUNT F40.0] BY POB + OC + DS + Ini
  /CATEGORIES VARIABLES=mes ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=ciudad sexo mig_ven g_etarios POB OC DS Ini ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

* --------------------- Data 4 - Tipo de trabajador  ------------------------------*

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes total_nal sexo mig_ven g_etarios tip_ocu Informalidad_Salud urbano
    ciudad23 ciudad13 rural pobtot cont_trab total_horas_trabajadas ing_laboral
    DISPLAY=LABEL
  /TABLE mes > total_nal > sexo > mig_ven > g_etarios > tip_ocu > Informalidad_Salud + mes > urbano
    > sexo > mig_ven > g_etarios > tip_ocu > Informalidad_Salud + mes > ciudad23 > sexo > mig_ven >
    g_etarios > tip_ocu > Informalidad_Salud + mes > ciudad13 > sexo > mig_ven > g_etarios > tip_ocu >
    Informalidad_Salud + mes > rural > sexo > mig_ven > g_etarios > tip_ocu > Informalidad_Salud BY
    pobtot [COUNT F40.0] + cont_trab [COUNT F40.0] + total_horas_trabajadas [MEAN] + ing_laboral
    [MEAN]
  /CATEGORIES VARIABLES=mes pobtot ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=total_nal sexo mig_ven g_etarios tip_ocu Informalidad_Salud urbano ciudad23
    ciudad13 rural cont_trab ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes total_nal sexo mig_ven g_etarios tip_ocu Informalidad_DANE urbano
    ciudad23 ciudad13 rural pobtot cont_trab total_horas_trabajadas ing_laboral
    DISPLAY=LABEL
  /TABLE mes > total_nal > sexo > mig_ven > g_etarios > tip_ocu > Informalidad_DANE + mes > urbano
    > sexo > mig_ven > g_etarios > tip_ocu > Informalidad_DANE + mes > ciudad23 > sexo > mig_ven >
    g_etarios > tip_ocu > Informalidad_DANE + mes > ciudad13 > sexo > mig_ven > g_etarios > tip_ocu >
    Informalidad_DANE + mes > rural > sexo > mig_ven > g_etarios > tip_ocu > Informalidad_DANE BY
    pobtot [COUNT F40.0] + cont_trab [COUNT F40.0] + total_horas_trabajadas [MEAN] + ing_laboral
    [MEAN]
  /CATEGORIES VARIABLES=mes pobtot ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=total_nal sexo mig_ven g_etarios tip_ocu Informalidad_DANE urbano ciudad23
    ciudad13 rural cont_trab ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

* --------------------- Data 4 Sector Economico  ------------------------------*

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes total_nal sexo mig_ven g_etarios act_eco_r4_DANE Informalidad_Salud urbano
    ciudad23 ciudad13 rural pobtot cont_trab total_horas_trabajadas ing_laboral
    DISPLAY=LABEL
  /TABLE mes > total_nal > sexo > mig_ven > g_etarios > act_eco_r4_DANE > Informalidad_Salud + mes > urbano
    > sexo > mig_ven > g_etarios > act_eco_r4_DANE > Informalidad_Salud + mes > ciudad23 > sexo > mig_ven >
    g_etarios > act_eco_r4_DANE > Informalidad_Salud + mes > ciudad13 > sexo > mig_ven > g_etarios > act_eco_r4_DANE >
    Informalidad_Salud + mes > rural > sexo > mig_ven > g_etarios > act_eco_r4_DANE > Informalidad_Salud BY
    pobtot [COUNT F40.0] + cont_trab [COUNT F40.0] + total_horas_trabajadas [MEAN] + ing_laboral
    [MEAN]
  /CATEGORIES VARIABLES=mes pobtot ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=total_nal sexo mig_ven g_etarios act_eco_r4_DANE Informalidad_Salud urbano ciudad23
    ciudad13 rural cont_trab ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=mes total_nal sexo mig_ven g_etarios act_eco_r4_DANE Informalidad_DANE urbano
    ciudad23 ciudad13 rural pobtot cont_trab total_horas_trabajadas ing_laboral
    DISPLAY=LABEL
  /TABLE mes > total_nal > sexo > mig_ven > g_etarios > act_eco_r4_DANE > Informalidad_DANE + mes > urbano
    > sexo > mig_ven > g_etarios > act_eco_r4_DANE > Informalidad_DANE + mes > ciudad23 > sexo > mig_ven >
    g_etarios > act_eco_r4_DANE > Informalidad_DANE + mes > ciudad13 > sexo > mig_ven > g_etarios > act_eco_r4_DANE >
    Informalidad_DANE + mes > rural > sexo > mig_ven > g_etarios > act_eco_r4_DANE > Informalidad_DANE BY
    pobtot [COUNT F40.0] + cont_trab [COUNT F40.0] + total_horas_trabajadas [MEAN] + ing_laboral
    [MEAN]
  /CATEGORIES VARIABLES=mes pobtot ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=total_nal sexo mig_ven g_etarios act_eco_r4_DANE Informalidad_DANE urbano ciudad23
    ciudad13 rural cont_trab ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

