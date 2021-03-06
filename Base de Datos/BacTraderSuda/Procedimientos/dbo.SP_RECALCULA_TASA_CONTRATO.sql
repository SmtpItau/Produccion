USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALCULA_TASA_CONTRATO]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RECALCULA_TASA_CONTRATO]
	(	@dFecpro		char(10) , 
		@cTipoSalida	CHAR(1)
	)
AS
BEGIN

  DECLARE @rutcart numeric(9),
          	@tipcart numeric(5),
          	@numdocu numeric(10),
          	@correla  numeric(3),
          	@instser char(12),
          	@mascara  char(12),
          	@Nominal numeric(19,4),
          	@feccomp datetime,
          	@valcomp numeric(19,4),
          	@valcomu float, 
          	@tircomp numeric(9,4),
          	@numucup numeric(3),
          	@fecemi DATETIME,
	@fecven DATETIME,
          	@seriado CHAR(1),
      	@codigo Numeric(5),
          	@vptirc NUMERIC(19,04),
          	@fecucup DATETIME,
          	@fecpcup DATETIME,
          	@FecPagoM DATETIME,
          	@TasaCon NUMERIC(8,6),
          	@ValorCon NUMERIC(19,2), -- CBG 30/08/2004
          	@numcont NUMERIC(10),
	@cdias1 VARCHAR(255),
	@cChar CHAR(02),
	@dFecant DATETIME

  DECLARE @nValMonInico FLOAT,
          	@vValMonPcup FLOAT,
          	@nValConUm FLOAT,
          	@xValVenAct FLOAT,
          	@ntasemi  FLOAT,
          	@nbasemi  INTEGER, 
          	@ntasest FLOAT,
          	@dFecpcup DATETIME,
	@monemi INTEGER,
          	@cEstado CHAR(1),
          	@FecpCupo DATETIME,
          	@FecCalInt DATETIME

  DECLARE @xIntUlPer FLOAT, 
  	@xIntUlPerP NUMERIC(19), -- CBG 30/08/2004
	@xValVenUm FLOAT,
	@xAmorUm  FLOAT,
	@xAmorP NUMERIC(19,2), -- CBG 30/08/2004 
          	@valPtepCuUm FLOAT,
 	@valPtepCup NUMERIC(19,2),  -- CBG 30/08/2004 
	@dFecPpCup DATETIME,
          	@nDias INTEGER,
	@nTasaContrato FLOAT,
	@nFactor FLOAT,
          	@Nominalvi  numeric(19,4),
          	@cEstadoVi CHAR(1),
          	@MtoValVenVi FLOAT

  DECLARE @cPlaza INTEGER,
          	@dfechaHabil DATETIME,
          	@cString CHAR(25),
          	@PerVCup INTEGER

  DECLARE @fPvp  FLOAT  ,
	  @fMT  FLOAT  ,
	  @fMTUM  FLOAT  ,
	  @fMT_cien FLOAT  ,
	  @fVan  FLOAT  ,
	  @fVpar  FLOAT  ,
	  @nNumucup INTEGER  ,
	  @fIntucup FLOAT  ,
	  @fAmoucup FLOAT  ,
	  @fSalucup FLOAT  ,
	  @nNumpcup INTEGER  ,
	  @fIntpcup FLOAT  ,
	  @fAmopcup FLOAT  ,
	  @fSalpcup FLOAT  ,
	  @fDurat  FLOAT  ,
	  @fConvx  FLOAT  ,
	  @fDurmo  FLOAT  ,
	  @nError  INTEGER,
	  @nAmor INTEGER,
          	  @nvalmon FLOAT,
	  @nvalmonPxpr FLOAT,
	  @cProg CHAR(10),
  	  @dFecucup DATETIME,
          	  @nTasaCont NUMERIC (09,06),
          	  @nNominal FLOAT,
	  @cCartera CHAR(03),
	  @cInst    Char(12),
	  @ModInv   CHAR(01),
	  @tc_rep_cnt CHAR(01)

          DECLARE @UF FLOAT,
                @DO FLOAT,
                @DO_TC FLOAT,
                @DA FLOAT,
                @IVP FLOAT ,
                @BANCO CHAR(70),
                @RUT_BANCO CHAR(14) 
  
	DECLARE @Interes NUMERIC(19,4)
  
        SELECT @UF   = VMVALOR 
        FROM VIEW_VALOR_MONEDA,MDAC
        WHERE VMCODIGO = 998 AND VMFECHA = ACFECPROC
 
        SELECT @DO   = VMVALOR 
        FROM VIEW_VALOR_MONEDA,MDAC
        WHERE VMCODIGO = 994 AND VMFECHA = ACFECPROC

	/*
        SELECT @DO_TC   = isnull(VMVALOR_TCRC,0)     /* Dolar T/C Rep. Contable */
        FROM VIEW_VALOR_MONEDA,MDAC
        WHERE VMCODIGO = 994 AND VMFECHA = ACFECPROC
	*/

		SELECT	@DO_TC	= isnull( tipo_cambio, 0.0) 
		FROM	BacParamSuda.dbo.Valor_Moneda_Contable,MDAC
		WHERE	fecha	= acfecproc and codigo_moneda = 994

        SELECT @DA   = VMVALOR 
        FROM VIEW_VALOR_MONEDA,MDAC
        WHERE VMCODIGO = 995 AND VMFECHA = ACFECPROC

        SELECT @IVP   = VMVALOR 
        FROM VIEW_VALOR_MONEDA,MDAC
        WHERE VMCODIGO = 997 AND VMFECHA = ACFECPROC

	IF @DO_TC=0 BEGIN
         	 SELECT @tc_rep_cnt = 'N'   /* SE OCUPA T/C OBS */
        END ELSE BEGIN
		 SELECT @tc_rep_cnt = 'S'   /* SE OCUPA T/C REP CONTABLE */
	END

  CREATE TABLE #TempImp ( 
				  Inumdocu numeric(10),
				  ICartera CHAr(01),
				  Iinst	   Char(12),
 				  Iinstser char(12),
				  INominal numeric(19,4),
	       			  Itircomp numeric(9,4),
				  IValMonInico FLOAT, -- Moneda de Fecha pago efectivo 
		    		  IValConUm FLOAT , -- Capital UM Actual
		                  	  IValorCon numeric(19,4),  -- Capital Peso Actual
				  IValVenUm FLOAT ,  -- Valor Vencimiento proximo cupon Unidad monetaria
				  IAmorUm FLOAT, -- Amortizacion Cupon Unidad Monetaria 
				  IAmorP numeric(19,2),  -- Amortizacion Cupon Pesos --CBG 30/08/2004
		    		  IvalPtepCuUm FLOAT, -- Nuevo Capital Um
	    			  IvalPtepCup numeric(19,2), -- Nuevo Capital Peso --CBG 30/08/2004
				  ITasaContrato FLOAT, -- Nueva Tasa Contrato
				  IIntUlPer FLOAT, -- Intereses devengados UM
				  IIntUlPerP numeric(19,2)  -- Intereses devengados Pesos --CBG 30/08/2004
			     )

  CREATE TABLE #TmpMdcp 
		( 
		  rutcart Numeric(09),
	      	  tipcart Numeric(05),
        		  numdocu Numeric(10),
        		  correla Numeric(03),
        		  instser Char(12),
        		  mascara Char(12),
        		  Nominal Numeric(19,04),
        		  feccomp Datetime,
        		  valcomp Numeric(19,04),
        		  valcomu Numeric(19,04),
        		  tircomp Numeric(9,04),
        		  numucup Numeric(03),
        		  fecemi  Datetime,
        		  fecven  Datetime,
        		  seriado Char(01),
        		  codigo  Numeric(05),
        		  vptirc  Numeric(19,04),
        		  fecucup Datetime,
        		  fecpcup Datetime,
        		  Fecha_PagoM Datetime,
        		  TasaContrato Numeric(09,6),
		  	  ValorContable Numeric(19,2), --CBG 30/08/2004
		  	  NumeroContrato Numeric(10),  
		  	  Cartera Char(03),
		  		Flag INT,
		  		Interes NUMERIC(19,4)
		)

  SET NOCOUNT ON 
  SELECT @dFecant = acfecante From mdac

	If @cTipoSalida = 'L' 
	Begin
		insert into #tmpmdcp
		(		rutcart,
				tipcart,
				numdocu,
				correla,
				instser,
				mascara,
				Nominal,
				feccomp,
				valcomp,
				valcomu,
				tircomp,
				numucup,
				fecemi ,
				fecven ,
				seriado,
				codigo ,
				vptirc ,
				fecucup,
				fecpcup,
				Fecha_PagoM ,
				TasaContrato,
				ValorContable,
				NumeroContrato,
				Cartera,
				Flag,
				Interes
		)
		Select 	cprutcart,
				cptipcart,
				cpnumdocu,
				cpcorrela,
				cpinstser,
				cpmascara,
				cpNominal,
				cpfeccomp,
				cpvalcomp,
				cpvalcomu,
				cptircomp,
				cpnumucup,
				cpfecemi,
				cpfecven,
				cpseriado,
				cpcodigo,
				cpvptirc,
				cpfecucup,
				cpfecpcup,
				Fecha_PagoMañana,
				Tasa_Contrato,
				Valor_Contable,
				Numero_Contrato,
				'111',
				0,
				0
    From		Mdcp
				inner join	-- MMP 01/06/2011 CBG 30/08/2004 -- 26/03/2010 se agrega BTP de tesoreria / jcamposd se suma PDBC = 6
				(	select	incodigo
					from	BacParamSuda.dbo.instrumento
					where	inserie	IN('PRC', 'PDBC', 'DPF', 'DPR', 'PRD', 'BCD', 'BCP', 'BCU', 'BCX', 'PCX', 'BTU', 'BTP', 'DPX', 'CERO', 'XERO')
				)	ins		On ins.incodigo	= cpcodigo
    Where		cpfecpcup <= convert(datetime,@dFecpro) 
    Order
	By			cpnumdocu
			,	cpcorrela

	End Else 
	Begin
		insert into #tmpmdcp 
		(		rutcart,
				tipcart,
				numdocu,
				correla,
				instser,
				mascara,
				Nominal,
				feccomp,
				valcomp,
				valcomu,
				tircomp,
				numucup,
				fecemi ,
				fecven ,
				seriado,
				codigo ,
				vptirc ,
				fecucup,
				fecpcup,
				Fecha_PagoM ,
				TasaContrato,
				ValorContable,
				NumeroContrato,
				cartera,
				Flag,
				Interes
			)
		Select 	rsrutcart,
				rstipcart,
				rsnumdocu,
				rscorrela,
				rsinstser,
				rsmascara,
				rsNominal,
				rsfeccomp,
				rsvalcomp,
				rsvalcomu,
				rstir,
				rsnumucup,
				rsfecemi	= cpfecemi,
				rsfecven	= cpfecven,
				Isnull((Select inmdse From view_instrumento where incodigo = rscodigo),''),
				rscodigo,
				rsvppresen,		-->	rsvptirc,
				rsfecucup,
				rsfecpcup,
				Fecha_Pagomañana,

				Tasa_Contrato, 
				Valor_Contable,
				Numero_Contrato,

				rscartera,		-->	'111',
				0,
				rsinteres
		From	mdrs
				inner join
				(	select	incodigo
					from	BacParamSuda.dbo.instrumento with(nolock)
					where	inserie	IN('PRC', 'PDBC', 'DPF', 'DPR', 'PRD', 'BCD', 'BCP', 'BCU', 'BCX', 'PCX', 'BTU', 'BTP', 'DPX', 'CERO', 'XERO')
				)	ins		On ins.incodigo	= rscodigo
				left join
				(	select	cpnumdocu, cpcorrela, cpfecemi, cpfecven
					from	BacTraderSuda.dbo.mdcp  with(nolock)
				)	emis	on	emis.cpnumdocu	= rsnumdocu
							and	emis.cpcorrela	= rscorrela
		Where	rsfecha		= @dFecpro
		and		rscartera	= 111
	--	and		rsfecpcup  <= '20150925' --> convert(datetime,@dFecpro) 
	END
	
	update #tmpmdcp
	SET Interes = m.rsinteres
	FROM #tmpmdcp temp,
	mdrs m
	WHERE  m.rsfecha = @dFecpro
	AND temp.numdocu = m.rsnumdocu
	AND temp.correla = m.rscorrela

  WHILE (1=1)
   BEGIN
   SELECT @cEstado = '*'

   SET ROWCOUNT 1
   SELECT @rutcart  = rutcart,
          @tipcart =  tipcart,
          @numdocu  = numdocu,
          @correla  = correla,
          @instser  = instser,
          @mascara  = mascara,
          @nNominal  = Nominal,
          @feccomp  = feccomp,
          @valcomp  = valcomp,
          @valcomu  = valcomu,  
          @tircomp  = tircomp,
          @numucup  = numucup,
          @fecemi  =  fecemi,
          @fecven  =  fecven,
          @seriado  = seriado,
          @codigo   = codigo,
          @vptirc  =  vptirc,
          @fecucup =  fecucup,
          @fecpcup =  fecpcup,
          @FecPagoM  = CASE WHEN feccomp < '20070115' THEN Fecha_PagoM ELSE feccomp END,
          @TasaCon   = TasaContrato,
          @ValorCon  = ValorContable,
	  @numcont   = NumeroContrato,
	  @cCartera  = cartera,
	  @cInst     = (Select inserie from view_instrumento where incodigo = codigo),
          @cEstado = ' ',
	  @ModInv = CASE tipcart
			 WHEN 1 THEN 'T'
			 WHEN 2 THEN 'A'
			 WHEN 3 THEN 'P'
			 WHEN 4 THEN 'H'
				   END,
		 @Interes = Interes
     FROM #tmpmdcp WHERE flag = 0

     SET ROWCOUNT 0

     IF @cEstado = '*' BEGIN
        BREAK
     END

     -- Comienzo a procesar el archivo
     Select @cProg = (Select inprog FROM VIEW_INSTRUMENTO WHERE incodigo = @codigo)

     -- Moneda de emision
     Select @monemi = semonemi,
            @ntasemi = setasemi,
            @nbasemi = sebasemi, 
            @ntasest = 0,
	    @PerVCup = sepervcup
     FROM VIEW_SERIE WHERE seserie=@instser 

     -- Programa de cálculo
     IF @tc_rep_cnt = 'S' AND @monemi = 994
	 BEGIN
        select @cProg = 'sp_TCRC' + @cProg
     END ELSE
	 BEGIN
        select @cProg = 'sp_' + @cProg
     END

    -- Moneda fecha de pago original
	If @monemi = 999 OR @monemi = 13 OR @mascara = 'DPF' 
	BEGIN --CBG 30/08/2004
		Select @nValMonInico = 1
	END ELSE 
	BEGIN
		Select @nValMonInico = CASE WHEN @tc_rep_cnt='S' AND @monemi=994 THEN 
				(Select tipo_cambio from bacparamsuda.dbo.valor_moneda_contable where fecha=@FecPagoM and codigo_moneda=@monemi)
		    ELSE (Select vmvalor from VIEW_VALOR_MONEDA where vmfecha=@FecPagoM and vmcodigo=@monemi)
			    END
	END

     -- moneda fecha proximo cupon 
     Select @dfechaHabil = @fecpcup

     SELECT @cdias1 =CASE DATEPART(MONTH, @fecpcup)
    		WHEN  1 THEN feene
		WHEN  2 THEN fefeb
    		WHEN  3 THEN femar
    		WHEN  4 THEN feabr
    		WHEN  5 THEN femay
    		WHEN  6 THEN fejun
    		WHEN  7 THEN fejul
    		WHEN  8 THEN feago
    		WHEN  9 THEN fesep
    		WHEN 10 THEN feoct
    		WHEN 11 THEN fenov
    		WHEN 12 THEN fedic
   		END
     FROM VIEW_FERIADO
     WHERE feano  = DATEPART(YEAR,@fecpcup) AND feplaza = 6

     If DATEPART(DAY,@fecpcup) < 10    
        SELECT @cChar = '0'+CONVERT(CHAR(01),DATEPART(DAY,@fecpcup))
     Else
        SELECT @cChar = CONVERT(CHAR(02),DATEPART(DAY,@fecpcup))

     IF  CHARINDEX( @cchar,@cdias1) > 0 OR (DATEPART(WEEKDAY,@fecpcup)= 7 OR DATEPART(WEEKDAY,@fecpcup)=1 )
       	EXECUTE dbo.sp_TraeNexthabil @fecpcup ,@cPlaza, @dfechaHabil OUTPUT

     If @monemi = 999  OR @monemi = 13 OR @mascara = 'DPF'-- CBG 30/08/2004
     	Select @vValMonPcup = 1
     ELSE
     	Select @vValMonPcup = CASE WHEN @tc_rep_cnt='S' AND @monemi=994 THEN Isnull(( Select tipo_cambio from BacParamSuda.dbo.Valor_Moneda_Contable where fecha=@dfechaHabil and codigo_moneda=@monemi),0)
				   ELSE Isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmfecha=@dfechaHabil and vmcodigo=@monemi),0)
				   END

     If @cTipoSalida = 'L' 
	 Begin 
        -- Recuperando montos originales para cuando se este procesando la cartera Actual
        Select @nNominal = @nNominal + Isnull((SELECT sum(vinominal) 
                                               FROM MDVI 
 	   				       WHERE vinumdocu = @numdocu AND vicorrela = @correla AND Vitipoper = 'CP'),0)
   		Select @ValorCon = @ValorCon + Isnull((SELECT sum(Valor_Contable)
                	               FROM MDVI 
 					       WHERE vinumdocu = @numdocu AND vicorrela = @correla AND Vitipoper = 'CP') ,0)
     End

     Select @nValConUm = Round(@ValorCon / @nValMonInico,(CASE WHEN @monemi = 999 THEN 0 ELSE 2 END))

     -- Rescatar fecha cupon anterior cartado
     select @FecCalInt = @fecucup
