USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NGINE_BUSCA_CODIGO_ESTADO_PAGO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_NGINE_BUSCA_CODIGO_ESTADO_PAGO]
(
	@numoper		NUMERIC(10)
	,@nemo			VARCHAR(10)
	,@tbcateg		NUMERIC(4)
)AS
BEGIN
DECLARE
	@tbcodigo1 varchar(6)
	,@tbcodigo2 varchar(6)

	SELECT @tbcodigo1 = tbcodigo1
	FROM 
		bacparamsuda..NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO ep
		INNER JOIN bacparamsuda..TABLA_GENERAL_DETALLE tg
			on ep.Estado = tg.nemo
	WHERE Numero_operacion = @numoper
	
	SELECT @tbcodigo2 = tbcodigo1
	FROM
		bacparamsuda..tabla_general_detalle 
	WHERE tbcateg in (@tbcateg) and nemo = @nemo



	IF (@tbcodigo1 = @tbcodigo2)
		SELECT 'Valida'='OK'
	ELSE
		SELECT 'Valida'='NOK'
END
GO
