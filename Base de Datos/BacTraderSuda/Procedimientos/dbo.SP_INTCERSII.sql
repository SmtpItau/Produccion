USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTCERSII]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTCERSII]
   (
   @nAno INTEGER
   )
AS
BEGIN

 SET NOCOUNT ON
 SELECT  'forpago' 	= CASE
     				WHEN moforpagi<15 THEN '015'
				ELSE STUFF(STR(moforpagi,3),1,3-LEN(LTRIM(STR(moforpagi,3))),REPLICATE('0',3-LEN(LTRIM(STR(moforpagi,3)))))
		     	  END               ,
	  'numoper' 	= STUFF(STR(monumoper,7),1,7-LEN(LTRIM(STR(monumoper,7))),REPLICATE('0',7-LEN(LTRIM(STR(monumoper,7)))))  ,
	  'nombre' 	= SUBSTRING(clnombre,1,30)            ,
	  'rut'  	= STUFF(STR(morutcli,9),1,9-LEN(LTRIM(STR(morutcli,9))),REPLICATE('0',9-LEN(LTRIM(STR(morutcli,9)))))    ,
	  'dv'  	= cldv               ,
	  'direccion' 	= SUBSTRING(cldirecc,1,30)            ,
	  'moneda' 	= momonpact              ,
	  'fecinip' 	= CONVERT(CHAR(10),mofecinip,112)           ,
	  'fecvenp' 	= CONVERT(CHAR(10),mofecvenp,112)           ,
	  'codigo' 	= CASE
			     WHEN momonpact=13  THEN '3900'
			     WHEN momonpact=998 THEN '2900'
			     WHEN momonpact=994 OR momonpact=995 THEN '2910'
			     ELSE '1900'
		          END               ,
	  'valinip' 	= CASE
		     		WHEN momonpact<>999 THEN ROUND(movalinip/(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=momonpact AND vmfecha=mofecinip),4)
				ELSE movalinip
			  END               ,
	  'intpac' 	= CASE     
				WHEN momonpact=999 THEN movalvenp-movalinip
				ELSE ROUND(movalvenp/(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=momonpact AND vmfecha=mofecvenp),4)-ROUND(movalinip/(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=momonpact AND vmfecha=mofecinip),4)
			 END               ,
	  'valvenp' 	= CASE
			     WHEN momonpact<>999 THEN ROUND(movalvenp/(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=momonpact AND vmfecha=mofecvenp),4)
			     ELSE movalvenp
			  END               ,
	  'taspact' 	= motaspact         ,
	  'monini' 	= CASE
			     WHEN momonpact<>999 THEN (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=momonpact AND vmfecha=mofecinip)
			     ELSE 1
			  END               ,
  	  'monven' 	= CASE
     				WHEN momonpact<>999 THEN (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=momonpact AND vmfecha=mofecvenp)
				ELSE 1
      			  END               ,
	  'enduro' 	= 'N 000000000000000'
	 INTO    #tmp_h
	 FROM MdMh, VIEW_CLIENTE
	  WHERE DATEPART(YEAR,mofecvenp)=@nAno 
		AND (motipoper='RC' OR motipoper='RCA') 
		AND  clrut=morutcli


 SELECT forpago  ,
  	numoper  ,
  	nombre  ,
  	rut  ,
  	dv  ,
  	direccion ,
  	moneda  ,
  	fecinip  ,
  	fecvenp  ,
  	codigo  ,
  	'valinip' = SUM(valinip ) ,
  	'intpac' = SUM(intpac)  ,
  	'valvenp' = SUM(valvenp) ,
  	taspact  ,
  	monini  ,
  	monven  ,
  	enduro  --,
  --'cant_reg' = (select count(*) from #tmp_h) 
 	FROM   #tmp_h
 	GROUP BY  forpagO ,
  	numoper  ,
  	nombre  ,
  	rut  ,
  	dv  ,
  	direccion ,
  	moneda  ,
  	fecinip  ,
  	fecvenp  ,
  	codigo  ,
  	taspact  ,
  	monini  ,
  	monven  ,
  	enduro
 ORDER BY rut, numoper
 SET NOCOUNT OFF
END
-- SP_INTCERSII 2003
-- select STUFF(STR(morutcli,9),1,9-LEN(LTRIM(STR(morutcli,9))),REPLICATE('0',9-LEN(LTRIM(STR(morutcli,9))))) from mdmh where DATEPART(YEAR,mofecvenp)=2001 and morutcli=78002130 AND (motipoper='RC' OR motipoper='RCA')
-- select mofecpro,momonpact,movalinip,movalvenp from mdmh where DATEPART(YEAR,mofecvenp)=2001 AND (motipoper='RC' OR motipoper='RCA') and morutcli=78002130 
--sp_autoriza_ejecutar 'bacuser'
--go





GO
