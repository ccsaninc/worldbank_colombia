********************************************************************************************
* Insitucion:   	Banco Mundial 
* Autor: 		    Equipo de Trabajo 						  
* Version:		    1.0
* Descripción:		Cargué de informacion tablero - Banco Mundial
*********************************************************************************************

*- Indicadores Demograficos -*

			
		*------------ QUINTENIOS EDAD DANE ---------------*
		
		/*
		
		*Edad quinquenios del Dane
			
			gen quin_DANE_Ab =.
			replace quin_DANE_Ab =. if p6040<10
			replace quin_DANE_Ab =1 if p6040>=10 & p6040<=13
			replace quin_DANE_Ab =2 if p6040>=14 & p6040<=18
			replace quin_DANE_Ab =3 if p6040>=19 & p6040<=22
			replace quin_DANE_Ab =4 if p6040>=23 & p6040<=28
			replace quin_DANE_Ab =5 if p6040>=29 & p6040<=35
			replace quin_DANE_Ab =6 if p6040>=36 & p6040<=50
			replace quin_DANE_Ab =7 if p6040>50 

			lab define quin_DANE_Ab 1 "10-13" 2 "14-18" 3 "19-22" 4 "23-28" 5 "29-35" 6 "35-50" 7 "50 y más"
			lab values quin_DANE_Ab quin_DANE_Ab
			
		*/

		*Edad quinquenios del Dane
			
			gen quin_DANE =.
			replace quin_DANE =0 if p6040<5	
			replace quin_DANE =1 if p6040>=5 & p6040<=10
			replace quin_DANE =2 if p6040>=11 & p6040<=20
			replace quin_DANE =3 if p6040>=21 & p6040<=30
			replace quin_DANE =4 if p6040>=31 & p6040<=40
			replace quin_DANE =5 if p6040>=41 & p6040<=50
			replace quin_DANE =6 if p6040>=51 & p6040<=60
			replace quin_DANE =7 if p6040>=61 & p6040<=70
			replace quin_DANE =8 if p6040>=71 & p6040<=80
			replace quin_DANE =9 if p6040>=81 & p6040<=90
			replace quin_DANE =10 if p6040>=91 & p6040<=100
			replace quin_DANE =11 if p6040>100

			lab define quin_DANE 0 "Q_0" 1 "Q_1" 2 "Q_2" 3 "Q_3" 4 "Q_4" 5 "Q_5" 6 "Q_6" 7 "Q_7" 8 "Q_8" 9 "Q_9" 10 "Q_10" 11 "Q_11" 
			lab values quin_DANE quin_DANE 	
			
			
		
