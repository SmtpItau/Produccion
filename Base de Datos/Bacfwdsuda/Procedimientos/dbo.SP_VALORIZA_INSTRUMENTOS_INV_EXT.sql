USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZA_INSTRUMENTOS_INV_EXT]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALORIZA_INSTRUMENTOS_INV_EXT]
                               (@Codigo_nemotecnico      CHAR(20),
                                @Fecha_Vcto_papel        DATETIME,
                                @Fecha_de_Valorizacion   DATETIME,
                                @Nominal                 NUMERIC(20,6),
                                @Tir_Valorizacion        NUMERIC(18,6),       
                                @Tasa_Fwd_Teorica        NUMERIC(18,6),
                                @Tasa_Spot               NUMERIC(18,6),
                                @Modo_Valoriza           INT      ,
                                @Precio                  FLOAT	= 0.0 ,
				@Monto_Transado          FLOAT	= 0.0
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
                @Moneda_Emision    =  monemi
 
	FROM  bacbonosextsuda..TEXT_SER
	WHERE COD_NEMO = @Codigo_nemotecnico AND FECHA_VCTO = @Fecha_Vcto_papel

	SET NOCOUNT OFF


/*
        SELECT  @COD_FAMILIA       ,--1
		@COD_NEMO          ,--2
		@NOM_NEMO          ,--3
		@RUT_EMIS          ,--4
		@TIPO_TASA         ,--5
		@INDICE_BASILEA    ,--6
		@PER_CUPONES       ,--7
		@NUM_CUPONES 	   ,--8
		@FECHA_EMIS	   ,--9
		@FECHA_VCTO        ,--10
		@AFECTO_ENCAJE     ,--11
		@TASA_EMIS         ,--12                                             
		@BASE_TASA_EMI     ,--13
		@TASA_VIGENTE      ,--14                              
		@FECHA_PRIMER_PAGO ,--15    
		@DIAS_REALES	 ,--16
		@TASA_FIJA	,--17
		@MONTO_EMISION	,--18
		@VALOR_SPREAD   -- 19
*/


Set @Tasa_Emision_Spread   = @TASA_EMIS  - @VALOR_SPREAD
Set @Tasa_Vigente_Spread  = @TASA_VIGENTE - @VALOR_SPREAD


/*                          SELECT @Fecha_de_Valorizacion,
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
                                 @Monto_Transado,		-- MONTO TRANSADO
                                 0,
                                 0,
                                 @Precio,
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
                                 13  


*/

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
                                 @Monto_Transado,		-- MONTO TRANSADO
                                 0,
                                 0,
                                 @Precio,
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
 

END

GO
