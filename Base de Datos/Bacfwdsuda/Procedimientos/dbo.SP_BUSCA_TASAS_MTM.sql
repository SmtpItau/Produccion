USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_TASAS_MTM]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_BUSCA_TASAS_MTM]( @Moneda NUMERIC(4) )
AS
BEGIN

 SELECT Moneda,
	--Plazo_Ini,
	Plazo_Fin,
	Tasa,
	--Spread,
	fSpotCom,
	fSpotVen

  FROM MF_TASAS_MTM
  WHERE Moneda = @Moneda
  ORDER BY Plazo_Fin               -- <== ORDENAR POR PLAZO FIN !!!!

END




GO
