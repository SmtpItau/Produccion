USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_grabar_P36]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_grabar_P36] (@Nombre_serie 		VARCHAR(15),
				    @Clasificadora_de_Riesgo_1 	NUMERIC(03),
				    @Clasificacion_de_Riesgo_1 	VARCHAR(05),
				    @Clasificadora_de_Riesgo_2 	NUMERIC(03),
				    @Clasificacion_de_Riesgo_2 	VARCHAR(05),
				    @Numero_de_inscripcion     	VARCHAR(15),
				    @Fecha_de_inscripcion      	VARCHAR(15),
				    @Fecha_límite_para_la_colocacion VARCHAR(15),
				    @Monto_inscrito 		numeric(14),
				    @gasto_fact 		numeric(14))
AS
BEGIN

SET NOCOUNT ON

      /*****************************************************************
      CREADO
      AUTOR : Juan Pablo Lizama
      FECHA : 19/12/2007
      MOTIVO: Procedimiento encargado de grabar bono existente en la tabla_P36
      *****************************************************************/

SET @Numero_de_inscripcion = LEFT(@Numero_de_inscripcion,LEN(@Numero_de_inscripcion)- 1)


IF EXISTS(SELECT * FROM TABLA_P36 WHERE Nombre_serie = @Nombre_serie ) BEGIN 
--AND Numero_de_inscripcion= @Numero_de_inscripcion
	
		UPDATE TABLA_P36
		SET 	Nombre_serie = @Nombre_serie, 		
			Clasificadora_de_Riesgo_1 = @Clasificadora_de_Riesgo_1, 	
			Clasificacion_de_Riesgo_1 = @Clasificacion_de_Riesgo_1,	
			Clasificadora_de_Riesgo_2 = @Clasificadora_de_Riesgo_2, 	
			Clasificacion_de_Riesgo_2 = @Clasificacion_de_Riesgo_2, 	
			Numero_de_inscripcion	  = @Numero_de_inscripcion,     	
			Fecha_de_inscripcion	  = @Fecha_de_inscripcion,      	
			Fecha_límite_para_la_colocacion	 = @Fecha_límite_para_la_colocacion, 
			Monto_inscrito = @Monto_inscrito,
			gasto_col_ult_mes = @gasto_fact
		WHERE	Nombre_serie = @Nombre_serie --AND 
--			Numero_de_inscripcion= @Numero_de_inscripcion	


			SELECT 'Grabación procesada correctamente'
 
END

ELSE BEGIN

		IF EXISTS(SELECT * FROM VIEW_SERIE_PASIVO WHERE Nombre_serie = @Nombre_serie ) BEGIN
		
			INSERT INTO TABLA_P36 VALUES(@Nombre_serie,
						     @Clasificadora_de_Riesgo_1,
						     @Clasificacion_de_Riesgo_1,
						     @Clasificadora_de_Riesgo_2,
						     @Clasificacion_de_Riesgo_2,
						     @Numero_de_inscripcion,
						     @Fecha_de_inscripcion,
						     @Fecha_límite_para_la_colocacion,
						     @Monto_inscrito,
						     @gasto_fact)

			SELECT 'Grabación procesada correctamente'
		END

		ELSE BEGIN

			SELECT 'Error', 'No se encontró nombre de serie en la tabla serie pasivo'
		END
				

END

END

--select * from tabla_p36

--delete tabla_p36 where nombre_serie='BBDES-B6'



--sp_helptext sp_interfaz_P36





GO
