USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_IND_ACT_VLU]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVA_IND_ACT_VLU]
AS
BEGIN


SET NOCOUNT ON

 DECLARE @x           integer  ,
         @suma        integer  ,
         @nnumdocu    numeric (10,0) ,
         @ncorrela    numeric (03,0) ,
         @ctipoper    char (03) ,
         @nnumoper    numeric (10,0) ,
         @nnominal    numeric (19,4) 
         
	DECLARE @PrimerDiaMes	CHAR(12),
		@UltimoDiaMes	CHAR(12),
		@Paridad	NUMERIC(12,4),
		@TipoCambio	NUMERIC(12,4),
                @valorDolar	NUMERIC(12,4),
                @dFechaproc     DATETIME,
                @dFechaprox     DATETIME

        SELECT  @dFechaproc    =  convert(char(8), acfecproc , 112) ,
                @dFechaprox    =  convert(char(8), acfecprox , 112) 
         FROM text_arc_ctl_dri 

-- select dolarObsFinMes, *  select  convert(char(8), acfecproc , 112) from text_arc_ctl_dri
	DELETE	text_mvt_dri
	FROM	text_arc_ctl_dri
	WHERE	mofecpro >= acfecproc
	AND	motipoper IN ('CP','VP')

         -- Valor de dolar para loas operaciones compras en valuta

	SELECT @PrimerDiaMes   = SUBSTRING( ( convert(char(8), @dFechaproc , 112))  ,1,6)  + '01'
	SELECT @UltimoDiaMes   = SUBSTRING(CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,35,@PrimerDiaMes)),112),1,6) + '01'
	SELECT @UltimoDiaMes   = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@UltimoDiaMes)),112)


		----<< Chequea si es el ultimo dia del Mes
	IF SUBSTRING(@UltimoDiaMes,5,2) <> SUBSTRING( (convert(char(8), @dFechaprox , 112))  ,5,2)
	BEGIN
	--      PRINT 'Hoy es el Ultimo dia del Mes'
		SELECT	@valorDolar	= ISNULL(vmvalor, 0 ) 
		FROM    view_valor_moneda 
		WHERE   vmcodigo = 994 and vmfecha = @dFechaproc

	END
	ELSE
	BEGIN
		SELECT	@valorDolar	= ISNULL( dolarObsFinMes , 0 ) FROM text_arc_ctl_dri
	END	

	INSERT INTO TEXT_MVT_DRI (
		mofecpro,
		morutcart,
		monumdocu,
		monumoper,
		mocorrelativo,
		motipoper,
		cod_nemo,
		cod_familia,
		id_instrum,
		morutcli,
		mocodcli,
		mofecemi,
		mofecven,
		mofecneg,
		momonemi,
		momonpag,
		momontoemi,
		motasemi,
		mobasemi,
		morutemi,
		mofecpago,
		monominal,
		movpresen,
		movalvenc,
		momtps,
		momtum,
		motir,
		mopvp,
		movpar,
		moint_compra,
		moprincipal,
		movalcomp,
		movalcomu,
		mointeres,
		moreajuste,
		moutilidad,
		moperdida,
		movalven,
		monumucup,
		monumpcup,
		mousuario,
--		moterminal,
		mostatreg,
		moobserv,
		basilea,
		tipo_tasa,
		encaje,
		monto_encaje,
		codigo_carterasuper,
		Tipo_Cartera_Financiera,
		sucursal,
		corr_bco_nombre,
		corr_bco_cta,
		corr_bco_aba,
		corr_bco_pais,
		corr_bco_ciud,
		corr_bco_swift,
		corr_bco_ref,
		corr_cli_nombre,
		corr_cli_cta,
		corr_cli_aba,
		corr_cli_pais,
		corr_cli_ciud,
		corr_cli_swift,
		corr_cli_ref,
		operador_contraparte,
		operador_Banco,
		calce,
		tipo_inversion,
		para_quien,
--		tipo_riesgo,
--		grado_riesgo,
--		codigo_riesgo,
		nombre_custodia,
		confirmacion,
		forma_pago,
		base_tasa,
		cod_emi,
		capitalpeso,
		interespeso,
		Resultado_Dif_Precio,		--> Ventas AFS
		Resultado_Dif_Mercado,		--> Ventas AFS
		ValorMercado_prop			--> Ventas AFS
		)
	SELECT	acfecproc,
		morutcart,
		monumdocu,
		monumoper,
		mocorrelativo,
		LTRIM(RTRIM(motipoper)),
		cod_nemo,
		cod_familia,
		id_instrum,
		morutcli,
		mocodcli,
		mofecemi,
		mofecven,
		mofecneg,
		momonemi,
		momonpag,
		momontoemi,
		motasemi,
		mobasemi,
		morutemi,
		mofecpago,
		monominal,
		movpresen,
		movalvenc,
		momtps,
		momtum,
		motir,
		mopvp,
		movpar,
		moint_compra,
		moprincipal,
		movalcomp,
		movalcomu,
		mointeres,
		moreajuste,
		moutilidad,
		moperdida,
		movalven,
		monumucup,
		monumpcup,
		mousuario,
