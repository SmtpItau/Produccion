USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[FL51]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC FL51 '20211126'
CREATE PROC [dbo].[FL51] (@dFechaProceso DAteTime=Null)
AS
BEGIN

SET NOCOUNT ON 

DECLARE @VALORX NUMERIC(19,4),
         @xx15 NUMERIC(19,4),
         @nmone NUMERIC(3),
         @campo_26 datetime,
	 @feccontable DATETIME


DECLARE @CCMOR CHAR(3)
DECLARE @CCMON CHAR(2)
DECLARE @c                CHAR (1) ,
        @c1               CHAR (1) ,
        @mascara          CHAR (25) ,
        @instrumento      CHAR (25) ,
        @codigo           NUMERIC (5) ,
        @nominal          NUMERIC (19,4) ,
        @tir              NUMERIC (19,4) ,
        @taspact          NUMERIC (19,4) ,
        @fecvenpact       DATETIME ,
        @moneda           NUMERIC (5) ,
        @seriado          CHAR (1) ,
        @tipoper          CHAR (3) ,
        @valinip          NUMERIC (19,4) ,
        @valvenp          NUMERIC (19,4) ,
        @valcomp          NUMERIC (19,4) ,
        @rutcli           NUMERIC (9) ,
        @codcli           NUMERIC (5) ,
        @rutemi           NUMERIC (9) ,
        @tabla            CHAR (4) ,
        @numero           NUMERIC (9) ,
        @cuenta           CHAR (20) ,
        @tipo_tasa        NUMERIC (1) ,
        @inversion        NUMERIC (5) ,
        @tipo_cuenta      CHAR (2) ,
        @fecha            DATETIME ,
        @periodo          INTEGER  ,
        @fecvenp          DATETIME,
        @cliente          NUMERIC (9) ,
        @estado           NUMERIC (9) ,
        @emtipo           CHAR (5) ,
        @nmes             CHAR (2) ,
        @nmes_a           CHAR (2) ,
        @nano             CHAR (4) ,
        @cano             CHAR (4) ,
        @nNumdocu         NUMERIC (10,0) ,
        @nNumoper         NUMERIC (10,0) ,
        @nCorrela         NUMERIC (03,0)  ,
        @fec_comp         DATETIME , 
        @CTTAS            CHAR (3) ,
        @dias_dife        NUMERIC(6),
        @tran_perm        CHAR (10) ,
        @tirc             NUMERIC(19,4),
        @DIAS             NUMERIC(19),
        @max_fecha        DATETIME,
        @cope             NVARCHAR(20),
        @corr             NUMERIC(2),
        @ntoc             NUMERIC(19) ,--- char(3),   --3
        @sepa             CHAR(1),
        @vcuo             NUMERIC(19,4),
        @svca             NUMERIC(19),
        @tasa             NUMERIC(19,4),
        @rut              CHAR(10),
        @cant             NUMERIC(19),
        @contador         NUMERIC(19),
        @val_presen       NUMERIC(19,4),
        @tdmascara        CHAR(10)       ,
        @tdcupon          NUMERIC (5)    ,
        @tdcupon2         NUMERIC (5)    ,
        @tdamort          NUMERIC (25,10),  --19
        @tdamort2         FLOAT, -- NUMERIC (19),
        @tdfecven         DATETIME       ,
        @tdinteres        NUMERIC(21,10) ,-- NUMERIC(19,10) ,
        @tdinteres2       FLOAT ,--NUMERIC(21,10) ,-- NUMERIC(19,10) ,
        @tdflujo          NUMERIC(21,10) ,
        @tdsaldo          NUMERIC(21,10) ,
        @cuenta_flu       CHAR(20),
        @valcomu          NUMERIC(19,4),
        @nsnumdocu        numeric(9),
        @nsfecven         datetime,
        @nsfecemi         datetime,
        @fecha_ami        datetime,
        @inte             numeric(19,4),
        @valmoneda        numeric(19,4),
        @valmoneda_ori    numeric(19,4),
        @valmoneda_comp   numeric(19,4),
        @valmoneda_dia    numeric(19,4),
        @ref              NVARCHAR(20)   ,
        @cont_reg         NUMERIC(19)    ,
        @valorpresente    NUMERIC(25,4) ,--19
        @mas_paso         CHAR (12)   ,
        @Peri_cupon       numeric(19) ,--numeric(5) ,
        @dfecfmes         datetime   ,
        @dFecFMesProx     datetime   ,
        @acfecprox        datetime   ,
        @fecucup          datetime ,
        @interes          numeric(19,4),
	@Spread		  numeric(19,4),
	@TipoTasa	  CHAR(1)	,
	@TipoDIAS	  CHAR(1)	,
	@Difdias	  numeric(19)	,
        @interesTabla     numeric(19,4)	,
	@FechaEmision	  Datetime	,
	@Base		  numeric(5)	,
	@FechaInicio	  Datetime	


