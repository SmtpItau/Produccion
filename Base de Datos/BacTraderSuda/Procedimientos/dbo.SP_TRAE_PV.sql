USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_PV]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_PV]
AS
BEGIN
 SET NOCOUNT ON
 SELECT DISTINCT 'NumOper' = monumoper ,
   'tipoper' = SPACE (3) ,
   'rutcli' = SPACE (9) ,
   'forpagv' = SPACE (30) ,
   'nomcli' = SPACE (40) ,
   'codpagv' = SPACE (5) ,
   'instser' = SPACE (12) ,
   'totales' = SPACE (30)
 INTO #TEMPO
 FROM MDMO
 WHERE mostatreg<>'A' AND (motipoper='RC' OR motipoper='RV')
 UPDATE #TEMPO
 SET tipoper = motipoper   ,
  rutcli = CONVERT(CHAR(09),morutcli) ,
  codpagv = CONVERT(CHAR(05),moforpagv)
 FROM MDMO,
--      MDPA RQ_7619
      #TEMPO LEFT OUTER JOIN MDPA ON numoper=panumoper
 WHERE numoper=monumoper 
--       numoper*=panumoper
 INSERT #TEMPO
 SELECT DISTINCT
   'numoper' = rsnumoper ,
   'tipoper' = SPACE (3) ,
   'RutCli' = SPACE (9) ,
   'forpagv' = SPACE (30) ,
   'nomcli' = SPACE (40) ,
   'codpagv' = SPACE (5) ,
   'instser' = SPACE (12) ,
   'totales' = SPACE (30)
 FROM MDRS, MDAC
 WHERE (rsfecha=acfecproc AND rstipoper='VC' AND (rsinstser='ICOL' OR rsinstser='ICAP'))
 UPDATE #TEMPO
 SET tipoper = rstipoper   ,
  rutcli = convert(char(09),rsrutcli) ,
  codpagv = convert(char(05),rsforpagv) ,
  instser = rsinstser
 FROM MDRS
 WHERE (numoper=rsnumoper AND rstipoper='VC' AND (rsinstser='ICOL' OR rsinstser='ICAP'))
 UPDATE #TEMPO
 SET nomcli = clnombre
 FROM VIEW_CLIENTE
 WHERE CONVERT(CHAR(9),clrut)=rutcli
 UPDATE #TEMPO
 SET ForPagv = GLOSA
 FROM VIEW_FORMA_DE_PAGO
 WHERE CONVERT(CHAR(5),codigo)=codpagv
 UPDATE #TEMPO
 SET totales = CONVERT(CHAR(30),(SELECT SUM(rsflujo) FROM MDRS WHERE rsnumoper=numoper))
   FROM MDRS
  WHERE numoper=rsnumoper 
 UPDATE #TEMPO
 SET totales = CONVERT(CHAR(30),(SELECT SUM(movalven) FROM MDMO WHERE monumoper=numoper))
 FROM MDMO
 WHERE numoper=monumoper 
 SELECT * FROM #TEMPO ORDER BY tipoper
 SET NOCOUNT OFF 
END

GO
