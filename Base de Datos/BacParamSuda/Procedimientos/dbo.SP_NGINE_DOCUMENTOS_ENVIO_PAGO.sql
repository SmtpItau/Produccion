USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NGINE_DOCUMENTOS_ENVIO_PAGO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_NGINE_DOCUMENTOS_ENVIO_PAGO]
(
	@cSistema			CHAR(3)
	,@numero_operacion	NUMERIC(10)
)
AS
BEGIN
	-- =====================================================================
	-- RENTA FIJA NACIONAL
	-- =====================================================================
	IF EXISTS(	SELECT 1 
				FROM 
					bactradersuda..mdmo mo
					INNER JOIN baclineas..aprobacion_operaciones ao
						ON mo.monumoper = ao.numerooperacion
					INNER JOIN baclineas..detalle_aprobaciones do
						ON ao.id_sistema = do.id_sistema 
						AND ao.numerooperacion = do.numero_operacion
				WHERE
					mo.monumoper = @numero_operacion
					AND mo.motipoper NOT IN ('TM')
			)
	BEGIN
		SELECT 
			'CodigoProducto'			= 'BTR'
			,'NumeroOperacion'			= monumoper
			,'NemonicoTipoInstrumento'	= moinstser
			,'ValorNominal'				= sum(monominal)
			,'Tir'						= motir
			,'ValorCompra'				= sum(movalcomp)
			,'ClaveOperacion'			= moclave_dcv
			,'CorrelativoRegistro'		= mocorrela
		FROM bactradersuda..mdmo mo
			INNER JOIN baclineas..aprobacion_operaciones ao
				ON mo.monumoper = ao.numerooperacion
			INNER JOIN baclineas..detalle_aprobaciones do
				ON ao.id_sistema = do.id_sistema 
				AND ao.numerooperacion = do.numero_operacion
		WHERE 
			mo.monumoper = @numero_operacion
			AND mo.motipoper NOT IN ('TM')
		GROUP BY
			mo.monumoper
			,mo.moinstser
			,mo.motir
			,mo.moclave_dcv
			,mo.mocorrela
	END

	-- =====================================================================
	-- RENTA FIJA EXTRANJERA
	-- =====================================================================
	IF EXISTS(	SELECT 1 
				FROM 
					Bacbonosextsuda..TEXT_MVT_DRI mx
					INNER JOIN baclineas..aprobacion_operaciones ao
						ON mx.monumoper = ao.numerooperacion
					INNER JOIN baclineas..detalle_aprobaciones do
						ON ao.id_sistema = do.id_sistema 
						AND ao.numerooperacion = do.numero_operacion
				WHERE
					mx.monumoper = @numero_operacion
					AND mx.motipoper NOT IN ('TM')
			)
	BEGIN
		SELECT 
			'CodigoProducto'			= 'BTRX'
			,'NumeroOperacion'			= monumoper
			,'NemonicoTipoInstrumento'	= id_instrum
			,'ValorNominal'				= sum(monominal)
			,'Tir'						= motir
			,'ValorCompra'				= sum(movalcomp)
			,'ClaveOperacion'			= ''
			,'CorrelativoRegistro'		= mocorrelativo
		FROM Bacbonosextsuda..TEXT_MVT_DRI mx
			INNER JOIN baclineas..aprobacion_operaciones ao
				ON mx.monumoper = ao.numerooperacion
			INNER JOIN baclineas..detalle_aprobaciones do
				ON ao.id_sistema = do.id_sistema 
				AND ao.numerooperacion = do.numero_operacion
		WHERE 
			mx.monumoper = @numero_operacion
			AND mx.motipoper NOT IN ('TM')
		GROUP BY
			mx.monumoper
			,mx.id_instrum
			,mx.motir
			--,mx.moclave_dcv
			,mx.mocorrelativo
	END
END
GO