DECLARE @valdolarant      numeric(19,4)
DECLARE @PrimerDiaMes	CHAR(12),
	@UltimoDiaMes	CHAR(12)


--declare @dFechaProceso           DATETIME 
	
--set @dFechaProceso ='20220329'
			
if @dFechaProceso is null  
begin   
 SELECT @dFechaProceso = acfecproc ,
		@cliente   = acrutprop ,		
        @acfecprox   = acfecprox
 from BacBonosExtSuda..TEXT_ARC_CTL_DRI
 WHERE acfecproc=@dFechaProceso
end  
else
begin
 SELECT 
        @cliente   = acrutprop ,
        @acfecprox   = acfecprox
 FROM 
		BacBonosExtSuda..TEXT_ARC_CTL_DRI
end

SELECT	@feccontable = @dFechaProceso



 IF  month (@dFechaProceso )<> month( @acfecprox ) BEGIN
	SELECT @PrimerDiaMes   = SUBSTRING( ( convert(char(8), @acfecprox , 112))  ,1,6)  + '01'
	SELECT @UltimoDiaMes   = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@PrimerDiaMes)),112)
        SELECT @dFechaProceso = CONVERT(DATETIME,  @UltimoDiaMes ,112)
        
 END 

 SELECT @estado = emrut FROM BacBonosExtSuda..VIEW_EMISOR WHERE emgeneric='EST'

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

 declare @CARTERA table
    (
    mascara              CHAR (25)    ,                                 
    numdocu              NUMERIC (10,0)    ,         --4
    numoper              NUMERIC (10,0)    ,         --4
    corre                NUMERIC (03,0)    ,         --4
    instrumento          CHAR (25)    ,
    codigo               NUMERIC (5)    ,
    nominal              NUMERIC (19,4)    ,
    tir                  NUMERIC (19,4)    ,
    taspact              NUMERIC (19,4) NULL DEFAULT (0) ,
    fecvenpact           DATETIME NULL   ,
    moneda               NUMERIC (5)    ,
    tipoper              CHAR (3)    ,
    valinip              NUMERIC (19,4) NULL DEFAULT (0) ,
    rutcli               NUMERIC (9)    ,
    codcli               NUMERIC (5)    ,
    rutemi               NUMERIC (9)    ,
    periodo              INTEGER     ,
    fecvenp              DATETIME NULL   ,      --20
    valvenp              NUMERIC (19,4) NULL DEFAULT (0) ,
    valcomp              NUMERIC (19,4) NULL DEFAULT (0) ,
    correla              NUMERIC (9) IDENTITY (1,1) ,
    cuenta               CHAR(20) NULL DEFAULT ('')  ,
    fecha_compra         datetime,
    fec_ven              datetime,
    amortizacion         numeric(19,4),
    saldo                numeric(19,4),
    invers               NUMERIC (5) ,
    cttas                char(3),
    dias_dife            numeric(6),    
    tran_perm            CHAR (10) ,
    tirc                 numeric(19,4),
    campo_26             datetime ,                     --- fecha proximo cupon 
    valorpresente        numeric(19,4),
    cuenta2              char(20) ,
    valcomu              numeric(19,4),
    fecha_ami            datetime  ,
    fecucup              datetime  ,                     --- fecha corte cupon     
    interes              numeric(19,4)

  )

