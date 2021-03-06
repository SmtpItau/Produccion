USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FRMLETRASHIPOTECARIAS_TRAE_DATOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FRMLETRASHIPOTECARIAS_TRAE_DATOS]
AS
BEGIN
      SET NOCOUNT ON
      SELECT 
       codigo_planilla
      ,fecha_ingreso
      ,letra_serie +'                   '+(SELECT nemotecnico FROM LETRA_HIPOTECARIA_SERIE WHERE LETRA_HIPOTECARIA.letra_serie = LETRA_HIPOTECARIA_SERIE.letra_serie)
      ,fecha_emision_nominal
      ,fecha_emision_material
      ,letra_tipo
      ,letra_nemotecnico
      ,str(codigo_moneda)+ '      ' + (SELECT mnnemo FROM VIEW_MONEDA WHERE codigo_moneda = mncodmon)
      ,letra_nominal
      ,str(rut_cliente) --+ '-' +(SELECT dv FROM LETRA_HIPOTECARIA_CLIENTE WHERE LETRA_HIPOTECARIA_CLIENTE.rut_cliente = LETRA_HIPOTECARIA.rut_cliente)
      ,codigo_cliente
      ,str(rut_emisor)  --+ '-' +(SELECT dv FROM LETRA_HIPOTECARIA_CLIENTE WHERE LETRA_HIPOTECARIA_CLIENTE.rut_cliente = LETRA_HIPOTECARIA.rut_emisor)
      ,codigo_emisor
      ,codigo_sucursal
      ,letra_condicion
      ,codigo_obligacion
      ,observacion
      ,letra_estado
      ,usuario
      FROM LETRA_HIPOTECARIA
      SET NOCOUNT OFF
END

GO
