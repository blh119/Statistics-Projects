DATA nycovid ; 
    INFILE "/home/u45153057/covid ny.csv" 
    DELIMITER = ","
    MISSOVER DSD 
    FIRSTOBS=2 ;
    INPUT county $ pop cases metro $ rate;
RUN;

PROC print data = nycovid ; 
run ; 

PROC means data = nycovid ; 
	by metro ; 
	var rate ; 
	output out = mnycovid mean = ratemean ; 
run;

PROC print data = mnycovid ;
run;

PROC sgplot data = mnycovid ;
	title 'Rate Infection Mean by Population Area' ; 
	series x = metro y = ratemean ;
	scatter x = metro y = ratemean ; 
run;

PROC glm data = nycovid ;
	class  metro ; 
	model rate = metro ;
	means metro / duncan ; 
run; 