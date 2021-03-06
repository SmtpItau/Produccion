USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFOPERADOR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_INFOPERADOR]
AS
BEGIN 
SET NOCOUNT ON
 
	SELECT 	monumoper,
		mousuario,
		tipo_operacion = (CASE WHEN motipoper = 'VI' or motipoper = 'CI' THEN Motipoper + '   '+ convert(char(3),momonpact) ELSE motipoper END),
		monto = (CASE  	WHEN motipoper = 'CP' or motipoper = 'IB' THEN movalcomp
       		  		WHEN motipoper = 'VI' or motipoper = 'CI' THEN movalinip  
   		  		WHEN motipoper = 'VP' THEN movalven END),
   		Monemi = CASE WHEN motipoper = 'CP' Or Motipoper = 'VP' THEN (CASE WHEN momonemi = 13 THEN 13 ELSE 999 END)
		      	ELSE (CASE WHEN momonpact = 13 THEN 13 ELSE 999 END)
		 	END

	INTO #operador
	FROM MDMO 
	WHERE   motipoper = 'CP' or motipoper = 'VP' or motipoper = 'IB' or motipoper = 'CI'
      		or motipoper = 'VI'
 
  
	SELECT 	mousuario,
   		tipo_operacion,
 		MONTO = sum(monto),
 		monumoper,
		Monemi
 	INTO #operador1 
 	FROM #operador 
 	Group by mousuario,tipo_operacion,monumoper,Monemi
  
 --UPDATE #OPERADOR1 SET CONT = (SELECT COUNT (DISTINCT TIPO_OPERACION))
  	SELECT mousuario,tipo_operacion,monto=sum(monto),oper = substring(tipo_operacion,1,5),
   		CONT1  = (SELECT COUNT (A.TIPO_OPERACION) FROM #OPERADOR1 A WHERE B.TIPO_OPERACION = A.TIPO_OPERACION),
   		moneda =  substring(rtrim(tipo_operacion),6,4),
   		FECHA  =  CONVERT(CHAR(10),ACFECPROC,103),
   		HORA   =  RIGHT(GETDATE(),8),
   		'ACNOMPROP' = acnomprop,
   		monemis = Monemi
   	FROM #OPERADOR1 B,mdac
 	GROUP BY mousuario,tipo_operacion,Monemi,acfecproc,acnomprop
 
 	SET NOCOUNT OFF
END
--select * from mdac
--select sum(movalcomp) from mdmo where motipoper = 'CP'  3016272834
--update mdrs set rstipopero = 'CP' where rsnumoper = 46224
--drop table #operador
--drop table #operador1
--select * from mdrs where rsnumoper = 46224
--SP_INFOPERADOR



GO
