USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTVALORESMONEDAS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTVALORESMONEDAS]
(
	@xFechaDesde CHAR(10),
	@xFechaHasta CHAR(10)
)
AS

BEGIN

	DECLARE @COUNT INT
	
	SET @COUNT = (SELECT COUNT(*) 
                    FROM VIEW_MDAC, VALOR_MONEDA, MONEDA 
                   WHERE VALOR_MONEDA.vmcodigo = MONEDA.mncodmon
                     AND VALOR_MONEDA.vmfecha  >= @xFechaDesde
                     AND VALOR_MONEDA.vmfecha  <= @xFechaHasta
                     AND MONEDA.mnmx           <> 'C'
                     AND MONEDA.mncodmon       <> 999)

	IF @COUNT <> 0

		BEGIN

			SELECT 'Nomemp'  = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales),
				   'Rutemp'  = ISNULL( ( RTRIM (CONVERT( CHAR(9), VIEW_MDAC.acrutprop ) ) + '-' + VIEW_MDAC.acdigprop ),'' ),
				   'fecpro'  = CONVERT(CHAR(10), VIEW_MDAC.acfecproc, 103),
				   'Codmon'  = ISNULL(CONVERT(NUMERIC(5,0), VALOR_MONEDA.vmcodigo),0),
				   'NomMon'  = ISNULL(MONEDA.mnglosa  ,''),
				   'Valor'   = ISNULL(VALOR_MONEDA.vmvalor,0.0),
				   'fecha'   = CONVERT(CHAR(10), VALOR_MONEDA.vmfecha, 103),
				   'hora'    = CONVERT(CHAR(10),GETDATE(),108) 
			  FROM VIEW_MDAC, VALOR_MONEDA, MONEDA 
			 WHERE VALOR_MONEDA.vmcodigo = MONEDA.mncodmon
			   AND VALOR_MONEDA.vmfecha  >= @xFechaDesde
			   AND VALOR_MONEDA.vmfecha  <= @xFechaHasta
			   AND MONEDA.mnmx           <> 'C'
			   AND MONEDA.mncodmon       <> 999
		  ORDER BY vmcodigo,vmfecha

		END

	ELSE

		BEGIN

			SELECT 'Nomemp'  = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales),
				   'Rutemp'  = '',
				   'fecpro'  = '',
				   'Codmon'  = 0,
				   'NomMon'  = '',
				   'Valor'   = 0,
				   'fecha'   = '',
				   'hora'    = '' 
		END




END

GO
