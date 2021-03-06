USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaContable_ReportesPasivos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CuadraturaContable_ReportesPasivos]
AS
BEGIN
	-- BONOS - CORFO 
	SELECT        'CodIBS'				= ccd.codIBS
				, 'NombreCuenta'	 	= p.PlanCuenta
				, 'SaldoCartera'       	= ccd.saldoContable
				, 'SaldoContable'     	= ccd.saldoIBS
				, 'Diferencia'			= ccd.saldoContable  - (ccd.saldoIBS - 0) 
				, 'Moneda'				= ccd.Moneda
				, 'Serie'				= p.NombreSerie
				, 'Sistema'				= ccd.Sistema
				, 'Glosa'				= pc.glosa
				, 'TipoBono'			= CASE WHEN RTRIM(p.PlanCuenta) LIKE'%SUBORDINADOS%' THEN 'BONOS SUBORDINADOS'
											   WHEN RTRIM(REPLACE(p.PlanCuenta,'SUBORDIN','SUBORDINADOS')) LIKE'%SUBORDINADOS%' THEN 'BONOS SUBORDINADOS'
											   WHEN RTRIM(REPLACE(p.PlanCuenta,'SUBORD','SUBORDINADOS'))   LIKE'%SUBORDINADOS%' THEN 'BONOS SUBORDINADOS'
											   --WHEN RTRIM(p.PlanCuenta) LIKE'%'+RTRIM(pc.glosa)+'%' THEN pc.glosa  
											   --WHEN RTRIM(p.PlanCuenta) LIKE'%'+RTRIM(REPLACE(pc.glosa,'BONOS','BONO'))+'%' THEN pc.glosa  
											   WHEN RTRIM(p_cnt.tipo_operacion) = 'CORFO' THEN 'CREDITOS CORFO'
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE D%'  THEN 'BONOS SERIE D' --pc.glosa
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE J%'  THEN 'BONOS SERIE J' --pc.glosa
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE K%'  THEN 'BONOS SERIE K' --pc.glosa
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE L%'  THEN 'BONOS SERIE L' --pc.glosa
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE M%'  THEN 'BONOS SERIE M' --pc.glosa												   
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE Q%'  THEN 'BONOS SERIE Q' --pc.glosa	
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE R%'  THEN 'BONOS SERIE R' --pc.glosa			
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE AI%' THEN 'BONOS SERIE AI' --pc.glosa
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE AD%' THEN 'BONOS SERIE AD' --pc.glosa		
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE AE%' THEN 'BONOS SERIE AE' --pc.glosa			
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE AF%' THEN 'BONOS SERIE AF' --pc.glosa				
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE AG%' THEN 'BONOS SERIE AG' --pc.glosa			   
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE O%'  THEN 'BONOS SERIE O' --pc.glosa			
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE P%'  THEN 'BONOS SERIE P' --pc.glosa
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE A%'  THEN 'BONOS SERIE A' --pc.glosa
											   WHEN RTRIM(p.PlanCuenta) LIKE'%SERIE A%'  THEN 'BONOS SERIE P' --pc.glosa
											   WHEN RTRIM(p.PlanCuenta) LIKE'%BONOS J%'  THEN 'BONOS SERIE J' --pc.glosa			
											   WHEN RTRIM(p.PlanCuenta) LIKE'%BONOS AI%' THEN 'BONOS SERIE AI' --pc.glosa											   
										 ELSE '' END   
				, 'TipoOperacion'		= ISNULL('CRÉDITOS ' + p_cnt.tipo_operacion, 'BONOS') 
	FROM        dbo.CuadraturaContableDerivados AS ccd INNER JOIN
                dbo.Parametros_Detalle_Pasivos AS p ON ccd.Sistema = p.Sistema AND ccd.codIBS = p.CodIBS INNER JOIN
                Bacfwdsuda.dbo.VIEW_MONEDA AS m ON ccd.Moneda = m.mnnemo INNER JOIN
                MDParPasivo.dbo.PLAN_DE_CUENTA AS pc ON ccd.codIBS = CONVERT(FLOAT, pc.cuenta) LEFT OUTER JOIN
                    (SELECT        tipo_movimiento, codigo_instrumento, moneda_instrumento, tipo_operacion
                     FROM            MDParPasivo.dbo.PERFIL_CNT
                     WHERE        (tipo_movimiento = 'DEV')) AS p_cnt ON m.mncodmon = p_cnt.moneda_instrumento AND p.NombreSerie = p_cnt.codigo_instrumento


END  

GO
