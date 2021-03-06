USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRO_PACTOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_FILTRO_PACTOS]
   (   @gsbac_user   VARCHAR(15)  
   ,   @Normativa    VARCHAR(255) = ''  
   ,   @Financiera   VARCHAR(255) = ''  
   ,   @hWnd         NUMERIC(9)  
   ,   @TipOper      CHAR(3)  
   ,   @LCGP_Familia CHAR(5) = ''  --20181221.RCH.LCGP
   )  
AS

begin

	-- Se pondrá el emisor como parte de la data pero no se agrupará   
    -- por emisor.  
    -- SP_FILTRO_PACTOS 'ADMINISTRA' , '', '', 1, 'VI'  select * from  DETALLE_VTAS_CON_PCTO where documento = 79947  
    -- select * from BacParamSuda..tbl_Garantias_Otorgadas_Detalle  
  
	set nocount on  
  
 DECLARE @acfecante     DATETIME  
 , @acfecproc     DATETIME  
  
 DECLARE @cProg                CHAR(10)  
 , @cInstser             CHAR(10)  
 , @mascara              CHAR(10)  
 , @dFeccal             CHAR(10)   
 , @dFecemi              CHAR(10)   
 , @Marca               CHAR(01)   
 , @Moneda              CHAR(03)   
 , @dFecven              CHAR(10) ;  
  
 DECLARE @iModcal              INTEGER   
 , @iCodigo              INTEGER   
 , @plazo       INTEGER    
 , @iMonemi              INTEGER  ;  
  
  
 DECLARE @Nominal      FLOAT   
 , @Tasa_Compra         FLOAT   
 , @Valor_Par           FLOAT   
 , @Valor_Presente      FLOAT   
 , @Margen              FLOAT   
 , @Valor_Inicial       FLOAT   
 , @fTasemi              FLOAT   
 , @fBasemi              FLOAT   
 , @fTasest              FLOAT   
 , @fNominal             FLOAT   
 , @fTir                 FLOAT   
 , @fPvp                 FLOAT   
 , @fMT                  FLOAT  ;  
  
 DECLARE @Usuario             VARCHAR(15)   
 , @Serie               VARCHAR(20) ;  
  
 DECLARE @Documento           NUMERIC(9)   
 , @Correlativo         NUMERIC(9)   
 , @Ventana             NUMERIC(9) ;  
  
 DECLARE @RutBCCH               NUMERIC(13);  --20181221.RCH.LCGP
 DECLARE @RutTGR				NUMERIC(13);  --20181221.RCH.LCGP

IF (@LCGP_Familia !='')
BEGIN
	IF (@LCGP_Familia='TGR')
		SELECT @RutTGR=EMRUT FROM VIEW_EMISOR WHERE emgeneric=@LCGP_Familia
	ELSE
		SELECT @RutBCCH=EMRUT FROM VIEW_EMISOR WHERE emgeneric=@LCGP_Familia
