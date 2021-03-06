USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTESPORTIPO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CLIENTESPORTIPO]
(
	 @tipoCliente	NUMERIC(5,0) = 0
	,@nomCliente	VARCHAR(70) = ''
	,@maximo		NUMERIC(5,0) = 0
)
AS
BEGIN
	SET NOCOUNT ON

	IF @maximo > 0
		SET ROWCOUNT 50
	
	IF LEN(LTRIM(@nomCliente)) > 0
		SELECT clrut
		,      cldv
		,      clcodigo
		,      clnombre
		,      clgeneric
		,      cldirecc
		,      clcomuna
		,      clregion
		,      clcompint
		,      cltipcli
		,      clfecingr
		,      clctacte
		,      clfono
		,      clfax
		,      mxcontab
		,      clpais
		,      clciudad
		,      clswift
		FROM   CLIENTE
		WHERE ( cltipcli  = @tipoCliente OR @tipoCliente = 0 )
		AND clnombre >= LTRIM(@nomCliente)
		AND clvigente = 'S'
		ORDER BY clnombre	
	ELSE
		SELECT clrut
		,      cldv
		,      clcodigo
		,      clnombre
		,      clgeneric
		,      cldirecc
		,      clcomuna
		,      clregion
		,      clcompint
		,      cltipcli
		,      clfecingr
		,      clctacte
		,      clfono
		,      clfax
		,      mxcontab
		,      clpais
		,      clciudad
		,      clswift
		FROM   CLIENTE
		WHERE ( cltipcli  = @tipoCliente OR @tipoCliente = 0 )
		AND clvigente = 'S'
		ORDER BY clnombre
	
	SET ROWCOUNT 0
	SET NOCOUNT OFF
END
GO
