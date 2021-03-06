USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_CARTERA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZA_CARTERA]  
AS    
BEGIN    
    
 SET NOCOUNT ON    
  
 DECLARE @csw_recompra CHAR(01)   
  , @csw_reventa CHAR(01)    
    
 SELECT @csw_recompra = acsw_rc ,    
   @csw_reventa = acsw_rv    
 FROM MDAC    
    
 -->  Lee el Sw de Configuracion de Garantias  
 DECLARE @iActivaCicloGarantias INT  
 SELECT @iActivaCicloGarantias = BacTraderSuda.dbo.Fx_Sw_Garantias(4)  
 -->  Si @iActivaCicloGarantias = 0 ; esta Apagado Garantias  
 -->  Si @iActivaCicloGarantias = 1 ; esta Encendido Garantias  
    
 EXECUTE BACLINEAS..SP_EXPOSICION_MAXIMA_ACTUALIZA_INICIO 'BTR'    
    
 IF @csw_recompra='0' AND @csw_reventa='0'    
 BEGIN   
  /*----------------------------------------------------------------------------------------------*/    
  /* Actualización de la tabla de movimientos historicos.                                         */    
  /*----------------------------------------------------------------------------------------------*/    
  update BacTraderSuda.dbo.VALORIZACION_MERCADO  
  set  valor_market  = valor_mercado  --> ( dinominal / valor_nominal ) * valor_mercado  
   , valor_market1  = valor_nominal  -->  dinominal  
  where fecha_valorizacion = (select acfecante from BacTraderSuda.dbo.Mdac)  
  
  if @@error <> 0  
  begin  
   select 'NO', 'Error en Traspaso de Valor de Mercado.'  
   return  
  end  
    
  /*----------------------------------------------------------------------------------------------*/    
  /* Actualización de la tabla de movimientos historicos.                                         */    
  /*----------------------------------------------------------------------------------------------*/    
  DELETE MDMH     
  FROM   MDAC    
  WHERE  mofecpro = acfecante    
    
  --> Elimina los Registros iniciales de las Ventas y Compras Definitivas Pago Mañana                  <--    
  --> Para que no los respalde, debido a que se respaldaran el día en que se hace efectiva la Op. T(1) <--    
  DELETE MDMO    
  FROM   MDAC    
  WHERE  Mofecpro           = acfecante    
  AND    Fecha_PagoMañana   > acfecante    
  AND    Motipoper          IN('CP','VP')    
  AND    PagoMañana         = 'N'    
    
  DELETE MDMH  
  FROM   MDMO  
  WHERE  MDMO.mofecpro  = MDMH.mofecpro     
  AND    MDMO.monumoper = MDMH.monumoper     
  AND    MDMO.monumdocu = MDMH.monumdocu     
  AND    MDMO.mocorrela = MDMH.mocorrela         
  AND    MDMO.motipoper IN('CP','VP')    
  AND    MDMO.mofecpro  < MDMO.Fecha_PagoMañana     
    
  INSERT INTO MDMH    
  ( mofecpro,    
   morutcart,    
   motipcart,    
   monumdocu,    
   mocorrela,    
   monumdocuo,    
   mocorrelao,    
   monumoper,    
   motipoper,    
   motipopero,    
   moinstser,    
   momascara,    
   mocodigo,    
   moseriado,    
   mofecemi,    
   mofecven,    
   momonemi,    
   motasemi,    
   mobasemi,    
   morutemi,    
   monominal,    
   movpresen,    
   momtps,    
   momtum,    
   momtum100,    
   monumucup,    
   motir,    
   mopvp,    
   movpar,    
   motasest,    
   mofecinip,    
   mofecvenp,    
   movalinip,    
   movalvenp,    
   motaspact,    
   mobaspact,    
   momonpact,    
   moforpagi,    
   moforpagv,    
   motipobono,    
   mocondpacto,    
   mopagohoy,    
   morutcli,    
   mocodcli,    
   motipret,    
   mohora,    
   mousuario,    
   moterminal,    
   mocapitali,    
   mointeresi,    
   moreajusti,    
   movpreseni,    
   mocapitalp,    
   mointeresp,    
   moreajustp,    
   movpresenp,    
   motasant,    
   mobasant,    
   movalant,    
   mostatreg,    
   movpressb,    
   modifsb,    
   monominalp,    
   movalcomp,    
   movalcomu,    
   mointeres,    
   moreajuste,    
   mointpac,    
   moreapac,    
   moutilidad,    
   moperdida,    
   movalven,    
   mocontador,    
   monsollin,    
   moobserv,    
   moobserv2,    
   movvista,    
   movviscom,    
   momtocomi,    
   mocorvent,    
   modcv,    
   moclave_dcv,    
   mocodexceso,    
   momtoPFE,    
   momtoCCE,    
   mointermesc,    
   moreajumesc,    
   mointermesvi,    
   moreajumesvi,    
   fecha_compra_original,    
   valor_compra_original,    
   valor_compra_um_original,    
   tir_compra_original,    
   valor_par_compra_original,    
   porcentaje_valor_par_compra_original,    
   codigo_carterasuper,    
   Tipo_Cartera_Financiera,    
   Mercado,    
   Sucursal,    
   Id_Sistema,    
   Fecha_PagoMañana,    
   Laminas,    
   Tipo_Inversion,    
   Cuenta_Corriente_Inicio,    
   Cuenta_Corriente_Final,    
   Sucursal_Inicio,    
   Sucursal_Final,    
   motipoletra,    
   movaltasemi,    
   moprimadesc,    
   MtoCompraPM,    
   MtoVentaPM,    
   PagoMañana,    
   SorteoLCHR,    
   Dcrp_Confirmador,    
   Dcrp_Codigo,    
   Dcrp_Glosa,    
   Dcrp_HoraConfirm,    
   Dcrp_OperConfirm,    
   Dcrp_OpeCnvConfirm,    
   moid_libro,    
   moTirTran    ,    
   moPvpTran    ,    
   moVPTran     ,    
   moDifTran_MO ,    
   moDifTran_CLP,    
   moDigitador -- JBH, 22-12-2009    
  
   ,  Resultado_Dif_Precio      --> Ventas AFS  
   ,  Resultado_Dif_Mercado      --> Ventas AFS  
   ,  ValorMercado_prop       --> Ventas AFS  
  
  )    
  SELECT    
   mofecpro,    
   morutcart,    
   motipcart,    
   monumdocu,    
   mocorrela,    
   monumdocuo,    
   mocorrelao,    
   monumoper,    
   motipoper,    
   motipopero,    
   moinstser,    
   momascara,    
   mocodigo,    
   moseriado,    
   mofecemi,    
   mofecven,    
   momonemi,    
   motasemi,    
   mobasemi,    
   morutemi,    
   monominal,    
   movpresen,    
   momtps,    
   momtum,    
   momtum100,    
   monumucup,    
   motir,    
   mopvp,    
   movpar,    
   motasest,    
   mofecinip,    
   mofecvenp,    
   movalinip,    
   movalvenp,    
   motaspact,    
   mobaspact,    
   momonpact,    
   moforpagi,    
   moforpagv,    
   motipobono,    
   mocondpacto,    
   mopagohoy,    
   morutcli,    
   mocodcli,    
   motipret,    
   mohora,    
   mousuario,    
   moterminal,    
   mocapitali,    
   mointeresi,    
   moreajusti,    
   movpreseni,    
   mocapitalp,    
   mointeresp,    
   moreajustp,    
   movpresenp,    
   motasant,    
   mobasant,    
   movalant,    
   mostatreg,    
   movpressb,    
   modifsb,    
   monominalp,    
   movalcomp,    
   movalcomu,    
   mointeres,    
   moreajuste,    
   mointpac,    
   moreapac,    
   moutilidad,    
   moperdida,    
   movalven,    
   mocontador,    
   monsollin,    
   moobserv,    
   moobserv2,    
   movvista,    
   movviscom,    
   momtocomi,    
   mocorvent,    
   modcv,    
   moclave_dcv,    
   mocodexceso,    
   momtoPFE,    
   momtoCCE,    
   mointermesc,    
   moreajumesc,    
   mointermesvi,    
   moreajumesvi,    
   fecha_compra_original,    
   valor_compra_original,    
   valor_compra_um_original,    
   tir_compra_original,    
   valor_par_compra_original,    
   porcentaje_valor_par_compra_original,    
   codigo_carterasuper,    
   Tipo_Cartera_Financiera,    
   Mercado,    
   Sucursal,    
   Id_Sistema,    
   Fecha_PagoMañana,    
   Laminas,    
   Tipo_Inversion,    
   Cuenta_Corriente_Inicio,    
   Cuenta_Corriente_Final,    
   Sucursal_Inicio,    
   Sucursal_Final,    
   motipoletra,    
   movaltasemi,    
   moprimadesc,    
   MtoCompraPM,    
   MtoVentaPM,    
   PagoMañana,    
   SorteoLCHR,    
   Dcrp_Confirmador,    
   Dcrp_Codigo,    
   Dcrp_Glosa,    
   Dcrp_HoraConfirm,    
   Dcrp_OperConfirm,    
   Dcrp_OpeCnvConfirm,    
   id_libro,    
   moTirTran    ,    
   moPvpTran    ,    
   moVPTran     ,    
   moDifTran_MO ,    
   moDifTran_CLP,    
   moDigitador     -- JBH, 22-12-2009    
     
  ,  Resultado_Dif_Precio      --> Ventas AFS  
  ,  Resultado_Dif_Mercado      --> Ventas AFS  
  ,  ValorMercado_prop       --> Ventas AFS  
  
  FROM MDMO    
  
  IF @@ERROR<>0    
  BEGIN    
   SELECT 'NO', 'No se pudo traspasar Movimiento Diario a Historico'    
   SET NOCOUNT OFF    
   RETURN   
  END    
  
  /*----------------------------------------------------------------------------------------------*/    
  /* Limpieza de la tabla de movimiento.                                                          */    
  /*----------------------------------------------------------------------------------------------*/    
  
  TRUNCATE TABLE MDMO    
  
  IF @@ERROR <> 0    
  BEGIN    
   SELECT 'NO', 'No se pudieron eliminar datos del Movimiento Diario'    
   SET NOCOUNT OFF    
   RETURN    
  END    
 END  
    
 INSERT INTO MDMO    
 ( mofecpro    
 , morutcart    
 , motipcart    
 , monumdocu    
 , mocorrela    
 , monumdocuo     
 , mocorrelao    
 , monumoper    
 , motipoper    
 , motipopero    
 , moinstser    
 , momascara    
 , mocodigo    
 , moseriado    
 , mofecemi    
 , mofecven    
 , momonemi    
 , motasemi    
 , mobasemi    
 , morutemi    
 , monominal    
 , movpresen    
 , momtps    
 , momtum    
 , momtum100    
 , monumucup    
 , motir    
 , mopvp    
 , movpar    
 , motasest    
 , mofecinip    
 , mofecvenp    
 , movalinip    
 , movalvenp    
 , motaspact    
 , mobaspact    
 , momonpact    
 , moforpagi    
 , moforpagv    
 , motipobono    
 , mocondpacto    
 , mopagohoy    
 , morutcli    
 , mocodcli    
 , motipret    
 , mohora    
 , mousuario    
 , moterminal    
 , mocapitali    
 , mointeresi    
 , moreajusti    
 , movpreseni    
 , mocapitalp    
 , mointeresp    
 , moreajustp    
 , movpresenp    
 , motasant    
 , mobasant    
 , movalant    
 , mostatreg    
 , movpressb    
 , modifsb    
 , monominalp    
 , movalcomp    
 , movalcomu    
 , mointeres    
 , moreajuste    
 , mointpac    
 , moreapac    
 , moutilidad    
 , moperdida    
 , movalven    
 , mocontador    
 , monsollin    
 , moobserv    
 , moobserv2    
 , movvista    
 , movviscom    
 , momtocomi    
 , mocorvent    
 , modcv    
 , moclave_dcv    
 , mocodexceso    
 , momtoPFE    
 , momtoCCE    
 , mointermesc    
 , moreajumesc    
 , mointermesvi    
 , moreajumesvi    
 , fecha_compra_original    
 , valor_compra_original    
 , valor_compra_um_original    
 , tir_compra_original    
 , valor_par_compra_original    
 , porcentaje_valor_par_compra_original    
 , codigo_carterasuper    
 , Tipo_Cartera_Financiera    
 , Mercado    
 , Sucursal    
 , Id_Sistema    
 , Fecha_PagoMañana    
 , Laminas    
 , Tipo_Inversion    
 , Cuenta_Corriente_Inicio    
 , Cuenta_Corriente_Final    
 , Sucursal_Inicio    
 , Sucursal_Final    
 , motipoletra    
 , moreserva_tecnica1    
 , movalvenc    
 , movaltasemi    
 , moprimadesc    
 , SwImpresion    
 , MtoCompraPM    
 , MtoVentaPM    
 , PagoMañana    
 , SorteoLchr    
 , id_libro    
 , Dcrp_Confirmador    
 , Dcrp_Codigo    
 , Dcrp_Glosa    
 , Dcrp_HoraConfirm    
 , Dcrp_OperConfirm    
 , Dcrp_OpeCnvConfirm    
 , moTirTran        
 , moPvpTran        
 , moVPTran         
 , moDifTran_MO    
 , moDifTran_CLP    
 , Resultado_Dif_Precio      --> Ventas AFS  
 , Resultado_Dif_Mercado     --> Ventas AFS  
 , ValorMercado_prop      --> Ventas AFS  
 )    
 SELECT    
   mofecpro    
 , morutcart    
 , motipcart    
 , monumdocu    
 , mocorrela    
 , monumdocuo    
 , mocorrelao    
 , monumoper    
 , motipoper    
 , motipopero    
 , moinstser    
 , momascara    
 , mocodigo    
 , moseriado    
 , mofecemi    
 , mofecven    
 , momonemi    
 , motasemi    
 , mobasemi    
 , morutemi    
 , monominal    
 , movpresen    
 , momtps    
 , momtum    
 , momtum100    
 , monumucup    
 , motir    
 , mopvp    
 , movpar    
 , motasest    
 , mofecinip    
 , mofecvenp    
 , movalinip    
 , movalvenp    
 , motaspact    
 , mobaspact    
 , momonpact    
 , moforpagi    
 , moforpagv    
 , motipobono    
 , mocondpacto    
 , mopagohoy    
 , morutcli    
 , mocodcli    
 , motipret    
 , mohora    
 , mousuario    
 , moterminal    
 , mocapitali    
 , moINTeresi    
 , moreajusti    
 , movpreseni    
 , mocapitalp    
 , moINTeresp    
 , moreajustp    
 , movpresenp    
 , motasant    
 , mobasant    
 , movalant    
 , mostatreg    
 , movpressb    
 , modifsb    
 , monominalp    
 , movalcomp    
 , movalcomu    
 , moINTeres    
 , moreajuste    
 , moINTpac    
 , moreapac    
 , moutilidad    
 , moperdida    
 , movalven    
 , mocontador    
 , monsollin    
 , moobserv    
 , moobserv2    
 , movvista    
 , movviscom    
 , momtocomi    
 , mocorvent    
 , modcv    
 , moclave_dcv    
 , mocodexceso    
 , momtoPFE    
 , momtoCCE    
 , moINTermesc    
 , moreajumesc    
 , moINTermesvi    
 , moreajumesvi    
 , fecha_compra_original    
 , valor_compra_original    
 , valor_compra_um_original    
 , tir_compra_original    
 , valor_par_compra_original    
 , porcentaje_valor_par_compra_original    
 , codigo_carterasuper    
 , Tipo_Cartera_Financiera    
 , Mercado    
 , Sucursal    
 , Id_Sistema    
 , Fecha_PagoMañana    
 , Laminas    
 , Tipo_Inversion    
 , Cuenta_Corriente_Inicio    
 , Cuenta_Corriente_Final    
 , Sucursal_Inicio    
 , Sucursal_Final    
 , motipoletra    
 , moreserva_tecnica1    
 , movalvenc    
 , movaltasemi    
 , moprimadesc    
 , SwImpresion    
 , MtoCompraPM    
 , MtoVentaPM    
 , PagoMañana    
 , SorteoLCHR    
 , moid_libro    
 , Dcrp_Confirmador    
 , Dcrp_Codigo    
 , Dcrp_Glosa    
 , Dcrp_HoraConfirm    
 , Dcrp_OperConfirm    
 , Dcrp_OpeCnvConfirm    
 , 0  -- tir tran    
 , 0  -- pvp tran    
 , 0  -- vp tran    
 , 0  -- dif mo    
 , 0  -- dif clp    
  
 --> Ventas AFS  
 ,  Resultado_Dif_Precio  /*= case when motipoper = 'VP' then BacTraderSuda.dbo.Fx_UtilidadVenta ('BTR', monumoper, monumdocu, mocorrela, monominal, (((momtocce - ABS(moperdida)) + moutilidad) + moprimadesc), 1 )  
           else 0  
         end*/  
 ,  Resultado_Dif_Mercado /*= case when motipoper = 'VP' then BacTraderSuda.dbo.Fx_UtilidadVenta ('BTR', monumoper, monumdocu, mocorrela, monominal, (((momtocce - ABS(moperdida)) + moutilidad) + moprimadesc), 2 )  
           else 0  
         end*/  
 ,  ValorMercado_prop  
 --> Ventas AFS  
 FROM MDMOPM   
  , MDAC    
 WHERE Fecha_PagoMañana >=  acfecproc      /*VB+++ se cambio para considerar operaciones T+2 Fecha_PagoMañana =  acfecproc     */
 AND  PagoMañana   = 'S'    
    
 /*----------------------------------------------------------------------------------------------*/    
 /* Actualización de la cartera compras propias.     */    
 /*----------------------------------------------------------------------------------------------*/    
 UPDATE MDCP  
 SET  cpinstser  = rsinstcam  ,    
   cpinteresc  = rsinteres_acum ,    
   cpreajustc  = rsreajuste_acum ,    
   cpvptirc  = rsvppresenx  ,    
   cpvpcomp  = CASE WHEN rsrutemis = 97023000 and rscodigo = 20 THEN valor_par ELSE rsvpcomp END ,    
   cpintermes  = rsintermes  ,    
   cpreajumes  = rsreajumes  ,    
   cpfecucup  = rsfecucup  ,    
   cpfecpcup  = rsfecpcup  ,           
   cppvpcomp  = rsvpcomp  ,                      
   cpdurat   = rsdurat  ,      
   cpdurmod  = rsdurmod  ,    
   cpconvex  = rsconvex,    
   cpprimdescacum = round((prima_descuento_total/(DATEDIFF(DAY,rsfeccomp,rsfecvcto))),0)*(DATEDIFF(DAY,rsfeccomp,acfecproc))     
 FROM   MDRS    
 ,      MDAC    
 WHERE  rsfecha        = acfecproc     
 AND    rsrutcart      = cprutcart     
 AND    rsnumdocu      = cpnumdocu     
 AND    rscorrela      = cpcorrela     
 AND    rstipoper      = 'DEV'    
 AND    rscartera      = '111'    
 AND    rscodigo      <> 98    
    
 IF @@ERROR <> 0    
 BEGIN    
  SELECT 'NO', 'Proceso de Actualización en la cartera de compras propias a fallado.'    
  SET NOCOUNT OFF    
  RETURN    
 END    
  
	/*----------------------------------------------------------------------------------------------*/  
	/* Actualización de la Cartera Compras Propias por Pago de Cupon    */  
	/*----------------------------------------------------------------------------------------------*/  
	UPDATE	MDCP   -- Verificar Acumulados y cartera 111  
	SET		cpinstser  = rsinstser,  
			cpcapitalc = rsvalcomp,  
			cpvalcomp  = rsvalcomp,  
			cpvalcomu  = rsvalcomu,  
			cpvpcomp   = rsvpcomp,  
			cpinteresc = rsinteres_acum,  
			cpreajustc = rsreajuste_acum,  
			cpintermes = rsintermes,  
			cpreajumes = rsreajumes,  
			cpfecucup  = rsfecucup,  
			cpfecpcup  = rsfecpcup,  
			cppvpcomp  = rsvpcomp    
	FROM	MDRS  
	,		MDAC  
	WHERE	rsfecha    = acfecproc   
	AND		rsrutcart  = cprutcart
	AND		rsnumdocu  = cpnumdocu   
	AND		rscorrela  = cpcorrela   
	AND		rstipoper  = 'VC'   
	AND		rscartera  = '111'  
	AND		rscodigo  <> 98
  
	IF @@ERROR <> 0
	BEGIN
	  SELECT 'NO', 'Proceso de Actualización en la cartera de compras propias VC a fallado.'
	  SET NOCOUNT OFF
	  RETURN
	END

	if @iActivaCicloGarantias = 1	-->	Sw Garantias
	begin
		UPDATE	Tbl_Valorizacion_Instrumento_Agrupada
			SET	/*
				CapitalCompra			= rsvalcomp
			,	Capital					= rsvalcomp
			,	ValorCompra				= rsvalcomp
			,	ValorCompraUm			= rsvalcomu
			,*/	Interes_Acum			= rsinteres_acum
			,	Reajuste_Acum			= rsreajuste_acum
			,	Interes_Mes				= rsintermes
			,	Reajuste_Mes			= rsreajumes
			,	ValorProceso			= rsvppresen
			,	ValorProxProceso		= rsvppresenx
		FROM	MDRS
		WHERE	rsfecha					= ( select acfecproc from mdac )
		AND		rstipoper				= 'DEV'
		AND		rscartera				= '159'
		AND		Garantia_Numero			= rsnumoper
		AND		NumeroDocumento			= rsnumdocu
		AND		CorrelativoDocumento	= rscorrela

		EXECUTE SP_PRORRATEA_TBL_VALORIZACION

		UPDATE	bdbomesa.Garantia.Tbl_Valorizacion_Instrumento
			SET	ValorPar				= rsvpcomp	--> cpvpcomp
			,	FechaCorteUltCupon		= rsfecucup
			,	FechaCorteProxCupon		= rsfecpcup
			,	PorcentajeValorPar		= rsvpcomp	--> cppvpcomp
		FROM	MDRS
		WHERE	rsfecha					= ( select acfecproc from mdac )
		AND		rstipoper				= 'DEV'
		AND		rscartera				= '159'
		AND		Garantia_Numero			= rsnumoper
		AND		NumeroDocumento			= rsnumdocu
		AND		CorrelativoDocumento	= rscorrela

	/*
		UPDATE	bdbomesa.Garantia.Tbl_Valorizacion_Instrumento
			SET	CapitalCompra			= rsvalcomp
			,	Capital					= rsvalcomp
			,	ValorCompra				= rsvalcomp
			,	ValorCompraUm			= rsvalcomu
			,	ValorPar				= rsvpcomp	--> cpvpcomp
			,	Interes_Acum			= rsinteres_acum
			,	Reajuste_Acum			= rsreajuste_acum
			,	Interes_Mes				= rsintermes
			,	Reajuste_Mes			= rsreajumes
			,	FechaCorteUltCupon		= rsfecucup
			,	FechaCorteProxCupon		= rsfecpcup
			,	PorcentajeValorPar		= rsvpcomp	--> cppvpcomp
			,	ValorProceso			= rsvppresen
			,	ValorProxProceso		= rsvppresenx
		FROM	MDRS
		WHERE	rsfecha					= ( select acfecproc from mdac )
		AND		rstipoper				= 'DEV'
		AND		rscartera				= '160'
		AND		Garantia_Numero			= rsnumoper
		AND		NumeroDocumento			= rsnumdocu
		AND		CorrelativoDocumento	= rscorrela
	*/

		--		Detalle Cartera Garantia
		UPDATE	BdBomesa.Garantia.Tbl_DetalleCarteraGarantia
		SET		VPAR				= Garantias.VPar
		,		VPVP				= Garantias.Pvp
		,		ValorPresente		= Garantias.vProx
		,		ValorPresenteHaircut= Garantias.vpHaircut
		,		ValorActualizadoCLP	= Garantias.vpHaircut
		FROM	(	SELECT	NumGar		= Gar.NumGar
						,	CorrGar		= Gar.CorrGar
						,	NumDocu		= Gar.Numocu
						,	Correla		= Gar.Correla
						,	VPar		= Gar.VPar
						,	Pvp			= Gar.Pvp
						,	vPres		= Gar.vPres
						,	vProx		= Gar.vProx
						,	Haircut		= Gar.Haircut
						,	vpHaircut	= round(Gar.vProx - (Gar.vProx * (Gar.Haircut /100)), 0)
						--,	vpHaircut	= round( Gar.vProx * ( 1.0 - Gar.Haircut ), 0)
					FROM	(	select	NumGar	= vli.Garantia_Numero
									,	CorrGar	= vli.Garantia_Correlativo
									,	Numocu	= vli.NumeroDocumento
									,	Correla	= vli.CorrelativoDocumento
									,	VPar	= vli.ValorPar
									,	Pvp		= vli.PorcentajeValorPar
									,	vPres	= vli.ValorProceso
									,	vProx	= vli.ValorProxProceso
									,	Haircut	= case	when Haircut = 0.0 then 0.0 else Haircut end
								from	bdbomesa.Garantia.Tbl_Valorizacion_Instrumento vli
										inner join 
										(	select	nGar	= NumeroGarantia
												,	nCGar	= CorrelativoGarantia
												,	NumDocu	= NumeroOperacionInstrumento
												,	Correla	= CorrelativoInstrumento
												,	Haircut	= Haircut
											from	BdBomesa.Garantia.Tbl_DetalleCarteraGarantia with(nolock)
											where   Nominal > 0
										)	dcg		On	dcg.nGar	= vli.Garantia_Numero
													and	dcg.nCGar	= vli.Garantia_Correlativo
													and	dcg.NumDocu	= vli.NumeroDocumento
													and	dcg.Correla	= vli.CorrelativoDocumento
													and vli.ValorProceso > 0
							)	Gar
				)	Garantias
		WHERE	Garantias.NumGar	= NumeroGarantia
		AND		Garantias.CorrGar	= CorrelativoGarantia
		AND		Garantias.NumDocu	= NumeroOperacionInstrumento
		AND		Garantias.Correla	= CorrelativoInstrumento
		and		Garantias.vPres		> 0

	/*
		UPDATE	BdBomesa.Garantia.Tbl_DetalleCarteraGarantia
		SET		VPAR				= val.VPar
		,		VPVP				= val.PVP
		,		ValorPresente		= val.VPresen
		,		ValorPresenteHaircut= val.Haircut
		,		Duration			= val.DUR
		,		DurationMod			= val.DURMOD
		,		Convexidad			= val.CONEX
		,		ValorActualizadoCLP	= val.Haircut
		FROM	(	select	NumDocu	= NumeroDocumento
						,	Correla	= CorrelativoDocumento
						,	NumGar	= Garantia_Numero
						,	CorrGar	= Garantia_Correlativo
						,	serie	= Serie
						,	nominal	= rsnominal
						,	tir		= rstir
						,	VPresen	= rsvppresenx
						,	VPar	= valor_par
						,	PVP		= rsvpcomp
						,	DUR		= rsdurat
						,	DURMOD	= rsdurmod
						,	CONEX	= rsconvex
						,	Haircut	= rsvppresenx * (1.0 - Gar.Haircut)
					from	bdbomesa.Garantia.Tbl_Valorizacion_Instrumento vli
							inner join
							(	select	NumGar	= NumeroGarantia
									,	CorrGar	= CorrelativoGarantia
									,	NumDocu	= NumeroOperacionInstrumento
									,	Correla	= CorrelativoInstrumento
									,	Haircut	= case	when Haircut = 0.0 then 0.0 
														else (5.0 / 100.0)
													end
								from	BdBomesa.Garantia.Tbl_DetalleCarteraGarantia
								where	Nominal	> 0
							)	Gar		On	Gar.NumGar	= vli.Garantia_Numero
										and	Gar.CorrGar	= vli.Garantia_Correlativo
										and	Gar.NumDocu	= vli.NumeroDocumento
										and Gar.Correla	= vli.CorrelativoDocumento
							inner join
							(	select	rsfecha, rsnumdocu, rscorrela, rsnumoper, rsinstser
									,	rsnominal, rstir, rsvppresen, rsvppresenx
									,	rsdurat, rsdurmod, rsconvex, rsvpcomp, valor_par
								from	bactradersuda.dbo.mdrs
								where	rsfecha		= (select acfecproc from BacTraderSuda.dbo.mdac)
								and		rstipoper	= 'DEV'
								and		rscartera	= 159
							)	mdrs	On	mdrs.rsnumdocu	= NumeroDocumento
										and	mdrs.rscorrela	= CorrelativoDocumento
										and mdrs.rsnumoper	= Garantia_Numero
					where	Garantia_Numero = 2
				)	val
		where	NumeroGarantia				= val.NumGar
		and		CorrelativoGarantia			= val.CorrGar
		and		NumeroOperacionInstrumento	= val.NumDocu
		and		CorrelativoInstrumento		= val.Correla
	*/
	end			-->	Sw Garantias
	
   /*----------------------------------------------------------------------------------------------*/  
   /* Actualización de la cartera disponible.                                                      */  
   /*----------------------------------------------------------------------------------------------*/  

	UPDATE	MDDI  
	SET		diinstser  = rsinstcam,  
			divptirc   = (CASE rstipopero WHEN 'CP' THEN rsvppresenx     ELSE 0 END) ,  
			dicapitalc = (CASE rstipopero WHEN 'CP' THEN rsvalcomp       ELSE 0 END) ,  
			diinteresc = (CASE rstipopero WHEN 'CP' THEN rsinteres_acum  ELSE 0 END) ,  
			direajustc = (CASE rstipopero WHEN 'CP' THEN rsreajuste_acum ELSE 0 END) ,  
			diintermes = rsintermes       ,  
			direajumes = rsreajumes       ,  
			divptirci  = (CASE rstipopero WHEN 'CI' THEN rsvppresenx     ELSE 0 END) ,  
			dicapitaci = (CASE rstipopero WHEN 'CI' THEN rsvalcomp       ELSE 0 END) ,  
			diintereci = (CASE rstipopero WHEN 'CI' THEN rsinteres       ELSE 0 END) ,  
			direajusci = (CASE rstipopero WHEN 'CI' THEN rsreajuste      ELSE 0 END) ,  
			divpmcd    = (CASE rstipopero WHEN 'CI' THEN 0				 ELSE Valor_Par END)  
	FROM	MDRS
		,	MDAC  
	WHERE	rsfecha    = acfecproc   
	AND		rsrutcart  = dirutcart   
	AND		rsnumdocu  = dinumdocu   
	AND		rscorrela  = dicorrela   
	AND		rstipoper  = 'DEV'   
	AND		rscartera  = '111'  
	AND		rscodigo  <> 98  

	IF @@ERROR<>0  
	BEGIN  
		SELECT 'NO', 'Proceso de Actualización en la cartera disponible a fallado.'  
		SET NOCOUNT OFF  
		RETURN  
	END  
  
	UPDATE	MDDI  
	SET		diinstser = rsinstser ,  
			divptirc = rsvppresenx ,  
			dicapitalc = rsvalcomp ,  
			diinteresc = rsinteres ,  
			direajustc = rsreajuste ,  
			diintermes = rsintermes ,  
			direajumes = rsreajumes  
	FROM	MDRS
		,	MDAC 
	WHERE	rsfecha		= acfecproc 
	AND		rsrutcart	= dirutcart 
	AND		rsnumdocu	= dinumdocu 
	AND		rscorrela	= dicorrela 
	AND		rstipoper	= 'VC'
	AND		rscartera	= '111'  
	AND		rscodigo   <> 98  

	IF @@ERROR<>0  
	BEGIN  
		SELECT 'NO', 'Proceso de Actualización en la cartera disponible VC a fallado.'  
		SET NOCOUNT OFF  
		RETURN  
	END  

 /*----------------------------------------------------------------------------------------------*/  
 /* Actualización de la Cartera Interbancario                                                    */  
 /*----------------------------------------------------------------------------------------------*/  
 UPDATE MdCi  
 SET civptirci = rsvppresenx    
   , civptirc = rsvppresenx    
   , cicapitalc = rsvalcomp    
   , ciinteresc = rsinteres_acum   
   , cireajustc = rsreajuste_acum   
   , ciintermes = rsintermes    
   , cireajumes = rsreajumes  
 FROM MdRs, MdAc  
 WHERE rsfecha=acfecproc AND rsrutcart=cirutcart AND rsnumdocu=cinumdocu AND rscorrela=cicorrela AND  
  rscartera='121'  
  
 IF @@ERROR<>0  
 BEGIN  
  SELECT 'NO', 'Proceso de Actualización en la cartera compra con pacto a fallado.'  
  SET NOCOUNT OFF  
  RETURN  
 END  
  
 /*----------------------------------------------------------------------------------------------*/  
 /* Actualización de la Cartera Interbancario con el central                                                   */  
 /*----------------------------------------------------------------------------------------------*/  
  
	UPDATE	MDCI  
    SET		civptirci	= rsvppresenx    
      ,		civptirc	= rsvppresenx    
      ,		cicapitalc	= rsvalcomp    
      ,		ciinteresc	= rsinteres_acum   
      ,		cireajustc	= rsreajuste_acum   
      ,		ciintermes	= rsintermes    
      ,		cireajumes	= rsreajumes  
	FROM	MDRS
	,		MDAC  
	WHERE	rsfecha		= acfecproc 
	AND		rsrutcart	= cirutcart 
	AND		rsnumdocu	= cinumdocu 
	AND		rscorrela	= cicorrela   
	AND		rscartera	= '130'  
  
	IF @@ERROR<>0  
	BEGIN  
		SELECT 'NO', 'Proceso de Actualización en la cartera interbancaria con el Central'  
		SET NOCOUNT OFF  
		RETURN  
	END  
  
	/*----------------------------------------------------------------------------------------------*/  
	/* Actualización de los Compras Pactos                                                          */  
	/*----------------------------------------------------------------------------------------------*/  
	UPDATE	MdCi  
	SET		civptirci	= rsvppresenx  ,  
			civptirc	= rsvppresenx  ,  
			cicapitalci = CASE	WHEN mnmx = 'C' and rsmonpact <> 13 THEN Round(rsvalinip/citcinicio,mndecimal)  
								ELSE rsvalinip 
							END  ,  
			ciinteresci = rsinteres_acum ,  
			cireajustci = rsreajuste_acum ,  
			ciintermes	= rsintermes  ,  
			cireajumes	= rsreajumes  
	FROM	MDRS
		,	MDAC
		,	VIEW_MONEDA  
	WHERE	rsfecha		= acfecproc 
	AND		rsrutcart	= cirutcart  
	AND		rsnumdocu	= cinumdocu 
	AND		rscorrela	= cicorrela 
	AND		rstipopero	= 'CI'
	AND		rscartera	= '112'
	AND		rsmonpact	= mncodmon  
  
	IF @@ERROR<>0  
	BEGIN  
		SELECT 'NO', 'Proceso de Actualización en la cartera compra con pacto a fallado.'  
		SET NOCOUNT OFF  
		RETURN  
	END
	
	UPDATE	MDVI  
	SET		viinstser		= rsinstcam  ,  
			viinteresv		= rsinteres_acum ,  
			vireajustv		= rsreajuste_acum ,  
			vivptirv		= rsvppresenx  ,  
			vivpvent		= rsvalcomp  ,  
			vivptirc		= rsvppresenx  ,  
			viintermesv		= rsintermes  ,  
			vireajumesv		= rsreajumes  ,  
			vifecucup		= rsfecucup  ,  
			vifecpcup		= rsfecpcup  ,  
			porcentaje_valor_par_compra_original = rsvpcomp  ,  
			vidurat			= rsdurat  ,  
			vidurmod		= rsdurmod  ,  
			viconvex		= rsconvex  
	FROM	MDRS
		,	MDAC  
	WHERE	rsfecha			= acfecproc 
	AND		rsrutcart		= virutcart 
	AND		rsnumdocu		= vinumdocu 
	AND		rscorrela		= vicorrela 
	AND		rsnumoper		= vinumoper 
	AND		rstipoper		= 'DEV' 
	AND		rscartera		= '114'  
  
	IF @@ERROR<>0  
	BEGIN  
		SELECT 'NO', 'Proceso de Actualización en la cartera venta con pacto a fallado.'  
		SET NOCOUNT OFF  
		RETURN  
	END

	UPDATE	MDVI  
	SET		viintermesvi	= rsintermes  ,  
			vireajumesvi	= rsreajumes  ,  
			vicapitalvi		= CASE	WHEN mnmx = 'C' and rsmonpact <> 13 THEN Round(rsvalinip/vitcinicio,mndecimal)  
									ELSE rsvalinip 
								END ,-- VGS rsvalinip  ,  
			viinteresvi		= rsinteres_acum ,  
			vireajustvi		= rsreajuste_acum ,  
			vivptirvi		= rsvppresenx  
	FROM	MDRS
		,	MDAC
		,	VIEW_MONEDA  
	WHERE	rsfecha			= acfecproc 
	AND		rsrutcart		= virutcart 
	AND		rsnumdocu		= vinumdocu 
	AND		rscorrela		= vicorrela 
	AND		rsnumoper		= vinumoper 
	AND		rstipoper		= 'DEV'
	AND		rscartera		= '115'
	AND		rsmonpact		= mncodmon

	IF @@ERROR<>0  
	BEGIN  
		SELECT 'NO', 'Proceso de Actualización en la cartera venta con pacto a fallado.'  
		SET NOCOUNT OFF  
		RETURN  
	END  

	UPDATE	MDVI  
	SET		viinstser       = rsinstser       ,  
			vicapitalv      = rsvalcomp		  ,  
			vivalcomu       = rsvalcomu       ,  
			vivalcomp       = rsvalcomp       ,  
			viinteresv      = rsinteres_acum  ,  
			vireajustv		= rsreajuste_acum ,  
			vivptirv        = rsvppresenx     ,  
			vivpvent        = rsvalcomp       ,  
			vivptirc        = rsvppresenx     ,  
			viintermesv     = rsintermes      ,  
			vireajumesv     = rsreajumes      ,  
			vifecucup       = rsfecucup		  ,  
			vifecpcup       = rsfecpcup       ,  
			porcentaje_valor_par_compra_original = rsvpcomp
	FROM	MDRS
		,	MDAC  
	WHERE	rsfecha			= acfecproc 
	AND		rsrutcart		= virutcart 
	AND		rsnumdocu		= vinumdocu 
	AND		rscorrela		= vicorrela 
	AND		rsnumoper		= vinumoper 
	AND		rstipoper		= 'VC'
	AND		rscartera		= '114'  

	IF @@ERROR <> 0
	BEGIN  
		SELECT 'NO', 'Proceso de Actualización en la cartera venta con pacto a fallado.'  
		SET NOCOUNT OFF  
		RETURN  
	END  

	-----------------------------------------------------------  
	--  ACTUALIZANDO PASIVO  
	------------------------------------------------------------  
	UPDATE	MdPasivo  
	SET		cpinteres_col	= rsinteres_acum ,  
			cpreajust_col	= rsreajuste_acum ,  
			cpinteres_emis	= rsinteres_acum_emis ,  
			cpreajust_emis	= rsreajuste_acum_emis ,  
			cpvptircol		= rsvppresenx  ,  
			cpvpemis		= rsvppresenx_emis ,  
			cpfecucup		= rsfecucup  ,  
			cpfecpcup		= rsfecpcup  ,  
			cpnominal_r		= rsnominal  
	FROM	MDRS
		,	MDAC  
	WHERE	rsfecha			= acfecproc 
	AND		rsrutcart		= cprutcart 
	AND		rsnumdocu		= cpnumdocu 
	AND		rscorrela		= cpcorrela  
	AND		rstipoper		= 'DEV'
	AND		rscartera		= '211'  
  
	IF @@ERROR<>0  
	BEGIN  
		SELECT 'NO', 'Proceso de Actualización en la cartera de Pasivos a fallado.'  
		SET NOCOUNT OFF  
		RETURN  
	END  

	/*----------------------------------------------------------------------------------------------*/  
	/* Actualización de la Cartera PASIVOS por Pago de Cupon    */  
	/*----------------------------------------------------------------------------------------------*/  
  
	UPDATE	MdPASIVO		-- Verificar Acumulados y cartera 114  
	SET		cpvalcol		= rsvalcomp  ,  
			cpvalcomu		= rsvalcomu  ,  
			cpinteres_col	= rsinteres_acum ,  
			cpreajust_col	= rsreajuste_acum ,  
			cpfecucup		= rsfecucup  ,  
			cpfecpcup		= rsfecpcup  ,  
			cppvpcolc		= rsvpcomp   
	FROM	MDRS
		,	MDAC  
	WHERE	rsfecha			= acfecproc 
	AND		rsrutcart		= cprutcart 
	AND		rsnumdocu		= cpnumdocu 
	AND		rscorrela		= cpcorrela 
	AND		rstipoper		= 'VC'
	AND		rscartera		= '211'  
  
	UPDATE	MDAC  
	SET		ac_ipcmes		= vmvalor  
	FROM	VIEW_VALOR_MONEDA  
	WHERE	vmcodigo		= 502  
	AND		vmfecha			= ( DATEADD(MONTH,-1,acfecante) - DATEPART(DAY, DATEADD(MONTH,-1,acfecante) ) )+1  
  
