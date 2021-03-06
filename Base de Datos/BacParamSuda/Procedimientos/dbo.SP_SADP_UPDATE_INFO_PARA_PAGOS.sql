USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_UPDATE_INFO_PARA_PAGOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_UPDATE_INFO_PARA_PAGOS]
	( @iNumOperacion NUMERIC(10),@sistema VARCHAR(4), @vTransferencia VARCHAR(20),@smensaje VARCHAR(30))
AS
BEGIN
		IF @sistema ='FFMM' 
		BEGIN
			IF EXISTS(SELECT 1 FROM bacparamsuda.dbo.SADP_RESCATES_PAGO WHERE idFolio = @iNumOperacion)
			BEGIN 
				UPDATE bacparamsuda.dbo.SADP_RESCATES_PAGO 
				   SET estado ='A' 
				,      sNumTransferencia = @vTransferencia
				 WHERE idFolio = @iNumOperacion
			END
		END 
		
		IF EXISTS(SELECT 1 FROM bacparamsuda.dbo.SADP_DETALLE_PAGOS WHERE Id_Detalle_Pago = @iNumOperacion)
		BEGIN					
			UPDATE bacparamsuda.dbo.SADP_DETALLE_PAGOS 
			   SET	vNumTransferencia = @vTransferencia  
			,		cObservaciones	  = @smensaje
			WHERE cModulo		  = @sistema 
			  AND Id_Detalle_Pago = @iNumOperacion
		END
	
		IF (@@ERROR<>0) 
			SELECT -1
		ELSE 
			SELECT 0		 	
END
GO
