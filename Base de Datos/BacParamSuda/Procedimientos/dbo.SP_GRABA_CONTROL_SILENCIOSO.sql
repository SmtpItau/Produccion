USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_CONTROL_SILENCIOSO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_GRABA_CONTROL_SILENCIOSO]  
 (  
  @codModulo CHAR(3),  
  @numOper NUMERIC(9),  
  @codProducto VARCHAR(5),  
  @tipoOp  CHAR(1),  
  @Plazo  INTEGER,  
  @Tasa  NUMERIC(19,4),  
  @Diferencia NUMERIC(19,4),  
  @Mensaje VARCHAR(255),  
  @BandaSuperior  NUMERIC(19,4),  
  @BandaInferior  NUMERIC(19,4),  
  @FechaProceso 	DATETIME,
  @Correlativo	NUMERIC(5) = 1
 )  
AS  
BEGIN  
  
	SET NOCOUNT ON
  
 IF @BandaSuperior IS NULL    
		SELECT @BandaSuperior = 0
  
 IF @BandaInferior IS NULL    
		SELECT @BandaSuperior = 0
  
	INSERT INTO Tbl_Control_Silencioso(codModulo, numOper, codProducto, tipoOp, Plazo, Tasa, Diferencia, Mensaje, FechaRegistro, BandaSuperior, BandaInferior, FechaProceso, Correlativo)
	VALUES(@codModulo, @numOper, @codProducto, @tipoOp, @Plazo, @Tasa, @Diferencia, @Mensaje, getdate(), @BandaSuperior, @BandaInferior, @FechaProceso, @Correlativo)
  
 SET NOCOUNT OFF  
END  
GO