---------------------------------------------------------------------------------------------
declare @TABLA_INTERFAZ table
      (    Cod_Pais         VARCHAR(3)
          ,Num_Fuente       VARCHAR(14)
	  ,Fecha_Interfaz   CHAR(8)
          ,Cod_Emp          VARCHAR(3)
          ,Cod_Interno      VARCHAR(16)
          ,Numero_Operacion VARCHAR(20)
          ,F_Pago_Cuota     DATETIME
          ,Mto_Moneda_Local NUMERIC(18,2)
          ,Mto_A_Mda_local  NUMERIC(18,2)
          ,Mto_I_Mda_local  NUMERIC(19,2) 
	  ,Cod_Interno_suc  VARCHAR(3)
      )

---------------------------------------------------------------------------------------------
  
  
Declare @FL51 Table(
		ctry			CHAR(3)
,		intf_dt			CHAR(8)
,		src_id			CHAR(14)
,		cem				VARCHAR(3)
,		prod			CHAR(16)
,		con_no			CHAR(20)
,		coup_dt			CHAR(8)
,		lcy_coup_amt	NUMERIC(19,2)
,		lcy_amrt_amt	NUMERIC(19,2)
,		Lcy_int_amt		NUMERIC(19,2)
,		br				CHAR(4)
,		cc				CHAR(10)
)

Declare @FL51_SALIDA Table ( REG_SALIDA  Varchar(160))  


 INSERT @CARTERA 
 SELECT cod_nemo 	,
        rsnumdocu 	,
        rsnumdocu 	,
        rscorrelativo 	,
        id_instrum      ,
        cod_familia	, --cpcodigo ,
        rsnominal 	,
        rstir 	        ,
        0  		,
        rsfecvcto	,
	rsmonemi	,
        'CP'  		,
        0  		,
        rsrutcli 	,
        rscodcli 	,
	rsrutemis	,
        ISNULL((SELECT per_cupones FROM BacBonosExtSuda..text_ser WHERE cod_nemo = TEXT_rsu.cod_nemo),0),
        rsfecvcto 	,    	--25
    CapitalPeso 	,
        (case when cod_familia = 2000 then PrincipalDiaPeso else CapitalPeso end) ,--valorpresentepeso 	, --monto en peso del valor presente	
        CtaContable	,    	-- cartera cuenta
        rsfeccomp	,    	--13
        ''		,
        0		,
        0		,
        0		,
        ''		,
        datediff(day,@dFechaProceso,rsfecvcto),
        codigo_carterasuper,
        0		,
   rsfecpcup  	,    -- 26
        rsinteres       ,
        ctacontable     ,
        rsvalcomu       , 
        rsfecemis 	,
        rsfecucup        ,
        abs(InteresPesoAcum) --rsinteres 	

 FROM BacBonosExtSuda..TEXT_rsu,BacBonosExtSuda..CARTERA_CUENTA
 WHERE rsnominal   > 0 AND rsrutcart > 0    
       AND Correla   = rscorrelativo -- 1
       AND NumOper   = rsnumdocu
       and rsfecpro  = @dFechaProceso 
       and rsfecpago < @dFechaProceso 	
       AND variable  = 'valor_compra'
       AND t_operacion = 'CP'
       AND rstipoper = 'DEV' 	


 INSERT @CARTERA 
 SELECT distinct 
        TEXT_MVT_DRI.cod_nemo 	,-- 1
        monumdocu 	,--2
        monumdocu 	,--3
	mocorrelativo	,--4
        TEXT_MVT_DRI.id_instrum 	,--5
        TEXT_MVT_DRI.cod_familia	,--6
        monominal 	,--7
        motir     	,--8
        0  		,--9
        mofecven	,--10
	momonemi	,--11
        'CP'  		,--12
        0  		,--13
        morutcli 	,--14
        mocodcli 	,--15
	morutemi	,--16
        ISNULL((SELECT per_cupones FROM BacBonosExtSuda..text_ser WHERE cod_nemo = TEXT_MVT_DRI.cod_nemo),0), --17
        mofecven 	,--17
        monominal 	,--19
	movalcomp	,--20
	CtaContable     ,--21
	mofecpro	,--22
	''		,--23
	0		,--24
	0		,--25
	0		,--26
	''		,--27
        datediff(day,@dFechaProceso,mofecven),--28
        TEXT_MVT_DRI.codigo_carterasuper,--29
	0		,--30
        mofecpcup  	,--31
        motir    	,--32 	
	CtaContable     ,--33
        movalcomu	,--34    	
        mofecemi	,--35 
	mofecucup	,--36
        mointeres 	 --37

 FROM BacBonosExtSuda..TEXT_MVT_DRI,BacBonosExtSuda..CARTERA_CUENTA, BacBonosExtSuda..text_ctr_inv
 WHERE monominal   > 0 AND morutcart > 0    
       AND NumDocu   = monumdocu
       AND Correla   = mocorrelativo
       AND NumOper   = monumoper 
       AND variable  = 'valor_compra'
       AND motipoper = 'CP'
       AND mofecpago  = @dFechaProceso	  	
       and mofecpro  = @dFechaProceso
       AND mostatreg	<> 'A'   	
       and cpnumdocu =  monumoper
       and cpcorrelativo =  mocorrelativo
       and cpnominal >0


