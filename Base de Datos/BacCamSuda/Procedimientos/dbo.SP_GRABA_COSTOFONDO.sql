USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_COSTOFONDO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_COSTOFONDO]( @Entidad     CHAR(2)       ,
                                       @CostoCompra NUMERIC(19,4) ,
                                       @CostoVenta  NUMERIC(19,4) )
AS
BEGIN
     SET NOCOUNT ON
     DECLARE @Fecha_Actual CHAR(8)
     SELECT @Fecha_Actual = CONVERT(CHAR(8),acfecpro,112) FROM meac
     UPDATE meac 
        SET acCosComp = @CostoCompra
           ,acCosVent = @CostoVenta  
      WHERE acentida  = @Entidad
     IF @@error <> 0
        SELECT -1, 'No se pueden Grabar Costos de Fondo en Archivo de Control'
     INSERT INTO COSTODEFONDO
          VALUES (@Entidad 
                 ,@CostoCompra
                 ,@CostoVenta
                 ,CONVERT(CHAR(8),GETDATE(),108)
                 ,@Fecha_Actual
                 )
     IF @@error <> 0
        SELECT -1, 'No se pueden Grabar en Tabla Costos de Fondo'
END

GO
