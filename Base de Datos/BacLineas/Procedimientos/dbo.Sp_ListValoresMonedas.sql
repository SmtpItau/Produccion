USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ListValoresMonedas]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[Sp_ListValoresMonedas]
                  (@xFechaDesde CHAR(10),@xFechaHasta CHAR(10))
AS
BEGIN

 	SELECT 	'Nomemp'  = ISNULL(VIEW_MDAC.acnomprop,''),
		'Rutemp'  = ISNULL( ( RTRIM (CONVERT( CHAR(9), VIEW_MDAC.acrutprop ) ) + "-" + VIEW_MDAC.acdigprop ),"" ),
        	'fecpro'  = CONVERT(CHAR(10), VIEW_MDAC.acfecproc, 103),
		'Codmon'  = ISNULL(CONVERT(NUMERIC(5,0), VALOR_MONEDA.vmcodigo),0),
        	'NomMon'  = ISNULL(MONEDA.mnglosa  ,''),
        	'Valor'   = ISNULL(VALOR_MONEDA.vmvalor,0.0),
        	'fecha'   = CONVERT(CHAR(10), VALOR_MONEDA.vmfecha, 103),
                'hora'    = CONVERT(CHAR(10),GETDATE(),108)
 			
	FROM   VIEW_MDAC, VALOR_MONEDA, MONEDA 
 	WHERE  VALOR_MONEDA.vmcodigo  	= MONEDA.mncodmon
	AND    VALOR_MONEDA.vmfecha 	>= @xFechaDesde
	AND    VALOR_MONEDA.vmfecha  	<= @xFechaHasta
        AND    MONEDA.mnmx     		<> "C"
        AND    MONEDA.mncodmon 		<> 999
 	ORDER by vmcodigo,vmfecha

END











GO
