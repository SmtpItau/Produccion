USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_FECHAPROC_RCM]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FECHAPROC_RCM]
	(	@modulo	    CHAR(3) = ''
	    ,@opcion	CHAR(3) = NULL 	
	    ,@fecha	    DATETIME OUTPUT 	
	)
AS
  
BEGIN   

    SET NOCOUNT ON	

    CREATE TABLE #FECHA_PROCESO
    ( [modulo] CHAR(3)
	,[fecha_anterior] DATETIME
	,[fecha_proceso] DATETIME
	,[fecha_proxima] DATETIME
    )

    INSERT INTO #FECHA_PROCESO 
    select Alan.Módulo_,Alan.FechaAnterior,Alan.FechaProceso,Alan.FechaProxima 
    from
	(
		SELECT 'RentaFija'	as [Sistema_____],	'BTR' as [Módulo_],	acsw_mesa	AS MesaCerrada,	acfecante	AS FechaAnterior,	acfecproc	AS FechaProceso,	acfecprox	AS FechaProxima,	acsw_pd	as InicioDia,	acsw_fd	as FinDia, 6	AS Posición	FROM BacTraderSuda.dbo.MDAC	with(nolock)
		UNION
		SELECT 'Forward'	as Sistema,	'BFW' as Módulo, acsw_ciemefwd	AS MesaCerrada,	acfecante	AS FechaAnterior,	acfecproc	AS FechaProceso,	acfecprox	AS FechaProxima,	acsw_pd 	as InicioDia,	acsw_fd as FinDia, 1	AS Posición	FROM BacFwdSuda.dbo.mfac 		 with(nolock)
		UNION                                            
		SELECT 'Swap'		as Sistema,	'PCS' as Módulo, cierreMesa		AS MesaCerrada,	fechaant	AS FechaAnterior,	fechaproc	AS FechaProceso,	fechaprox	AS FechaProxima,	iniciodia 	as InicioDia,	findia as FinDia, 2		AS Posición	FROM BacSwapSuda.DBO.SwapGeneral with(nolock)
		UNION                                            
		SELECT 'Opciones'	as Sistema,	'OPC' as Módulo, cierreMesa		AS MesaCerrada,	fechaant	AS FechaAnterior,	fechaproc	AS FechaProceso,	fechaprox	AS FechaProxima,	iniciodia 	as InicioDia,	findia as FinDia, 4		AS Posición	FROM CbMdbOpc.dbo.OpcionesGeneral with(nolock)
		UNION                                            
		SELECT 'Bonex'		as Sistema,	'BEX' as Módulo, acsw_mesa		AS MesaCerrada,	acfecante	AS FechaAnterior,	acfecproc	AS FechaProceso,	acfecprox	AS FechaProxima,	acsw_pd 	as InicioDia,	acsw_fd as FinDia, 3	AS Posición	FROM BacBonosExtSuda.dbo.text_arc_ctl_dri with(nolock)
		UNION
		SELECT 'Spot'		as Sistema,	'BCC' as Módulo,	substring(aclogdig,6,1)	AS MesaCerrada,	ACFECANT	AS FechaAnterior,	ACFECPRO	AS FechaProceso,	ACFECPRX	AS FechaProxima,	CASE WHEN substring(aclogdig,1,1) = 1 THEN 1 ELSE 0 END		as InicioDia,	CASE WHEN substring(aclogdig,9,1) = 1 THEN 1 ELSE 0 END		as FinDia, 5	AS Posición	FROM BacCamSuda.dbo.meac with(nolock)
    ) as Alan, 
		(SELECT Modulo = 'BTR',	/*ID = CASE WHEN acsw_pd     = 1 THEN 1 ELSE 0 END  ,						*/ RC = CASE WHEN acsw_rc     = 1 THEN 1 ELSE 0 END  , RV = CASE WHEN acsw_rv     = 1 THEN 1 ELSE 0 END  , CM = CASE WHEN acsw_mesa   = 1 THEN 1 ELSE 0 END  , CO = CASE WHEN acsw_co     = 1 THEN 1 ELSE 0 END  , DV = CASE WHEN acsw_dvprop = 1 THEN 1 ELSE 0 END  , TM = CASE WHEN NOT Tm.Fecha IS NULL THEN 1 ELSE 0 END  , FD = CASE WHEN acsw_fd = 1 THEN 1 ELSE 0 END  FROM  BacTraderSuda.dbo.MDAC with (nolock) LEFT  JOIN ( select top 1 Fecha = fecha_valorizacion  from  BacTraderSuda.dbo.VALORIZACION_MERCADO with(nolock)  where fecha_valorizacion  = (select acfecproc from BacTraderSuda.dbo.MDAC with(nolock) )  ) Tm On Tm.Fecha = acfecproc 
			 union SELECT 'BEX',	/*ID = CASE WHEN acsw_pd     = 1 THEN 1 ELSE 0 END  ,				*/ RC = -1,	RV = -1, CM = CASE WHEN acsw_mesa   = 1 THEN 1 ELSE 0 END  , CO = CASE WHEN acsw_co     = 1 THEN 1 ELSE 0 END  , DV = CASE WHEN acsw_dv     = 1 THEN 1 ELSE 0 END  , TM = CASE WHEN NOT Tm.Fecha IS NULL THEN 1 ELSE 0 END  , FD = CASE WHEN acsw_fd     = 1 THEN 1 ELSE 0 END  FROM  BacBonosExtSuda.dbo.TEXT_ARC_CTL_DRI with (nolock)  LEFT JOIN ( select  top 1 Fecha = mofecpro  from  BacBonosExtSuda.dbo.TEXT_MVT_DRI_TAS_MERC with (nolock) where mofecpro    = ( select acfecproc from BacBonosExtSuda.dbo.TEXT_ARC_CTL_DRI with(nolock) )  ) Tm  On Tm.Fecha = acfecproc 
			 union SELECT 'BCC',	/*ID = CASE WHEN substring(aclogdig,1,1) = 1 THEN 1 ELSE 0 END  ,	*/ RC = -1,	RV = -1, CM = CASE WHEN substring(aclogdig,6,1) = 1 THEN 1 ELSE 0 END  , CO = CASE WHEN substring(aclogdig,8,1) = 1 THEN 1 ELSE 0 END  , DV = -1  , TM = -1  , FD = CASE WHEN substring(aclogdig,9,1) = 1 THEN 1 ELSE 0 END  FROM BaccamSuda.dbo.MEAC        with(nolock) 
			 union SELECT 'BFW',	/*ID = CASE WHEN acsw_pd       = 1 THEN 1 ELSE 0 END ,				*/ RC = -1,	RV = -1, CM = CASE WHEN acsw_ciemefwd = 1 THEN 1 ELSE 0 END , CO = CASE WHEN acsw_contafwd = 1 THEN 1 ELSE 0 END , DV = CASE WHEN acsw_devenfwd = 1 THEN 1 ELSE 0 END , TM = -1  , FD = CASE WHEN acsw_fd       = 1 THEN 1 ELSE 0 END  FROM BacFwdSuda.dbo.MFAC with(nolock) 
			 union SELECT 'PCS',	/*ID = CASE WHEN iniciodia     = 1 THEN 1 ELSE 0 END  ,				*/ RC = -1,	RV = -1, CM = CASE WHEN cierreMesa    = 1 THEN 1 ELSE 0 END  , CO = CASE WHEN contabilidad  = 1 THEN 1 ELSE 0 END  , DV = CASE WHEN devengo       = 1 THEN 1 ELSE 0 END  , TM = -1  , FD = CASE WHEN findia        = 1 THEN 1 ELSE 0 END  FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock) 
			 union SELECT 'OPC',	/*ID = CASE WHEN iniciodia     = 1 THEN 1 ELSE 0 END  ,				*/ RC = -1,	RV = -1, CM = CASE WHEN cierreMesa    = 1 THEN 1 ELSE 0 END  , CO = CASE WHEN contabilidad  = 1 THEN 1 ELSE 0 END  , DV = CASE WHEN devengo       = 1 THEN 1 ELSE 0 END  , TM = -1  , FD = CASE WHEN findia        = 1 THEN 1 ELSE 0 END  FROM CbMdbOpc.dbo.OPCIONESGENERAL with(nolock) 
		) as Adrian
    where Alan.[Módulo_] = Adrian.Modulo

    SELECT @fecha = fp.fecha_proceso
    FROM #FECHA_PROCESO fp
    WHERE fp.modulo = @modulo

    IF(@opcion IS NOT NULL and @opcion = @modulo)
        BEGIN       
            SELECT * FROM #FECHA_PROCESO
            where modulo =@modulo
        END  
    ELSE IF(@opcion is not null and @opcion <> @modulo)
	   BEGIN
            SELECT * FROM #FECHA_PROCESO
	   END
     
END
GO
