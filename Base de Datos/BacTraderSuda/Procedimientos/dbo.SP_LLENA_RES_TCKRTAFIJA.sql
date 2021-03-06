USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_RES_TCKRTAFIJA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LLENA_RES_TCKRTAFIJA]
   (
   @dfechoy DATETIME ,
   @dfecprox DATETIME ,
   @devengo_dolar CHAR (01)
   )
AS
BEGIN 
 	SET NOCOUNT ON 
 	DECLARE @modcal  INTEGER  ,
  	@ncodigo INTEGER  ,
  	@cmascara CHAR (10) ,
  	@moneda INTEGER  ,
  	@cfecemi CHAR (10) ,
  	@cfecven CHAR (10) ,
  	@ftasemi FLOAT  ,
  	@fbasemi FLOAT  ,
  	@ftasest FLOAT  ,
  	@fnominal FLOAT  ,
  	@ftir  FLOAT  ,
  	@fmt  FLOAT  ,
  	@fmtum  FLOAT  ,
 	@fmt_cien FLOAT  ,
  	@fvan  FLOAT  ,
  	@fvpar  FLOAT  ,
  	@nnumucup INTEGER  ,
  	@dfecucup DATETIME ,
  	@fintucup FLOAT  ,
  	@famoucup FLOAT  ,
  	@fsalucup FLOAT  ,
  	@nnumpcup INTEGER  ,
  	@dfecpcup DATETIME ,
  	@fintpcup FLOAT  ,
  	@famopcup FLOAT  ,
  	@fsalpcup FLOAT  ,
  	@nerror  INTEGER  ,
  	@fdurat  FLOAT  ,
  	@fconvx  FLOAT  ,
  	@fdurmo  FLOAT  ,
  	@nintmes  FLOAT  ,
  	@nreames FLOAT  


 	DECLARE @dfecemi DATETIME ,
  	@dfecven DATETIME ,
  	@dfecinip DATETIME ,
  	@dfecvtop DATETIME ,
  	@mascara CHAR (10),
  	@cinstorg CHAR (10) ,
  	@cseriado CHAR (01) ,
  	@ctipopero CHAR(03) ,
  	@nnumdocu NUMERIC (10,0) ,
  	@ncorrela NUMERIC (03,0) ,
  	@nnumoper NUMERIC (10,0) ,
  	@fvpresen NUMERIC (19,4) ,
  	@nvalmon_h FLOAT  ,
  	@nvalmon_m FLOAT  ,
  	@nvalmon_o FLOAT  ,
  	@fvalcomu FLOAT  ,
  	@fvalcupo FLOAT  ,
  	@fintcupo FLOAT  ,
  	@famocupo FLOAT  ,
  	@dfeccomp DATETIME ,
  	@dfpxreal DATETIME ,
  	@dfecoriginal DATETIME ,
  	@nvalmon_c FLOAT  ,
  	@nvalmon_i FLOAT  ,
  	@nmoncupon FLOAT  ,
  	@fcapital FLOAT  ,
  	@nnumcupant INTEGER  ,
  	@fcapital_um FLOAT  ,
  	@ctipoper CHAR (02) ,
  	@nvpresenci NUMERIC (19,0) ,
  	@ninteres NUMERIC (19,4) ,
  	@nreajuste NUMERIC (19,4),
  	@nintdia NUMERIC (19,4) ,
  	@nreadia NUMERIC (19,4) ,
  	@nvalinip NUMERIC (19,4) ,
  	@nvpresen NUMERIC (19,4) ,
  	@nbasemi INTEGER  ,
  	@ntasemi NUMERIC (08,4) ,
  	@nreacup NUMERIC (19,4) ,
  	@nintcup NUMERIC (19,4) ,
  	@ndifcup NUMERIC (19,4) ,
  	@npagcup NUMERIC (19,4) ,
  	@npagcupo NUMERIC (19,4) ,
  	@pago_nohabil INTEGER  ,
  	@nmes  INTEGER  ,
  	@ndia  INTEGER  ,
  	@nano  INTEGER  ,
  	@nmes_a  INTEGER  ,
  	@nast  INTEGER  ,
  	@cmes  CHAR (02) ,
  	@cdia  CHAR (02) ,
  	@cano  CHAR (04) ,
  @nuf  INTEGER  ,
  @nivp  INTEGER  ,
  @ndo  INTEGER  ,
  @nvpresen1 NUMERIC(19,4),
  @cmx  CHAR (01) ,
  @id_libro	CHAR(06),
  @Tipo_Operacion varchar(3)

 DECLARE @cestado  CHAR(02)  ,  
  @redondeo  NUMERIC(1) ,
  @ndecimal  NUMERIC(2),
  @redondeo1 NUMERIC(1) 
 
 DECLARE 
  @x1  INTEGER  ,
  @contador INTEGER  ,
  @nvalcomp NUMERIC (19,4) ,
  @nnominal NUMERIC (19,4) ,
  @carterao CHAR (03),
  @mesao CHAR(3),
  @nForpagv NUMERIC (04,0) ,
  @nforpagi NUMERIC (04,0) ,
  @fecdevengo     DATETIME


 SELECT @fecdevengo = @dfechoy

 SELECT @moneda = 0  ,
  @dfecemi = ''  ,
  @dfecven = ''  ,
  @ftasemi = 0.0  ,
  @fbasemi = 0  ,
  @ftasest = 0.0  ,
  @fnominal = 0.0  ,
  @ftir  = 0.0  ,
  @fmt  = 0.0000  ,
  @fmtum  = 0.0  ,
  @fmt_cien = 0.0  ,
  @fvan  = 0.0  ,
  @fvpar  = 0.0  ,
  @nnumucup = 0.0  ,
  @dfecucup = ''  ,
  @fintucup = 0.0  ,
  @famoucup = 0.0  ,
  @fsalucup = 0.0  ,
  @nnumpcup = 0.0  ,
  @dfecpcup = ''  ,
  @fintpcup = 0.0  ,
  @famopcup = 0.0  ,
  @fsalpcup = 0.0  ,
  @nerror  = 0  ,
  @nvalcomp = 0.0,
  @redondeo = 0,
  @redondeo1 = 0

 -- Aqui comienza el proceso --
 -- ________________________ --
 SELECT @x1  = 1  ,
  @contador = 0   ,
  @mascara = ''   ,
  @ninteres = 0.0   ,
  @nreajuste = 0.0   ,
  @moneda = 0.0   ,
  @nbasemi = 0.0   ,
  @ftasemi = 0.0   ,
  @nnumdocu = 0.0   ,
  @ncorrela = 0.0   ,
  @dfecven = ''   ,
  @nvalcomp = 0.0   ,
  @fvalcomu = 0.0   ,
  @nnominal = 0.0   ,
  @fvpresen = 0.0   ,
  @redondeo = 0,
  @redondeo1 = 0
 SELECT  @contador =  COUNT(*) FROM tbl_carticketrtafija WHERE Tipo_Operacion='CI' OR Tipo_Operacion='VI'


 WHILE @x1<=@contador
 BEGIN	-- inicio While
	
	SELECT @mascara='*'
	SET ROWCOUNT @x1
	SELECT 
	@mascara = tcar.Mascara  ,
	@moneda = tcar.Moneda  ,
	@nbasemi = vm.mnbase,
	@ftasemi = tcar.Tir  ,
	@nnumdocu = tcar.Numero_Documento,
	@carterao = tcar.CodCarteraOrigen,
	@mesao = tcar.CodMesaOrigen,
	@nnumoper = tcar.Numero_Operacion,
	@ncorrela = tcar.Correlativo,
        @dfecinip= tcar.Fecha_Operacion,
	@dfecven = tcar.Fecha_Vencimiento,

	@nvalinip = ISNULL(tcar.Valor_InicialPacto,0) ,
	@nvalcomp = tcar.Valor_InicialPacto,
	@fvalcomu = tcar.Valor_Compra_UM,
 	@nvpresen = ISNULL(tcar.Valor_Presente,0) ,

	@fnominal = tcar.Valor_Nominal,
	@dfeccomp = tcar.Fecha_Vencimiento,
	@nvpresen1      = tcar.Valor_Presente, 	
	@ndecimal  = mndecimal,
	@redondeo1 = mndecimal,
	@Tipo_Operacion = tcar.Tipo_Operacion

	FROM	tbl_carticketrtafija tcar,
		view_moneda vm
	WHERE	(tcar.Tipo_Operacion='CI' OR tcar.Tipo_Operacion='VI')
		AND tcar.Moneda=vm.mncodmon

	SET ROWCOUNT 0

	SELECT @x1 = @x1 + 1
                /* dolares existentes ============= */
                /* 994 : dolar observado            */
        	/* 995 : dolar acuerdo        	    */
                /* 996 : dolar interbancario        */
                /* ================================ */

	  	SELECT @ninteres  = 0
  		SELECT @nreajuste = 0
	  	SELECT @nintmes   = 0
	  	SELECT @nreames   = 0

        	IF @devengo_dolar='S'
        	BEGIN
   		IF @moneda<>994 AND @moneda<>995 AND @moneda<>988
    			CONTINUE
  	END
        	ELSE
        	BEGIN
   		IF @moneda=994 OR @moneda=995 OR @moneda=988
	    		CONTINUE
  		END

	IF @moneda=994 or @moneda= 999 or @moneda=998 
     		SELECT @redondeo = 0
	ELSE 
		SELECT @redondeo = @ndecimal

  	IF @mascara='*'
   		BREAK

   	SELECT @nvalmon_h = 1.0 ,
   	@nvalmon_m = 1.0 ,
   	@nvalmon_c = 1.0 ,
   	@nreadia = 0.0 ,
   	@nintdia = 0.0,
        @nintmes = 0.0 ,
        @nreames = 0.0

  	SELECT @cmx = (CASE WHEN MNMX = 'C' THEN 'S' ELSE 'N' END) FROM VIEW_MONEDA WHERE MNCODMON = @moneda

  	IF @moneda<>999 AND @cmx<>'S'
  	BEGIN
   		SELECT @nvalmon_h=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@moneda AND vmfecha=@dfechoy
   		SELECT @nvalmon_m=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@moneda AND vmfecha=@dfecprox
   		SELECT @nvalmon_c=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@moneda AND vmfecha=@dfecinip
  	END

  	IF DATEDIFF(MONTH,@dfechoy,@dfecprox)>0
   	SELECT	@nintmes = 0.0 ,
		@nreames = 0.0

  	IF @dfechoy=@dfecinip
   		SELECT @fvpresen = @nvalcomp

