USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_MNT_CRITERIOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_MNT_CRITERIOS]
	(	@iTag				INT
	,	@Id_Criterio		INT				= 0
	,	@Modulo_Origen		CHAR(5)			= ''
	,	@Tipo_Mercado		VARCHAR(15)		= ''
	,	@Moneda				INT				= 0
	,	@Forma_Pago			INT				= 0
	,	@Rut_Cliente		NUMERIC(10)		= 0
	,	@Codigo_Cliente		INT				= 0
	)
AS
BEGIN

	SET NOCOUNT ON	

	IF @iTag = 1
	BEGIN
		SELECT  Id_Criterio		= Cri.Id_Criterio 
			,	Modulo_Origen	= Mod.nombre_sistema -->	Modulo_Origen 
			,	Tipo_Mercado	= Prd.descripcion	 -->	Tipo_Mercado
			,	Moneda			= mon.mnnemo		 -->	Moneda
			,	Forma_Pago		= Fpa.Glosa			 -->	Forma_Pago
			,	Rut_Cliente		= Cri.Rut_Cliente
			,	Codigo_Cliente	= Cri.Codigo_Cliente
			,	Nombre			= isnull( Cli.clnombre, '')
		FROM	dbo.SADP_CRITERIOS					     Cri
				LEFT JOIN BacParamSuda.dbo.SISTEMA_CNT   Mod ON Mod.id_sistema   = Cri.Modulo_Origen
				LEFT JOIN BacParamSuda.dbo.PRODUCTO      Prd ON Prd.id_sistema   = Cri.Modulo_Origen AND Prd.codigo_producto = Cri.Tipo_Mercado
				LEFT JOIN BacParamSuda.dbo.MONEDA		 Mon ON Mon.mncodmon	 = Cri.moneda
				LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO Fpa ON Fpa.codigo		 = Cri.Forma_Pago
				LEFT JOIN BacParamSuda.dbo.CLIENTE		 Cli ON Cli.clrut	     = Cri.Rut_Cliente	 AND Cli.clcodigo = Cri.Codigo_Cliente
		WHERE   Modulo_Origen	IN('BTR', 'BEX', 'BCC', 'BFW', 'PCS') 

		UNION

		SELECT  Id_Criterio		= Cri.Id_Criterio 
			,	Modulo_Origen	= Mod.Descripcion	--> Cri.Modulo_Origen 
			,	Tipo_Mercado	= Prd.Producto		--> Cri.Tipo_Mercado
			,	Moneda			= mon.mnnemo		 -->	Moneda
			,	Forma_Pago		= Fpa.Glosa			 -->	Forma_Pago
			,	Rut_Cliente		= Cri.Rut_Cliente
			,	Codigo_Cliente	= Cri.Codigo_Cliente
			,	Nombre			= isnull( Cli.clnombre, '')
		FROM	dbo.SADP_CRITERIOS										Cri
				LEFT JOIN BacParamSuda.dbo.SADP_MODULOS_EXTERNOS		Mod ON Mod.nemo		= Cri.Modulo_Origen
				LEFT JOIN BacParamSuda.dbo.SADP_PRODUCTO_MODULOEXTERNO  Prd ON Prd.Modulo	= Mod.nemo AND Prd.Codigo = Cri.Tipo_Mercado
				LEFT JOIN BacParamSuda.dbo.MONEDA						Mon ON Mon.mncodmon	= Cri.moneda 
				LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO				Fpa ON Fpa.codigo	= Cri.Forma_Pago
				LEFT JOIN BacParamSuda.dbo.CLIENTE						Cli ON Cli.clrut	= Cri.Rut_Cliente AND Cli.clcodigo = Cri.Codigo_Cliente
		WHERE   Modulo_Origen	NOT IN('BTR', 'BEX', 'BCC', 'BFW', 'PCS') 

		RETURN
	END
	
	IF @iTag = 2
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM dbo.SADP_CRITERIOS WHERE Modulo_Origen = @Modulo_Origen AND Tipo_Mercado   = @Tipo_Mercado
														 AND Moneda		   = @Moneda		AND Forma_Pago	   = @Forma_Pago
														 AND Rut_Cliente   = @Rut_Cliente	AND Codigo_Cliente = @Codigo_Cliente)
		BEGIN
			SELECT @Id_Criterio = isnull(MAX( Id_Criterio ), 0) + 1 FROM dbo.SADP_CRITERIOS
		END 

		IF EXISTS( SELECT 1 FROM dbo.SADP_CRITERIOS WHERE Id_Criterio = @Id_Criterio )
		BEGIN
			DELETE FROM dbo.SADP_CRITERIOS 
				  WHERE Id_Criterio = @Id_Criterio
		END

		DELETE FROM dbo.SADP_CRITERIOS 
		WHERE	Modulo_Origen		= @Modulo_Origen
			AND	Tipo_Mercado		= @Tipo_Mercado
			AND	Moneda				= @Moneda
			AND	Forma_Pago			= @Forma_Pago
			AND	Rut_Cliente			= @Rut_Cliente
			AND	Codigo_Cliente		= @Codigo_Cliente

		INSERT INTO dbo.SADP_CRITERIOS
			(	Id_Criterio
			,	Nombre_Criterio
			,	Modulo_Origen
			,	Tipo_Mercado
			,	Moneda
			,	Forma_Pago
			,	Rut_Cliente
			,	Codigo_Cliente
			)
		VALUES
			(	@Id_Criterio
			,	' ' --> @Nombre_Criterio
			,	@Modulo_Origen
			,	@Tipo_Mercado
			,	@Moneda
			,	@Forma_Pago
			,	@Rut_Cliente
			,	@Codigo_Cliente
			)

		RETURN
	END	

	IF @iTag = 3
	BEGIN
		SELECT Criterio = isnull(MAX( Id_Criterio ), 0) + 1 FROM dbo.SADP_CRITERIOS
		RETURN 
	END

	IF @iTag = 4
	BEGIN
		SELECT  Id_Criterio		= Cri.Id_Criterio 
			,	Nombre_Criterio = Cri.Nombre_Criterio 
			,	Modulo_Origen	= Cri.Modulo_Origen 
			,	Tipo_Mercado	= Cri.Tipo_Mercado
			,	Moneda			= Cri.Moneda 
			,	Forma_Pago		= Cri.Forma_Pago 
			,	Rut_Cliente		= Cri.Rut_Cliente
			,	Codigo_Cliente	= Cri.Codigo_Cliente 
		FROM	dbo.SADP_CRITERIOS				   Cri
				LEFT JOIN BacParamSuda.dbo.CLIENTE Cli ON Cli.clrut = Cri.Rut_Cliente AND Cli.clcodigo = Cri.Codigo_Cliente 
		WHERE   Cri.Id_Criterio	= @Id_Criterio
	END

END
GO
