USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Valida_Fechas_Cierre]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/************************************************************
 * Code formatted by SoftTree SQL Assistant © v6.2.107
 * Time: 10-09-2013 10:22:30
 * EXECUTE Sp_Valida_Fechas_Cierre '20130908', BTR 
 * EXECUTE Sp_Valida_Fechas_Cierre '20111012', BEX 
 ************************************************************/

        /*    09 -09 -2013        10 -09 -2013  
              10 -09 -2013        10 -09 -2013*/    
  
CREATE PROCEDURE [dbo].[Sp_Valida_Fechas_Cierre] 
(@dFechaSistema DATETIME, @cOrigen CHAR(3))
AS
BEGIN
	DECLARE @dFechaTabla DATETIME  
	SET @dFechaTabla = CASE 
	                        WHEN @cOrigen = 'BTR' THEN (
	                                 SELECT CONVERT(CHAR(8), acfecproc, 112)
	                                 FROM   BacTraderSuda.dbo.Mdac WITH(NOLOCK)
	                             )
	                        WHEN @cOrigen = 'BEX' THEN (
	                                 SELECT CONVERT(CHAR(8), acfecproc, 112)
	                                 FROM   BacBonosExtSuda.dbo.text_arc_ctl_dri 
	                                        WITH(NOLOCK)
	                             )
	                        WHEN @cOrigen = 'BFW' THEN (
	                                 SELECT CONVERT(CHAR(8), acfecproc, 112)
	                                 FROM   BacFwdSuda.dbo.Mfac WITH(NOLOCK)
	                             )
	                        WHEN @cOrigen = 'PCS' THEN (
	                                 SELECT CONVERT(CHAR(8), fechaproc, 112)
	                                 FROM   BacSwapSuda.dbo.Swapgeneral WITH(NOLOCK)
	                             )
	                        WHEN @cOrigen = 'OPC' THEN (
	                                 SELECT CONVERT(CHAR(8), fechaproc, 112)
	                                 FROM   lnkOpc.CbMdbOpc.dbo.OPCIONESGENERAL 
	                                        WITH(NOLOCK)
	                             )
	                        WHEN @cOrigen = 'BCC' THEN (
	                                 SELECT CONVERT(CHAR(8), acfecpro, 112)
	                                 FROM   BacCamsuda.dbo.Meac WITH(NOLOCK)
	                             )
	                   END  
	
	IF @dFechaSistema <> @dFechaTabla
	    SELECT 1,
	           'Fechas NOK'
	ELSE
	    SELECT 0,
	           'Fechas OK'
END  
GO
