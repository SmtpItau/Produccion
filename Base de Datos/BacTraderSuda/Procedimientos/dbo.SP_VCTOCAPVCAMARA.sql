USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VCTOCAPVCAMARA]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_VCTOCAPVCAMARA]
AS
BEGIN
 SELECT DISTINCT 'numoper' = rsnumoper       ,
   'totvcto' = CONVERT(NUMERIC(19,0),0)     ,
   'nombre' = SPACE (60)       ,
   'rutcli' = CONVERT(NUMERIC(9,0),0)     ,
   'codigo' = SPACE (02)       ,
   'nomemp' = acnomprop       ,
   'rutemp' = STR(acrutprop)+'-'+acdigprop     ,
   'info'  = 'SPVCCAPC'       ,
   'fecpro' = ISNULL(CONVERT(CHAR(10),rsfecctb,103),CHAR(10))  ,
   'dv'  = SPACE(01)
 INTO #TMP
 FROM MDRS1, MDAC
 WHERE rstipoper='VC' AND rsinstser='ICAP' AND rsforpagv=3
 UPDATE #TMP
 SET totvcto = rsvppresenx      ,
  nombre = ISNULL(clnombre,'CLIENTE NO EXISTE EN BACTRADER') ,
  rutcli = rsrutcli      ,
  dv = ISNULL(cldv,'')
 FROM  --  REQ. 7619
       MDRS1 LEFT OUTER JOIN VIEW_CLIENTE ON rsrutcli = clrut  
--      VIEW_CLIENTE
 WHERE numoper=rsnumoper AND 
--  REQ. 7619
--       rsrutcli*=clrut AND 
       rstipoper='VC'
 IF (SELECT COUNT(*) FROM #TMP)>0 
  SELECT nomemp,rutemp,info,fecpro,STR(rutcli)+'-'+dv,nombre,totvcto,numoper FROM #TMP ORDER BY numoper
 ELSE
  SELECT 'NO','No Existen Vencimientos de Captaciones Vale Camara'
 
END


GO