--  	SELECT  @nValinip  = Round(@nvalinip/@nvalmon_c , 4)

 	SELECT @fMt       = ROUND(@nvalinip*(((@ftasemi/(@nbasemi*100.0))*DATEDIFF(DAY,@dfecinip,@dfecprox))+1.0),@redondeo1)
  	SELECT @fMt	= ROUND(@fMt*@nvalmon_m, @redondeo)
  	SELECT @nreadia	= ROUND((@nvalmon_m-@nvalmon_h)*@nvalinip,@redondeo)
  	SELECT @nintdia	= ROUND(@fMt - @nvpresen1 - @nreadia,@redondeo)

  	SELECT @ninteres  = @ninteres  + @nintdia
  	SELECT @nreajuste = @nreajuste + @nreadia
  	SELECT @nintmes   = @nintmes  + @nintdia
  	SELECT @nreames   = @nreames  + @nreadia

  	INSERT INTO tbl_resticketrtafija
    	(
    	Fecha_Operacion,  -- 1
    	Numero_Documento, -- 2
    	Correlativo,      -- 3
    	CodCartera,       -- 4
	CodMesa,	  -- 5
    	tipo_resultado,   -- 6 
    	Mascara,          -- 7
    	Valor_Presente_Hoy, -- 8
    	Valor_Presente_prox, -- 9
    	Valor_Nominal, --10
    	Tir, --11
    	moneda, --12
    	valor_tasa_emision , --13
    	Intereses, --14
    	Reajustes, --15
    	Interes_mes, --16
    	Reajuste_mes, --17
	Interes_Acumulado,
	Reajuste_Acumulado,
    	valor_compra, --18
    	valor_compra_um, --19
    	tipo_operacion --20 
    	)
  	VALUES
    	(
    	@dfecprox,  -- 1
    	@nnumdocu,  -- 2
    	@ncorrela,  -- 3
    	@carterao,  -- 4
	@mesao,	    -- 5	
    	'DEV',     -- 6
    	@mascara,   -- 7
    	@nvpresen,  -- 8
    	ISNULL(@fmt,0),      -- 9
      	@fnominal,  --10
    	@ftasemi,   --11 
    	@moneda,     --12
    	@ftasemi,   --13
    	ISNULL(@nintdia,0),   --14
    	ISNULL(@nreadia, 0),   --15    
    	ISNULL(@nintmes,0), 
    	ISNULL(@nreames, 0),
	ISNULL(@ninteres,0),
	ISNULL(@nreajuste, 0),
	@nvalcomp,  -- 18
	@fvalcomu,  -- 19
    	@Tipo_Operacion -- 20
    	)

  	IF @@error<>0
  	BEGIN
   		SELECT 'NO','Devengamiento ha fallado en grabacion de procedimiento'
   		RETURN
  	END


   	IF @devengo_dolar='N'
	BEGIN
		IF DATEDIFF(MONTH,@fecdevengo,@dfecprox)=0 and DATEDIFF(MONTH,@fecdevengo,@dfpxreal)>0
	  	BEGIN
			UPDATE tbl_carticketrtafija 	
			SET 
			Valor_Presente  = @nvalcomp+@ninteres+@nreajuste  ,
			Tir  = @nvalcomp+@ninteres+@nreajuste
			WHERE Numero_Documento=@nnumdocu AND Correlativo=@ncorrela
	  	END
	END

   	IF @@error<>0
   	BEGIN
--    		SELECT 'NO','Devengamiento ha fallado en grabación de procedimiento'
    		RETURN
   	END
 END	-- fin While
 IF @contador = 0
	BEGIN
		SELECT 'OK','Proceso de Devengamiento ha finalizado sin movimientos'
--		RETURN
	END
 ELSE
	BEGIN
--	 	SELECT 'OK','Proceso de Devengamiento ha finalizado en forma correcta'
		RETURN
	END
	
END

GO
