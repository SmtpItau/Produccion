USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_buscar_P36]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_buscar_P36] (@Nombre_serie VARCHAR(15), @Numero_de_inscripcion VARCHAR(15))
AS
BEGIN

SET NOCOUNT ON

      /*****************************************************************
      CREADO
      AUTOR : Juan Pablo Lizama
      FECHA : 19/12/2007
      MOTIVO: Procedimiento encargado de buscar bono existente en la tabla_P36
      *****************************************************************/
SET @Numero_de_inscripcion = LEFT(@Numero_de_inscripcion,LEN(@Numero_de_inscripcion)- 1)


		IF EXISTS(SELECT * FROM TABLA_P36 WHERE Nombre_serie = @Nombre_serie  ) BEGIN
		--AND Numero_de_inscripcion = @Numero_de_inscripcion
			
			SELECT 	Nombre_serie,
			    	Clasificadora_de_Riesgo_1,
				Clasificacion_de_Riesgo_1,
			 	Clasificadora_de_Riesgo_2,
		 		Clasificacion_de_Riesgo_2,
		 		Numero_de_inscripcion,
				CONVERT(VARCHAR(10),CONVERT(DATETIME,Fecha_de_inscripcion),103), 
				CONVERT(VARCHAR(10),CONVERT(DATETIME,Fecha_límite_para_la_colocacion),103),
		 		Monto_inscrito,
				gasto_col_ult_mes
			FROM 	TABLA_P36
			WHERE Nombre_serie = @Nombre_serie 
		--	AND   Numero_de_inscripcion = @Numero_de_inscripcion   
		
		END
		ELSE BEGIN
				IF not EXISTS(SELECT * FROM VIEW_SERIE_PASIVO WHERE Nombre_serie = @Nombre_serie  ) BEGIN
					SELECT 'Error', 'No se encuentra información para ese nombre de serie en la base de datos'
				END
		END

END



GO