--     FROM VIew_tabla_desarrollo
--     where tdmascara = @mascara and tdfecven < @Fecucup
--     order by tdfecven desc

     set rowcount 0
     If @nNominal > 0 BEGIN
        -- Valoriza a la fecha de proceso para sacar el valor vencimiento actual
        	Select @fPvp = 0 
   	Select @fMt = 0
	Select @fMtum = 0
        	Select @fMt_cien = 0
        	Select @fVan = 0
	Select @fVpar = 0
	Select @nNumucup = 0
        	Select @dFecucup = ''
        	Select @fIntucup = 0
        	Select @fAmoucup = 0
        	Select @fSalucup = 0
       	Select @nNumpcup = 0
        	Select @fIntpcup = 0
   	Select @fAmopcup = 0
        	Select @fSalpcup = 0
        	Select @fDurat   = 0
        	Select @fConvx  = 0
        	Select @fDurmo  = 0

        	If convert(datetime,@dFecpro) >= @Fecven
           		Select @dFecPpCup = @Fecven
 	Else
	   	Select @dFecPpCup = convert(datetime,@dFecpro)

	If @tc_rep_cnt = 'S' AND @monemi = 994
	        EXECUTE @nError =	@cProg 2, @dFecPpCup, @codigo,@instser, @monemi, @fecemi, @Fecven, 
        	        @ntasemi,	@nbasemi, @ntasest,	/*@tc_rep_cnt,*/
					@nNominal	OUTPUT, @tircomp	OUTPUT, @fPvp		OUTPUT, @fMt		OUTPUT,
	                @fMtum		OUTPUT, @fMt_cien	OUTPUT, @fVan		OUTPUT, @fVpar		OUTPUT, @nNumucup	OUTPUT, @dFecucup	OUTPUT,
	                @fIntucup	OUTPUT, @fAmoucup	OUTPUT, @fSalucup	OUTPUT, @nNumpcup	OUTPUT, @dFecpcup	OUTPUT,
	                @fIntpcup	OUTPUT, @fAmopcup	OUTPUT, @fSalpcup	OUTPUT, @fDurat		OUTPUT, @fConvx		OUTPUT, @fDurmo		OUTPUT
	ELSE
			EXECUTE @nError =	@cProg 2, @dFecPpCup, @codigo,@instser, @monemi, @fecemi, @Fecven,
        	        @ntasemi,	@nbasemi, @ntasest, 
					@nNominal	OUTPUT, @tircomp	OUTPUT,	@fPvp		OUTPUT, @fMt		OUTPUT,
	                @fMtum		OUTPUT, @fMt_cien	OUTPUT,	@fVan		OUTPUT, @fVpar		OUTPUT, @nNumucup	OUTPUT, @dFecucup	OUTPUT,
	                @fIntucup	OUTPUT, @fAmoucup	OUTPUT,	@fSalucup	OUTPUT, @nNumpcup	OUTPUT, @dFecpcup	OUTPUT,
	                @fIntpcup	OUTPUT, @fAmopcup	OUTPUT,	@fSalpcup	OUTPUT, @fDurat		OUTPUT, @fConvx		OUTPUT, @fDurmo		OUTPUT

   	Select @xValVenAct = ROUND( round( Round( (@fIntucup+@fAmoucup),6) * @nNominal,6) / 100,6)

	-- Valorizar a Proximo cupon
        	Select @fPvp = 0 
	Select @fMt = 0
	Select @fMtum = 0
        	Select @fMt_cien = 0
        	Select @fVan = 0
	Select @fVpar = 0
	Select @nNumucup = 0
        	Select @dFecucup = ''
        	Select @fIntucup = 0
        	Select @fAmoucup = 0
        	Select @fSalucup = 0
        	Select @nNumpcup = 0
        	Select @fIntpcup = 0
        	Select @fAmopcup = 0
        	Select @fSalpcup = 0
        	Select @fDurat   = 0
        	Select @fConvx  = 0
        	Select @fDurmo  = 0

        If convert(datetime,@dFecpro) >= @Fecven
           Select @dFecPpCup = @Fecven -- ????????????? Revisar cuando el papel vence
        Else
           Select @dFecPpCup = @fecpcup

	If @tc_rep_cnt = 'S' AND @monemi = 994
			EXECUTE @nError		= @cProg 2, @dFecPpCup, @codigo,@instser, @monemi, @fecemi, @Fecven, 
        	        @ntasemi,	@nbasemi,	@ntasest,	/*@tc_rep_cnt,*/
					@nNominal	OUTPUT,		@tircomp	OUTPUT, @fPvp		OUTPUT, @fMt		OUTPUT,
                	@fMtum		OUTPUT,		@fMt_cien	OUTPUT, @fVan		OUTPUT, @fVpar		OUTPUT, @nNumucup	OUTPUT, @dFecucup	OUTPUT,
	                @fIntucup	OUTPUT,		@fAmoucup	OUTPUT, @fSalucup	OUTPUT, @nNumpcup	OUTPUT, @dFecpcup	OUTPUT,
        	        @fIntpcup	OUTPUT,		@fAmopcup	OUTPUT, @fSalpcup	OUTPUT, @fDurat		OUTPUT, @fConvx		OUTPUT, @fDurmo		OUTPUT
	Else
			EXECUTE @nError		= @cProg 2, @dFecPpCup, @codigo,@instser, @monemi, @fecemi, @Fecven, 
        			@ntasemi,	@nbasemi,	@ntasest,	
					@nNominal	OUTPUT,		@tircomp	OUTPUT, @fPvp		OUTPUT, @fMt		OUTPUT,
                	@fMtum		OUTPUT,		@fMt_cien	OUTPUT, @fVan		OUTPUT, @fVpar		OUTPUT, @nNumucup	OUTPUT, @dFecucup	OUTPUT,
	                @fIntucup	OUTPUT,		@fAmoucup	OUTPUT, @fSalucup	OUTPUT, @nNumpcup	OUTPUT, @dFecpcup	OUTPUT,
        	        @fIntpcup	OUTPUT,		@fAmopcup	OUTPUT, @fSalpcup	OUTPUT, @fDurat		OUTPUT, @fConvx		OUTPUT,	@fDurmo		OUTPUT

        -- Sacar intereses Devengados desde el ultimo cupon cortado hasta el proximo cupon            

        if @FecCalInt < @FecPagoM
           Select @FecCalInt = @FecPagoM

	Select @xIntUlPer =  Round(((@nValConUm * @TasaCon)/36000)*(Datediff(DD,@FecCalInt,@dFecPpCup)),(CASE WHEN @monemi = 999 THEN 0 ELSE 2 END))
	Select @xIntUlPerP = (CASE WHEN  @monemi <> 13 THEN Round(@xIntUlPer*@vValMonPcup ,0) ELSE  Round(@xIntUlPer*@vValMonPcup ,2) END) -- CBG 30/08/2004
	Select @xValVenUm = ROUND( round( Round( (@fIntpcup+@fAmopcup),6) * @nNominal,6) / 100,(CASE WHEN @monemi = 999 THEN 0 ELSE 2 END)) --CBG 30/08/2004

	If @xValVenUm = 0  
	   Begin
	     Select @xAmorUm = @nValConUm
	     Select @xAmorP  = (CASE WHEN @monemi <> 13 THEN  Round(@xAmorUm * @nValMonInico,0) ELSE Round(@xAmorUm * @nValMonInico,2) END ) -- CBG 30/08/2004
	   End
	Else
	   Begin
	     Select @xAmorUm = Round((@xValVenAct - @xIntUlPer),(CASE WHEN @monemi = 999 THEN 0 ELSE 2 END))
	     Select @xAmorP  = (CASE WHEN @monemi <> 13 THEN  Round(@xAmorUm * @nValMonInico,0) ELSE Round(@xAmorUm * @nValMonInico,2) END ) -- CBG 30/08/2004
	End

	Select @valPtepCuUm = Round((@nValConUm - @xAmorUm),(CASE WHEN @monemi = 999 THEN 0 ELSE 2 END)) -- Nuevo Capital Um
	Select @valPtepCup  = (CASE WHEN @monemi <> 13 THEN  Round(@valPtepCuUm * @nValMonInico,0) ELSE Round(@valPtepCuUm * @nValMonInico,2) END )  -- Nuevo Capital Peso --CBG 30/08/2004
                       
	-- Valorizar al subsiguiente cupon
        	Select @fPvp = 0 
	Select @fMt = 0
	Select @fMtum = 0
        	Select @fMt_cien = 0
        	Select @fVan = 0
	Select @fVpar = 0
	Select @nNumucup = 0
        	Select @dFecucup = ''
        	Select @fIntucup = 0
        	Select @fAmoucup = 0
        	Select @fSalucup = 0
        	Select @nNumpcup = 0
        	Select @fIntpcup = 0
        	Select @fAmopcup = 0
        	Select @fSalpcup = 0
        	Select @fDurat   = 0
        	Select @fConvx  = 0
        	Select @fDurmo  = 0

        SET ROWCOUNT 1
        SELECT @dFecPpCup  = tdfecven
        FROM  VIEW_TABLA_DESARROLLO
        WHERE tdmascara = @instser AND tdfecven > @FecpCup
        SET ROWCOUNT 0

        Select @nDias = DAteDiff(DD,@Fecpcup,@dFecpcup)

	If @tc_rep_cnt = 'S' AND @monemi = 994
	        EXECUTE @nError = @cProg 2, @dFecpcup, @codigo,@instser, @monemi, @fecemi, @Fecven, 
	                @ntasemi, @nbasemi, @ntasest,	/*@tc_rep_cnt,*/
					@nNominal	OUTPUT, @tircomp	OUTPUT, @fPvp		OUTPUT, @fMt		OUTPUT,
	                @fMtum		OUTPUT, @fMt_cien	OUTPUT, @fVan		OUTPUT, @fVpar		OUTPUT, @nNumucup	OUTPUT, @dFecucup	OUTPUT,
	                @fIntucup	OUTPUT, @fAmoucup	OUTPUT, @fSalucup	OUTPUT, @nNumpcup	OUTPUT, @dFecpcup	OUTPUT,
	                @fIntpcup	OUTPUT, @fAmopcup	OUTPUT, @fSalpcup	OUTPUT, @fDurat		OUTPUT, @fConvx		OUTPUT, @fDurmo		OUTPUT
	Else
	        EXECUTE @nError = @cProg 2, @dFecpcup, @codigo,@instser, @monemi, @fecemi, @Fecven, 
	                @ntasemi, @nbasemi, @ntasest,
					@nNominal	OUTPUT, @tircomp	OUTPUT, @fPvp		OUTPUT, @fMt		OUTPUT,
	                @fMtum		OUTPUT, @fMt_cien	OUTPUT, @fVan		OUTPUT, @fVpar		OUTPUT, @nNumucup	OUTPUT, @dFecucup	OUTPUT,
	                @fIntucup	OUTPUT, @fAmoucup	OUTPUT, @fSalucup	OUTPUT, @nNumpcup	OUTPUT, @dFecpcup	OUTPUT,
	                @fIntpcup	OUTPUT, @fAmopcup	OUTPUT, @fSalpcup	OUTPUT, @fDurat		OUTPUT, @fConvx		OUTPUT, @fDurmo		OUTPUT

	If (@fMtum + @xValVenUm) > 0 And @valPtepCuUm > 0            
   	   Select @nTasaContrato = ROUND(((((  Round(@fMtum + @xValVenUm,2)-@valPtepCuUm) / @valPtepCuUm)*36000)  / @nDias),6)
	Else 
	   Select @nTasaContrato = 0

		    -- Actualizar cartera propia con los datos nuevos calculados Tasa Contrato y Valor Contable

