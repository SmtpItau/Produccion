USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_margenbanco_valorizarmargen]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_margenbanco_valorizarmargen]( @buffer	VARCHAR(2000))
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
	DECLARE	@cNumeroMargenPU	CHAR(20)
	DECLARE	@cNumeroItemPU		CHAR(2)



	SELECT	@nRutCli = CONVERT(NUMERIC(09), SUBSTRING(@buffer,15,9))


	SELECT 	@cod_servicio	= SUBSTRING(@buffer,1,5),
		@cod_err_serv	= SUBSTRING(@buffer,6,4),
		@cod_err_mq	= SUBSTRING(@buffer,10,4),
		@tipo_err_mq	= SUBSTRING(@buffer,13,1),
		@cDv		= SUBSTRING(@buffer,24,1)


	SELECT	@nMonto = 0


	IF (SELECT COUNT(*) FROM cliente WHERE CLRUT = @nRutCli) = 0 
	BEGIN
		SELECT	@cod_err_mq = '0010'
	END
	ELSE
	BEGIN

		SELECT 	top 1
			@cNumeroMargenPU = NumeroMargenPU,
			@cNumeroItemPU = NumeroItemPU
		FROM	CLIENTE
		WHERE	clrut = @nRutCli 



		IF LTRIM(RTRIM(@cNumeroMargenPU)) = '' OR LTRIM(RTRIM(@cNumeroItemPU))=''
		BEGIN
			SELECT	@cod_err_mq = '0025'
		END
		ELSE
		BEGIN

			SELECT	@nMonto = 0
	
			SELECT	@nMonto		= TotalOcupado
			FROM	linea_general
			WHERE	rut_cliente 	= @nRutCli


			IF @nMonto = 0
			BEGIN
				SELECT	@cod_err_mq = '0020'
			END


		END


	END

	SELECT 	@data =	REPLICATE('0',9-len(ltrim(rtrim(CONVERT(CHAR(9),@nRutCli))))) + LTRIM(RTRIM(CONVERT(CHAR(9),@nRutCli))) +
			ltrim(@cDv) +			
			REPLICATE('0',13-len(ltrim(RTRIM(CONVERT(CHAR(13),@nMonto))))) + lTRIM(RTRIM(CONVERT(CHAR(13),@nMonto))) +
			REPLICATE(' ',1963)


	SELECT	@buffer =	@cod_servicio	+
				@cod_err_serv	+
				@cod_err_mq	+
				@tipo_err_mq	+
				@data


	SELECT	@buffer


	SET NOCOUNT OFF

END



-- sp_margenbanco_valorizarmargen 'MAVAL000000000097080000K'

GO