--		moterminal,
		CASE WHEN mostatreg = 'P' THEN '' ELSE mostatreg END,
		moobserv,
		basilea,
		tipo_tasa,
		encaje,
		monto_encaje,
		codigo_carterasuper,
		Tipo_Cartera_Financiera,
		sucursal,
		corr_bco_nombre,
		corr_bco_cta,
		corr_bco_aba,
		corr_bco_pais,
		corr_bco_ciud,
		corr_bco_swift,
		corr_bco_ref,
		corr_cli_nombre,
		corr_cli_cta,
		corr_cli_aba,
		corr_cli_pais,
		corr_cli_ciud,
		corr_cli_swift,
		corr_cli_ref,
		operador_contraparte,
		operador_Banco,
		calce,
		tipo_inversion,
		para_quien,
		nombre_custodia,
		confirmacion,
		forma_pago,
		base_tasa,
		cod_emi, -- movpresen
                CASE motipoper WHEN 'CP'  THEN
   		                    ( CASE WHEN (momonemi = 994 or momonemi = 13) THEN ROUND( (movalcomu * @valorDolar ),0) 
                                                                                  ELSE ROUND( (movalcomu * (select vmvalor from view_valor_moneda WHERE vmcodigo = momonemi and vmfecha = acfecproc ) ) ,0)
                                     END)           
                               WHEN 'VP'  THEN
                  		    ( CASE WHEN (momonemi = 994 or momonemi = 13) THEN ROUND( (movpresen * ISNULL((SELECT dolarObsFinMes FROM text_arc_ctl_dri ),0) ),0) 
                                                                                  ELSE ROUND( (movpresen * (select vmvalor from view_valor_moneda WHERE vmcodigo = momonemi and vmfecha = acfecproc ) ) ,0)
                                      END)    

               END,
			interespeso,

			Resultado_Dif_Precio,		--> Ventas AFS
			Resultado_Dif_Mercado,		--> Ventas AFS
			ValorMercado_prop			--> Ventas AFS
	 FROM	text_ctr_cpr
		,	text_arc_ctl_dri
	WHERE	mofecpago = acfecproc
        and     mostatreg <> 'A'      


        /* Operaciones que se inician un dia inhabil*/                
	INSERT INTO TEXT_MVT_DRI(
		mofecpro,
		morutcart,
		monumdocu,
		monumoper,
		mocorrelativo,
		motipoper,
		cod_nemo,
		cod_familia,
		id_instrum,
		morutcli,
		mocodcli,
		mofecemi,
		mofecven,
		mofecneg,
		momonemi,
		momonpag,
		momontoemi,
		motasemi,
		mobasemi,
		morutemi,
		mofecpago,
		monominal,
		movpresen,
		movalvenc,
		momtps,
		momtum,
		motir,
		mopvp,
		movpar,
		moint_compra,
		moprincipal,
		movalcomp,
		movalcomu,
		mointeres,
		moreajuste,
		moutilidad,
		moperdida,
		movalven,
		monumucup,
		monumpcup,
		mousuario,
--		moterminal,
		mostatreg,
		moobserv,
		basilea,
		tipo_tasa,
		encaje,
		monto_encaje,
		codigo_carterasuper,
		Tipo_Cartera_Financiera,
		sucursal,
		corr_bco_nombre,
		corr_bco_cta,
		corr_bco_aba,
		corr_bco_pais,
		corr_bco_ciud,
		corr_bco_swift,
		corr_bco_ref,
		corr_cli_nombre,
		corr_cli_cta,
		corr_cli_aba,
		corr_cli_pais,
		corr_cli_ciud,
		corr_cli_swift,
		corr_cli_ref,
		operador_contraparte,
		operador_Banco,
		calce,
		tipo_inversion,
		para_quien,
--		tipo_riesgo,
--		grado_riesgo,
--		codigo_riesgo,
		nombre_custodia,
		confirmacion,
		forma_pago,
		base_tasa,
		cod_emi,
		capitalpeso,
		interespeso,
		Resultado_Dif_Precio,		--> Ventas AFS
		Resultado_Dif_Mercado,		--> Ventas AFS
		ValorMercado_prop			--> Ventas AFS
		)
	SELECT	acfecproc,
		morutcart,
		monumdocu,
		monumoper,
		mocorrelativo,
		LTRIM(RTRIM(motipoper)),
		cod_nemo,
		cod_familia,
		id_instrum,
		morutcli,
		mocodcli,
		mofecemi,
		mofecven,
		mofecneg,
		momonemi,
		momonpag,
		momontoemi,
		motasemi,
		mobasemi,
		morutemi,
		mofecpago,
		monominal,
		movpresen,
		movalvenc,
		momtps,
		momtum,
		motir,
		mopvp,
		movpar,
		moint_compra,
		moprincipal,
		movalcomp,
		movalcomu,
		mointeres,
		moreajuste,
		moutilidad,
		moperdida,
		movalven,
		monumucup,
		monumpcup,
		mousuario,