--select *  from #CARTERA    where numoper in (1400,1406,1407)

 INSERT @CARTERA 
 SELECT cod_nemo 	,-- 1
        monumdocu 	,--2
        monumdocu 	,--3
	mocorrelativo	,--4
        id_instrum 	,--5
        cod_familia	,--6
        monominal 	,--7
        motir     	,--8
        0  		,--9
        mofecven	,--10
	momonemi	,--11
        'CP'  		,--12
        0  		,--13
        morutcli 	,--14
        mocodcli 	,--15
	morutemi	,--16
        ISNULL((SELECT per_cupones FROM BacBonosExtSuda..text_ser WHERE cod_nemo = TEXT_MVT_DRI.cod_nemo),0), --17
        mofecven 	,--17
        monominal 	,--19
	movalcomp	,--20
	CtaContable     ,--21
	mofecpro	,--22
	''		,--23
	0		,--24
	0		,--25
	0		,--26
	''		,--27
        datediff(day,@dFechaProceso,mofecven),--28
        codigo_carterasuper,--29
	0		,--30
        mofecpcup  	,--31
        motir    	,--32 	
	CtaContable     ,--33
        movalcomu	,--34    	
        mofecemi	,--35 
	mofecucup	,--36
        mointeres 	 --37

  FROM BacBonosExtSuda..TEXT_MVT_DRI,BacBonosExtSuda..CARTERA_CUENTA
 WHERE monominal   > 0 AND morutcart > 0    
       AND NumDocu   = monumdocu
       AND Correla   = mocorrelativo
       AND NumOper   = monumoper 
       AND variable  = 'valor_venta'
       AND motipoper = 'VP'
       AND mofecpago  = @dFechaProceso	  	
       AND mostatreg	<> 'A'   	





set @contador = 1


-- EN #cartera queda las operaciones LFT y LNT
-- select 'debug', * from #CARTERA where numdocu >= 4031


DECLARE CURSOR_CARTERA CURSOR FOR 
  SELECT   mascara    , instrumento    , codigo  , nominal , tir    , taspact , fecvenpact 
         , moneda     , tipoper        , valinip , rutcli , codcli  , rutemi 
        , CONVERT(CHAR(9),correla)  ,'1'      , periodo, fecvenp , valvenp , valcomp 
         , numdocu    , numoper        , corre   , cuenta  , fecha_compra     , dias_dife 
         , tran_perm  , campo_26       , cuenta2 , valcomu , fecha_ami        , fecucup  , interes
         , valorpresente
  FROM @CARTERA


OPEN CURSOR_CARTERA
FETCH NEXT FROM CURSOR_CARTERA
INTO  @mascara   , @instrumento, @codigo    , @nominal , @tir      , @taspact   , @fecvenpact ,
      @moneda    , @tipoper    , @valinip   , @rutcli  , @codcli   , @rutemi    ,
      @numero    , @c          , @periodo   , @fecvenp , @valvenp  , @valcomp   ,
      @nNumdocu  , @nNumoper   , @nCorrela  , @cuenta  , @fec_comp , @dias_dife ,
      @tran_perm , @campo_26   , @cuenta_flu, @valcomu , @fecha_ami, @fecucup   , @interes , @val_presen

