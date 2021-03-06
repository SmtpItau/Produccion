USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COSTOS_COMEX_IBS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================================
-- Author		:	ASVG - Manuel Correa
-- Create date	:	20111013
-- Description	:	Obtiene los valores de spread
--					correspondientes según la operación y el monto
-- Test Case	:	
--	20110926 Procedimiento para obtener los datos asociados a los segmentos de IBS.
--	SELECT * FROM COSTOS_COMEX_IBS
--	exec SP_COSTOS_COMEX_IBS 'C','20110314',12,'GGEE',13
--	exec SP_COSTOS_COMEX_IBS 'V','20110314',12,'GGEE',13
--	exec SP_COSTOS_COMEX_IBS 'V','20110314',12345,'GGEE',13
-- ======================================================================

CREATE PROCEDURE [dbo].[SP_COSTOS_COMEX_IBS]
	(
		@CompVenta      CHAR(1),
		@Fecha          CHAR(8),
		@Monto          NUMERIC(18,4),
		@nemo		VARCHAR(6),
		@iMoneda	INT = 13
	)
AS
BEGIN    

 SET NOCOUNT ON

SELECT
	  Fecha
	, NEMO as NEMO_Segmento
	, Segmento as GLOSA_Segmento
	, CODMONEDA
	, MONTOMAX
	, SpreadTrading		=	case	when @CompVenta = 'C' then SPREAD_TRADING_COMPRA
					when @CompVenta = 'V' then SPREAD_TRADING_VENTA
					end
	, SpreadComercial	=	case	when @CompVenta = 'C' then SPREAD_COMPRA
					when @CompVenta = 'V' then SPREAD_VENTA
					end
	, ENTRE_DESDE
	, ENTRE_HASTA

  FROM
	COSTOS_COMEX_IBS

  WHERE
		Fecha		= @Fecha
      AND	nemo		= @nemo
      AND	@Monto		BETWEEN Entre_Desde AND Entre_Hasta
      AND	CodMoneda	= @iMoneda

END
GO
