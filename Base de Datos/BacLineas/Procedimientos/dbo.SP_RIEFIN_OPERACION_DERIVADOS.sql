USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_OPERACION_DERIVADOS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_OPERACION_DERIVADOS]
	(	@Id_Sistema		VARCHAR(3)
	,	@Rut			NUMERIC(9)=0
	,	@Codigo			NUMERIC(9)=0
	,	@Producto		VARCHAR(3)=''
	)	
AS
BEGIN
	SET NOCOUNT ON
	IF @Id_Sistema ='BFW' 
	BEGIN 
		SELECT	Ca.canumoper
		,		Ca.cafecvcto
		,		Cl.Clrut
		,		Cl.Clcodigo
		,		Cl.Clnombre
		,		Ca.cacodpos1
		,		Ca.camtomon1
		,		Ca.catipcam
		,		'Moneda1' = (SELECT mo.mnglosa 
		 		             FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = Ca.cacodmon1)
										
		,		'Moneda2' =	(SELECT mo.mnglosa
		 		           	 FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = Ca.cacodmon2)
		,		Ca.cacodmon1
		,		Ca.cacodmon2
				
		FROM BacfwdSuda..mfca  Ca
		INNER JOIN BacParamSuda..Cliente Cl ON	Ca.cacodigo = Cl.Clrut 
											and Ca.cacodcli = Cl.Clcodigo
		WHERE	(Cl.Clrut		= @Rut		OR @Rut = 0)
		AND		(Cl.Clcodigo	= @Codigo	OR @Codigo = 0)	
		AND 	(convert(varchar(3),Ca.cacodpos1)	= @Producto	OR @Producto = '')
		ORDER BY Ca.canumoper
	END

	IF @Id_Sistema ='PCS' 
	BEGIN
		SELECT DISTINCT	
				Ca.numero_operacion
		,		Ca.fecha_termino
		,		Cl.Clrut
		,		Cl.Clcodigo
		,		Cl.Clnombre
		,		Ca.Tipo_Swap
		,		Ca.Compra_Capital
		,		'Glosa Mon' =  (RTRIM(LTRIM((ISNULL((SELECT mo.mnglosa 
	 						   FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = Ca.Compra_Moneda),''))
		 		               + 
	 						   (ISNULL((SELECT mo.mnglosa 
								FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = Ca.Venta_Moneda),'')))))
		,		'Moneda' =(Ca.Compra_Moneda + Ca.Venta_Moneda)
		
		FROM BacSwapSuda..Cartera Ca
						INNER JOIN BacParamSuda..Cliente Cl ON	Ca.rut_cliente = Cl.Clrut 
											 and Ca.codigo_cliente = Cl.Clcodigo
		WHERE	(Cl.Clrut		= @Rut		OR @Rut = 0)
		AND		(Cl.Clcodigo	= @Codigo	OR @Codigo = 0)	
		AND 	(Convert(Varchar(3),Ca.tipo_swap)	= @Producto	OR @Producto ='')
		ORDER BY Ca.numero_operacion
		
	END
	
	
	IF @Id_Sistema ='OPT' 
	BEGIN
					
		SELECT	CaN.CaNumContrato
		,		Nro_Op =  rtrim( CaN.CaNumContrato ) + '-' + rtrim( CaN.CaNumEstructura )
		,		CaN.CaFechaVcto	
		,		CaE.CaRutCliente
		,		CaE.CaCodigo	
		,		Cl.Clnombre 
		,		Compra_vende_MOneda = CaN.CaCallPut 
		,		Compra_Vende_Derecho = CaN.CaCVOpc
		,		CaN.CaMontoMon1
		,		'Moneda1' = (SELECT mo.mnglosa 
		 		             FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = CaN.CaCodMon1)
										
		,		'Moneda2' =	(SELECT mo.mnglosa
		 		           	 FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = CaN.CaCodMon2)  
		,		OpE.OpcEstDsc 
		,		CaN.CaCodMon1
		,		CaN.CaCodMon2
		FROM	Lnkopc.CbmdbOpc.dbo.cadetcontrato CaN
				INNER JOIN Lnkopc.CbmdbOpc.dbo.CaEncContrato CaE ON	CaE.CaNumContrato = CaN.CaNumContrato 
				INNER JOIN Lnkopc.CbmdbOpc.dbo.OpcionEstructura OpE ON	OpE.OpcEstCod = CaE.CaCodEstructura 
				INNER JOIN Bacparamsuda..Cliente  Cl ON	CaE.CaRutCliente = Cl.Clrut 
												   AND  CaE.CaCodigo =Cl.Clcodigo
		WHERE	(Cl.Clrut		= @Rut		OR @Rut = 0)
		AND		(Cl.Clcodigo	= @Codigo	OR @Codigo = 0)	
		AND 	(Convert(Varchar(3),CaE.CaSistema)	= @Producto	OR @Producto ='')
		ORDER BY CaN.CaNumContrato

	END
	
	IF @Id_Sistema ='BTR'
	BEGIN
	
		SELECT	Md.dinumdocu
		,		Md.dirutcart
		,		Md.ditipcart
		,		Cl.Clnombre
		,		Md.diserie	
		,		Md.diinstser
		,		Md.digenemi
		FROM Bactradersuda..mddi  Md
				INNER JOIN BacParamSuda..Cliente Cl ON	Md.dirutcart = Cl.Clrut 
													and Md.ditipcart = Cl.Clcodigo
		WHERE	(Cl.Clrut		= @Rut		OR @Rut = 0)
		AND		(Cl.Clcodigo	= @Codigo	OR @Codigo = 0)	
		AND 	(Md.ditipoper	= @Producto	OR @Producto = '')
		AND		 Md.dinominal <> 0
		ORDER BY Md.dinumdocu

	END
	
	IF   @Id_Sistema ='BEX'	
	BEGIN
		SELECT	mofecpago
		,		monumdocu
		,		cod_nemo
		,		monominal 
		,		mofecpcup 
		FROM	BacBonoSextSuda..text_ctr_cpr 
		WHERE	mofecpcup > (SELECT acfecprox FROM BacBonoSextSuda..text_arc_ctl_dri) --'20110823' 
		and		motipoper = 'CP' and monominal > 0
		UNION
		SELECT	mofecpago = cpfecpago
		,		monumdocu = cpnumdocu
		,		cod_nemo
		,		monominal = cpnominal 
		,		mofecpcup = cpfecpcup 
		FROM	BacBonoSextSuda..TEXT_CTR_INV 
		WHERE cpfecpcup > (SELECT acfecprox FROM BacBonoSextSuda..text_arc_ctl_dri) and Cpnominal > 0
		ORDER BY monumdocu
		
	END
	
END
SET NOCOUNT OFF
GO
