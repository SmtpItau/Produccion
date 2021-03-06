USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_GRABA_DRV_MIDDLE_OFFICE]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_GRABA_DRV_MIDDLE_OFFICE]
	(	@MddMod								VARCHAR(3)
	,	@MddNumOpe							NUMERIC(10,0)
	,	@MddSujEarlyTerminationSN			CHAR(1)
	,	@MddSujEarlyTerminationFecha		DATETIME
	,	@MddSujEarlyTerminationPeriodo		NUMERIC(5,0)
	,	@MddTipPer							NUMERIC(5,0)
	,	@MddModRel							VARCHAR(3)
	,	@MddOpeRel							NUMERIC(10,0)
	,	@MddFecVcto							DATETIME
	)	
	
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @EXISTE INT
	SET @EXISTE = 0

	SELECT	@EXISTE =1
	FROM	TBL_RIEFIN_DRV_MIDDLE_OFFICE 
	WHERE	MddMod = @MddMod 
	AND		MddNumOpe = @MddNumOpe
	
	IF @EXISTE = 1 
	BEGIN
		
		UPDATE TBL_RIEFIN_DRV_MIDDLE_OFFICE
		SET 	MddSujEarlyTerminationSN		= @MddSujEarlyTerminationSN
		,		MddSujEarlyTerminationFecha		= @MddSujEarlyTerminationFecha
		,		MddSujEarlyTerminationPeriodo	= @MddSujEarlyTerminationPeriodo      
		,		MddTipPer						= @MddTipPer                            
		,		MddModRel						= @MddModRel
		,		MddOpeRel						= @MddOpeRel                            
		,		MddFecVcto						= @MddFecVcto
		
		WHERE	MddMod = @MddMod 
		AND		MddNumOpe = @MddNumOpe
			
		SELECT -1 , 'Registro actualizado'
		RETURN	
	END
					
	INSERT INTO TBL_RIEFIN_DRV_MIDDLE_OFFICE	
	(		MddMod 
	,		MddNumOpe                               
	,		MddSujEarlyTerminationSN 
	,		MddSujEarlyTerminationFecha 
	,		MddSujEarlyTerminationPeriodo           
	,		MddTipPer                               
	,		MddModRel 
	,		MddOpeRel                               
	,		MddFecVcto
	)	 

	VALUES	
	(		@MddMod								
	,		@MddNumOpe							
	,		@MddSujEarlyTerminationSN			
	,		@MddSujEarlyTerminationFecha		
	,		@MddSujEarlyTerminationPeriodo		
	,		@MddTipPer							
	,		@MddModRel							
	,		@MddOpeRel							
	,		@MddFecVcto							
	)	
END
SET NOCOUNT OFF
GO
