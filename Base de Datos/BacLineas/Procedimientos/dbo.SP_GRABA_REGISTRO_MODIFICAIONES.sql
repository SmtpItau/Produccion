USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_REGISTRO_MODIFICAIONES]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GRABA_REGISTRO_MODIFICAIONES]
	(	@FechaModificacion	DATETIME
	,	@Modulo				CHAR(3)
	,	@FolioContrato		NUMERIC(10)
	,	@FolioCotizacion	NUMERIC(10)
	,	@FolioModificacion	NUMERIC(10)
	,	@Items				VARCHAR(20)
	,	@DatosOriginales	VARCHAR(155)
	,	@DatosNuevos		VARCHAR(155)
	,	@Correlativo		NUMERIC(9)
	)
AS
BEGIN
	
	SET NOCOUNT ON

	IF @FolioModificacion = 0 
	BEGIN
		IF EXISTS( SELECT 1 FROM dbo.TBL_MODIFICACIAONES WHERE Modulo = @Modulo AND FolioContrato = @FolioContrato )
		BEGIN
			SET @FolioModificacion = ( SELECT MAX( FolioModificacion ) 
										 FROM dbo.TBL_MODIFICACIAONES 
					                    WHERE Modulo		= @Modulo 
										  AND FolioContrato = @FolioContrato )
		END
		SET @FolioModificacion = @FolioModificacion + 1
	END

	

	--INSERT INTO dbo.TBL_MODIFICACIAONES
	--SELECT	FechaModificacion	= @FechaModificacion 
	--	,	Modulo				= @Modulo 
	--	,	FolioContrato		= @FolioContrato
	--	,	FolioCotizacion		= @FolioCotizacion 
	--	,	FolioModificacion	= @FolioModificacion 
	--	,	Correlativo			= @Correlativo
	--	,	Items				= @Items 
	--	,	DatosOriginales		= @DatosOriginales 
	--	,	DatosNuevos			= @DatosNuevos 			


	IF EXISTS(SELECT 1
	            FROM dbo.TBL_MODIFICACIAONES 
			   WHERE FechaModificacion  = @FechaModificacion
			     AND Modulo             = @Modulo
				 AND FolioContrato      = @FolioContrato
				 AND FolioModificacion  = @FolioModificacion
				 AND Correlativo        = @Correlativo
				 AND Items				= @Items) BEGIN

		 UPDATE dbo.TBL_MODIFICACIAONES
		    SET DatosOriginales	   = @DatosOriginales 
		       ,DatosNuevos		   = @DatosNuevos 	
		  WHERE FechaModificacion  = @FechaModificacion
		    AND Modulo             = @Modulo
		    AND FolioContrato      = @FolioContrato
			AND FolioModificacion  = @FolioModificacion
			AND Correlativo        = @Correlativo
			AND Items			   = @Items
 
	 END
	 ELSE BEGIN


	     INSERT INTO dbo.TBL_MODIFICACIAONES
	     SELECT	FechaModificacion	= @FechaModificacion 
	     	,	Modulo				= @Modulo 
	     	,	FolioContrato		= @FolioContrato
	     	,	FolioCotizacion		= @FolioCotizacion 
	     	,	FolioModificacion	= @FolioModificacion 
	     	,	Correlativo			= @Correlativo
	     	,	Items				= @Items 
	     	,	DatosOriginales		= @DatosOriginales 
	     	,	DatosNuevos			= @DatosNuevos 	


	 END


	SELECT @FolioContrato , @FolioCotizacion , @FolioModificacion 
	
END
GO
