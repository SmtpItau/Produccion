USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_LINEA_PRODUCTO_POR_PLAZO]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_MNT_LINEA_PRODUCTO_POR_PLAZO]
		(	@iFlag			CHAR(01)
		,	@iRutCliente	NUMERIC(09)
		,	@iCodigo		NUMERIC(03)
		,	@iSistema		CHAR(03)
		,	@iProducto		CHAR(05)		= ''
		,	@iInstrumento	NUMERIC(04)		= 0
		,	@iMoneda        NUMERIC(03)		= 0
		,	@iForPag		NUMERIC(03)		= 0
		,	@iDiasDesde		NUMERIC(05)		= 0
		,	@iDiasHasta		NUMERIC(05)		= 0
		,	@iMontoLinea	NUMERIC(18,3)	= 0
		,	@iMontoOcupa	NUMERIC(18,3)	= 0
		,	@iMontoExec		NUMERIC(18,3)	= 0
		)
as
begin
	
	set nocount on

    if @iSistema = 'PCS'
    begin
		set @iInstrumento = 0
	end

	IF @iFlag = 'C' 
	BEGIN
		SELECT	LP.Codigo_Producto			-- 01
		,		LP.incodigo					-- 02
		,		LP.mncodmon					-- 03
		,		LP.codigo					-- 04
		,		LP.plazodesde				-- 05
		,		LP.Plazohasta				-- 06
		,		LP.TotalAsignado			-- 07
		,		LP.TotalOcupado				-- 08	
		,		LP.TotalExceso				-- 09
		,		ISNULL(PS.Descripcion,'')	-- 10
		,		ISNULL(VI.inserie,'')		-- 11
		,		ISNULL(VF.glosa,'')			-- 12
		,		ISNULL(VM.mnnemo,'')		-- 13
   	    FROM	LINEA_PRODUCTO_POR_PLAZO	LP	with(nolock)
				left join	(	select	incodigo, inserie from BacParamSuda.dbo.Instrumento with(nolock)
								union
								select	cod_familia, nom_familia from BacBonosExtSuda.dbo.text_fml_inm with(nolock)
							)	Vi		On VI.incodigo = LP.incodigo

				left join	(	select	mncodmon, mnnemo, mnglosa
								from	BacParamSuda.dbo.MONEDA	with(nolock)
							)	VM		On VM.mncodmon	= LP.mncodmon

				left join	(	select	codigo, glosa, diasvalor 
								from	BacParamSuda.dbo.FORMA_DE_PAGO with(nolock)
							)	VF		On VF.codigo	= LP.codigo

				left join	(	select	Id_Sistema, Codigo_Producto, Descripcion
								from	BacLineas.dbo.PRODUCTO_SISTEMA with(nolock)
								where	Id_Sistema		= @iSistema 
							)	PS		On	PS.Codigo_Producto	= LP.Codigo_Producto   
		WHERE	LP.Rut_Cliente 		= @iRutCliente
		AND		LP.Codigo_Cliente	= @iCodigo
		AND		LP.Id_Sistema		= @iSistema
		AND		LP.Codigo_Producto 	= PS.Codigo_Producto
		AND		PS.Id_Sistema		= @iSistema
		ORDER 
		BY		ISNULL(PS.Descripcion,'')
			,	ISNULL(VI.inserie,'')
			,	ISNULL(VM.mnnemo,'')
			,	ISNULL(VF.glosa,'')
			,	LP.plazodesde
			,	LP.Plazohasta
		RETURN
	END


	IF @iFlag = 'E' 
	BEGIN
		DELETE
		  FROM LINEA_PRODUCTO_POR_PLAZO
		 WHERE Rut_Cliente 	= @iRutCliente
		   AND Codigo_Cliente	= @iCodigo
		   AND Id_Sistema	= @iSistema
		RETURN
	END


	IF @iFlag = 'I' 
	BEGIN

		INSERT INTO LINEA_PRODUCTO_POR_PLAZO
		(	Rut_Cliente 
		,	Codigo_Cliente
		,	Id_Sistema
		,	Codigo_Producto
		,	incodigo
		,	mncodmon
		,	codigo
		,	plazodesde
		,	Plazohasta 
		,	TotalAsignado
		,	TotalOcupado
		,	TotalExceso 
		,	TotalRecibido          
		,	TotalTraspaso
		,	TotalDisponible
		,	Porcentaje
		)
		VALUES
		(	@iRutCliente
		,	@iCodigo
		,	@iSistema
		,	@iProducto
		,	@iInstrumento
		,	@iMoneda
		,	@iForPag
		,	@iDiasDesde
		,	@iDiasHasta
		,	@iMontoLinea
		,	@iMontoOcupa
		,	@iMontoExec
		,	0
		,	0
		,	@iMontoLinea - @iMontoOcupa
		,	0)

		RETURN

	  END

   SET NOCOUNT OFF

END
GO
