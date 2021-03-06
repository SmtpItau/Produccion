USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_TasamConvencional_Graba]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_TasamConvencional_Graba]
		(	@codigom	numeric(5,0)	,
			@diasdesde	int		,
			@diashasta	int		,
			@montomin	float		,	
			@montomax	float		,
			@tasa		float
		)

AS
BEGIN
        SET NOCOUNT ON
 	--BEGIN TRANSACTION
	IF EXISTS(SELECT codigo_moneda FROM TASAS_MAXIMAS_CONVENCIONAL WHERE codigo_moneda	= @codigom 
										and diasdesde 		= @diasdesde
										and diashasta 		= @diashasta
										and montominimo 	= @montomin
										and montomaximo  	= @montomax
										and tasa 		= @tasa) 

		----BEGIN 
		----SELECT ''EXISTE ELIMINADO''
   		BEGIN
	   	DELETE FROM TASAS_MAXIMAS_CONVENCIONAL 
			WHERE	codigo_moneda	= @codigom
			and 	diasdesde 	= @diasdesde
			and 	diashasta 	= @diashasta
			and 	montominimo 	= @montomin
			and 	montomaximo  	= @montomax
			and 	tasa 		= @tasa
		    	----AND	DiasDesde	= @DiasDesde		
	   		IF @@ERROR <> 0 
	   			BEGIN
 	   			SELECT 'ERROR'
	   		END ELSE
	   			BEGIN
				SELECT 'ELIMINADO'
	   		END
	END
		
	----END ELSE
   	BEGIN
		INSERT INTO TASAS_MAXIMAS_CONVENCIONAL
			(codigo_moneda   ,
			diasdesde       ,
			diashasta       ,
			montominimo     ,
			montomaximo	,
			tasa )     
		   VALUES
			(@codigom        ,
			@diasdesde      ,
			@diashasta      ,
			@montomin       ,
			@montomax       ,
			@tasa)        

			IF @@error <> 0
			    	BEGIN
               	  		--ROLLBACK TRANSACTION
		              	SELECT 'NO ACTUALIZADO'
                		RETURN
	                END
			--COMMIT TRANSACTION
			BEGIN	
			SELECT 'OK'
			END
			
	END
	SET NOCOUNT OFF
END
GO
