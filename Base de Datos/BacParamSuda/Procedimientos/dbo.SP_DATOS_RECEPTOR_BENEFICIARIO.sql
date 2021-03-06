USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOS_RECEPTOR_BENEFICIARIO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DATOS_RECEPTOR_BENEFICIARIO]
   (   @NumeroOperacion   NUMERIC(10)   
   ,   @cSistema          VARCHAR(5)
   ,   @Moneda            CHAR(3)
   ,   @iSecuencia		  INT  
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Ben_Rut       NUMERIC(9)
   ,       @Ben_Codigo    NUMERIC(9)
   ,       @Ben_Dv        CHAR(1)
   ,       @Ben_Direccion VARCHAR(50)
   ,       @Ben_CtaCte    VARCHAR(50)
   ,       @Ben_Nombre    VARCHAR(30)

   ,       @Rec_RutBco    NUMERIC(10)
   ,       @Rec_Codigo    NUMERIC(10)
   ,       @Rec_Dv        CHAR(1)
   ,       @Rec_Nombre    VARCHAR(30)
   ,       @Rec_Swift     VARCHAR(30)
   ,       @Rec_CtaCte    VARCHAR(50)
   ,       @cltipo        INT

	DECLARE @iMoneda		INT
		SET @iMoneda		= CASE	WHEN @Moneda = 'USD' THEN 13 
									WHEN @Moneda = 'CLP' THEN 999
							  END
	

	IF @cSistema = 'GPI' or @cSistema = 'CDB' or @cSistema = 'FFMM'
	BEGIN
		SELECT  @Ben_Rut				= dp.iRutBeneficiario
		,		@Ben_Dv					= dp.sDigBeneficiario
		,		@Ben_Codigo				= 1
		,		@Ben_Nombre				= dp.sNomBeneficiario
		,		@Ben_Direccion			= 'SIN DIRECCION'
		,		@Ben_CtaCte				= dp.sCtaCte
		,		@Rec_RutBco				= dp.iRutCliente
		,		@Rec_Codigo				= 1
		,		@cltipo					= 7
		,		@Rec_Nombre				= dp.sNomBanco
		,		@Rec_Swift				= dp.sSwift
		,		@Rec_CtaCte				= dp.sCtaCte
		FROM	BacParamSuda.dbo.MDLBTR							md
				INNER JOIN BacParamSuda.dbo.SADP_DETALLE_PAGOS	dp ON dp.cModulo  = md.sistema AND dp.nContrato = md.numero_operacion AND  dp.iSecuencia  = md.secuencia 
				INNER JOIN BacParamSuda.dbo.MONEDA				mn ON mn.mncodmon = md.moneda  
		WHERE	md.sistema				= @cSistema
		AND		md.numero_operacion		= @NumeroOperacion
		AND		md.secuencia			= @iSecuencia 
		AND		mn.mnnemo				= @Moneda 
		AND		dp.cEstado				= 'P'

		SELECT	@Rec_Dv					= cldv
		FROM	BacParamSuda.dbo.CLIENTE with(nolock)
		WHERE	clrut					= @Rec_RutBco
		AND		clcodigo				= @Rec_Codigo
	
	END ELSE
	BEGIN
		SELECT @Ben_Rut         = clrut
		,      @Ben_Dv          = cldv 
		,      @Ben_Codigo      = clcodigo
		,      @Ben_Nombre      = clnombre
		,      @Ben_Direccion   = RecDireccion
		,      @Ben_CtaCte      = RecCtaCte
		,      @Rec_RutBco      = RecRutBanco
		,      @Rec_Codigo      = RecCodBanco
		,      @cltipo          = cltipcli
		,	@Rec_Swift				= RecCodSwift
		,	@Rec_CtaCte				= RecCtaCte
	
		FROM   BacParamSuda.dbo.MDLBTR  with(nolock) 
		,      BacParamSuda.dbo.CLIENTE	with(nolock)
		WHERE  numero_operacion = @NumeroOperacion
		AND    sistema          = @cSistema
		AND    Moneda           = @iMoneda
		AND    clrut            = rut_cliente
		AND    clcodigo         = codigo_cliente

		SELECT @Rec_Dv          = cldv
		,      @Rec_Nombre      = clnombre
		,      @Rec_Swift       = Clswift
		,      @Rec_CtaCte      = Clctacte
		FROM   BacParamSuda.dbo.CLIENTE	with(nolock)
		WHERE  clrut            = @Rec_RutBco
		AND    clcodigo         = @Rec_Codigo
	END

   SELECT  'Ben_Rut'       = @Ben_Rut
   ,       'Ben_Codigo'    = @Ben_Codigo
   ,       'Ben_Dv'        = @Ben_Dv
   ,       'Ben_Nombre'    = @Ben_Nombre
   ,       'Ben_Direccion' = @Ben_Direccion
   ,       'Ben_CtaCte'    = @Ben_CtaCte

   ,       'Rec_RutBco'    = @Rec_RutBco
   ,       'Rec_Codigo'    = @Rec_Codigo
   ,       'Rec_Dv'        = @Rec_Dv
   ,       'Rec_Nombre'    = @Rec_Nombre
   ,       'Rec_Swift'     = @Rec_Swift
   ,       'Rec_CtaCte'    = @Rec_CtaCte 
   ,       'cltipcli'      = @cltipo
   ,       'Moneda'        = @Moneda

END
GO
