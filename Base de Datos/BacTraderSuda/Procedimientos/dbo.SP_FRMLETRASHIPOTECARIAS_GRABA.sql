USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FRMLETRASHIPOTECARIAS_GRABA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FRMLETRASHIPOTECARIAS_GRABA]
            (
             @codigo_planilla  NUMERIC (10) 
            ,@fecha_ingreso  DATETIME
            ,@letra_serie  VARCHAR (15)      
            ,@fecha_emision_nominal DATETIME     
            ,@fecha_emision_material DATETIME
            ,@letra_tipo  CHAR (1)      
            ,@letra_nemotecnico  VARCHAR (10)      
            ,@codigo_moneda  NUMERIC (3) 
            ,@letra_nominal  NUMERIC (19,4)
            ,@rut_cliente  NUMERIC (9) 
            ,@codigo_cliente  NUMERIC (9) 
            ,@rut_emisor  NUMERIC (9) 
            ,@codigo_emisor  NUMERIC (9) 
            ,@codigo_sucursal  VARCHAR (5)      
            ,@letra_condicion  CHAR (1)      
            ,@codigo_obligacion  VARCHAR (15)      
            ,@observacion  VARCHAR (60)      
            ,@letra_estado  CHAR (1)      
            ,@usuario          VARCHAR (15)      
            )
AS
BEGIN
      SET NOCOUNT ON
      IF NOT EXISTS ( SELECT 1 FROM LETRA_HIPOTECARIA WHERE codigo_planilla = @codigo_planilla ) BEGIN
            INSERT INTO LETRA_HIPOTECARIA 
            (
             codigo_planilla
            ,fecha_ingreso
            ,letra_serie
            ,fecha_emision_nominal
            ,fecha_emision_material
            ,letra_tipo
            ,letra_nemotecnico
            ,codigo_moneda
            ,letra_nominal
            ,rut_cliente
            ,codigo_cliente
            ,rut_emisor
            ,codigo_emisor
            ,codigo_sucursal
            ,letra_condicion
            ,codigo_obligacion
            ,observacion
            ,letra_estado
            ,usuario
            )
            VALUES
            (
             @codigo_planilla
            ,@fecha_ingreso
            ,@letra_serie
            ,@fecha_emision_nominal
            ,@fecha_emision_material
            ,@letra_tipo
            ,@letra_nemotecnico
            ,@codigo_moneda
            ,@letra_nominal
            ,@rut_cliente
            ,@codigo_cliente
            ,@rut_emisor
            ,@codigo_emisor
            ,@codigo_sucursal
            ,@letra_condicion
            ,@codigo_obligacion
            ,@observacion
            ,@letra_estado
            ,@usuario
            )
           SELECT 'INSERTA'
      END ELSE BEGIN
            UPDATE LETRA_HIPOTECARIA
            SET
             codigo_planilla             = @codigo_planilla
            ,fecha_ingreso             = @fecha_ingreso
            ,letra_serie             = @letra_serie
            ,fecha_emision_nominal     = @fecha_emision_nominal
            ,fecha_emision_material     = @fecha_emision_material
            ,letra_tipo                     = @letra_tipo
            ,letra_nemotecnico             = @letra_nemotecnico
            ,codigo_moneda             = @codigo_moneda
            ,letra_nominal             = @letra_nominal
            ,rut_cliente             = @rut_cliente
            ,codigo_cliente             = @codigo_cliente
            ,rut_emisor                     = @rut_emisor
            ,codigo_emisor             = @codigo_emisor
            ,codigo_sucursal             = @codigo_sucursal
            ,letra_condicion             = @letra_condicion
            ,codigo_obligacion             = @codigo_obligacion
            ,observacion             = @observacion
            ,letra_estado             = @letra_estado
            ,usuario                     = @usuario
           WHERE codigo_planilla = @codigo_planilla
           SELECT 'MODIFICA'
      END
      IF @@ERROR <> 0 BEGIN
            SELECT 'ERROR'
            
      END 
      SET NOCOUNT OFF
END 

GO
