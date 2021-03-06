USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CALIDAD_JURIDICA]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_CALIDAD_JURIDICA](@icodigo_cal_juridica 	NUMERIC(5)	,		
 				        @idescripcion    	CHAR(40)	,
                                        @iCodigo_contable 	CHAR(3) 	,
					@sector			CHAR(10)	
					)	
AS
BEGIN
	
	SET DATEFORMAT DMY
	SET NOCOUNT ON


	DECLARE @descripcion_antigua 		CHAR(40),
                @codigo_contable_antiguo 	CHAR(3)	,
		@sector_antiguo			CHAR(10)


	SET NOCOUNT ON	
	
	IF EXISTS(SELECT  descripcion 
		  FROM CALIDAD_JURIDICA
		  WHERE Codigo_Calidad = @icodigo_cal_juridica)
	
	BEGIN	

		SELECT	@descripcion_antigua	= descripcion 			,
			@codigo_contable_antiguo = codigo_calidad_contable 	,
			@sector_antiguo		 = sector 
		FROM 	CALIDAD_JURIDICA
		WHERE 	Codigo_Calidad = @icodigo_cal_juridica

		IF (@descripcion_antigua <> @idescripcion OR @codigo_contable_antiguo <> @icodigo_contable OR @sector_antiguo <> @sector ) 
		BEGIN		

			UPDATE 	CALIDAD_JURIDICA
			SET 	descripcion 		= @idescripcion		,
				codigo_calidad_contable = @icodigo_contable	,
				sector			= @sector
			WHERE 	Codigo_Calidad = @icodigo_cal_juridica
		
		   SELECT 'MOD'
	
          END ELSE BEGIN

		   SELECT 'NO'		

      	  END		          
	
	END ELSE BEGIN
	  	
			INSERT INTO CALIDAD_JURIDICA
				(	Codigo_Calidad		,
					Descripcion		,
					codigo_calidad_contable	,
					sector
				)
			VALUES	(	@icodigo_cal_juridica	,
					@idescripcion		,
					@icodigo_contable	,
					@sector
				) 	

	   	   SELECT 'SI'	

	END
	 

END



GO
