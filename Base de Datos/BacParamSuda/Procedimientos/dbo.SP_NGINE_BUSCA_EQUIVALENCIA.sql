USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NGINE_BUSCA_EQUIVALENCIA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_NGINE_BUSCA_EQUIVALENCIA] (@tbcategoria		NUMERIC(4)
													,@cfiltro			VARCHAR(6)
													,@tbvalor			VARCHAR(50))
AS BEGIN
	
	IF @tbcategoria IN (9929,9930) -- Usuario, Sistema
	BEGIN
		SELECT 
			nemo 
		FROM TABLA_GENERAL_DETALLE 
		WHERE 
			tbcateg			= @tbcategoria 
			AND tbcodigo1	= @cfiltro
			AND (tbvalor	= @tbValor OR @tbValor=0)
	END

	IF @tbcategoria IN (9931,9933) -- Canal, AppCodigo, AppNombre;Forma Pago
	BEGIN
		SELECT
			tbglosa,nemo
		FROM TABLA_GENERAL_DETALLE
		WHERE
			tbcateg			= @tbcategoria 
			AND tbcodigo1	= @cfiltro
			AND (tbvalor	= @tbValor OR  @tbValor=0)
	END

	IF @tbcategoria IN (9932,9935) -- Productos
	BEGIN
		SELECT
			tbglosa,nemo
		FROM TABLA_GENERAL_DETALLE
		WHERE
			tbcateg			= @tbcategoria 
			AND tbcodigo1	= @cfiltro
			AND (tbglosa	= @tbValor OR @tbValor='')
	END

	IF @tbcategoria IN (9934) -- Valuta
	BEGIN
		SELECT codigo,diasvalor,nemo as valuta
		FROM FORMA_DE_PAGO fp
			INNER JOIN TABLA_GENERAL_DETALLE tg
			on fp.diasvalor=tg.tbvalor
		WHERE
			tbcateg			= @tbcategoria
			AND fp.codigo	= @tbvalor
	END

	IF @tbcategoria IN (9936) -- Valuta
	BEGIN
	-- 840 USA US
		SELECT
			mo.MNCODPAIS
			,CONVERT(varchar(5),CONVERT(numeric(5),tg.tbvalor))+' '+ pa.COD_ITAU +' '+ pa.cod_swift
			,cr.codigo_swift		--ID CLIENTE: BIC del cliente
			,dr.corr_bco_swift		--BancoIntermediario
			,dr.corr_bco_cta		--CuentaIntermediario
		FROM Bacbonosextsuda..TEXT_MVT_DRI dr
			INNER JOIN BACPARAMSUDA..MONEDA mo
				ON dr.MOMONPAG = mo.MNCODMON
			INNER JOIN BACPARAMSUDA..PAIS pa
				ON mo.MNCODPAIS = pa.codigo_pais
			INNER JOIN bacparamsuda..CORRESPONSAL cr
				on cr.rut_cliente=dr.morutcli
			INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE tg
				ON tg.TBCATEG = @tbcategoria 
				AND tg.TBTASA = pa.codigo_pais
		WHERE 
			dr.MONUMOPER = @tbvalor
	END

	IF @tbcategoria IN (9938) -- BANCO
	BEGIN
		SELECT ISNULL(SUBSTRING(cl.Clswift,1,4),'') FROM CLIENTE cl WHERE cl.CLRUT = @tbvalor
	END
END
GO
