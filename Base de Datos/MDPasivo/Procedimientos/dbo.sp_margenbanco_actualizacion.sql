USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_margenbanco_actualizacion]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_margenbanco_actualizacion](	@buffer	VARCHAR(2000)	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE	@cod_servicio		CHAR(05),
		@cod_err_serv		CHAR(04),
		@cod_err_mq		CHAR(04),
		@tipo_err_mq		CHAR(01),
		@data			VARCHAR(1986)



	DECLARE	@nRutCli		NUMERIC(09)
	DECLARE	@cDv			CHAR(1)
	DECLARE	@nMonto			NUMERIC(19)
	DECLARE	@cNumeroMargenPU_Actual	CHAR(20)
	DECLARE	@cNumeroMargenPU_Nuevo	CHAR(20)
	DECLARE	@cNumeroItemPU		CHAR(2)
	DECLARE	@cAccion		CHAR(1)
	DECLARE	@cNumeroMargenPU	CHAR(20)



	SELECT	@nRutCli = CONVERT(NUMERIC(09), SUBSTRING(@buffer,15,9))



	SELECT 	@cod_servicio		= SUBSTRING(@buffer,1,5),
		@cod_err_serv		= SUBSTRING(@buffer,6,4),
		@cod_err_mq		= SUBSTRING(@buffer,10,4),
		@tipo_err_mq		= SUBSTRING(@buffer,13,1),
		@cDv			= SUBSTRING(@buffer,24,1),
		@cNumeroMargenPU_Actual	= SUBSTRING(@buffer,25,20),
		@cNumeroMargenPU_Nuevo	= SUBSTRING(@buffer,45,20),
		@cNumeroItemPU		= SUBSTRING(@buffer,65,2),
		@cAccion		= SUBSTRING(@buffer,67,1)



	SELECT	@cNumeroMargenPU = ''



	IF (SELECT COUNT(*) FROM cliente WHERE CLRUT = @nRutCli) = 0 
	BEGIN
		SELECT	@cod_err_mq = '0010'
	END
	ELSE
	BEGIN

		IF @cAccion = 'R'
		BEGIN
			UPDATE	cliente
			SET	NumeroMargenPU	= @cNumeroMargenPU_Nuevo,
				NumeroItemPU	= @cNumeroItemPU
			WHERE	clrut = @nRutCli

			SELECT	@cNumeroMargenPU = @cNumeroMargenPU_Nuevo
		END


		IF @cAccion = 'C'
		BEGIN
			UPDATE	cliente
			SET	NumeroMargenPU	= @cNumeroMargenPU_Actual,
				NumeroItemPU	= @cNumeroItemPU
			WHERE	clrut = @nRutCli

			SELECT	@cNumeroMargenPU = @cNumeroMargenPU_Actual
		END


		IF @cAccion = 'E'
		BEGIN
			UPDATE	cliente
			SET	NumeroMargenPU	= '',
				NumeroItemPU	= ''
			WHERE	clrut = @nRutCli

			SELECT	@cNumeroMargenPU = ''
		END




	END



	SELECT 	@data =	REPLICATE('0',9-len(ltrim(rtrim(CONVERT(CHAR(9),@nRutCli))))) + LTRIM(RTRIM(CONVERT(CHAR(9),@nRutCli))) +
			ltrim(@cDv) +			
			@cNumeroMargenPU +
			@cNumeroItemPU + 
			@cAccion +
			REPLICATE(' ',1967)

	SELECT	@buffer =	@cod_servicio	+
				@cod_err_serv	+
				@cod_err_mq	+
				@tipo_err_mq	+
				@data


	SELECT	@buffer





	SET NOCOUNT OFF

END

-- dbo.sp_margenbanco_actualizacion 'MAACM000000000097080000K123456789012345678901234567890123456789099R'
--12345678901234567890
--
--SELECT 	NumeroMargenPU, NumeroItemPU FROM CLIENTE WHERE	clrut = 97080000


GO
