USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_QUERYHISPAPEL]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_QUERYHISPAPEL] 
     (@dFechapro DATETIME,
      @cCodigo   CHAR (01))
AS
BEGIN
set nocount on
 SELECT DISTINCT 'numoper' = monumoper  ,
   'rutcartera' = SPACE (09)  ,
   'tipoper'	= SPACE (05)  ,
   'rutcli'		= SPACE (09)  ,
   'nomcli'		= SPACE (40)  ,
   'totoper'	= SPACE (30)  ,
   'horat'		= SPACE (20)  ,
   'operador'	= SPACE (12)  ,
   'nomoper'	= SPACE (30)  ,
   'papeleta'	= CONVERT(INTEGER,1) ,
   'contrato'	= CONVERT(INTEGER,1) ,
   'estaOper'   = SPACE(1)
 INTO #TMP
 FROM MDMH
 WHERE  (motipoper='CP' OR motipoper='CI' OR motipoper='VP' OR
  motipoper='VI' OR motipoper='IB' OR motipoper='ST' OR motipoper='RCA' OR motipoper='RVA' OR motipoper='IC') AND
  mofecpro = @dfechapro 
 UPDATE #TMP
 SET tipoper  = motipoper   ,
  rutcartera = CONVERT(CHAR(09),morutcart) ,
  rutcli  = CONVERT(CHAR(09),morutcli) ,
  nomcli  = SPACE(40)   ,
  totoper  = SPACE(30)   ,
  horat  = SUBSTRING(mohora,1,8)  ,
  nomoper  = SPACE(30)   ,
  operador = mousuario   ,
  papeleta = ISNULL(papapimp,0)  ,
  contrato = ISNULL(paconimp,0)  ,
  estaoper = mostatreg
 FROM #TMP INNER JOIN MDMH ON numoper = monumoper 
		  LEFT OUTER JOIN MDPA ON numoper = panumoper

-- REQ.7619 CASS 27-01-2011
-- FROM MDMH, MDPA
-- WHERE numoper=monumoper AND numoper*=panumoper
 
 UPDATE #TMP
 SET tipoper  = SUBSTRING(moinstser,2,3)
 FROM MDMH
 WHERE numoper=monumoper AND motipoper='IB'
 
 UPDATE #TMP
 SET totoper = CONVERT(CHAR(30),(SELECT SUM(movalcomp) FROM MdMh WHERE numoper=monumoper))
 FROM MDMH
 WHERE tipoper='CP' OR tipoper='RC' OR tipoper='RCA' OR tipoper='CAP' OR tipoper='COL' 
 UPDATE #TMP
 SET totoper = CONVERT(CHAR(30),(SELECT SUM(movalven) FROM MdMh WHERE numoper=monumoper))
 FROM MDMH
 WHERE tipoper='VP' OR tipoper='RV' OR tipoper='RVA' OR tipoper='ST' 
 UPDATE #TMP
 SET totoper = CONVERT(CHAR(30),(SELECT SUM(movalinip) FROM MdMh WHERE numoper=monumoper))
 FROM MDMH
 WHERE tipoper='CI' OR tipoper='VI' 
 UPDATE #TMP
 SET totoper = CONVERT(CHAR(30),(SELECT SUM(movpresen) FROM MdMh WHERE numoper=monumoper))
 FROM MDMH
 WHERE tipoper='IC' 
 UPDATE #TMP
 SET nomcli = clnombre
 FROM VIEW_CLIENTE
 WHERE CONVERT(CHAR(9),clrut)=rutcli 
 UPDATE #TMP
 SET nomoper = nombre
 FROM VIEW_USUARIO
 WHERE operador=usuario 
 UPDATE  #tmp SET tipoper  = 'A' +TIPOPER WHERE estaoper = 'A'
 IF @cCodigo='N'
  SELECT numoper,tipoper,rutcartera,nomcli,totoper,horat,nomoper,papeleta,contrato,estaOper FROM #TMP ORDER BY numoper
 IF @cCodigo='T'
  SELECT numoper,tipoper,rutcartera,nomcli,totoper,horat,nomoper,papeleta,contrato,estaOper FROM #TMP ORDER BY tipoper
 IF @cCodigo='C'
  SELECT numoper,tipoper,rutcartera,nomcli,totoper,horat,nomoper,papeleta,contrato,estaOper FROM #TMP ORDER BY rutcli
SET NOCOUNT OFF
SELECT 'OK'
END



GO