WHILE @@FETCH_STATUS  = 0
BEGIN 



         


	IF @moneda = 999  or @moneda = 998 BEGIN
	   SET @valmoneda_dia   = isnull((select vmvalor  from BacBonosExtSuda..view_valor_moneda    
                                       where vmfecha = @fec_comp and vmcodigo = @moneda),0)
	   set @valmoneda_comp = @valmoneda_dia

	  END
	ELSE IF @moneda = 13  or @moneda = 994 BEGIN
--		if month(@dFechaProceso)<> month(@acfecprox) BEGIN
		   SET @valmoneda_dia =isnull((select Tipo_Cambio from BACPARAMSUDA..VALOR_MONEDA_CONTABLE 
        	                        where Codigo_Moneda = 994 and Fecha = @feccontable ),0)

--		END
/*		ELSE BEGIN
		   SET @valmoneda_dia = @valdolarant 
		   set @valmoneda_comp = @valmoneda_dia
		END
*/
  	END

	ELSE BEGIN
	   SET @valmoneda_dia =isnull((select Tipo_Cambio from BACPARAMSUDA..VALOR_MONEDA_CONTABLE 
                                       where Codigo_Moneda = @moneda and Fecha = @feccontable ),0)
	   set @valmoneda_comp = @valmoneda_dia
	  END

	SET @rut = (SELECT TOP 1 RIGHT('000000000'+CONVERT(VARCHAR(9),CLRUT),9) + Cldv FROM BacBonosExtSuda..view_cliente where Clrut = @rutemi)

	SET @ref = RIGHT('00000000000000000000'+ CAST(@nNumdocu AS VARCHAR(5)) +  cast(@nNumoper AS VARCHAR(5))+ CAST( @nCorrela AS VARCHAR(2) ) ,20)

	SET @cant = ISNULL(( SELECT COUNT(*) FROM BacBonosExtSuda..text_dsa  WHERE  cod_nemo = @mascara  ),0)

	IF @cant  > 1 begin 
	   SET @corr = 1
	 END ELSE BEGIN 
	   SET @corr = 0
	END 

----------------------------------------        tabla desarrollo   -----------------------------------------   



	select top 1 

	@Peri_cupon	= ISNULL(per_cupones , 0)	,
	@Tasa 	    	= ISNULL(tasa_emis   , 0)	,
	@Spread	      	= ISNULL(valor_spread, 0)	,
	@Base	      	= ISNULL(base_flujo, 0)		,
	@TipoTasa	= tasa_fija			,
	@Tipodias	= dias_reales			,
	@FechaEmision	= fecha_emis
	FROM BacBonosExtSuda..TEXT_SER
	where  cod_nemo = @mascara  

	Select @FechaInicio = @FechaEmision	  

   	IF @Peri_cupon > 12  begin 
		SET @sepa = 'A'   
	      	SET @contador = round(DATEDIFF(MONTH, @campo_26 , @fecucup ),0) --@Peri_cupon  / 12
    	end else IF @Peri_cupon >= 1 and @Peri_cupon <= 12  BEGIN 
	      	SET @sepa = 'M'
	      	SET @contador = @Peri_cupon  
	END ELSE BEGIN 
      		SET @sepa = 'D'
		SET @contador = @Peri_cupon
	END 





-- select *  	FROM   TEXT_DSA   where   Cod_familia =2001
	DECLARE CURSOR_INTERFAZ CURSOR FOR 
	SELECT cod_nemo , num_cupon , fecha_vcto_cupon , interes , amortizacion , flujo , saldo 
	FROM   BacBonosExtSuda..TEXT_DSA  
	WHERE cod_nemo=@mascara 
	AND   fecha_vcto_cupon  > @dFechaProceso 


	OPEN CURSOR_INTERFAZ
	FETCH NEXT FROM CURSOR_INTERFAZ
	INTO  @mascara , @tdcupon , @tdfecven , @tdinteres , @tdamort , @tdflujo , @tdsaldo 




	WHILE @@FETCH_STATUS  = 0
	BEGIN 


		/*
		IF @codigo = 2000    BEGIN
	      		SET @tdfecven = DATEADD( MONTH , @tdcupon * @Peri_cupon, @fecha_ami )
	   	END 
		*/


		IF @TipoTasa = 'F' BEGIN
			If @Tipodias = 'T' BEGIN
                    		Select @Difdias  	= DateDiff(d, @FechaInicio, @tdfecven )
		                Select @interesTabla 	= Round((((( @Tasa + @Spread )  /@Base) * @Difdias)), 6)
			END
    	Else BEGIN
	                	Select @Difdias  	= (DateDiff(m, @FechaInicio, @tdfecven) * 30)
        	            	Select @interesTabla 	= Round((((( @Tasa + @Spread ) / @Base) * @Difdias)), 6)
            	End 
		
			Select @FechaInicio = @tdfecven
			Select @tdinteres   = @interesTabla


		END		  
		

	   	SET @nToc 	=  @cant -- numero total de cupones 
