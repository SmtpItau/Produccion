USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIMONEDAS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DIMONEDAS]
   (   @rutcart1     numeric(09,0)
   ,   @paretipoper  char(03) 
   ,   @parenumcart  numeric(09,0)
   )
AS
BEGIN

	SET NOCOUNT ON

   DECLARE @dFechaPro   DATETIME

   SELECT  @dFechaPro   = acfecproc
   FROM    MDAC

	SET  @dFechaPro   = ( SELECT  acfecproc   FROM    MDAC)
  
   IF @paretipoper = 'VP'
		SELECT DISTINCT mnnemo as Nemotecnico
		FROM MDDI
		INNER	JOIN VIEW_MONEDA ON mnnemo = dinemmon 
		WHERE	dirutcart = @rutcart1 
		AND	dinominal > 0
		AND	ditipoper ='CP'
		AND	ditipcart = @parenumcart
		AND	Estado_Operacion_Linea =''		 
--		AND	SUBSTRING(diserie, 1, 3 ) <> 'DPX'
   ELSE
		SELECT	DISTINCT mnnemo as Nemotecnico
		FROM	MDDI 
		INNER JOIN VIEW_MONEDA ON mnnemo    = dinemmon 
		WHERE	dirutcart		= @rutcart1 
		AND	dinominal		> 0
		AND	ditipcart 		= @parenumcart
		AND	Estado_Operacion_Linea	=''		 
		AND	(digenemi  <> 'BCO' OR diserie <> 'LCHR')
--		AND	SUBSTRING(diserie, 1, 3 ) <> 'DPX'
		AND	Fecha_PagoMañana	<= @dFechaPro
END
GO
