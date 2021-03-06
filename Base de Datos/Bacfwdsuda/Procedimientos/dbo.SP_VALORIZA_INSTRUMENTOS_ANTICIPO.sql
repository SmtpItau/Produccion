USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZA_INSTRUMENTOS_ANTICIPO]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALORIZA_INSTRUMENTOS_ANTICIPO]
                                (@Id_Sistema		 CHAR(3)            -- 'BTR' o 'BEX'
				,@Codigo_instrumento	 Numeric(9)         -- CaBroker para BFT, 2000 para 'BEX'
				,@Codigo_nemotecnico     CHAR(20)           -- CaSerie
                                ,@Fecha_de_Valorizacion  DATETIME           -- Fecha de Proceso  
                                ,@Nominal                NUMERIC(20,6)      -- CaMtoMon1
                                ,@Tir_Valorizacion       NUMERIC(18,6)      -- Tir para valorizar si Modo = 2
				,@Precio_Valorizacion	 FLOAT = 0.0        -- Precio para valorizar si Modo = 1
                                ,@Modo_Valoriza          INT            -- Indica si se valorizará por precio(1) o por tasa(2) 
				,@MontoTransado		 FLOAT	= 0.0	    -- Monto transado para valorizar en INVEX modalidad 3
                                )
 
AS
BEGIN

DECLARE @COD_FAMILIA         NUMERIC(9)
DECLARE @COD_NEMO            CHAR(20)
DECLARE @NOM_NEMO            CHAR(50)
DECLARE @RUT_EMIS            NUMERIC(9)
DECLARE @TIPO_TASA           NUMERIC(8)
DECLARE @INDICE_BASILEA      NUMERIC(11)
DECLARE @PER_CUPONES 	     NUMERIC(9)
DECLARE @NUM_CUPONES 	     NUMERIC(9)
DECLARE @FECHA_EMIS	     DATETIME
DECLARE @FECHA_VCTO          DATETIME
DECLARE @AFECTO_ENCAJE       CHAR(1)
DECLARE @TASA_EMIS           FLOAT                                            
DECLARE @BASE_TASA_EMI 	     NUMERIC(3)
DECLARE @TASA_VIGENTE        FLOAT 
DECLARE @FECHA_PRIMER_PAGO   DATETIME
DECLARE @DIAS_REALES	     CHAR(3)
DECLARE @TASA_FIJA	     CHAR(1)
DECLARE @MONTO_EMISION       NUMERIC(19,4)
DECLARE @VALOR_SPREAD        FLOAT
DECLARE @Moneda_emision      NUMERIC(5)

DECLARE @Tasa_Emision_Spread  NUMERIC(18,6)
DECLARE @Tasa_Vigente_Spread  NUMERIC(18,6)

