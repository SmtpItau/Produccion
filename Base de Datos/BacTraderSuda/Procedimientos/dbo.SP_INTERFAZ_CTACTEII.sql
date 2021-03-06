USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_CTACTEII]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_CTACTEII]
AS
BEGIN
 SET NOCOUNT ON
 SELECT codigo = CASE
    WHEN motipoper='VI' THEN '024001'
    WHEN CHARINDEX(motipoper,'RV -VP ')>0 THEN '024002' 
    WHEN motipoper='RVA' THEN '024004'
     END , --FALTA VP
  monto = CASE
    WHEN motipoper='VI' THEN movalinip
    WHEN CHARINDEX(motipoper,'RV -RVA-VP ')>0 THEN movalvenp
     END ,
  coa = '1' ,
  clctacte ,
  clrut  ,
  clcodigo ,
  monumoper
 INTO #CTACTE 
 FROM MDMO, VIEW_CLIENTE 
 WHERE morutcli=clrut
 AND mocodcli=clcodigo
 AND ( ( (moforpagi=6 OR moforpagi=7) AND motipoper IN ('VI','VP'  )  )
 OR    ( (moforpagv=6 OR moforpagv=7) AND motipoper IN ('RV','RVA' )  )  ) 
 AND mostatreg=' '
--  ((moforpagi=6 OR moforpagi=7) OR (moforpagv=6 OR moforpagv=7)) AND
--  CHARINDEX(motipoper,'VI -RV -RVA-VP')>0 AND mostatreg=' '
 
 INSERT INTO
 #CTACTE
 SELECT  CASE
   WHEN motipoper='CI' THEN '024006'
   WHEN CHARINDEX(motipoper,'RC -CP ')>0 THEN '024005'
   WHEN motipoper='RCA' THEN '024008'
  END  ,
  CASE
   WHEN motipoper='CI' THEN movalinip
   WHEN CHARINDEX(motipoper,'RC -RCA')>0 THEN movalvenp
   WHEN motipoper='CP' THEN movalcomp
  END  ,
  '2'  ,
  clctacte ,
  clrut  ,
  clcodigo ,
  monumoper
 FROM MDMO, VIEW_CLIENTE 
 WHERE morutcli=clrut
 AND mocodcli=clcodigo
 AND ( ( (moforpagi=6 OR moforpagi=7) AND motipoper IN ('CI','CP'  )  )
 OR    ( (moforpagv=6 OR moforpagv=7) AND motipoper IN ('RC','RCA' )  )  ) 
 AND mostatreg=' '
--  ((moforpagi=6 OR moforpagi=7) OR (moforpagv=6 OR moforpagv=7)) AND
--  CHARINDEX(motipoper,'CI -RC -RCA-CP')>0 AND mostatreg=' '
 UPDATE MDAC SET acint_cteii = '1'
 IF NOT EXISTS (SELECT * FROM #CTACTE)
 BEGIN
  SELECT 'OK'
  RETURN
 END
 SELECT codigo   ,
  monto = SUM(monto) ,
  coa   ,
  clctacte  ,
  clrut   ,
  clcodigo  ,
  monumoper
 FROM #CTACTE
 GROUP BY codigo, coa, clctacte, clrut, clcodigo, monumoper
END 
-- SP_INTERFAZ_CTACTEII


GO
