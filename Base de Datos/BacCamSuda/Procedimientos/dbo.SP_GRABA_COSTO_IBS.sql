USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_COSTO_IBS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* PRUEBAS */
--EXECUTE SP_GRABA_COSTO_IBS 'BF', '20110314', 0, 0, 0, 0, 0, 0, 0, 0, '2', 0, 13 
--dbo.SP_GRABA_COSTO_IBS 'G', '20110314', 200.0001, 400, 450, 450, 0.5, 0.5, 0, 0, 1, 600, 13
--dbo.SP_GRABA_COSTO_IBS 'D', '20110314', 0, 0, 0, 0, 0, 0, 0, 0, 1, 600, 13
--DBO.SP_GRABA_COSTO_IBS 'BF', '20110314', 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 13

/*06-10-2011. MACO, Graba los Costos Fondo WEB */

CREATE PROCEDURE [dbo].[SP_GRABA_COSTO_IBS]
	(		@Tipo					CHAR(2),
			@Fecha					CHAR(8),
			@Entre_Desde			NUMERIC(18,4),
			@Entre_Hasta			NUMERIC(18,4),
			@Costo_Compra			NUMERIC(18,4),
			@Costo_Venta			NUMERIC(18,4),
			@Spread_Compra			NUMERIC(18,4),
			@Spread_Venta			NUMERIC(18,4),
			@Spread_Trading_Compra	NUMERIC(18,4),
			@Spread_Trading_Venta	NUMERIC(18,4),
			@Nemo					CHAR	(4) ,--= 0,	   -- PRD7494
 			@Monto_max				NUMERIC(18,4) 	= 0,	   -- PRD7494
			@monCod					NUMERIC(5)		= 0		   --> 31-05-2011 arm+-
	)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @iCodNemo	INT
		SET @iCodNemo	 = CONVERT( INT, @Nemo )
	
	DECLARE @Nemo1	char(4)
			DECLARE @Glosa	char(20)
			set @Nemo1 = (select NEMO from BacParamSuda.dbo.TABLA_GENERAL_DETALLE where tbcateg = 9007 and tbcodigo1 = @iCodNemo)
			set @Glosa = (select tbglosa from BacParamSuda.dbo.TABLA_GENERAL_DETALLE where tbcateg = 9007 and tbcodigo1 = @iCodNemo)


	IF @Tipo = 'BF'
	BEGIN

		SELECT	CCB.Entre_Desde,
				CCB.Entre_Hasta,
				--CC.Costo_Compra,
				--CC.Costo_Venta,
				CCB.Spread_Compra,
				CCB.Spread_Venta,
				CCB.Spread_Trading_Compra,
				CCB.Spread_Trading_Venta,
				CCB.NEMO,-- PRD7494
				CCB.montomax,		-- PRD7494
				CCB.codMoneda,
			    'CodSegmento' = tgd.tbcodigo1
		  FROM	COSTOS_COMEX_IBS ccb
				INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE tgd ON tgd.tbcateg = 9007 and tgd.tbcodigo1 = @iCodNemo
--				INNER JOIN COSTOS_COMEX							  cc  ON cc.Fecha		= ccb.fecha
--																     and cc.codMoneda = ccb.codMoneda
--																     and cc.Perfil_Comercial = 2
		WHERE	ccb.fecha		= @Fecha
		AND		ccb.codMoneda = @monCod
		AND		ccb.nemo		= tgd.nemo
	   ORDER BY Entre_Desde, Entre_Hasta

	END

	IF @Tipo = 'EU'
	BEGIN
			DELETE	COSTOS_COMEX_IBS
			WHERE	Fecha			= @Fecha
			AND		Entre_Desde		= @Entre_Desde
			AND		Entre_Hasta		= @Entre_Hasta

			IF @@ERROR <> 0
			BEGIN
				PRINT 'ERROR_PROC FALLA BORRANDO COSTO.'
				RETURN 1
			END
	END

	IF @Tipo = 'G'
	BEGIN
			
			
			INSERT INTO COSTOS_COMEX_IBS(	Fecha,
							Entre_Desde,
							Entre_Hasta,
							Spread_Compra,
							Spread_Venta,
							Spread_Trading_Compra,
							spread_trading_venta,
							NEMO,
							SEGMENTO,
							montomax,
							CodMoneda)

					VALUES	(	@Fecha,
							@Entre_Desde,
							@Entre_Hasta,
							@Spread_Compra,
							@Spread_Venta,
							@Spread_Trading_Compra,
							@Spread_Trading_Venta,
							@Nemo1,
							@Glosa,
							@monto_max,
                            @MonCod )

			IF @@ERROR <> 0
			BEGIN
				PRINT 'ERROR_PROC FALLA AGREGANDO COSTOS COMEX'
				RETURN 1
			END
		
		END
	
	IF @Tipo = 'D'
	BEGIN
		print @Tipo
		DELETE	COSTOS_COMEX_IBS
		WHERE	Fecha			 = @Fecha
		AND		NEMO			 = @Nemo1
		AND		CodMoneda		 = @MonCod

		IF @@ERROR <> 0
		BEGIN
			PRINT 'ERROR_PROC FALLA AGREGANDO COSTOS COMEX'
			RETURN 1
		END
	END

END
GO