declare @Fecha_Vcto_papel     DateTime


	if @Id_sistema = 'BEX'  
	begin
		SET NOCOUNT ON
		SELECT  @COD_FAMILIA       =  COD_FAMILIA		,--1
			@COD_NEMO          =  COD_NEMO		,--2
			@NOM_NEMO          =  NOM_NEMO		,--3
			@RUT_EMIS          =  RUT_EMIS		,--4
			@TIPO_TASA         =  TIPO_TASA		,--5
			@INDICE_BASILEA    =  INDICE_BASILEA	,--6
			@PER_CUPONES       =  PER_CUPONES	,--7
			@NUM_CUPONES 	   =  NUM_CUPONES	,--8
			@FECHA_EMIS	   =  FECHA_EMIS	,--9
			@FECHA_VCTO        =  FECHA_VCTO      	,--10
			@AFECTO_ENCAJE     =  AFECTO_ENCAJE,--11
			@TASA_EMIS         =  TASA_EMIS	,--12                                             
			@BASE_TASA_EMI     =  BASE_TASA_EMI	,--13
			@TASA_VIGENTE      =  TASA_VIGENTE          ,--14                              
			@FECHA_PRIMER_PAGO =  FECHA_PRIMER_PAGO     ,--15    
			@DIAS_REALES	   =  DIAS_REALES	,--16
			@TASA_FIJA	   =  TASA_FIJA	,--17
			@MONTO_EMISION	   =  MONTO_EMISION	,--18
 			@VALOR_SPREAD      =  VALOR_SPREAD,	 --19
	                @Moneda_Emision    =  monemi,
 			@Fecha_Vcto_papel  =  FECHA_VCTO 
		FROM  bacbonosextsuda..TEXT_SER
		WHERE COD_NEMO = @Codigo_nemotecnico --AND FECHA_VCTO = @Fecha_Vcto_papel

		SET NOCOUNT OFF

		Set @Tasa_Emision_Spread   = @TASA_EMIS  - @VALOR_SPREAD
		Set @Tasa_Vigente_Spread  = @TASA_VIGENTE - @VALOR_SPREAD


		EXECUTE  bacbonosextsuda..Svc_Prc_val_ins 
                                 @Fecha_de_Valorizacion,
                                 ' ',
                                 @Modo_Valoriza,
                                 @COD_FAMILIA,
                                 @Codigo_nemotecnico,
                                 @Fecha_Vcto_papel,
                                 @Tir_Valorizacion,                   -- tir ingresada 
                                 @Tasa_Emision_Spread,  
                                 @Tasa_Vigente_Spread,
                                 0,
                                 @BASE_TASA_EMI,
                                 0,
                                 @Nominal,
                                 @MontoTransado, --0 
                                 0,
                                 0,
				 @Precio_Valorizacion,
                                 0,
                                 @Fecha_de_Valorizacion,
                                 @FECHA_EMIS,
                                 @FECHA_VCTO, 
                                 '18991230',      -- Valor de esta fecha aun no conocido, verificar
                                 '18991230',
                                 @Fecha_de_Valorizacion,
                                 0,
                                 0,
                                 0,
                                 0, 
                                 '18991230',
                                 0,
                                 0,
                                 @VALOR_SPREAD,
                                 'S', 
                                 13          ---  Por ahora, preguntar por el tema de la moneda @Moneda_emision
	End
 	else
	Begin
		SET NOCOUNT ON
		declare @Seriado Char(1)
		declare @Existe_Instrumento char(1)
		declare @Valorizador        varchar(50)
		declare @Tas_Est            numeric(21,4)
		select  @Seriado = 'S', @Existe_Instrumento = 'N'
		select  @Seriado = inmdse,
			@Valorizador =  'BacTraderSuda..Sp_' + ltrim( rtrim( inprog ) ),
			@Existe_Instrumento = 'S' from BacParamSuda..INSTRUMENTO where incodigo = @Codigo_Instrumento
		if @Existe_instrumento = 'N' begin
			insert into  bacLineas..debug_Valores
			select 'Instrum. Código =' + @Codigo_Instrumento + ' No existe', 0.0, ' ', 0.0
		end
		-- En esta sección se evalúan las variables utilizadas
                -- cuando la info proviene de navegación de Base de Datos
		declare @Tas_Emis Numeric(21,4)
		declare @Mon_Emis Numeric(9)
		declare @Bas_Emis Numeric(9)
		declare @Fec_Emis DateTime
		declare @dFechaVctoIns DateTime
		IF @Seriado = 'S'
			select 		
				@Tas_Emis = SeTasEmi
				, @Mon_Emis = SeMonEmi 
				, @Bas_Emis = SeBasEmi
				, @Fec_Emis = SeFecEmi
				, @dFechaVctoIns = SeFecVen
			from BacParamSuda..Serie
				where SeMascara = @Codigo_nemotecnico
		else 
		begin
			Set RowCount 1
			select @Tas_Emis = NSTasEmi
				, @Mon_Emis = NSMonEmi
				, @Bas_Emis = NSBasEmi
				, @Fec_Emis = NSFecEmi
				, @dFechaVctoIns = NsFecVen
			from BacParamSuda..NoSerie
				where NSSerie = @Codigo_nemotecnico
			set RowCount 0

		end
		-- Preparando llamada al valorizador
		declare 
		           @nError        INT
		   ,       @fPvp          FLOAT
		   ,       @fMt           FLOAT
		   ,       @fMtum         FLOAT
		   ,       @fMt_cien      FLOAT
		   ,       @fVan          FLOAT
		   ,       @fVpar         FLOAT
		   ,       @nNumucup      INT
		   ,       @dFecucup      DATETIME
		   ,       @fIntucup      FLOAT
		   ,       @fAmoucup      FLOAT
		   ,       @fSalucup      FLOAT
		   ,       @nNumpcup      INT
		   ,       @dFecpcup      DATETIME
		   ,       @fIntpcup      FLOAT
		   ,       @fAmopcup      FLOAT
		   ,       @fSalpcup      FLOAT
		   ,       @fDurat        FLOAT
		   ,       @fConvx        FLOAT
		   ,       @fDurmo        FLOAT
		
		Execute @nError = @Valorizador
				  2 -- Modo del cálculo
				, @Fecha_de_Valorizacion
				, @Codigo_Instrumento
				, @Codigo_nemotecnico
				, @Mon_Emis
				, @Fec_Emis
				, @dFechaVctoIns
				, @Tas_Emis
				, @Bas_Emis
				, @Tas_Est
                                , @Nominal
				, @Tir_Valorizacion 
				, @fPvp        OUTPUT
				, @fMt         OUTPUT  -- <-- Valor Presente en CLP
				, @fMtum       OUTPUT
				, @fMt_cien    OUTPUT
				, @fVan        OUTPUT
				, @fVpar       OUTPUT
				, @nNumucup    OUTPUT
				, @dFecucup    OUTPUT
				, @fIntucup    OUTPUT
				, @fAmoucup    OUTPUT
				, @fSalucup    OUTPUT
				, @nNumpcup    OUTPUT
				, @dFecpcup    OUTPUT
				, @fIntpcup    OUTPUT
				, @fAmopcup    OUTPUT
				, @fSalpcup    OUTPUT
				, @fDurat      OUTPUT
				, @fConvx      OUTPUT
				, @fDurmo      OUTPUT

		SET NOCOUNT OFF
		-- Simula la misma Salida de Bonex, solo para entregar el @fMt
		select @Tir_Valorizacion, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, @fMt  
	End
END

GO
