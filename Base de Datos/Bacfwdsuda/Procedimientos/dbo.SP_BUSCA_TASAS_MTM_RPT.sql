USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_TASAS_MTM_RPT]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_BUSCA_TASAS_MTM_RPT](@Tipo char(1) , @CodMoneda NUMERIC(4))
AS
IF @Tipo='T'
  BEGIN	
 SELECT tas.moneda,
	mon.mnglosa,
--	tas.Plazo_Ini,
	tas.Plazo_Fin,
	tas.Tasa,
--	tas.Spread,
	'SpotCompra'=isnull(tas.fSpotCom,0),
	'SpotVenta'=isnull(tas.fSpotVen,0)
   FROM MF_TASAS_MTM tas, 
	view_moneda mon      	
   WHERE tas.moneda=mon.mncodmon
   ORDER BY tas.moneda,Plazo_Fin   -- Idem problema !!
   END	
ELSE
  BEGIN
 SELECT tas.moneda,
	mon.mnglosa,
--	tas.Plazo_Ini,
	tas.Plazo_Fin,
	tas.Tasa,
--	tas.Spread,
	'SpotCompra'=isnull(tas.fSpotCom,0),
	'SpotVenta'=isnull(tas.fSpotVen,0)
   FROM MF_TASAS_MTM tas, 
	view_moneda mon      	
  WHERE tas.moneda=@CodMoneda
    AND tas.moneda=mon.mncodmon
  ORDER BY tas.moneda,Plazo_Fin -- -- Idem problema !!
  END	

GO
