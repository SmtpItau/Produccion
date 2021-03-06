USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_CUSTODIA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_CUSTODIA]
                  (@xRut    NUMERIC(9))
AS
BEGIN
set nocount on
 SELECT rut_cliente      ,
        numero_operacion     ,
        monto_inicio      ,
        monto_final      ,
        tasa       ,
        'UM'=mnnemo      ,
        fecha_operacion      ,
        fecha_vencimiento     ,
        'Custodia'=CASE custodia WHEN 'P' THEN 'PROPIA' 
                                 WHEN 'D' THEN 'DCV' 
                                 ELSE 'CLIENTE' END  ,
        correla_operacion
        FROM GEN_CAPTACION, VIEW_MONEDA 
        WHERE Rut_Cliente = @xRut AND
              Moneda      = mncodmon ORDER BY numero_operacion
set nocount off
END

GO
