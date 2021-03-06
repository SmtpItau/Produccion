USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_MONITOREO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_CARGA_MONITOREO]

(

	@Ambiente VARCHAR(2)

)

AS

BEGIN

	

	SET NOCOUNT ON;



	CREATE TABLE #TEMP

	(

		NOM_ARCHIVO		VARCHAR(25),

		PRODUCTO		VARCHAR(15),

		MONTO_COMPRA	NUMERIC(21,4),

		MONTO_VENTA		NUMERIC(21,4),

		CANT_COMPRA		INT,

		CANT_VENTA		INT

	)



	if 	(@Ambiente = 'N' )

	begin 

		INSERT #TEMP

		SELECT conf.Arch_sCodigo, 

				 mfto.ARR_tipo_producto_nombre, 

				 SUM( CASE WHEN arr_compra_venta = 'C' THEN arr_monto ELSE 0 end ),

				 SUM( CASE WHEN arr_compra_venta = 'V' THEN arr_monto ELSE 0 end ),

				 sum(CASE WHEN arr_compra_venta = 'C' THEN 1 ELSE 0 END ),

				 sum(CASE WHEN arr_compra_venta = 'V' THEN 1 ELSE 0 END )			 

		FROM bacparamsuda.dbo.MonitorFX_TblOperaciones mfto 

			,MonitorFX_TblConfArchivos conf

		WHERE mfto.idArchivo = conf.idArchivo	

		and conf.idAmbiente = 1
		AND mfto.NUMEROBAC <> NULL 
		
		GROUP BY conf.Arch_sCodigo, 

				 mfto.ARR_tipo_producto_nombre

	end

	else begin 

		INSERT #TEMP

		SELECT conf.Arch_sCodigo, 

				 mfto.Oper_sEquivalencia,

				 SUM( CASE WHEN arr_compra_venta = 'C' THEN arr_monto ELSE 0 end ),

				 SUM( CASE WHEN arr_compra_venta = 'V' THEN arr_monto ELSE 0 end ),

				 sum(CASE WHEN arr_compra_venta = 'C' THEN 1 ELSE 0 END ),

				 sum(CASE WHEN arr_compra_venta = 'V' THEN 1 ELSE 0 END )			 

		FROM bacparamsuda.dbo.MonitorFX_TblOperaciones mfto 

			,MonitorFX_TblConfArchivos conf

		WHERE mfto.idArchivo = conf.idArchivo	

		and conf.idAmbiente <> 1
		AND mfto.NUMEROBAC <> NULL 

		GROUP BY conf.Arch_sCodigo, 

				 mfto.Oper_sEquivalencia

	end 

	

	SELECT *

	FROM #TEMP

	DROP TABLE #TEMP



END

GO
