USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEE_RESCATES_DEL_DIA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEE_RESCATES_DEL_DIA]
AS
BEGIN
	
	DECLARE @dFecha DATETIME
	    SET @dFecha = (SELECT dFechaProceso 
	                     FROM bacparamsuda.dbo.SADP_Control);

	SELECT ffx.COD_FONDO
	,	   ffx.NOMBRE_FONDO
	,	    ISNULL(scc.sCuentaCorriente,'N/A')  AS CtaCte
	,		fm.DESCRIPCION_CORTA				AS Moneda
	,	   fondo.Montox
	  
	  FROM
			(SELECT cod_fondo_madre
			,		SUM(ISNULL(monto,0)) AS Montox
			   FROM fmparticipes.dbo.FMP_FONDOS ff
			   LEFT
			   JOIN  (SELECT fmc.cod_fondo
					 ,		 SUM(ISNULL(fmc.MONTO_MOVIMIENTO,0)-isnull(fmc.COMISION_UM_MOV,0)) AS Monto
						FROM fmparticipes.dbo.fmp_movimientos_cursados fmc
					   WHERE fmc.fecha_pago=@dfecha
					     AND FMC.TIPO_MOVIMIENTO ='R' 
					   GROUP
						  BY fmc.COD_FONDO) dff
				 ON dff.cod_fondo = ff.COD_FONDO	
			  GROUP 
			     BY ff.COD_FONDO_MADRE) Fondo
	  INNER 
	   JOIN fmparticipes.dbo.fmp_fondos ffx
		 ON ffx.cod_fondo = fondo.cod_fondo_madre
	   LEFT  
	   JOIN bacparamsuda.dbo.SADP_CuentasCorrientes scc
	     ON scc.iRutCliente = 96513630
	    AND scc.iCodCliente = ffx.cod_fondo
	  INNER   
	   JOIN fmparticipes.dbo.fmp_monedas fm 
	     ON fm.cod_moneda = ffx.COD_MONEDA
	  WHERE cod_fondo<>0
	ORDER BY ffx.ORDEN_FONDOS
		 
END 		   
GO
