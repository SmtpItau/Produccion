USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_POSINICIAL_DOLAR]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_POSINICIAL_DOLAR]
AS
BEGIN
  DECLARE @PosDolares Numeric(19,2) ,
          @resu       float  
  
  SELECT vmcodigo
        ,mnglosa
        ,vmposini
        ,mnrefusd
        ,mnmx
        ,vmparmes
        ,acfecpro
/* 
        ,PosDolares = CASE WHEN vmparmes = 0 THEN
                                0
                           ELSE
                                vmposini / vmparmes
                      END 
*/
        ,PosDolares = CASE WHEN mnrrda = 'M' THEN   (vmposini * vmparidad)
                           WHEN mnrrda = 'D' and vmparidad <> 0 THEN (vmposini / vmparidad)
                           ELSE 0
                      END  

        ,vmparidad 

  FROM view_moneda
      ,view_posicion_spt
      ,meac
 WHERE mnnemo  = vmcodigo and
       vmfecha = acfecpro and
       mnmx    = 'c'
END


GO
