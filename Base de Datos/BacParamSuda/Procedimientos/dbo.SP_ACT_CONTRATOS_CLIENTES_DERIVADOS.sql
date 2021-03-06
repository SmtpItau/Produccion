USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CONTRATOS_CLIENTES_DERIVADOS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ACT_CONTRATOS_CLIENTES_DERIVADOS] (	@Sistema	CHAR(10)
							 ,	@RutCli		NUMERIC(9,0)
							 ,	@CodCli		INTEGER
							 ,	@CodDctoPrinc	CHAR(10)
						 	 ,	@CodDcto	CHAR(10)
							 )
AS
BEGIN

	SET NOCOUNT ON

        IF EXISTS( SELECT 1 FROM TBL_CLIENTE_CONTRATO_DERIVADOS WHERE Cod_Sistema    = @Sistema AND Rut_Cliente    = @RutCli
                                                                  AND Codigo_Cliente = @CodCli  AND Cod_Dcto_Princ = @CodDctoPrinc
                                                                  AND Codigo         = @CodDcto)
        BEGIN
            DELETE FROM TBL_CLIENTE_CONTRATO_DERIVADOS
                  WHERE Cod_Sistema    = @Sistema AND Rut_Cliente    = @RutCli
                  AND   Codigo_Cliente = @CodCli  AND Cod_Dcto_Princ = @CodDctoPrinc
                  AND   Codigo         = @CodDcto
        END

	INSERT INTO TBL_CLIENTE_CONTRATO_DERIVADOS
	(	Cod_Sistema
	,	Rut_Cliente
	,	Codigo_Cliente 
	,	Cod_Dcto_Princ
	,	Codigo
	)
	VALUES
	(	@Sistema
	,	@RutCli
	,	@CodCli
	,	@CodDctoPrinc
	,	@CodDcto
	)


END
GO
