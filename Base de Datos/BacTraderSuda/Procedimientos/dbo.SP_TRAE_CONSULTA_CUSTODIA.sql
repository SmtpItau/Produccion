USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_CONSULTA_CUSTODIA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_CONSULTA_CUSTODIA]
                  (@xRut    NUMERIC(9),@xCustodia CHAR(1))
AS
BEGIN
set nocount on
 SELECT Rut_Cliente      ,
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
        Correla_operacion
        FROM GEN_CAPTACION, VIEW_MONEDA 
        WHERE rut_cliente = @xRut AND
              moneda      = mncodmon AND
              custodia    = @xCustodia ORDER BY Numero_Operacion
set nocount off
END

GO