--**********************************************************************************************
	/* Se debe tener MUCHO OJO con este Párrafo ya que actualiza los valores contables y tasa contrato
           de los papeles en cartera. Si se desea sacar solo el listado se debe enviar el parámetro @cTipoSalida 
           como "L" */
        /* Debe actualizar solo la cartera Available for Sale */

	If @cTipoSalida = 'I'  Begin 

  	  UPDATE MDCP
	  SET	tasa_contrato	= CASE WHEN @ModInv = 'A' THEN @nTasaContrato ELSE @tircomp END ,
			valor_Contable	=(CASE WHEN cpcodigo IN (35,36,38) THEN Round((@valPtepCup * (cpnominal/@nNominal)),2) ELSE Round((@valPtepCup * (cpnominal/@nNominal)),0) END) -- CBG 30/08/2004
	  WHERE cprutcart		= @rutcart AND cptipcart = @tipcart AND cpnumdocu = @numdocu AND cpcorrela = @correla

	  UPDATE MDDI
	  SET	tasa_contrato = CASE WHEN @ModInv = 'A' THEN @nTasaContrato ELSE @tircomp END ,
			valor_Contable =(CASE WHEN dimoneda<>13 THEN  Round((@valPtepCup * (dinominal/ @nNominal)),0) ELSE Round((@valPtepCup * (dinominal/ @nNominal)),2) END) -- CBG 30/08/2004
	  WHERE dirutcart = @rutcart AND ditipcart = @tipcart AND dinumdocu = @numdocu AND dicorrela = @correla


          UPDATE MDVI
	  SET tasa_contrato = CASE WHEN @ModInv = 'A' THEN @nTasaContrato ELSE @tircomp END ,
	      valor_Contable =(CASE WHEN vicodigo IN (35,36,38) THEN Round((@valPtepCup * (vinominal/ @nNominal)),2) ELSE  Round((@valPtepCup * (vinominal/ @nNominal)),0) END ) -- CBG 30/08/2004
	  WHERE virutcart = @rutcart AND vinumdocu = @numdocu AND vicorrela = @correla


        End

