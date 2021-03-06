USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CONTRATO_LEER_DATOS_CONTRATO_RF]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[CONTRATO_LEER_DATOS_CONTRATO_RF] 

   (			@nContrato			NUMERIC(9)  

		,		@cTipoper			VARCHAR(5)  

   		,		@RUT_CLIENTE		AS NUMERIC(11)  

		,		@COD_CLIENTE		AS NUMERIC(10)  

		,		@RUT_APODERADOB1	AS NUMERIC(11) = 0  

		,		@RUT_APODERADOB2	AS NUMERIC(11) = 0  

		,		@RUT_APODERADO1		AS NUMERIC(11) = 0  

		,		@RUT_APODERADO2		AS NUMERIC(11) = 0  
		
		,		@ClausulaTipoPago	AS NUMERIC(1)	= 0

		,		@ClausulaCustodia	AS NUMERIC(1)	= 0





   )  

AS  

BEGIN  

  

   SET NOCOUNT ON  



  

	DECLARE @NomEntidad		VARCHAR(100)

	DECLARE @RutEntidad		NUMERIC(12)

	DECLARE	@DvEntidad		VARCHAR(1)

	DECLARE @CodEntidad		VARCHAR(2)

	DECLARE	@DirecEntidad	VARCHAR(100)

	DECLARE @FonoEntidad	VARCHAR(14)

	DECLARE @ComunaEntidad	VARCHAR(30)

	DECLARE @CiudadEntidad	VARCHAR(30)
	
	DECLARE @ImagenContrato	VARBINARY(MAX)
	DECLARE @DireccionCliente VARCHAR(MAX)





   	SELECT TOP 1

			@NomEntidad		=	RazonSocial	

	,		@RutEntidad		=	RutEntidad	

	,		@DvEntidad		=	DigitoVerificador

	,		@CodEntidad		=   CodigoEntidad

	,		@DirecEntidad	=	DireccionLegal + ', ' + Comuna + ', ' + Ciudad

	,		@FonoEntidad	=	TelefonoLegal

	,		@ComunaEntidad  =	Comuna

	,		@CiudadEntidad  =	Ciudad
	
	,		@ImagenContrato =	bannerlargoContrato	

	FROM bacparamsuda..Contratos_ParametrosGenerales

				SELECT  @DireccionCliente	=    (SELECT ltrim(rtrim(CLDIRECC))

												FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE) 
										+
										', '
										+
										ISNULL ((SELECT	ltrim(rtrim(COMU.NOMBRE)) FROM	BACPARAMSUDA..COMUNA COMU   

											INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE

										WHERE	CLRUT = @RUT_CLIENTE),'')
										+
										', '
										+
										 ISNULL ((SELECT	ltrim(rtrim(NOMBRE)) FROM	BACPARAMSUDA..CIUDAD CIU  

											INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE

										WHERE CLRUT = @RUT_CLIENTE),'')	





 --  	DECLARE @cNom_Apoderado_Banco_1		VARCHAR(40);	SET @cNom_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( 97023000, 1, @RUT_APODERADOB1, 1)

	--DECLARE @cRut_Apoderado_Banco_1		VARCHAR(40);	SET	@cRut_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( 97023000, 1, @RUT_APODERADOB1, 2)

	--DECLARE @cNom_Apoderado_Banco_2		VARCHAR(40);	SET @cNom_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( 97023000, 1, @RUT_APODERADOB2, 1)

	--DECLARE @cRut_Apoderado_Banco_2		VARCHAR(40);	SET	@cRut_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( 97023000, 1,@RUT_APODERADOB2, 2)

	DECLARE @cNom_Apoderado_Banco_1		VARCHAR(40);	SET @cNom_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( @RutEntidad, @CodEntidad, @RUT_APODERADOB1, 1)

	DECLARE @cRut_Apoderado_Banco_1		VARCHAR(40);	SET	@cRut_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( @RutEntidad, @CodEntidad, @RUT_APODERADOB1, 2)

	DECLARE @cNom_Apoderado_Banco_2		VARCHAR(40);	SET @cNom_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( @RutEntidad, @CodEntidad, @RUT_APODERADOB2, 1)

	DECLARE @cRut_Apoderado_Banco_2		VARCHAR(40);	SET	@cRut_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( @RutEntidad, @CodEntidad,@RUT_APODERADOB2, 2)

	DECLARE @cNom_Apoderado_Cliente_1	VARCHAR(40);	SET @cNom_Apoderado_Cliente_1	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO1, 1)

	DECLARE @cRut_Apoderado_Cliente_1	VARCHAR(40);	SET @cRut_Apoderado_Cliente_1	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO1, 2)

	DECLARE @cNom_Apoderado_Cliente_2	VARCHAR(40);	SET @cNom_Apoderado_Cliente_2	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO2, 1)

	DECLARE @cRut_Apoderado_Cliente_2	VARCHAR(40);	SET @cRut_Apoderado_Cliente_2	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RUT_APODERADO2, 2)





		DECLARE @cadena_ante varchar(50)

	DECLARE @cadena_desp varchar(50)

	if @cRut_Apoderado_Cliente_1 <> ''

	begin

		SET @cadena_ante = SUBSTRING(@cRut_Apoderado_Cliente_1, 1, charindex('-', @cRut_Apoderado_Cliente_1) - 1); 

		SET @cadena_desp = SUBSTRING(@cRut_Apoderado_Cliente_1, charindex('-', @cRut_Apoderado_Cliente_1), charindex('-', @cRut_Apoderado_Cliente_1) + 1); 

		SET @cRut_Apoderado_Cliente_1 = (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( @cadena_ante ))))) ), 1), '.00', ''), ',','.')+@cadena_desp)

	end



	if @cRut_Apoderado_Cliente_2 <> ''

	begin

		SET @cadena_ante = SUBSTRING(@cRut_Apoderado_Cliente_2, 1, charindex('-', @cRut_Apoderado_Cliente_2) - 1); 

		SET @cadena_desp = SUBSTRING(@cRut_Apoderado_Cliente_2, charindex('-', @cRut_Apoderado_Cliente_2), charindex('-', @cRut_Apoderado_Cliente_2) + 1); 

		SET @cRut_Apoderado_Cliente_2 = (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( @cadena_ante ))))) ), 1), '.00', ''), ',','.')+@cadena_desp)

	end



	if @cRut_Apoderado_Banco_1 <> ''

	begin

		SET @cadena_ante = SUBSTRING(@cRut_Apoderado_Banco_1, 1, charindex('-', @cRut_Apoderado_Banco_1) - 1); 

		SET @cadena_desp = SUBSTRING(@cRut_Apoderado_Banco_1, charindex('-', @cRut_Apoderado_Banco_1), charindex('-', @cRut_Apoderado_Banco_1) + 1); 

		SET @cRut_Apoderado_Banco_1 = (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( @cadena_ante ))))) ), 1), '.00', ''), ',','.')+@cadena_desp)

	end



	if @cRut_Apoderado_Banco_2 <> ''

	begin

		SET @cadena_ante = SUBSTRING(@cRut_Apoderado_Banco_2, 1, charindex('-', @cRut_Apoderado_Banco_2) - 1); 

		SET @cadena_desp = SUBSTRING(@cRut_Apoderado_Banco_2, charindex('-', @cRut_Apoderado_Banco_2), charindex('-', @cRut_Apoderado_Banco_2) + 1); 

		SET @cRut_Apoderado_Banco_2 = (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( @cadena_ante ))))) ), 1), '.00', ''), ',','.')+@cadena_desp)

	end





   SELECT DISTINCT  

          FolioContrato    = mov.monumoper  

      --,   A                = SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN ent.rcnombre ELSE cli.clnombre END, 1, 30)  

	   ,   A                = SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN ent.RazonSocial ELSE cli.clnombre END, 1, 60)  

      ,   De               = SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN cli.clnombre ELSE ent.RazonSocial END, 1, 60)  

      ,   FirmaCondGener   = --CONVERT(CHAR(10), FechaFirmaCG_Pactos, 103) -->  CONVERT(CHAR(10), clFechaFirma_cond, 103)  

							dbo.Fx_Retorna_Mes( FechaFirmaCG_Pactos )	

	  ,   FechaContrato    = ---CONVERT(CHAR(10), mov.mofecpro, 103)  

								ltrim(rtrim(dbo.Fx_Retorna_Mes( mov.mofecpro )	))

  

      ,   Comprador        = SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN cli.clnombre ELSE ent.RazonSocial END, 1, 60)  

      ,   Vendedor         = SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN ent.RazonSocial ELSE cli.clnombre END, 1, 60)  

  

      ,   FechaCierre      = CONVERT(CHAR(10), mov.mofecpro, 103)  

  

      ,   MonedaComVta     = mon.mnnemo  

      ,   PrecioComVta     = Monto  

      ,   FechaEntreValor  = CONVERT(CHAR(10), mov.mofecinip, 103) --> CONVERT(CHAR(10), mov.mofecvenp, 103)

      ,   FormaEntreValor  = ISNULL(CASE WHEN modcv = 'C' THEN 'EN CUSTODIA DEL CLIENTE'  

                                         WHEN modcv = 'P' THEN 'EN CUSTODIA PROPIA'  

                                         WHEN modcv = 'D' THEN 'TRASPASO EN DCV'  

                                    END,' ')  

      ,   FechaPagoPrecio  = CONVERT(CHAR(10), mov.mofecinip, 103) --> CONVERT(CHAR(10), mov.mofecvenp, 103)

      ,   FormaPagoPrecio  = SUBSTRING( fp1.glosa, 1, 17)  

  

      ,   FechaRetroCompra = CONVERT(CHAR(10), mov.mofecvenp, 103)  

      ,   MonedaRetroCompra= mon.mnnemo  

      ,   PrecioRetroCompra= mov.movptran  

      ,   FormaEntreValorR = ISNULL(CASE WHEN modcv = 'C' THEN 'EN CUSTODIA DEL CLIENTE'  

                                         WHEN modcv = 'P' THEN 'EN CUSTODIA PROPIA'  

                                         WHEN modcv = 'D' THEN 'TRASPASO EN DCV'  

                                    END,' ')  

      ,   FormaPagoPrecioR = SUBSTRING( fp2.glosa, 1, 17)  

      ,   BancoRef         = ' '  

      ,   ValoresSub       = ' '  

      ,   OtrasCond        = ' '  

     -- ,   PP_BANCO         = SUBSTRING( ent.rcnombre, 1, 30)  

	    ,   PP_BANCO         = SUBSTRING( ent.RazonSocial, 1, 60)  

      ,   PP_CLIENTE      = SUBSTRING( cli.clnombre, 1, 60)  

     -- ,   RUT_CLIENTE      = LTRIM(RTRIM( cli.clrut )) + '-' + LTRIM(RTRIM( cli.cldv ))  

	    ,   RUT_CLIENTE      =  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),LTRIM(RTRIM( cli.clrut ))))) ), 1), '.00', ''), ',','.'))+'-' +LTRIM(RTRIM( cli.cldv ))

      ,   NOMCLI           = cli.clnombre  

      ,   CLICUSTODIO      = cli.clnombre  

      ,   CUSTODIO         = ISNULL(CASE WHEN modcv = 'C' THEN cli.clnombre  

                                         WHEN modcv = 'P' THEN ent.RazonSocial --> ent.rcnombre  

                                         WHEN modcv = 'D' THEN 'DEPOSITO DE VALORES'  

                                    END,' ')  

   INTO   #TMP_RETORNO  

   FROM   BacTraderSuda.dbo.MDMO                    mov with(nolock)  

          INNER JOIN (SELECT monumoper, Monto = SUM(movpresen) FROM BacTraderSuda.dbo.MDMO   

                       WHERE monumoper = @nContrato AND motipoper = @cTipoper GROUP BY monumoper) pas ON pas.monumoper = @nContrato  

  

          LEFT  JOIN BacParamSuda.dbo.CLIENTE       cli with(nolock) ON cli.clrut    = mov.morutcli and cli.clcodigo = mov.mocodcli  

          LEFT  JOIN BacParamSuda.dbo.MONEDA        mon with(nolock) ON mon.mncodmon = mov.momonpact  

          LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO fp1 with(nolock) ON fp1.codigo   = mov.moforpagi  

          LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO fp2 with(nolock) ON fp2.codigo   = mov.moforpagv  

  -- ,      BacParamSuda.dbo.ENTIDAD                  ent with(nolock)   

     ,      bacparamsuda.dbo.Contratos_ParametrosGenerales  ent with(nolock) 

   WHERE  mov.monumoper = @nContrato  

   AND    mov.motipoper = @cTipoper  

  





