USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_VALOR_MERCADO]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_VALOR_MERCADO]
( 
                @NumeroOperacion 	NUMERIC(10, 0), 
		@NumeroDocumento 	NUMERIC(10, 0),
		@NumeroCorrelativo 	NUMERIC(10, 0),
		@Id_Sistema 		CHAR (3),
		@Codigo_Grupo 		CHAR (10),
		@valMercado		NUMERIC(18, 4) OUTPUT
)
AS

BEGIN

        SET NOCOUNT OFF
        SET DATEFORMAT dmy


	SET @valMercado=0


	SET NOCOUNT ON

END




GO
