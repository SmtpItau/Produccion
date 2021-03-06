USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SISTEMAS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_SISTEMAS] 
	@SysFilter		AS varchar(80)
AS
BEGIN

-- EXEC SP_CON_SISTEMAS 'BFW,PCS,OPT,BCC'


DECLARE @lstCadena varchar(700)
DECLARE @lstDato varchar(7)
DECLARE @lnuPosComa int

CREATE TABLE #sistemasTemporal( id_sistema char(3) , nombre_sistema char(30) )


SET @lstCadena = @SysFilter

WHILE  LEN(@lstCadena)> 0
	BEGIN
		SET @lnuPosComa = CHARINDEX(',', @lstCadena ) -- Buscamos el caracter separador
		IF ( @lnuPosComa=0 )
		BEGIN
			SET @lstDato = @lstCadena
			SET @lstCadena = ''
		END
		ELSE
		BEGIN
			SET @lstDato = Substring( @lstCadena , 1  , @lnuPosComa-1)
			SET @lstCadena = Substring( @lstCadena , @lnuPosComa + 1 , LEN(@lstCadena))
		END
		

		INSERT INTO #sistemasTemporal (id_sistema,nombre_sistema) 
		(
			SELECT id_sistema , nombre_sistema 
				FROM   bacparamsuda..SISTEMA_CNT
				WHERE  operativo = 'S'
					AND    gestion   = 'N'
					AND id_sistema = ltrim(rtrim(@lstDato ))
		)


	--	PRINT 'Dato: ' + ltrim(rtrim(@lstDato ))



	END

	SELECT * FROM #sistemasTemporal


END
GO