--		moterminal,
		CASE WHEN mostatreg = 'P' THEN '' ELSE mostatreg END,
		moobserv,
		basilea,
		tipo_tasa,
		encaje,
		monto_encaje,
		codigo_carterasuper,
		Tipo_Cartera_Financiera,
		sucursal,
		corr_bco_nombre,
		corr_bco_cta,
		corr_bco_aba,
		corr_bco_pais,
		corr_bco_ciud,
		corr_bco_swift,
		corr_bco_ref,
		corr_cli_nombre,
		corr_cli_cta,
		corr_cli_aba,
		corr_cli_pais,
		corr_cli_ciud,
		corr_cli_swift,
		corr_cli_ref,
		operador_contraparte,
		operador_Banco,
		calce,
		tipo_inversion,
		para_quien,
--		tipo_riesgo,
--		grado_riesgo,
--		codigo_riesgo,
		nombre_custodia,
		confirmacion,
		forma_pago,
		base_tasa,
		cod_emi,
--		capitalpeso,
                CASE motipoper WHEN 'CP'  THEN
   		                    ( CASE WHEN (momonemi = 994 or momonemi = 13) THEN ROUND( (movalcomu * (select vmvalor from view_valor_moneda WHERE vmcodigo = 994 and vmfecha = acfecproc ) ),0) 
                                                                                  ELSE ROUND( (movalcomu * (select vmvalor from view_valor_moneda WHERE vmcodigo = momonemi and vmfecha = acfecproc ) ) ,0)
                                     END)           
                               WHEN 'VP'  THEN
                  		    ( CASE WHEN (momonemi = 994 or momonemi = 13) THEN ROUND( (movpresen * (select vmvalor from view_valor_moneda WHERE vmcodigo = 994 and vmfecha = acfecproc ) ),0) 
                                                                                  ELSE ROUND( (movpresen * (select vmvalor from view_valor_moneda WHERE vmcodigo = momonemi and vmfecha = acfecproc ) ) ,0)
                                      END)    

               END,
		interespeso,

		Resultado_Dif_Precio,		--> Ventas AFS
		Resultado_Dif_Mercado,		--> Ventas AFS
		ValorMercado_prop			--> Ventas AFS
	 FROM	text_ctr_cpr, text_arc_ctl_dri -- select * from text_arc_ctl_dri
	WHERE	mofecpago < acfecproc
          AND   mofecpago > acfecante 
          AND   mostatreg <> 'A'

	UPDATE	text_mvt_dri
	SET		movpresen  = ROUND( cpvptirc  /  cpnominal * monominal , 2),
			mointeres  = ROUND( cpinteres /  cpnominal * monominal , 2),
			moreajuste = ROUND( cpreajust /  cpnominal * monominal , 2)
	FROM	text_ctr_inv,
			text_arc_ctl_dri
	WHERE	monumdocu = cpnumdocu
	and		motipoper = 'VP'
	and		mofecpro  = acfecproc
	and     mostatreg <> 'A' 

	UPDATE	text_mvt_dri
	SET		moutilidad = 0,
			moperdida = 0
	FROM	text_arc_ctl_dri
	WHERE	motipoper = 'VP'
	and		mofecpro  = acfecproc
	and     mostatreg <> 'A'

	UPDATE	text_mvt_dri
	SET		moutilidad = movalven - movpresen
	FROM	text_arc_ctl_dri
	WHERE	motipoper = 'VP'
	AND		movalven > movpresen  
	and		mofecpro  = acfecproc
	and     mostatreg <> 'A'

	UPDATE	text_mvt_dri
	SET	moperdida = movpresen - movalven
	FROM	text_arc_ctl_dri
	WHERE	motipoper = 'VP'
	AND	movpresen  > movalven
	and	mofecpro  = acfecproc
        and     mostatreg <> 'A'

	 create table #TEMP
	   (
        	 tipoper        char (03) not null ,
	         numdocu        numeric (10,0) not null ,
	         correla        numeric (03,0) not null ,
	         numoper        numeric (10,0) not null ,
	         nominal        numeric (19,4) not null ,
	         registro       integer identity(1,1) not null
	   )

	 select @x        = 1 ,
        	@suma     = 0 ,
	        @ctipoper = ''


	 insert #TEMP
	 select motipoper  ,
        	monumdocu  ,
	        mocorrelativo  ,
        	monumoper  ,
	        monominal  
	 from text_ctr_cpr, text_arc_ctl_dri
	 WHERE motipoper='VP'
	   and mofecpago <= acfecproc
           and mostatreg <> 'A'

	while (@x = 1)  begin


	       	select @ctipoper = '*'
   		set rowcount 1 
		   select @ctipoper = isnull(tipoper,'*') ,
        		  @nnumdocu = numdocu  ,
	        	  @ncorrela = correla  ,
		          @nnumoper = numoper  ,
		          @nnominal = nominal  ,
		          @suma     = registro  
		   from #TEMP
		   WHERE registro>@suma
		   set rowcount 0 
  
		   if @ctipoper='*'
		    break
-- select cpvptirc, princdia, * from text_ctr_inv WHERE  cpnumdocu = 126

                   /*Rebaja montos en cartera proporcional*/
		   UPDATE text_ctr_inv
		   SET    cpnominal  = cpnominal   - @nnominal  ,
		          cpnomi_vta = cpnomi_vta  - @nnominal  ,
			  cpvptirc   = cpvptirc - (cpvptirc *  (@nnominal  / cpnominal)),
			  princdia   = princdia - (princdia *  (@nnominal  / cpnominal)),   	
			  cpprincipal= ((cpnominal   - @nnominal  ) *  cppvpcomp /100 ),--cpprincipal - (cpprincipal *  (@nnominal  / cpnominal))   		
                          cpvalcomu   = cpvalcomu - (cpvalcomu *  (@nnominal  / cpnominal))                           
		   WHERE  cpnumdocu = @nnumdocu and cpcorrelativo = 1
			

	  end


	DELETE	text_ctr_cpr
	FROM	text_arc_ctl_dri
	WHERE	mofecpago <= acfecproc

SET NOCOUNT OFF

END

GO