--**********************************************************************************************

        -- Actualizo el archivo temporal par la impresion
	INSERT INTO #TempImp VALUES ( @numcont, -- Numero de documento Original 
				      @ModInv , -- Modalidad de Inversión
				      @cInst  , -- Familia instrumento
 		      		      @instser, -- Codigo Nemotecnico del Instrumento
				      @nNominal, -- Nominal Real Original
       				      @tircomp, -- Tir de Compra Original
				      Round(@nValMonInico,2), -- Moneda de Fecha pago efectivo 
	    							@valcomu , --Round(@nValConUm,2), -- Capital UM Actual
									@valcomp ,  --@ValorCon,  -- Capital Peso Actual	
				      Round(@xValVenUm,2), -- Valor Vencimiento proximo cupon Unidad monetaria
				      Round(@xAmorUm,2), -- Amortizacion Cupon Unidad Monetaria 
				      @xAmorP,  -- Amortizacion Cupon Pesos
	    			      Round(@valPtepCuUm,2), -- Nuevo Capital Um
	    			      @valPtepCup, -- Nuevo Capital Peso
				      CASE WHEN @ModInv = 'A' THEN @nTasaContrato ELSE @tircomp END, -- Nueva Tasa Contrato
									@Interes, --Round(@xIntUlPer,2) , -- Intereses devengados UM
									@Interes --@xIntUlPerP -- Intereses devengados Pesos
				   )

     END -- Nominal Mayor a 0
     UPDATE #tmpmdcp SET flag = 1 WHERE numdocu = @numdocu AND correla = @correla
   END

  IF EXISTS(SELECT * FROM #TEMPIMP) BEGIN   
                   Select Inumdocu ,
			  ICartera ,
			  Iinst	   ,
 			  Iinstser ,
			  INominal ,
       			  Itircomp ,
			  IValMonInico , -- Moneda de Fecha pago efectivo 
	    		  IValConUm  , -- Capital UM Actual
	                  IValorCon ,  -- Capital Peso Actual
			  IValVenUm ,  -- Valor Vencimiento proximo cupon Unidad monetaria
			  IAmorUm , -- Amortizacion Cupon Unidad Monetaria 
			  IAmorP ,  -- Amortizacion Cupon Pesos
    		  	  IvalPtepCuUm , -- Nuevo Capital Um
	    		  IvalPtepCup , -- Nuevo Capital Peso
			  ITasaContrato , -- Nueva Tasa Contrato
			  IIntUlPer , -- Intereses devengados UM
	 	          IIntUlPerP  -- 
                          ,'Hora'= Convert(Char(10),GetDate(),108)
                          ,fecha = convert(char(10),convert(DATETIME,@dFecpro),103),
                         'NomProp' = acnomprop,
                         'RutProp' = Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop,
                         'UF'        = @UF,
                         'IVP'       = @IVP,
                         'DO'        = @DO,
                         'DA'        = @DA
              from #TempImp,mdac
     Order by ICartera,Iinst,Iinstser-- Datos para el reporte de 

  END ELSE begin
                 SELECT   Inumdocu = convert(numeric(10),0),
			  ICartera = ' ',
			  Iinst	   = convert(Char(12),' '),
 			  Iinstser = convert(Char(12),' '),
			  INominal = convert(numeric(19,4),0),
       			  Itircomp = convert(numeric(9,4),0),
			  IValMonInico =convert(FLOAT,0), -- Moneda de Fecha pago efectivo 
	    		  IValConUm  =convert(FLOAT,0), -- Capital UM Actual
	                  IValorCon = convert(numeric(19,4),0),  -- Capital Peso Actual
			  IValVenUm =convert(FLOAT,0),  -- Valor Vencimiento proximo cupon Unidad monetaria
			  IAmorUm =convert(FLOAT,0), -- Amortizacion Cupon Unidad Monetaria 
			  IAmorP =convert(numeric(19),2),  -- Amortizacion Cupon Pesos -- CBG 30/08/2004
	    		  IvalPtepCuUm =convert(FLOAT,0), -- Nuevo Capital Um
	    		  IvalPtepCup = convert(numeric(19,2),0), -- Nuevo Capital Peso --CBG 30/08/2004
			  ITasaContrato =convert(FLOAT,0), -- Nueva Tasa Contrato
			  IIntUlPer =convert(FLOAT,0), -- Intereses devengados UM
	                  IIntUlPerP =convert(numeric(19,2),0) ,--  END  -- CBG 30/08/2004
                          'Hora'= Convert(Char(10),GetDate(),108),
                          fecha = convert(char(10),convert(DATETIME,@dFecpro),103),
                          'NomProp' = acnomprop,
                          'RutProp' = Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop,
                          'UF'        = @UF,
                          'IVP'       = @IVP,
                          'DO'        = @DO,
                          'DA'        = @DA
                 from mdac
   END    

   DROP TABLE #TempImp
   DROP TABLE #tmpmdcp
   SET NOCOUNT OFF

END
GO
