USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_FECHA_FERIADO]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CON_FECHA_FERIADO]
			(
			@nPais		NUMERIC(05)	,
			@nPlaza		NUMERIC(05)	,
			@dFecha		DATETIME	,
			@iBuscar	INTEGER		,
			@cHabil		CHAR(01) = 1    ,
                        @dFecha_Salida  DATETIME = 0    OUTPUT
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
        SET DATEFORMAT dmy
        SET NOCOUNT ON
	SET DATEFIRST 1

	DECLARE @dFecha_aux	DATETIME
	DECLARE @dFecha_Prox	DATETIME
	DECLARE @dFecha_Ult	DATETIME
	DECLARE @dFecha_Ant	DATETIME
	DECLARE @cEspecial	CHAR(01)

	IF @iBuscar = 1 BEGIN			-- ultimo dia del mes, Habil o FERIADO
		SELECT @dFecha_aux = @dFecha - (DAY(@dFecha) - 1)
		WHILE MONTH(@dFecha_aux) <= MONTH(@dFecha) AND YEAR(@dFecha_aux) <= YEAR(@dFecha) BEGIN
			IF NOT EXISTS(SELECT fecha FROM FERIADO WITH (NOLOCK)
							WHERE	plaza	= @nPlaza	AND
								pais 	= @nPais	AND
								fecha	= @dFecha_aux) BEGIN
				IF DATEPART(dw, @dFecha_aux) <> 6 AND DATEPART(dw, @dFecha_aux) <> 7 BEGIN
					SELECT @dFecha_Ult = @dFecha_aux
					SELECT @cEspecial  = 1
				END
			END
			SELECT 	@dFecha_aux = @dFecha_aux + 1
		END
		
		IF @cHabil = 1 BEGIN
                        SELECT @dFecha_Salida = @dFecha_Ult
			SELECT @dFecha_Ult, @cEspecial                        
		END ELSE BEGIN
			SELECT @dFecha_Ult = @dFecha_aux - 1
				IF NOT EXISTS(SELECT fecha FROM FERIADO WITH (NOLOCK)
								WHERE	plaza	= @nPlaza	AND
									pais 	= @nPais	AND
									fecha	= @dFecha_Ult) BEGIN
					SELECT @cEspecial = 1	-- es habil
				END ELSE BEGIN
					SELECT @cEspecial = 0	-- es FERIADO
				END

				IF ((DATEPART(dw, @dFecha_Ult) = 6) OR (DATEPART(dw, @dFecha_Ult) <> 7)) BEGIN
					SELECT @cEspecial  = 0
				END
                                SELECT @dFecha_Salida = @dFecha_Ult
				SELECT @dFecha_Ult, @cEspecial
			END
	END

	IF @iBuscar = 2 BEGIN			-- buscar proximo dia habil
		SELECT @dFecha_aux = @dFecha + 1

		WHILE @dFecha <= @dFecha_aux BEGIN
			IF NOT EXISTS(SELECT fecha FROM FERIADO WITH (NOLOCK)
							WHERE	plaza	= @nPlaza	AND
								pais 	= @nPais	AND
								fecha	= @dFecha_aux) BEGIN
				IF DATEPART(dw, @dFecha_aux) <> 6 AND DATEPART(dw, @dFecha_aux) <> 7 BEGIN
					SELECT @dFecha_Prox = @dFecha_aux
					BREAK
				END
			END
			SELECT 	@dFecha_aux = @dFecha_aux + 1
		END
                SELECT @dFecha_Salida = @dFecha_Prox
		SELECT @dFecha_Prox
	END

	IF @iBuscar = 3 BEGIN			-- Busca el dia anterior habil
		SELECT @dFecha_aux = @dFecha - 1
		WHILE @dFecha_aux <= @dFecha BEGIN
			IF NOT EXISTS(SELECT fecha FROM FERIADO WITH (NOLOCK)
							WHERE	plaza	= @nPlaza	AND
								pais 	= @nPais	AND
								fecha	= @dFecha_aux) BEGIN
				IF DATEPART(dw, @dFecha_aux) <> 6 AND DATEPART(dw, @dFecha_aux) <> 7 BEGIN
					SELECT @dFecha_Ant = @dFecha_aux
					BREAK
				END
			END
			SELECT 	@dFecha_aux = @dFecha_aux - 1
		END
                SELECT @dFecha_Salida = @dFecha_Ant
		SELECT @dFecha_Ant
	END


	IF @iBuscar = 4 BEGIN			-- Determina se la fecha ingresada es FERIADO o no
		IF NOT EXISTS(SELECT fecha FROM FERIADO WITH (NOLOCK)
						WHERE	plaza	= @nPlaza	AND
							pais 	= @nPais	AND
							fecha	= @dFecha) BEGIN
			SELECT @cEspecial = 1	-- es habil
		END ELSE BEGIN
			SELECT @cEspecial = 0	-- es feriado
		END

		IF ((DATEPART(dw, @dFecha) = 6) OR (DATEPART(dw, @dFecha) = 7)) BEGIN
			SELECT @cEspecial  = 0
		END
                SELECT @cEspecial     = @cEspecial
                SELECT @dFecha_Salida = @dFecha
		SELECT @cEspecial
	END

 	IF @iBuscar = 5 BEGIN			-- Determina el primer dia habil del mes
		SELECT @dFecha_aux = @dFecha - (DAY(@dFecha) - 1)
		SELECT @dFecha	   = @dFecha - (DAY(@dFecha) - 1)
		WHILE DAY(@dFecha_aux) < DAY(@dFecha) + 20 BEGIN
			IF NOT EXISTS(SELECT fecha FROM FERIADO WITH (NOLOCK)
							WHERE	plaza	= @nPlaza	AND
								pais 	= @nPais	AND
								fecha	= @dFecha_aux) BEGIN
				IF DATEPART(dw, @dFecha_aux) <> 6 AND DATEPART(dw, @dFecha_aux) <> 7 BEGIN
					BREAK
				END
			END
			SELECT 	@dFecha_aux = @dFecha_aux + 1
		END
		SELECT @dFecha_Salida = @dFecha_aux 
		SELECT @dFecha_aux 
	END


END







GO