--**********************************************************************************************     
--CARGAR VENCIMIENTOS DE FONDOS MUTUOS  
	declare @fec_proc	datetime  
		SET @fec_proc	= ( select acfecproc from mdac with(nolock) )
  
	INSERT INTO MDMO  
	( mofecpro  
	, morutcart  
	, motipcart  
	, monumdocu  
	, mocorrela  
	, monumdocuo   
	, mocorrelao  
	, monumoper  
	, motipoper  
	, motipopero  
	, moinstser  
	, momascara  
	, mocodigo  
	, moseriado  
	, mofecemi  
	, mofecven  
	, momonemi  
	, motasemi  
	, mobasemi  
	, morutemi  
	, monominal  
	, movpresen  
	, momtps  
	, momtum  
	, momtum100  
	, monumucup  
	, motir  
	, mopvp  
	, movpar  
	, motasest  
	, mofecinip  
	, mofecvenp  
	, movalinip  
	, movalvenp  
	, motaspact  
	, mobaspact  
	, momonpact  
	, moforpagi  
	, moforpagv  
	, motipobono  
	, mocondpacto  
	, mopagohoy  
	, morutcli  
	, mocodcli  
	, motipret  
	, mohora  
	, mousuario  
	, moterminal  
	, mocapitali  
	, mointeresi  
	, moreajusti  
	, movpreseni  
	, mocapitalp  
	, mointeresp  
	, moreajustp  
	, movpresenp  
	, motasant  
	, mobasant  
	, movalant  
	, mostatreg  
	, movpressb  
	, modifsb  
	, monominalp  
	, movalcomp  
	, movalcomu  
	, mointeres  
	, moreajuste  
	, mointpac  
	, moreapac  
	, moutilidad  
	, moperdida  
	, movalven  
	, mocontador  
	, monsollin  
	, moobserv  
	, moobserv2  
	, movvista  
	, movviscom  
	, momtocomi  
	, mocorvent  
	, modcv  
	, moclave_dcv  
	, mocodexceso  
	, momtoPFE  
	, momtoCCE  
	, mointermesc  
	, moreajumesc  
	, mointermesvi  
	, moreajumesvi  
	, fecha_compra_original     
	, valor_compra_original                     
	, valor_compra_um_original                  
	, tir_compra_original                       
	, valor_par_compra_original                 
	, porcentaje_valor_par_compra_original      
	, codigo_carterasuper                       
	, Tipo_Cartera_Financiera                   
	, Mercado                                   
	, Sucursal                                  
	, Id_Sistema                                
	, Fecha_PagoMañana                          
	, Laminas                                   
	, Tipo_Inversion   
	, Cuenta_Corriente_Inicio                   
	, Cuenta_Corriente_Final                    
	, Sucursal_Inicio                           
	, Sucursal_Final                            
	, motipoletra                               
	, moreserva_tecnica1                        
	, movalvenc                                 
	, movaltasemi                               
	, moprimadesc                               
	, SwImpresion          
	, MtoCompraPM          
	, MtoVentaPM           
	, PagoMañana           
	, SorteoLchr           
	, id_libro             
	, Dcrp_Confirmador     
	, Dcrp_Codigo          
	, Dcrp_Glosa           
	, Dcrp_HoraConfirm     
	, Dcrp_OperConfirm     
	, Dcrp_OpeCnvConfirm   
	)
	SELECT  
	  @fec_proc --CONVERT(VARCHAR(8),GETDATE(),112)                                        
	, cprutcart                                                                          
	, cptipcart                                                                          
	, cpnumdocu                                                                          
	, cpcorrela                                                                          
	, cpnumdocuo                                                                         
	, cpcorrelao                                                                         
	, cpnumdocu                                        
	, 'VFM'                                                                              
	, 'CP'                                                                               
	, cpinstser                                                                          
	, cpmascara                           
	, cpcodigo                                                                           
	, cpseriado                                                                          
	, cpfecemi                                                                           
	, cpfecven                                                                           
	, nsmonemi                   
	, nstasemi                                                                           
	, nsbasemi                                                                           
	, nsrutemi                                                                           
	, cpnominal                                                                          
	, 0                                                                                  
	, 0                                                                          
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                               
	, '19000101'                                                                         
	, '19000101'                                                                         
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, cpforpagi                                                
	, 0             
	, ''                                                                                 
	, 'N'                                                                                
	, ''                                                                                 
	, cprutcli                                                                     
	, cpcodcli                                                                     
	, ''                                                                                 
	, '11:11:11:11'                                                                      
	, 'ADMINISTRA'                                                                       
	, ''                                                                                 
	, cpcapitalc                                                                         
	, cpinteresc                                                                         
	, cpreajustc                                                                         
	, 0                                                                                  
	, 0                                                                                  
	, 0                                        
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, ' '                                   
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, cpvalcomp                                                                
	, cpvalcomu                                                                          
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, 0              
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, cpcontador                                                                         
	, 0                                                                                  
	, ''                                                                                 
	, ''              
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, cpdcv                                                                             
	, ''                                                                                 
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, 0                                                                                  
	, 0                                     
	, 0                                                                                  
	, 0                                                                                  
	, fecha_compra_original                          
	, valor_compra_original                          
	, valor_compra_um_original                  
	, tir_compra_original                   
	, valor_par_compra_original                  
	, porcentaje_valor_par_compra_original            
	, codigo_carterasuper            
	, Tipo_Cartera_Financiera           
	, Mercado             
	, Sucursal             
	, Id_Sistema             
	, Fecha_PagoMañana            
	, Laminas             
	, Tipo_Inversion                   
	, ''                                              
	, ''                                              
	, ''                                              
	, ''                                              
	, cptipoletra             
	, 0 --cpreserva_tecnica            
	, cpvalvenc             
	, cpvaltasemi             
	, cpprimadesc             
	, 0                 
	, 0           
	, 0                 
	, 'N'               
	, 'N'               
	, id_libro    
	, 'N'               
	, 0    
	, '-'               
	, '18:30:01'        
	, '-'               
	, '-'               
	FROM	MDCP 
		,	VIEW_NOSERIE  
    WHERE	cpfecven	= @fec_proc  
    AND		cpcodigo	= 98  
    and		nsrutcart	= cprutcart   
    and		nsnumdocu	= cpnumdocu  
    and		nscorrela	= cpcorrela   
    and		nsserie		= cpinstser   

	--**********************************************************************************************  
	-- COMMIT TRANSACTION  
	--- JBH, 18-12-2009 --- Actualización de Cartera de movimientos Intramesa Cartera Fija    

	--/*----------------------------------------------------------------------------------------------*/  
	--/* Actualización de la cartera de operaciones DEV  
	--/*----------------------------------------------------------------------------------------------*/  

	UPDATE	TBL_CARTICKETRTAFIJA   
	SET     Valor_Presente			= res.Valor_Presente_prox,  
			Duration				= res.Duration,  
			DurationMod				= res.DurationMod,  
			Convexidad				= res.Convexidad  
	FROM	Tbl_ResTicketRtaFija res
		,	MDAC
		,	Tbl_CarTicketRtaFija car  
	WHERE	res.Fecha_Operacion		= acfecproc   
	AND		res.Numero_Documento	= car.Numero_Documento  
	AND		res.Correlativo			= car.Correlativo  
	AND		res.Tipo_Operacion		= 'DEV'  

	IF @@ERROR <> 0  
	BEGIN  
		SELECT 'NO', 'Proceso de Actualización de cartera Intramesa (DEV) ha fallado.'  
		SET NOCOUNT OFF  
		RETURN  
	END  
  
   --/*----------------------------------------------------------------------------------------------*/  
   --/* Actualización de la Cartera de operaciones VC  
   --/*----------------------------------------------------------------------------------------------*/  

	UPDATE	TBL_CARTICKETRTAFIJA
	SET		Valor_Compra			= res.valor_compra,  
			Valor_Compra_UM			= res.valor_compra_um,  
			FechaUltCupon			= res.fecha_ult_cupon,  
			FechaProxCupon			= res.fecha_prox_cupon  
	FROM	TBL_RESTICKETRTAFIJA res
		,	MDAC
		,	TBL_CARTICKETRTAFIJA car  
	WHERE	res.Fecha_Operacion		= acfecproc   
	AND		res.Numero_Documento	= car.Numero_Documento  
	AND		res.Correlativo			= car.Correlativo  
	AND		res.Tipo_Operacion		= 'VC'   


	----/*CREAR REGISTRO DE GARANTIAS COMDER POR NPV Y VENCIMIENTO*/
	----/*PRD24171*/		
	DECLARE @RETORNO BIT
	exec BDBOMESA.garantia.sp_IngresosComDer_Efectivos @RETORNO OUTPUT
	 IF @RETORNO = 1 BEGIN
	 		SELECT 'NO', 'Proceso de registros de ComDer NPV y ComDer Vencimientos ha fallado.'  
			SET NOCOUNT OFF  
		  RETURN			
		 END
	  
	IF @@ERROR <> 0
	BEGIN  
		SELECT 'NO', 'Proceso de Actualización de cartera Intramesa (VC) ha fallado.'  
		SET NOCOUNT OFF  
		RETURN  
	END  

	SELECT 'SI','Proceso terminado con exito.'  
	RETURN  

END  
GO
