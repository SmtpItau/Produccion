USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTA_LIQUIDACION2]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARTA_LIQUIDACION2]( @tipoper  CHAR(10) ,
     @cliente CHAR(100) ,
     @monto_mon FLOAT  ,
     @monto_pesos FLOAT  ,
     @forma_pago CHAR(50) ,
     @valuta  CHAR(8)  
     )
AS
BEGIN

 SELECT 'FECHA'   = CONVERT( CHAR(10),acfecpro,103)          ,
  'CLIENTE'  = @cliente             ,
  'MONTO1'  = @monto_mon             ,
  'FECHA_VALUTA'  = CONVERT(CHAR(10),CONVERT(DATETIME,@valuta),103)         ,
  'FORMA_DE_PAGO'  = @forma_pago             ,
  'MONTO2'  = @monto_pesos             ,
  'CTA_CTE'  = (SELECT CUENTA_CORRIENTE FROM VIEW_CORRESPONSAL,MEAC WHERE RUT_CLIENTE = ACRUT AND ACCORRES = CODIGO_CORRES) ,
  'NOMBRE'  = (SELECT NOMBRE FROM VIEW_CORRESPONSAL,MEAC WHERE RUT_CLIENTE = ACRUT AND ACCORRES = CODIGO_CORRES)  ,
  'HORA_PROC'  = CONVERT(CHAR(8),GETDATE(),108), 
                'ENTIDAD'               =       (SELECT ACNOMBRE FROM MEAC)
 FROM meac
END

GO