--	   	SET @svca       = ISNULL( ROUND( ((@TDAMORT   / 100)  * @NOMINAL * @valmoneda_comp ) , 0 ) , 0 )
	   	SET @svca       = ISNULL( ROUND( ((@TDAMORT   / 100)  * @NOMINAL * CONVERT(NUMERIC(19,4),@valmoneda_dia) ) , 0 ) , 0 )
	   	SET @tdamort2   = ISNULL( ROUND( ((@TDAMORT   / 100)  * @NOMINAL * CONVERT(NUMERIC(19,4),@valmoneda_dia) ) , 0 ) , 0 )
	   	SET @tdinteres2 = ROUND ((( @tdinteres / 100 ) * @NOMINAL * CONVERT(NUMERIC(19,4),@valmoneda_dia)  ) ,0 )
	   	SET @VCUO       = ISNULL( ROUND( @tdamort2 + @tdinteres2 ,0) , 0 )
-------------------------------------------------------------------------------------------------
      INSERT @TABLA_INTERFAZ 
--           1      2                         3            4      5      							6	             								7        8      9          10      11 
  VALUES ('CL' , CONVERT(CHAR(8),GETDATE(),112), 'FL51' ,'001', 'MD01' , CAST(@nNumdocu AS VARCHAR(5)) + cast(@ncorrela AS VARCHAR(3))+ CAST(@nNumoper AS VARCHAR(5) ) , @tdfecven,  @vcuo, @svca , @tdinteres2, '1' )
------------------------------------------------------------------------------------------------   

		FETCH NEXT FROM CURSOR_INTERFAZ
		INTO  @mascara,@tdcupon,@tdfecven,@tdinteres,@tdamort,@tdflujo,@tdsaldo   
	END  -- fin cursor 
   	CLOSE       CURSOR_INTERFAZ
	DEALLOCATE  CURSOR_INTERFAZ


         -------------------------------------------------------------------------------------------------
         IF @codigo <> 2000 --  @codigo = 2001 -- mAP 2016-06-17 Hay que crear concepto seriado - no seriado
         BEGIN
		    if @codigo in ( 2001 )  
			Begin
				INSERT @TABLA_INTERFAZ 
				SELECT 'CL' , CONVERT(CHAR(8),GETDATE(),112), 'FL51' ,'001', 'MD01' , CAST(rsnumdocu AS VARCHAR(5)) + cast(rscorrelativo AS VARCHAR(1))+ CAST(rsnumoper AS VARCHAR(5) ) , 
				rsfecvcto,  ISNULL( ROUND (rsnominal * @valmoneda_dia,0),0) , ISNULL( ROUND (rsvalcomu *@valmoneda_dia,0),0) , 
				ISNULL( ROUND ((rsnominal -rsvalcomu)*@valmoneda_dia,0),0), '1' 
				FROM  BacBonosExtSuda..TEXT_RSU 
				WHERE rsfecpro = @dFechaProceso
				AND cod_familia =@codigo and rstipoper='DEV' AND rsnumdocu = @nNumdocu AND rscorrelativo = @nCorrela
		    End
			else  -- MAP 2016-06-17 Solo para LFT y LNT Significado del Nominal, se utilizan campos más adecuados, deberian servir para los 2001
			      -- y cualquier no seriado
			Begin 
				INSERT @TABLA_INTERFAZ 
				SELECT 'CL' , CONVERT(CHAR(8),GETDATE(),112), 'FL51' ,'001', 'MD01' , CAST(rsnumdocu AS VARCHAR(5)) + cast(rscorrelativo AS VARCHAR(1))+ CAST(rsnumoper AS VARCHAR(5) ) , 
				rsfecvcto,  ISNULL( ROUND (rsvalvenc  * @valmoneda_dia ,0),0) , ISNULL( ROUND (( rsvalvenc - rsinteres )  * @valmoneda_dia  ,0),0) , 
				ISNULL( ROUND ( rsinteres * @valmoneda_dia ,0),0), '1' 
				FROM  BacBonosExtSuda..TEXT_RSU 
				WHERE rsfecpro = @dFechaProceso
				AND cod_familia =@codigo and rstipoper='DEV' AND rsnumdocu = @nNumdocu AND rscorrelativo = @nCorrela			   
			end
         END
         ------------------------------------------------------------------------------------------------   
    
