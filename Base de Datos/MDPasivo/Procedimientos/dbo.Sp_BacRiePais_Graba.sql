USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacRiePais_Graba]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacRiePais_Graba]( 
					@codigo			NUMERIC (5),
				       	@nombre			CHAR    (50),				    
				       	@porcentaje		NUMERIC (8,4),
				       	@totalasignado		NUMERIC (19),
				       	@totalocupado		NUMERIC (19),
				       	@totaldisponible 	NUMERIC (19),
				       	@totalexceso		NUMERIC (19)
									)


As

BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy


	IF NOT EXISTS (SELECT codigo_pais FROM RIESGO_PAIS WHERE codigo_pais=@codigo) BEGIN

		INSERT INTO RIESGO_PAIS ( 
					  codigo_pais,
					  nombre,
					  porcentaje,
					  totalasignado,
					  totalocupado,
					  totaldisponible,
					  totalexceso )
			    
				VALUES	( 
					  @codigo,
					  @nombre,	
					  @porcentaje,			
                                          @totalasignado,
					  @totalocupado,
					  @totaldisponible,
					  @totalexceso

							) 				


	END

	ELSE BEGIN

	        UPDATE RIESGO_PAIS SET porcentaje      = @porcentaje,
				       totalasignado   = @totalasignado,
                                       totaldisponible = @totaldisponible
				   WHERE
	
				       codigo_pais      = @codigo AND
				       nombre           = @nombre

	END


	SET NOCOUNT OFF
		        	
END





GO
