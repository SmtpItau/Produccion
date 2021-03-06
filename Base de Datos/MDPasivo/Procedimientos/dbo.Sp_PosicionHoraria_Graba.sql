USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_PosicionHoraria_Graba]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_PosicionHoraria_Graba]
	       (@codigo_grupo		varchar	(5),	     	     
		@porcentaje		numeric	(10,4),
		@totalposicion		numeric	(19,4),
		@totalocupado		numeric	(19,4),
		--@totalcompra		numeric	(19,4),
		--@totalventa		numeric	(19,4),
		@totaldisponible	numeric	(19,4),
		@totalexcedido		numeric	(19,4))
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
		IF EXISTS(SELECT codigo_grupo FROM POSICION_GRUPO WHERE @codigo_grupo= codigo_grupo)
			
			BEGIN

			UPDATE POSICION_GRUPO SET

				codigo_grupo	= @codigo_grupo,
				porcentaje	= @porcentaje,
				totalposicion	= @totalposicion,
				totalocupado	= @totalocupado,
				totaldisponible	= @totaldisponible,
				totalexcedido	= @totalexcedido
					where @codigo_grupo= codigo_grupo

		
			END			

		ELSE
			
			BEGIN

			INSERT INTO POSICION_GRUPO

		                       (codigo_grupo,
					porcentaje,
					totalposicion,
					totalocupado,
					totalcompra,
					totalventa,
					totaldisponible,
					totalexcedido)
				
				VALUES
				       (@codigo_grupo,
					@porcentaje,
					@totalposicion,
					@totalocupado,
					0,--totalcompra,
					0,--totalventa,
					@totaldisponible,
					@totalexcedido)

		END

END



GO
