USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTRADAY_CARGA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_INTRADAY_CARGA]
      (    @FechaHoy   DATETIME   )
AS
BEGIN
   SET NOCOUNT ON
    SELECT 
   b.monumope
  ,b.motipope
  ,'monomcli'  = a.datatec 
  ,b.moticam
  ,b.momonmo       
  ,b.momonpe
  ,b.moestatus
  ,b.marca
  ,b.motipmer
 -- ,b.precio_cliente
 -- ,b.marca                          
 -- ,b.numerointerfaz 
 -- ,b.moestatus
 -- ,b.motipope
 FROM    VIEW_SINACOFI a, MEMO b
 WHERE  CONVERT(CHAR(10),b.mofech,112) = CONVERT(CHAR(10),@FechaHoy,112)
          AND  ( b.moestatus <> 'A'  ) --or ( b.moestatus <> 'a')
          AND  (b.motipmer   = 'PTA' OR b.motipmer  = 'PTAS') --or (b.motipmer  = 'pta' OR b.motipmer  = 'ptas') 
          AND  (b.morutcli   = a.clrut )
        --AND  (b.mocodmon   = 'USD')   
          
       -- OR B.MOTIPOPE  = 'V') 
        --AND (B.MORUTCLI = A.CLRUT ) 
 --AND (MOTIPMER <> 'CANJ')
 --AND (MOTIPMER <> 'TRAN')
 ORDER by b.monumope  DESC
   SET NOCOUNT OFF
END



GO
