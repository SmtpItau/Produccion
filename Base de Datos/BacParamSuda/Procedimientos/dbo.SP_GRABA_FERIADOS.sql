USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_FERIADOS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_FERIADOS] (@fer_id			NUMERIC,
										@origen_pais	INT,
										@nemo			VARCHAR(6),
										@descripcion	VARCHAR(200),
										@dia			INT,
										@mes			INT,
										@comportamiento	VARCHAR(200),
										@reglas			INT,
										@estado			VARCHAR(15),
										@opcion			INT)
 AS
 BEGIN
 
	IF @opcion=1 
	BEGIN
		INSERT INTO dbo.TBL_FestivosFijos VALUES(
					@origen_pais,
					@nemo,
					@descripcion,
					@dia,
					@mes,
					@comportamiento,
					@reglas,
					@estado)		
	END   

	IF @opcion=2
	BEGIN
		UPDATE dbo.TBL_FestivosFijos SET
				fer_nemo=@nemo,
				fer_descripcion=@descripcion,
				fer_dia_feriado=@dia,
				fer_mes=@mes,
				fer_comportamiento_especial=@comportamiento,
				fer_cod_regla_ajuste=@reglas,
				fer_estado=@estado
		WHERE fer_origen_pais=@origen_pais
		AND fer_id=@fer_id
	END
	
 END

GO
