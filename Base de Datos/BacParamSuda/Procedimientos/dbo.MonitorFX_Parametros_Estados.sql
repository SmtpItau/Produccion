USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_Parametros_Estados]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- sp_helptext MonitorFX_Parametros_Estados


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[MonitorFX_Parametros_Estados]
AS 
		SELECT	Spot.acfecpro														AS PE_FechaProceso_SPOT,
				Spot.acfecprx														AS PE_FechaProxima_SPOT,
				CASE WHEN substring(Spot.aclogdig,1,1) = 1 THEN '1' ELSE '0' END	AS PE_SW_InicioDia_SPOT,	
				--CASE WHEN substring(Spot.aclogdig,6,1) = 1 THEN '1' ELSE '0' END	AS PE_SW_Mesa_SPOT,	
				CASE WHEN substring(Spot.aclogdig,6,1) = 1 THEN '0' ELSE '1' END	AS PE_SW_Mesa_SPOT,	
				CASE WHEN substring(Spot.aclogdig,9,1) = 1 THEN '1' ELSE '0' END	AS PE_SW_FinDia_SPOT,
				Fwd.acfecproc														AS PE_FechaProceso_FWD,
				Fwd.acfecprox														AS PE_FechaProxima_FWD,
				CASE WHEN Fwd.acsw_pd = 1		THEN '1' ELSE '0' END				AS PE_SW_InicioDia_FWD,
				CASE WHEN Fwd.acsw_ciemefwd = 1 THEN '1' ELSE '0' END				AS PE_SW_Mesa_FWD,	
				CASE WHEN Fwd.acsw_fd = 1		THEN '1' ELSE '0' END				AS PE_SW_FinDia_FWD,
				Swap.fechaproc														AS PE_FechaProceso_SWAP,
				Swap.fechaprox														AS PE_FechaProxima_SWAP,
				CASE WHEN iniciodia = 1		THEN '1' ELSE '0' END					AS PE_SW_InicioDia_SWAP,
				CASE WHEN cierreMesa = 1	THEN '1' ELSE '0' END					AS PE_SW_Mesa_SWAP,	
				CASE WHEN findia = 1		THEN '1' ELSE '0' END					AS PE_SW_FinDia_SWAP
		  FROM BaccamSuda.dbo.MEAC Spot WITH(NOLOCK)
			  ,BacFwdSuda.dbo.MFAC  Fwd WITH(NOLOCK)
			  ,BacSwapSuda.dbo.SWAPGENERAL Swap WITH(NOLOCK)
GO
