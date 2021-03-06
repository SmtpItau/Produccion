USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NGINE_ACTUALIZACION_ESTADO_PAGO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_NGINE_ACTUALIZACION_ESTADO_PAGO]
(
	@tbcategoria		NUMERIC	(4)		
	,@cSistema			VARCHAR(3)
	,@iNumOper			NUMERIC(9)  = 0
	,@cEstadoenvio		VARCHAR(3)	= ''
)AS
BEGIN
	UPDATE ep
	SET
		Envio	=	CASE 
								WHEN @tbcategoria = 9927 THEN 'SI'
							ELSE
								'NO'	--9926
							END
		,Estado =			CASE WHEN  @tbcategoria = 9927 THEN @cEstadoenvio
							ELSE
								'PP'	--9926
							END
	FROM NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO ep 
	WHERE
		Sistema					= @cSistema 
		AND Numero_operacion	= @iNumoper
END
GO