SELECT /*01*/ tmp.FolioContrato  

      ,   /*02*/ tmp.A  

      ,   /*03*/ tmp.De  

      ,   /*04*/ tmp.FirmaCondGener  

      ,   /*05*/ FechaContrato = convert(char(30),tmp.FechaContrato,106)

      ,   /*06*/ tmp.Comprador  

      ,   /*07*/ tmp.Vendedor  

      ,   /*08*/ tmp.FechaCierre  

      ,   /*09*/ tmp.MonedaComVta  

      ,   /*10*/ tmp.PrecioComVta  

      ,   /*11*/ tmp.FechaEntreValor  

      ,   /*12*/ tmp.FormaEntreValor  

	  ,   /*13*/ tmp.FechaPagoPrecio  

      ,   /*14*/ tmp.FormaPagoPrecio  

      ,   /*15*/ tmp.FechaRetroCompra  

      ,   /*16*/ tmp.MonedaRetroCompra  

      ,   /*17*/ tmp.PrecioRetroCompra  

      ,   /*18*/ tmp.FormaEntreValorR  

      ,   /*19*/ tmp.FormaPagoPrecioR  

      ,   /*20*/ tmp.BancoRef  

      ,   /*21*/ tmp.ValoresSub  

      ,   /*22*/ tmp.OtrasCond  

      ,   /*23*/ tmp.PP_BANCO  

      ,   /*24*/ tmp.PP_CLIENTE  

      ,   /*25*/ TipoClaseValor   = ''  

      ,   /*26*/ Emisor           = emgeneric  

      ,   /*27*/ Serie            = ins.inserie  

      ,   /*28*/ SubSerie         = mov.moinstser  

      ,   /*29*/ Emision          = CONVERT(CHAR(10), mov.mofecemi, 103)  

      ,   /*30*/ Vencimiento      = CONVERT(CHAR(10), mov.mofecven, 103)  

      ,   /*31*/ Nominal          = mov.monominal  

      ,   /*32*/ Tasa             = mov.motir  

      ,   /*33*/ NomCli           = tmp.NOMCLI  

      ,   /*34*/ RutCli           = tmp.RUT_CLIENTE  

	 

      ,   /*35*/ CliCustodio      = tmp.CLICUSTODIO  

      ,   /*36*/ Custodio         = tmp.CUSTODIO  



	  	,	'Rut_Banco'		=	(SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, @RutEntidad), 1), '.00', ''), ',','.'))) + '-' + ltrim(rtrim(@DvEntidad)) )

	  --,	'Rut_Banco'				=  ISNULL(@RutEntidad,0) --> '97.023.000-9' --> '97.023.000-9'



	  	----------------------------------------------------------------------------------------------------------

				,	'APODERADO_CLIENTE_1'		= @cNom_Apoderado_Cliente_1

				,	'RUT_APODERADO_CLIENTE_1'	= @cRut_Apoderado_Cliente_1

				--,	'RUT_APODERADO_CLIENTE_11'	=  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Cliente_1))) ), 1), '.00', ''), ',','.'))



				,	'APODERADO_CLIENTE_2'		= @cNom_Apoderado_Cliente_2

				,	'RUT_APODERADO_CLIENTE_2'	= @cRut_Apoderado_Cliente_2

				----------------------------------------------------------------------------------------------------------

							-----------------------------------------------------------------------------------------------------------------------------

				,	'APODERADO_BANCO_1'			= LTRIM(RTRIM( @cNom_Apoderado_Banco_1 ))

				,	'RUT_APODERADO_BANCO_1'		= LTRIM(RTRIM( @cRut_Apoderado_Banco_1 ))

				--,	'RUT_APODERADO_BANCO_1'		=  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Banco_1 ))) ), 1), '.00', ''), ',','.'))



				,	'APODERADO_BANCO_2'			= LTRIM(RTRIM( @cNom_Apoderado_Banco_2 ))

				,	'RUT_APODERADO_BANCO_2'		= LTRIM(RTRIM( @cRut_Apoderado_Banco_2 ))

				-----------------------------------------------------------------------------------------------------------------------------



				--, 'Direcc_Banco'	= (select direccion       = isnull( cldirecc, '')

				--							from bacswapsuda..SwapGeneral

				--								       INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = rut AND clcodigo = codigobanco

				--								        LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com)

				, 'Direcc_Banco'	= @DirecEntidad

				

				, 'Comuna_Banco'	= @ComunaEntidad

				, 'Ciudad_Banco'	= @CiudadEntidad

				--, 'Fono_Banco'		= (select ciudad       = isnull( clfono, 0)

				--							from bacswapsuda..SwapGeneral

				--								       INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = rut AND clcodigo = codigobanco

				--								        LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com)

				, 'Fono_Banco'		= @FonoEntidad

				

				, 'Fax_Banco'		= (select ciudad       = isnull( clfax, 0)

											from bacswapsuda..SwapGeneral

												       INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = rut AND clcodigo = codigobanco

												        LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com)



				, 'Direcc_Cli'	=    @DireccionCliente

				, 'Comuna_Cli'	= 	 ISNULL ((SELECT	COMU.NOMBRE FROM	BACPARAMSUDA..COMUNA COMU   

						INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE

							WHERE	CLRUT = @RUT_CLIENTE),'')

				, 'Ciudad'		= ISNULL ((SELECT	NOMBRE FROM	BACPARAMSUDA..CIUDAD CIU  

						INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE

						WHERE CLRUT = @RUT_CLIENTE),'')



				, 'Fono_Cli' = (SELECT CLFONO FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE)

				, 'Fax_Cli'	=  (SELECT CLFAX FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE)  

				, 'ImagenContrato' = @ImagenContrato

				, 'Clausula_Tipo_Pago'	= @ClausulaTipoPago

				, 'Clausula_Custodia'	= @ClausulaCustodia

	


   FROM   BactraderSuda.dbo.MDMO                 mov with(nolock)   

LEFT JOIN BacParamSuda.dbo.EMISOR      emi with(nolock) ON emi.emrut    = mov.morutemi  

          LEFT JOIN BacParamSuda.dbo.INSTRUMENTO ins with(nolock) ON ins.incodigo = mov.mocodigo  

      ,   #TMP_RETORNO     tmp  

   WHERE  monumoper        = @nContrato  

   AND    motipoper        = @cTipoper  





  --, (select direccion       = isnull( cldirecc, '')

		-- , comuna          = isnull( nom_ciu, '')

		--, ciudad          = isnull( ciudad, '')

		--, telefono        --= isnull( clfono, 0)

		--, fax             --= isnull( clfax, 0)

	 --from bacswapsuda..SwapGeneral

  --        INNER JOIN BacParamSuda.dbo.CLIENTE       ON clrut = rut AND clcodigo = codigobanco

  --        LEFT  JOIN BacParamSuda.dbo.CIUDAD_COMUNA ON clcomuna = cod_com) info2

  

END  



GO