END		  
	  
   SELECT  @acfecante   = acfecante   
   ,       @acfecproc   = acfecproc  
   ,       @RutBCCH     = acRutBCCH  
   FROM dbo.MDAC WITH(NOLOCK)   ;  
   
   
 --ARM  
  create table #haircut_soma(
   codigotmp numeric(5),
   haircutmp numeric(5,4),
   serietmp varchar(9)
   )
  create table #tasareferencial_soma(
   codigoreftmp numeric(5),
   tasareftmp numeric(5,4),
   seriereftmp varchar(9)
   )
  
   create table #margen_soma(
    codigomargentmp numeric(5),
    margentmp numeric(5,4),
    seriemargentmp varchar(9)
    )
  
   CREATE TABLE #DETALLE_VTAS_CON_PCTO (  
 Usuario   VARCHAR(15)  NOT NULL  ,  
 Marca    CHAR(1)  NOT NULL  ,  
 Documento   NUMERIC(9,0)  NOT NULL  ,  
 Correlativo   NUMERIC(9, 0)  NOT NULL  ,  
 Serie    VARCHAR(20)  NOT NULL  ,  
 Moneda    CHAR(3)  NOT NULL  ,  
 Nominal_Compra   FLOAT   NOT NULL  ,  
 Tasa_Compra   FLOAT  NOT NULL  ,  
 Valor_Par   FLOAT   NOT NULL  ,  
 Valor_Presente   NUMERIC(19,4)  NOT NULL  ,  
 Margen    FLOAT   NOT NULL  ,  
 Valor_Inicial   NUMERIC(19,4)  NOT NULL  ,  
 Nominal_Venta   FLOAT   NOT NULL  ,  
 Tasa_Venta   FLOAT   NOT NULL  ,  
 vPar_Venta   FLOAT   NOT NULL  ,  
 vPresente_Venta  NUMERIC(19,4)  NOT NULL  ,  
 vInicial_Venta   NUMERIC(19,4)  NOT NULL  ,  
 Plazo    NUMERIC(21,0)  NOT NULL  ,  
 Ventana   NUMERIC(9,0)  NOT NULL  ,  
 CarteraSuper   CHAR (1)  NOT NULL ,  
 BloqueoPacto  NUMERIC(19,4) NOT NULL ,  
 Haircut   FLOAT  NOT NULL ,  
 Tipooper  CHAR(3)  NOT NULL ,  
 Rut_Emisor   NUMERIC(9,0)  NOT NULL  ,  
 InCodigo  NUMERIC(3,0) NOT NULL ,  
 InUnidadTiempoTasaRef  CHAR(3)  NOT NULL ,  
 InEstrucPlazoTasaRef   CHAR(2)  NOT NULL ,  
 DiFecSal  DATETIME NOT NULL ,  
 Clasif_Riesgo    CHAR(3)  NOT NULL ,    --->PRD-6006 CASS 10-12-2010   
 Fecha_UltCup  CHAR(10)        NOT NULL ,    --->PRD-6006 CASS 10-12-2010  
 Convexidad   FLOAT   NOT NULL  ,    --->PRD-6006 CASS 10-12-2010   
 DurMod    FLOAT   NOT NULL  ,    --->PRD-6006 CASS 10-12-2010   
 DurMac    FLOAT   NOT NULL  ,    --->PRD-6006 CASS 10-12-2010   
 cCustodia      CHAR(1)  NOT NULL  ,    --->PRD-6006 CASS 17-12-2010  
    Fecha_Vence     datetime        NOT NULL        ,    --->PRD-6006 MAP  28-12-2010  
        Mon_Emisor              integer         NULL            );   --->PRD-6006 MAP  28-12-2010   
  
 --CREATE INDEX #id_det_vtas_pcto ON #DETALLE_VTAS_CON_PCTO (Usuario,Ventana,Marca,Documento,Correlativo,Serie)  
 --CREATE CLUSTERED INDEX  #id_det_vtas_pcto2 ON #DETALLE_VTAS_CON_PCTO (CarteraSuper, Serie, Moneda, Plazo, Margen, HairCut, Tasa_Venta , Rut_Emisor, cCustodia)  
  
  
        INSERT INTO #DETALLE_VTAS_CON_PCTO   
       (  Usuario    
       , Marca     
 , Documento    
 , Correlativo    
 , Serie     
 , Moneda     
 , Nominal_Compra    
 , Tasa_Compra    
 , Valor_Par    
 , Valor_Presente    
 , Margen     
 , Valor_Inicial    
 , Nominal_Venta    
 , Tasa_Venta    
 , vPar_Venta    
 , vPresente_Venta   
 , vInicial_Venta    
 , Plazo     
 , Ventana    
 , CarteraSuper    
 , BloqueoPacto   
 , Haircut    
 , Tipooper   
 , Rut_Emisor    
 , InCodigo   
 , InUnidadTiempoTasaRef   
 , InEstrucPlazoTasaRef    
 , DiFecSal   
 , Clasif_Riesgo  
 , Fecha_UltCup    
 , Convexidad     
 , DurMod      
 , DurMac     
 , cCustodia --'PRD-6006 CASS 17-12-2010  
        ,       Fecha_Vence               
        ,       Mon_Emisor                
 )  
  
  
   SELECT DISTINCT   
		  Usuario             = @gsbac_user  
   ,      Marca               = ISNULL(bl.blusuario,'N')   
   ,      Documento           = cp.cpnumdocu  
   ,      Correlativo         = cp.cpcorrela  
   ,      Serie               = cp.cpinstser  
   ,      Moneda              = mn.mnnemo  
   ,      Nominal_Compra      = cp.cpnominal - ISNULL( bpNominal , 0.0 ) * ( CASE WHEN cp.cpnominal - ISNULL( bpNominal , 0.0 ) < 0 THEN 0.0 ELSE 1.0 END )   
   ,      Tasa_Compra         = cp.cptircomp   
   ,      Valor_Par           = cp.cpvpcomp  
   ,      Valor_Presente      = cp.cpvptirc * ( 1.0 - ISNULL( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  ) -- PRD-6005  
                                  * ( CASE WHEN cp.cpnominal - ISNULL( bpNominal , 0.0 ) < 0 THEN 0.0 ELSE 1.0 END )  
   ,      Margen              =  1.0  
   ,      Valor_Inicial       = cp.cpvptirc * ( 1.0 - ISNULL( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  ) * 1.0  
                                   * ( CASE WHEN cp.cpnominal - ISNULL( bpNominal , 0.0 ) < 0 THEN 0.0 ELSE 1.0 END )        
   ,      Nominal_Venta       = 0.0  
   ,      Tasa_Venta          = ISNULL( vm.tasa_mercado, 0 )  + 0.00   
   ,      vPar_Venta          = 0.0  
   ,      vPresente_Venta     = 0.0  
   ,      vInicial_Venta      = 0.0  
   ,      Plazo               = DATEDIFF(DAY, @acfecproc, di.difecsal)  
   ,      Ventana             = @hWnd  
   ,      cp.Codigo_carterasuper  
   ,      BloqueoPacto        = ISNULL( bpNominal, 0.0 ) * 1.0               
   ,      HairCut             = 0.0                
   ,      Tipoper             = @TipOper   
   ,      Rut_Emisor          = ISNULL( Em.EmRut, 0 )   
   ,      InCodigo				= fi.incodigo  
   ,		InUnidadTiempoTasaRef = ISNULL(fi.InUnidadTiempoTasaRef,'')  
   ,   InEstrucPlazoTasaRef  = ISNULL(fi.InEstrucPlazoTasaRef,'')   
   ,   DiFecSal  = @acfecproc  
   ,   Clasif_Riesgo  = isnull (em.tipo_corto1,'')  
   ,   Fecha_UltCup  = convert(datetime,cp.cpfecpcup,103) -->PRD-6006 CASS 13-12-2010   
   ,   Convexidad   = cp.cpconvex  
   ,   DurMod   = cp.cpdurmod   
   ,   DurMac   = cp.cpdurat  
   ,     cCustodia    = cp.cpdcv        -->PRD-6006 CASS 17-12-2010   
   ,      Fecha_Vence           = cp.cpfecven  
   ,      Mon_Emisor            = di.dimoneda  
  
   FROM   dbo.MDCP              cp WITH(NOLOCK)  
         INNER JOIN dbo.MDDI    di WITH(NOLOCK) ON di.dinumdocu  = cp.cpnumdocu   
         AND di.dicorrela      = cp.cpcorrela   
          AND di.ditipoper      = 'CP'   
--   AND di.dinemmon       <> 'USD'   
  
         LEFT JOIN  bacParamsuda..emisor Em WITH(NOLOCK)  
       ON   Em.EmGeneric = di.digenemi   
                  --  AND  Em.emtipo IN ('1', '2')     -- 20181226.RCH.LCGP, Instituciones Financieras  
                    AND  NOT ( Em.Emnombre LIKE '%NULO%' )  
                    AND  NOT ( Em.Emnombre LIKE '%MUTUO%' )  
  
         LEFT JOIN BacParamSuda..Cliente Cli WITH(NOLOCK)      
                    ON  Em.EmRut     = Cli.Clrut  
                    AND  Cli.ClCodigo = 1  -- Evita duplicados  
                    AND  Cli.CltipCli = 1  -- Bancos  
  
         LEFT JOIN dbo.BloqueadoPacto BlPact WITH(NOLOCK)  ON     BlPact.bpnumdocu = di.dinumdocu    
                                                              AND BlPact.bpcorrela = di.dicorrela  
         
         INNER JOIN BacParamSuda.dbo.INSTRUMENTO fi WITH(NOLOCK) ON fi.incodigo           = cp.cpcodigo  
         and di.DiSerie    = fi.inserie  
  
         LEFT  JOIN BacParamSuda.dbo.MONEDA      mn WITH(NOLOCK) ON mn.mnnemo = di.dinemmon   
         LEFT  JOIN dbo.MDBL                     bl WITH(NOLOCK) ON bl.blrutcart          = cp.cprutcart   
                                                                 AND bl.blnumdocu         = cp.cpnumdocu   
                                                     AND bl.blcorrela         = cp.cpcorrela  
  
         LEFT JOIN BacTraderSuda.dbo.VALORIZACION_MERCADO vm WITH(NOLOCK)  ON vm.fecha_valorizacion = @acfecante  
                                                                        AND vm.rminstser    = cp.cpinstser  
   WHERE cp.cpnominal > 0  
   AND   cp.Estado_Operacion_Linea = ''  
   AND   isnull(bl.blusuario,'')   = ''  
   AND  (CHARINDEX( LTRIM(RTRIM(cp.cptipcart))          , @Financiera) > 0 or @Financiera = '')  
   AND  (CHARINDEX( LTRIM(RTRIM(cp.codigo_carterasuper)), @Normativa)  > 0 or @Normativa  = '')  
   
   -->	Condicion que permite visualizar la cartera excluyendo las operaciones compradas PM
   and	cp.fecha_pagomañana	   <= (	select acfecproc from BacTraderSuda.dbo.mdac with(nolock) )
   -->	Condicion que permite visualizar la cartera excluyendo las operaciones compradas PM

   --ORDER BY cp.cpnumdocu, cp.cpcorrela  



   -- Se agregan las compras con Pacto  
        INSERT INTO #DETALLE_VTAS_CON_PCTO   
       (  Usuario    
       , Marca     
 , Documento    
 , Correlativo    
 , Serie     
 , Moneda     
 , Nominal_Compra    
 , Tasa_Compra    
 , Valor_Par    
 , Valor_Presente    
 , Margen     
 , Valor_Inicial    
 , Nominal_Venta    
 , Tasa_Venta    
 , vPar_Venta    
 , vPresente_Venta   
 , vInicial_Venta    
 , Plazo     
 , Ventana    
 , CarteraSuper    
 , BloqueoPacto   
 , Haircut    
 , Tipooper   
 , Rut_Emisor    
 , InCodigo   
 , InUnidadTiempoTasaRef   
 , InEstrucPlazoTasaRef    
 , DiFecSal   
 , Clasif_Riesgo  
 , Fecha_UltCup    
 , Convexidad     
 , DurMod      
 , DurMac     
 , cCustodia --'PRD-6006 CASS 17-12-2010  
        ,       Fecha_Vence               
        ,       Mon_Emisor                
 )  
  
  
   SELECT DISTINCT   
   Usuario             = @gsbac_user  
   ,      Marca               = ISNULL(bl.blusuario,'N')   
   ,      Documento           = cp.cinumdocu  
   ,      Correlativo         = cp.cicorrela  
   ,      Serie               = cp.ciinstser  
   ,      Moneda              = mn.mnnemo  
   ,      Nominal_Compra      = cp.cinominal - ISNULL( bpNominal , 0.0 ) * ( CASE WHEN cp.cinominal - ISNULL( bpNominal , 0.0 ) < 0 THEN 0.0 ELSE 1.0 END )   
   ,      Tasa_Compra         = cp.citircomp   
   ,      Valor_Par           = cp.civpcomp  
   ,      Valor_Presente      = cp.civptirc * ( 1.0 - ISNULL( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  ) -- PRD-6005  
                                  * ( CASE WHEN cp.cinominal - ISNULL( bpNominal , 0.0 ) < 0 THEN 0.0 ELSE 1.0 END )  
   ,      Margen              =  1.0  
   ,      Valor_Inicial       = cp.civptirc * ( 1.0 - ISNULL( bpNominal, 0.0 ) * 1.0 / (DiNominal * 1.0)  ) * 1.0  
                                 * ( CASE WHEN cp.cinominal - ISNULL( bpNominal , 0.0 ) < 0 THEN 0.0 ELSE 1.0 END )        
   ,      Nominal_Venta       = 0.0  
   ,      Tasa_Venta          = ISNULL( vm.tasa_mercado, 0 )  + 0.00   
   ,      vPar_Venta        = 0.0  
   ,      vPresente_Venta     = 0.0  
   ,      vInicial_Venta      = 0.0  
   ,      Plazo               = DATEDIFF(DAY, @acfecproc, di.difecsal)  
   ,      Ventana             = @hWnd  
   ,      cp.Codigo_carterasuper  
   ,      BloqueoPacto        = ISNULL( bpNominal, 0.0 ) * 1.0               
   ,      HairCut             = 0.0                
   ,      Tipoper             = @TipOper   
   ,      Rut_Emisor          = ISNULL( Em.EmRut, 0 )   
   ,      InCodigo       = fi.incodigo  
   ,   InUnidadTiempoTasaRef = ISNULL(fi.InUnidadTiempoTasaRef,'')  
   ,   InEstrucPlazoTasaRef  = ISNULL(fi.InEstrucPlazoTasaRef,'')   
   ,   DiFecSal  = @acfecproc  
   ,   Clasif_Riesgo  = isnull(em.tipo_corto1,'')  
   ,   Fecha_UltCup  = convert(datetime,cp.cifecpcup,103) -->PRD-6006 CASS 13-12-2010   
   ,   Convexidad   = cp.ciconvex  
   ,   DurMod   = cp.cidurmod   
   ,   DurMac   = cp.cidurat  
   ,     cCustodia    = cp.cidcv        -->PRD-6006 CASS 17-12-2010   
   ,      Fecha_Vence           = cp.cifecven  
   ,      Mon_Emisor            = mn.mncodmon   
  
   FROM   dbo.MDCI              cp WITH(NOLOCK)  
  INNER JOIN dbo.MDDI    di WITH(NOLOCK) ON di.dinumdocu  = cp.cinumdocu   
         AND di.dicorrela      = cp.cicorrela   
          AND di.ditipoper      = 'CI'   
--   AND di.dinemmon       <> 'USD'  
  
         LEFT JOIN  bacParamsuda..emisor Em WITH(NOLOCK)  
                    ON   Em.EmGeneric = di.digenemi   
                    AND  Em.emtipo = 2     -- Instituciones Financieras  
                    AND  NOT ( Em.Emnombre LIKE '%NULO%' )  
                    AND  NOT ( Em.Emnombre LIKE '%MUTUO%' )  
  
         LEFT JOIN BacParamSuda..Cliente Cli WITH(NOLOCK)      
                    ON  Em.EmRut     = Cli.Clrut  
                    AND  Cli.ClCodigo = 1  -- Evita duplicados  
                    AND  Cli.CltipCli = 1  -- Bancos  
  
         LEFT JOIN dbo.BloqueadoPacto BlPact WITH(NOLOCK)  ON     BlPact.bpnumdocu = di.dinumdocu    
                                                              AND BlPact.bpcorrela = di.dicorrela  
         
         INNER JOIN BacParamSuda.dbo.INSTRUMENTO fi WITH(NOLOCK) ON fi.incodigo           = cp.cicodigo  
         and di.DiSerie    = fi.inserie  
  
         LEFT  JOIN BacParamSuda.dbo.MONEDA      mn WITH(NOLOCK) ON mn.mncodmon = Cp.cimonemi   
         LEFT  JOIN dbo.MDBL                     bl WITH(NOLOCK) ON bl.blrutcart          = cp.cirutcart   
                                                                 AND bl.blnumdocu         = cp.cinumdocu   
                                                     AND bl.blcorrela         = cp.cicorrela  
  
         LEFT JOIN BacTraderSuda.dbo.VALORIZACION_MERCADO vm WITH(NOLOCK)  ON vm.fecha_valorizacion = @acfecante  
                                                                        AND vm.rminstser    = cp.ciinstser  
   WHERE di.dinominal > 0   
   AND   cp.Estado_Operacion_Linea = ''  
   AND   isnull(bl.blusuario,'')   = ''  
   AND  (CHARINDEX( LTRIM(RTRIM(cp.citipcart))          , @Financiera) > 0 or @Financiera = '')  
   AND  (CHARINDEX( LTRIM(RTRIM(cp.codigo_carterasuper)), @Normativa)  > 0 or @Normativa  = '')  
   -- Se agregan las compras con Pacto  
 
  
  
   DELETE #DETALLE_VTAS_CON_PCTO   
   FROM MDBL  
   WHERE (Documento = blnumdocu   
   AND Correlativo = blcorrela   
   AND blusuario = Usuario)  
   AND  Usuario   = @gsbac_user  
  
  
   -- Descarte de Nominales Otorgados en Garantía  
   update #DETALLE_VTAS_CON_PCTO   
   set  
          Nominal_Compra      = Nominal_Compra * ( 1.0 - isnull( Gar.Nominal, 0.0 ) * 1.0 / ( Nominal_Compra * 1.0 ) ) * 1.0  
                                               * ( case when Nominal_Compra - isnull( Gar.Nominal, 0.0 ) < 0 then 0.0 else 1.0 end )  
   ,      Valor_Presente      = Valor_Presente * ( 1.0 - isnull( Gar.Nominal, 0.0 ) * 1.0 / ( Nominal_Compra * 1.0 ) ) * 1.0  
                                                 * ( case when Nominal_Compra - isnull( Gar.Nominal, 0.0 ) < 0 then 0.0 else 1.0 end )  
   ,      Valor_Inicial       = Valor_Inicial * ( 1.0 - isnull( Gar.Nominal, 0.0 ) * 1.0 / ( Nominal_Compra * 1.0 ) ) * 1.0  
                                                 * ( case when Nominal_Compra - isnull( Gar.Nominal, 0.0 ) < 0 then 0.0 else 1.0 end )  
   from BacParamSuda..tbl_Garantias_Otorgadas_Detalle Gar    
   where Gar.Numdocu     = #DETALLE_VTAS_CON_PCTO.Documento            
            and Gar.Correlativo = #DETALLE_VTAS_CON_PCTO.Correlativo  
  
   -- Fin Descarte de Nominales Otorgados en Garantía  
  
   DELETE   
   FROM  dbo.DETALLE_VTAS_CON_PCTO     
   WHERE Usuario = @gsbac_user  
   AND Ventana = @hWnd     
-- select * from DETALLE_VTAS_CON_PCTO  
   INSERT INTO dbo.DETALLE_VTAS_CON_PCTO    
   (   Usuario  
   ,   Marca  
   ,   Documento  
   ,   Correlativo  
   ,   Serie  
   ,   Moneda  
   ,   Nominal_Compra  
   ,   Tasa_Compra  
   ,   Valor_Par  
   ,   Valor_Presente  
   ,   Margen  
   ,   Valor_Inicial  
   ,   Nominal_Venta  
   ,   Tasa_Venta  
   ,   vPar_Venta  
   ,   vPresente_Venta  
   , vInicial_Venta  
   ,   Plazo  
   ,   Ventana  
   ,   CarteraSuper   
   ,   BloqueoPacto    -- PRD-6005    
   ,   HairCut         -- PRD-6007  
   ,   Tipoper         -- PRD-6007  
   ,   Rut_Emisor      -- PRD-6006  
   ,   cCustodia       -- PRD-6006 CASS 17-12-2010  
   ,   Fecha_vence  
   ,   Mon_Emisor  
   )  
 -- Campos en Orden Fisico en table: DETALLE_VTAS_CON_PCTO  
 -- Usuario         Marca           Documento      Correlativo    Serie                  
 -- Moneda          Nominal_Compra  Tasa_Compra    Valor_Par                                               
 -- Valor_Presente  Margen          Valor_Inicial  Nominal_Venta  Tasa_Venta                                              
 -- vPar_Venta      vPresente_Venta vInicial_Venta Plazo          Ventana       
 -- Fecha_Emision   Fecha_Vence     Fecha_UltCup   Fecha_SigCup   Numero_Cupon   
 -- Rut_Emisor      Mon_Emisor      Convexidad     DurMod         DurMac                                                  
 -- TasaEstimada    CarteraSuper    BloqueoPacto   HairCut        TipOper   
 -- FolioBCCH       CorrelaBCCH     inCodigo       MarcaVta       cCustodia   
 -- cClave            
  SELECT DISTINCT   
   Usuario            =  Usuario   
   ,      Marca              =  Marca  
   ,      Documento          =  Documento  
   ,      Correlativo        =  Correlativo  
   ,      Serie              =  Serie  
   ,      Moneda             =  Moneda  
   ,      Nominal_Compra     =  Nominal_Compra                                 
   ,      Tasa_Compra        =  Tasa_Compra   
   ,      Valor_Par          =  Valor_Par  
   ,      Valor_Presente     =  Valor_Presente                                                             
   ,      Margen             =  Margen  
   ,      Valor_Inicial      =  Valor_Inicial                               
   ,      Nominal_Venta      =  Nominal_Venta  
   ,      Tasa_Venta         =  0--Tasa_Venta  
   ,      vPar_Venta         =  vPar_Venta  
   ,      vPresente_Venta    =  vPresente_Venta  
   ,      vInicial_Venta     =  vInicial_Venta  
   ,      Plazo              =  Plazo   
   ,      Ventana            =  Ventana  
   ,      carterasuper      =  carterasuper  
   ,      BloqueoPacto       =  BloqueoPacto      -- PRD-6005  
   ,      HairCut            =  HairCut           -- PRD-6007  
   ,      Tipoper            =  Tipooper  
   ,      Rut_Emisor         =  Rut_Emisor  
   ,      cCustodia          =  cCustodia  
,      Fecha_vence        = Fecha_vence  
   ,      Mon_Emisor         = Mon_Emisor         
   FROM   #DETALLE_VTAS_CON_PCTO  
  

  
   SELECT Serie      = Serie  
   ,      Moneda     = Moneda  
   ,      Nominal    = SUM( Nominal_Compra )  
   ,     Tir        = Tasa_venta --Tasa_Compra  -- PROD-6007 HairCut, Aplicar Tasa Referencia, única para la serie  
   ,      vPar       = AVG( Valor_Par )  
   ,      vPresent   = SUM( Valor_Presente )  
   ,      Plazo      = Plazo  
   ,      Margen     = Margen                  --  PRD-6007  antes AVG( Margen )  
   ,      vinicial   = SUM( Valor_Inicial )  
   ,      Cartera    = CarteraSuper  
   ,      IDENTITY(NUMERIC(10))  AS Registro  
   ,      BloqueoPacto   = SUM(BloqueoPacto)  -- PRD-6005  
   ,      HairCut         = HairCut            -- PRD-6007   
   ,      Rut_Emisor     = Rut_Emisor         -- PRD-6006  
   ,   cCustodia  = cCustodia      -- PRD-6006 CASS 17-12-2010  
   INTO   #TemporalPcto  
   FROM   dbo.DETALLE_VTAS_CON_PCTO  
   WHERE  Marca    = 'N'  
   AND    Ventana  = @hWnd  
   AND    Usuario  = @gsbac_user  
   GROUP BY CarteraSuper, Serie, Moneda, Plazo, Margen, HairCut, Tasa_Venta , Rut_Emisor, cCustodia --'PRD-6006 CASS 17-12-2010  
  
   CREATE INDEX #id_Temporal_vtas_pcto ON #TemporalPcto (Registro)  
  
  
  
   DECLARE @Registro NUMERIC(10)  
  
     CREATE TABLE #DatosSerie(   
      nerror       INTEGER  ,  
   cmascara     CHAR(12) ,  
   codigo  INTEGER  ,  
   cserie       CHAR(12) ,  
   nrutemi      NUMERIC(9,0) ,  
   nmonemi     	INTEGER		,
   ftasemi     	FLOAT		,
   nbasemi      NUMERIC(3,0) ,  
   dfecemi      CHAR(10) ,  
   dfecven      CHAR(10) ,  
   crefnomi     CHAR(1)  ,  
   cgenemi      CHAR(10) ,  
   cnemmon      CHAR(5)  ,  
   ncorte       NUMERIC(19,4) ,  
   cseriado     CHAR(1)  ,  
   clecemi      CHAR(6)  ,  
   fecpro      CHAR(10) );  
   
  
       -- Tabla para recibir datos de la Valorizacion  
  CREATE TABLE   
   #Valorizacion(  
   fError   INTEGER  ,  
   fNominal FLOAT  ,  
   fTir  FLOAT  ,   
   fPvp  FLOAT  ,  
   fMT  FLOAT  ,  
   fMTUM  FLOAT  ,  
   fMT_cien FLOAT  ,  
   fVan  FLOAT  ,  
   fVpar  FLOAT  ,  
   nNumucup INTEGER  ,  
   cFecucup CHAR(10) ,  
   fIntucup FLOAT  ,  
   fAmoucup FLOAT  ,  
   fSalucup FLOAT  ,  
   nNumpcup FLOAT  ,  
   cFecpcup CHAR(10) ,  
   fIntpcup FLOAT  ,  
   fAmopcup FLOAT  ,  
   fSalpcup FLOAT  ,  
   fDurat  FLOAT  ,  
   fConvx  FLOAT  ,  
   fDurmo  FLOAT   );  
  
  DECLARE @nNumucup INTEGER  ,  
   @cFecucup CHAR(10) ,  
   @cFecpcup CHAR(10) ,  
   @fDurat  FLOAT  ,  
   @fConvx  FLOAT  ,  
   @fDurmo  FLOAT   ,  
   @nrutemi NUMERIC(9) ,  
   @modcal  SMALLINT   
  
  DECLARE @estado INTEGER;  
  DECLARE @itotal  INTEGER   
  DECLARE @imenor  INTEGER   
   
  SET @itotal = (SELECT MAX(registro) FROM #TemporalPcto)  
  SET @imenor = (SELECT MIN(registro) FROM #TemporalPcto)  
  
  WHILE 1 > =2 ---@itotal >= @imenor   -- Evaluar si es necesario valorizar los papeles   
  BEGIN   
    SELECT @Serie  = serie  ,    
     @registro = registro ,  
     @Nominal = Nominal       ,          
     @fmt  = 0      ,          
                   @ftir           = Tir    
       FROM #TemporalPcto  
      WHERE registro =@imenor  
    
           if @nominal <> 0       
           BEGIN     
     SET @mascara  = @serie    
    
    
        /* ________________________________________________________________________________________________}  
    Cargo datos de las series para poder valorizar       |  
    ================================================================================================} */  
  
     TRUNCATE TABLE #DatosSerie;  
    
     INSERT INTO #DatosSerie    
     EXECUTE sp_chkinstser @mascara;  
    
     SELECT  @mascara = cmascara ,  
      @imonemi = nmonemi ,  
      @icodigo = codigo  ,  
      @dFecemi = CONVERT(CHAR(10),CONVERT(DATETIME,dFecemi,103),112),  
      @dFecven = CONVERT(CHAR(10),CONVERT(DATETIME,dFecven,103),112),  
      @ftasemi = ftasemi ,  
      @fbasemi = nbasemi ,  
      @ftasest = 0.0  ,  
      @fnominal= @nominal ,  
      @fpvp=0.0  ,  
@fmt=0.0  ,    -- PROD 6007 Aplicar HairCut, se valoriza por tasa  
      @nrutemi=nrutemi   
     FROM #DatosSerie;    
    
                   -- PROD 6007 Aplicar Hair-Cut  
                   -- La primera valorización debe ser por indicación de tasa mercado  
                   -- no por el valor presente   
     -- SET @modcal=3  
                   -- Faltaria aplicar los efectos del margen   
  
                   SET @modcal=2  
     
     SET @dfeccal = CONVERT(CHAR(10),@acfecproc,112);  
    
  
     TRUNCATE TABLE #Valorizacion;  
  
     INSERT INTO #Valorizacion  
     EXECUTE sp_valorizar_client  
      @modcal,  
      @dfeccal,  
      @iCodigo,  
      @Mascara,  
      @iMonemi,  
      @dFecemi,  
      @dFecven,  
      @fTasemi,  
      @fBasemi,  
      @fTasest,  
      @fNominal,  
      @fTir,  
      @fPvp,  
      @fMT  
    
     SELECT  @fmt   = FMT   ,  
      @fPvp  = fPvp  ,  
      @nNumucup = nNumucup  ,  
      @cFecucup = cFecucup  ,  
      @cFecpcup = cFecpcup  ,  
      @fDurat  = fDurat ,  
      @fConvx  = fConvx ,  
      @fDurmo  = fDurmo         
            FROM #Valorizacion;  
    
    
     UPDATE  #TemporalPcto   
            SET  vpar  = @fPvp             
                      , vPresent  = @fmt            
                      , vInicial  = @fmt * Margen   
     WHERE registro = @registro  
     
     UPDATE dbo.DETALLE_VTAS_CON_PCTO    
     SET   Valor_Presente = @fmt * ( nominal_compra / @nominal )  
                , Valor_Inicial  = @fmt * Margen * ( nominal_compra / @nominal )    ---> PROD 6007 Aplicar HairCut   
                , Valor_Par    = @fPvp                                            ---> PROD 6007 Aplicar HairCut  
         , Fecha_Vence    = @dFecven             ---> PRD 6006 CASS 09-12-2010  
         , Mon_Emisor     = @imonemi             ---> PRD 6006 CASS 09-12-2010  
         , InCodigo      = @icodigo             ---> PRD 6006 CASS 09-12-2010  
         , Fecha_UltCup   = @cFecpcup     ---> PRD-6006 CASS 10-12-2010  
         , Convexidad     = @fConvx       ---> PRD-6006 CASS 10-12-2010   
         , DurMod       = @fDurmo        ---> PRD-6006 CASS 10-12-2010   
         , DurMac       = @fDurat        ---> PRD-6006 CASS 10-12-2010   
     WHERE  Marca    = 'N'  
     AND    Ventana  = @hWnd  
     AND    Usuario  = @gsbac_user  
     AND    serie    = @Serie  
  
  END  
  
  SET @imenor=@imenor+1    
   
END   
-----------------------------  
  -- Retorna valor haircut soma
	insert into #haircut_soma  
    select  hs.hcincodigo,
            hs.hchaircut,
            i.inserie
    from    bacparamsuda..HAIRCUT_SOMA hs,
            bacparamsuda..instrumento i
    where hs.hcincodigo=i.incodigo

    update #TemporalPcto
    set    HairCut = hs.haircutmp
    from  #TemporalPcto pc,
         #haircut_soma hs 
    where substring(pc.Serie,1,3) = hs.serietmp
-----------------------------
  -- Retorna valor tasareferencial soma
	insert into #tasareferencial_soma  
    select ts.trincodigo,
          ts.trtasareferencial,
          i.inserie
    from  bacparamsuda..TASA_REFERENCIA_SOMA ts,
          bacparamsuda..instrumento i
    where ts.trincodigo=i.incodigo

    update #TemporalPcto
    set    TIR = hs.tasareftmp
    from  #TemporalPcto pc,
         #tasareferencial_soma hs 
    where substring(pc.Serie,1,3) = hs.seriereftmp    

-----------------------------
  -- Retorna valor Margen soma
	insert into #margen_soma  
    select mi.codigo_instrumento,
           mi.margen,
           i.inserie
    from   bacparamsuda..MARGEN_INSTRUMENTO_SOMA mi,
           bacparamsuda..instrumento i
    where  mi.codigo_instrumento=i.incodigo

    update #TemporalPcto
    set    Margen = hs.margentmp
    from   #TemporalPcto pc,
           #margen_soma hs 
    where substring(pc.Serie,1,3) = hs.seriemargentmp 

/****20181226.RCH.LCGP***********/
IF (@LCGP_Familia !='')
BEGIN
	IF (@LCGP_Familia='TGR')
	   SELECT		  Serie   
			   ,      Moneda  
			   ,      CASE WHEN Nominal < 0 THEN 0 ELSE Nominal END  
			   ,      TIR--CAST( ( Tir - HairCut) AS NUMERIC(10,4))   -- PROD-6007 Por presentación, se seprar el Haircut. 
			   ,      vPar  
			   ,      CASE WHEN Nominal < 0 THEN 0 ELSE vPresent END  
			   ,      Plazo   
			   ,      Margen  
			   ,      CASE WHEN Nominal < 0 THEN 0 ELSE vinicial END  
			   ,      tbglosa  
			   ,      cartera   -- Corresponde al código de Cartera  
			   ,      BloqueoPacto  -- PRD-6005  
			   ,      HairCut       -- PRD-6007  
			   ,      Rut_Emisor    -- PRD-6006  será necesario llenar la grilla   
			   ,	  EmGeneric     = ISNULL( ( SELECT MAX( A.emgeneric )   
												FROM BACPARAMSUDA..EMISOR A WITH(NOLOCK)   
												WHERE RUT_EMISOR = A.EMRUT) , 'N/E' )  
			   ,	  cCustodia     
		FROM 
				#TemporalPcto  
				INNER JOIN VIEW_TABLA_GENERAL_DETALLE ON tbcateg = '1111' AND tbcodigo1 = Cartera   
		WHERE   Rut_Emisor = @RutTGR 
		ORDER BY 
				serie, tbglosa  
	ELSE 
		 SELECT		  Serie   
			   ,      Moneda  
			   ,      CASE WHEN Nominal < 0 THEN 0 ELSE Nominal END  
			   ,      TIR--CAST( ( Tir - HairCut) AS NUMERIC(10,4))   -- PROD-6007 Por presentación, se seprar el Haircut. 
			   ,      vPar  
			   ,      CASE WHEN Nominal < 0 THEN 0 ELSE vPresent END  
			   ,      Plazo   
			   ,      Margen  
			   ,      CASE WHEN Nominal < 0 THEN 0 ELSE vinicial END  
			   ,      tbglosa  
			   ,      cartera   -- Corresponde al código de Cartera  
			   ,      BloqueoPacto  -- PRD-6005  
			   ,      HairCut       -- PRD-6007  
			   ,      Rut_Emisor    -- PRD-6006  será necesario llenar la grilla   
			   ,	  EmGeneric     = ISNULL( ( SELECT MAX( A.emgeneric )   
												FROM BACPARAMSUDA..EMISOR A WITH(NOLOCK)   
												WHERE RUT_EMISOR = A.EMRUT) , 'N/E' )  
			   ,   cCustodia     
	   FROM #TemporalPcto  
	 INNER JOIN VIEW_TABLA_GENERAL_DETALLE ON tbcateg = '1111' AND tbcodigo1 = Cartera   
		   WHERE   Rut_Emisor = @RutBCCH 
	 ORDER BY serie, tbglosa  
END
ELSE	 
BEGIN	 
		 SELECT		  Serie   
			   ,      Moneda  
			   ,      CASE WHEN Nominal < 0 THEN 0 ELSE Nominal END  
			   ,      TIR--CAST( ( Tir - HairCut) AS NUMERIC(10,4))   -- PROD-6007 Por presentación, se seprar el Haircut. 
			   ,      vPar  
			   ,      CASE WHEN Nominal < 0 THEN 0 ELSE vPresent END  
			   ,      Plazo   
			   ,      Margen  
			   ,      CASE WHEN Nominal < 0 THEN 0 ELSE vinicial END  
			   ,      tbglosa  
			   ,      cartera   -- Corresponde al código de Cartera  
			   ,      BloqueoPacto  -- PRD-6005  
			   ,      HairCut       -- PRD-6007  
			   ,      Rut_Emisor    -- PRD-6006  será necesario llenar la grilla   
			   ,	  EmGeneric     = ISNULL( ( SELECT MAX( A.emgeneric )   
												FROM BACPARAMSUDA..EMISOR A WITH(NOLOCK)   
												WHERE RUT_EMISOR = A.EMRUT) , 'N/E' )  
			   ,   cCustodia     
	   FROM #TemporalPcto  
		INNER JOIN VIEW_TABLA_GENERAL_DETALLE ON tbcateg = '1111' AND tbcodigo1 = Cartera   
		ORDER BY serie, tbglosa  
END		
/****20181226.RCH.LCGP***********/
         
END
GO
