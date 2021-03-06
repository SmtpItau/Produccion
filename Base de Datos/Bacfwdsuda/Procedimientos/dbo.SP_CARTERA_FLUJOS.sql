USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERA_FLUJOS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CARTERA_FLUJOS] 
   (    	 @nnumoper   NUMERIC(10) 
   ) 
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @dFechaProceso DATETIME

	SELECT @dFechaProceso = acfecproc FROM BacFwdSuda..MFAC

	SELECT   Ctf_Fecha_Vencimiento ,
		 Ctf_Monto_Principal,
		 Ctf_Precio_Contrato,
		 Ctf_Tasa_Moneda_Principal,
		 Ctf_Tasa_Moneda_Secundaria,
		 Ctf_Valor_Razonable
	FROM BacFwdSuda..TBL_CARTERA_FLUJOS 
	WHERE Ctf_Numero_OPeracion = @nnumoper
	AND Ctf_Fecha_Vencimiento >= @dFechaProceso
	ORDER BY Ctf_Fecha_Vencimiento

	SET NOCOUNT OFF
END 

GO
