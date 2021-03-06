USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIFAMILIAS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DIFAMILIAS]
   (   @rutcart1     NUMERIC(09,0)  
   ,   @parestipoper CHAR(03) 
   ,   @parenumcart  NUMERIC(09,00)
   )
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @dFechaPro   DATETIME

	SET  @dFechaPro   = ( SELECT  acfecproc   FROM    MDAC)

	IF  @parestipoper = 'VP'
		SELECT DISTINCT inserie  as Serie
      		FROM	MDDI 
	 		INNER  JOIN VIEW_INSTRUMENTO ON inserie = diserie 
		WHERE	dirutcart		= @rutcart1 
      		AND	dinominal		> 0
      		AND	ditipoper		='CP'
      		AND	ditipcart		= @parenumcart
		AND	Estado_Operacion_Linea	=''		 
--		AND	SUBSTRING(diserie,1,3)	<> 'DPX'				
	ELSE
		SELECT DISTINCT inserie  as Serie
		FROM 	MDDI 
		INNER JOIN VIEW_INSTRUMENTO ON inserie   = diserie 
		WHERE	dirutcart		= @rutcart1 
		AND	ditipoper		='CP'
		AND	dinominal		> 0
		AND	ditipcart		= @parenumcart
		AND	Estado_Operacion_Linea	=''		 
		AND	(digenemi  <> 'BCO' or diserie <> 'LCHR')
--		AND	SUBSTRING(diserie,1,3) <> 'DPX'
		AND	Fecha_PagoMañana	<= @dFechaPro				

END
GO
