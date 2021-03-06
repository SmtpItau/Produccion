USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_CTACTE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_CTACTE]
AS
BEGIN
 SET NOCOUNT ON
 SELECT cuenta = CASE WHEN clctacte=0 THEN '000000000'
    ELSE clctacte
    END  ,
  cod = CASE WHEN CHARINDEX(motipoper,'VP -VI -RV -RVA')>0 THEN '06'
    ELSE '04'
    END  ,
  monto = CASE WHEN CHARINDEX(motipoper,'VI -CI -IB ')>0 THEN SUM(movalinip)
    WHEN CHARINDEX(motipoper,'RC -RV -RCA-RVA-VP ')>0 THEN SUM(movalvenp)
    WHEN motipoper='CP' THEN SUM(movalcomp)
    ELSE 0
    END
 INTO #temp1
 FROM MDMO, VIEW_CLIENTE 
 WHERE morutcli=clrut
 AND mocodcli=clcodigo
 AND ( ( (moforpagi=6 OR moforpagi=7) AND motipoper IN ('CI','CP','VI','VP','IB' )  )
 OR    ( (moforpagv=6 OR moforpagv=7) AND motipoper IN ('RC','RCA','RV','RVA'    )  )  ) 
 AND mostatreg=' '
 GROUP BY clctacte,motipoper,monumoper
 UPDATE MDAC SET acint_cte = '1'
 SELECT * from  #temp1
 SET NOCOUNT OFF
END 
-- SP_INTERFAZ_CTACTE
-- SELECT * FROM VIEW_FORMA_DE_PAGO 
-- SELECT monumoper,motipoper FROM MDMO where ((MOFORPAGI = 6 OR MOFORPAGI = 7) OR (MOFORPAGV =6 OR MOFORPAGV = 7)) and mostatreg=' '
-- GROUP BY motipoper,monumoper


GO