------------------------------------------------------------------------------------------------------
	FETCH NEXT FROM CURSOR_CARTERA
	INTO  @mascara   , @instrumento , @codigo   , @nominal , @tir      , @taspact   , @fecvenpact ,
      	@moneda    , @tipoper  	, @valinip  , @rutcli  , @codcli   , @rutemi    ,
      	@numero    , @c           , @periodo  , @fecvenp , @valvenp  , @valcomp   ,
      	@nNumdocu  , @nNumoper    , @nCorrela , @cuenta  , @fec_comp , @dias_dife ,
      	@tran_perm , @campo_26    , @cuenta_flu ,@valcomu ,@fecha_ami, @fecucup   , @interes  , 
      	@val_presen

END
CLOSE CURSOR_CARTERA
DEALLOCATE  CURSOR_CARTERA

 insert into @FL51
  SELECT  Cod_Pais														--		01
	  ,  LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))					--		02
      , 'FL51' + SPACE(10)												--		03
      ,  Cod_Emp														--		04
      ,  'MD01'	 + SPACE(12) 	    									--		05
      ,  Numero_Operacion												--		06
      ,  LTRIM(CONVERT(CHAR(10),F_Pago_Cuota,112))						--		07
      ,  Mto_Moneda_Local = SUM( Mto_Moneda_Local )						--		08
      ,  Mto_A_Mda_local  = SUM( Mto_A_Mda_local  )						--		09
      ,  Mto_I_Mda_local  = SUM( Mto_I_Mda_local  )						--		10
	  ,	 '0011'															--		11
	  ,	 REPLICATE('0',10)												--		12
   FROM  @TABLA_INTERFAZ    
GROUP BY Cod_Pais    
      ,  Num_Fuente    
      ,  Cod_Emp    
      ,  Cod_Interno    
      ,  Numero_Operacion    
      ,  F_Pago_Cuota    


 
 declare @TipoSalida bit=0
 
if @TipoSalida != 0
	SELECT 
				  ctry																				--		1																							
				, intf_dt																			--		2																				
				, src_id																			--		3																				
				, cem																				--		4	
				, prod																				--		5
				,  left(con_no+space(20), 20)	as con_no											--		6	
				, coup_dt																			--      7
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_coup_amt*100))),19)	as lcy_coup_amt	--8
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_amrt_amt*100))),19) as lcy_amrt_amt	--9
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(Lcy_int_amt*100))),19)	as Lcy_int_amt	--10
				, br																																				--		11																			
				, cc 	
	
	FROM @FL51 ORDER BY cem , prod, con_no ,coup_dt
else
	begin
		INSERT INTO @FL51_SALIDA
		select 
				  ctry																				--		1																							
				+ intf_dt																			--		2																				
				+ src_id																			--		3																				
				+ cem																				--		4	
				+ prod																				--		5
				+ left(con_no+space(20), 20)														--		6	
				+ coup_dt																			--      7
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_coup_amt*100))),19)		--8
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_amrt_amt*100))),19)		--9
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(Lcy_int_amt*100))),19)		--10
				+ br																																				--		11																			
				+ cc 																																				--		12																							
		from @FL51
		ORDER BY cem , prod, con_no ,coup_dt


		SELECT *  FROM @FL51_SALIDA
	end 


END

GO
