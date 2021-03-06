USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PLANILLAOPERACION]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Graba_PlanillaOperacion    fecha de la secuencia de comandos: 03/04/2001 15:18:04 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Graba_PlanillaOperacion    fecha de la secuencia de comandos: 14/02/2001 09:58:26 ******/
CREATE PROCEDURE [dbo].[SP_GRABA_PLANILLAOPERACION](
                                             @tipo_documento        NUMERIC(1),
                                             @tipo_operacion_cambio NUMERIC(3),
                                             @comercio      CHAR(6),
                                             @concepto      CHAR(3),
                                             @condicion             VARCHAR(10)
                                           )
AS
BEGIN
set nocount on
     IF NOT EXISTS (SELECT 1 FROM CODIGO_PLANILLA_AUTOMATICA WHERE condicion = @condicion)
        BEGIN
             PRINT '<< Agregando >>'
             INSERT INTO CODIGO_PLANILLA_AUTOMATICA(fecha    , tipo_documento, tipo_operacion_cambio, comercio, concepto, condicion)
                                      VALUES(GETDATE(),@tipo_documento,@tipo_operacion_cambio,@comercio,@concepto,@condicion)
             IF @@error <> 0 
             BEGIN
                  SELECT -1,'No se puede Agregar esta Condicion'
                  RETURN
             END
        END
     ELSE
        BEGIN
             PRINT 'Actualizando Datos de Condicion ...'
             UPDATE CODIGO_PLANILLA_AUTOMATICA
                SET tipo_documento        = @tipo_documento       ,
                    tipo_operacion_cambio = @tipo_operacion_cambio,
                    comercio              = @comercio             ,
                    concepto    = @concepto
              WHERE condicion = @condicion
             IF @@error <> 0 
             BEGIN
                  SELECT -1,'No se puede Actualizar esta Condicion'
                  RETURN
             END
 END
select 0
set nocount off
END
GO
