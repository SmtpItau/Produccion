USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[BO15]    Script Date: 16-05-2022 10:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BO15] (   @dFechaProceso DATETIME   )
AS
BEGIN	
        SET NOCOUNT ON    
    
 DECLARE @tip_oper      CHAR(4)    
 , @mascara       CHAR (12)             
 , @numdocu       NUMERIC (10,0)        
 , @numoper       NUMERIC (10,0)        
 , @corre         NUMERIC (03,0)        
 , @codigo        NUMERIC (5)           
 , @tir           NUMERIC (19,4)        
 , @moneda        NUMERIC (5)           
 , @seriado       CHAR (1)              
 , @tipoper       CHAR (4)              
 , @tabla         CHAR (4)                      
 , @cuenta        CHAR(20)     
 , @fecha_compra  DATETIME                      
 , @dias_dife     NUMERIC(6)                    
 , @campo_26      DATETIME                      
 , @interes       NUMERIC(19,4)    
 , @vDolar_obs    NUMERIC(19,4)         
 , @dias          NUMERIC(1)    
 , @nIntasb       NUMERIC(5)    
 , @tip_tasa      CHAR(3)    
 , @inst_variable CHAR(1)    
 , @Ccuenta       CHAR(5)    
 , @dfecfmes      DATETIME    
 , @dFecFMesProx  DATETIME    
 , @acfecprox     DATETIME    
 
 , @NumCuenta     CHAR(1)    
 , @monto_origen  NUMERIC(19,4)    
 , @indicador     CHAR(1)    
 , @NumValor      CHAR(1)    
 , @NumReajuste   CHAR(1)    
 , @NumInteres    CHAR(1)    
 , @Max           INTEGER    
 , @Monto         NUMERIC(18,2)    
 , @cMoneda       NUMERIC(5)    
 , @monto_oper    NUMERIC(18,2)    
 , @Cod_Evento    CHAR(3)    
 , @TipoLinea     CHAR(03)    
 , @tipo        CHAR(03)    

Declare @Cartera Table
 ( tip_oper     CHAR(4)                                   --  0    
 , mascara      CHAR (12)                                 --  1        
 , numdocu      NUMERIC (10,0)                   
             --  2  
, numoper      NUMERIC (10,0)                            --  3  
 , corre        NUMERIC (03,0)                            --  4    
 , codigo       NUMERIC (5)                               --  5    
 , tir          NUMERIC (19,4)                  
              --  6  
 , moneda       NUMERIC (5)                               --  7  
 , seriado      CHAR (1)                                  --  8    
 , tipoper      CHAR (4)                                  --  9    
 , tabla        CHAR (4)                       
               --  10  
 , cuenta       CHAR(20) NULL DEFAULT ('')                --  11  
 , fecha_compra DATETIME                                  --  12    
 , dias_dife    NUMERIC(6)                                --  13    
 , campo_26     DATETIME                  
                    --  14    
 , interes      NUMERIC(19,4)  
 , monto_origen NUMERIC(18,2)    
 , Cod_Evento   CHAR(3)    
 , TipoLinea    CHAR(03)    
 , monto_oper   NUMERIC(18,2)    
 , tipo      CHAR(03)    
 )    
   
Declare @CARTERA_VI Table
 ( tip_oper     CHAR(4)                 
                      --  0  
 , mascara      CHAR (12)                                 --  1      
 , numdocu      NUMERIC (10,0)                            --  2    
 , numoper      NUMERIC (10,0)                            --  3    
 , corre        NUMERIC (03,0)                             --  4  
 , codigo       NUMERIC (5)                               --  5  
 , tir          NUMERIC (19,4)                            --  6    
 , moneda       NUMERIC (5)                               --  7    
 , seriado      CHAR (1)          
                            --  8  
 , tipoper      CHAR (4)                                  --  9  
 , tabla        CHAR (4)                                  --  10    
 , cuenta       CHAR(20) NULL DEFAULT ('')                --  11    
 , fecha_compra DATETIME       
                               --  12  
 , dias_dife    NUMERIC(6)                                --  13  
 , campo_26     DATETIME     -- 14      
 , interes      NUMERIC(19,4)    
 , monto_origen NUMERIC(18,2)    
 , Cod_Evento   CHAR(3)    
 , TipoLinea    CHAR(03)    
 , monto_oper   NUMERIC(18,2)    
 , tipo      CHAR(03)    
 )    

Declare @CARTERA_CI    Table
 ( tip_oper     CHAR(4)                                   --  0    
 , mascara      CHAR (12)                                 --  1        
 , numdocu      NUMERIC (10,0)                      
          --  2  
 , numoper      NUMERIC (10,0)  --  3  
 , corre      NUMERIC (03,0)                            --  4    
 , codigo       NUMERIC (5)                               --  5    
 , tir          NUMERIC (19,4)                            --  6    
 , moneda       NUMERIC (5)               
                    --  7  
 , seriado      CHAR (1)                                  --  8  
 , tipoper      CHAR (4)                                  --  9    
 , tabla        CHAR (4)                                  --  10    
 , cuenta       CHAR(20) NULL DEFAULT ('')                --  11    
 , fecha_compra DATETIME                                  --  12    
 , dias_dife    NUMERIC(6)                                --  13    
 , campo_26     DATETIME                                  --  14      
 , interes      NUMERIC(19,4)    
 , monto_origen NUMERIC(18,2)    
 , Cod_Evento   CHAR(3)    
 , TipoLinea    CHAR(1)    
 , monto_oper   NUMERIC(18,2)    
 , tipo      CHAR(03)    
 )    
    
Declare @TABLA_INTERFAZ2    Table
 ( COD_PAIS      CHAR(3)    
 , NRO_IDEN      CHAR(4)    
 , FAM_PROD      CHAR(4)    
 , TIP_PROD      CHAR(4)    
 , COD_PRO       CHAR(4)    
 , NRO_OPER      CHAR(20)    
 , FEC_CTBL      CHAR(8)    
 , COD_CTAC      CHAR(20)    
 , IND_DECR      CHAR(1)    
 , COD_CTBL      CHAR(3)    
 , SIG_MDO       CHAR(1)    
 , MDA_ORI       NUMERIC(19,4)    
 , SIG_MDL       CHAR(1)    
 , MDA_LOC       NUMERIC(19,4)    
 , SIG_LAG       CHAR(1)    
 , MDA_AGR       NUMERIC(19,4)    
 , MDA_CTBLE     NUMERIC(5)    
 )          

Declare @VM Table(Vmfecha Date, VmCodigo	Int, VmValor Float)


Declare @BO15 table(
			 ctry				VARCHAR(3)			--		1
			,intf_dt			CHAR(8)				--		2
			,src_id				VARCHAR(14)			--		3
			,cem				VARCHAR(3)			--		4
			,prod				VARCHAR(16)			--		5
			,con_no				VARCHAR(20)			--		6
			,book_dt			CHAR(8)				--		7
			,ain				VARCHAR(20)			--		8
			,dr_cr_ind			VARCHAR(1)			--		9
			,actg_evnt_cod		VARCHAR(3)			--		10
			,ocy_bal_sign		VARCHAR(1)			--		11
			,ocy_bal			Numeric(19,4)		--		12
			,lcy_bal_sign		VARCHAR(1)			--		13
			,lcy_bal			Numeric(19,2)		--		14
			,lcy_agg_bal_sign	VARCHAR(1)			--		15
			,lcy_agg_bal		Numeric(19,2)		--		16
			,br					CHAR(04)			--		17
			,cc					VARCHAR(10)			--		18
)
 Declare @BO15_SALIDA Table ( REG_SALIDA  Varchar(185))  
   
 DECLARE @PrimerDiaMes CHAR(12)    
 , @UltimoDiaMes CHAR(12)    
 , @FECHAFINMES    DATETIME         
 , @FINMES         CHAR(1)    
 , @valordolar     numeric(12,2)    
 , @valordolarant  numeric(12,2)    
 , @FECHAdolar     DATETIME        
 , @FECHA_MX       DATETIME        
 , @valor_142      numeric(12,2)    
 , @valor_72       numeric(12,4)    
 , @valor_102      numeric(12,2)    
 , @valor_13       numeric(12,2)     
 
 --DECLARE @dFechaProceso        DATETIME    
 --set @dFechaProceso        ='20211129'
 SELECT @dFechaProceso		= acfecproc     --'20220329'
 , @acfecprox				= acfecprox --'20220330'--acfecprox     
 , @FECHAFINMES				= acfecproc     --'20220331'--acfecproc     
 from bactradersuda..MDAC   
 where acfecproc=@dFechaProceso

if @dFechaProceso is null  
begin   
 select @dFechaProceso = acfecproc	,
		@acfecprox = acfecprox ,
		@FECHAFINMES = acfecproc
   from bactradersuda..MDAC
end  
else
begin
SELECT @dFechaProceso     =@dFechaProceso    
 , @acfecprox  = acfecprox     
 , @FECHAFINMES= @dFechaProceso    
 from bactradersuda..MDAC   
 where @dFechaProceso     = acfecproc     
    
end  

SELECT @FINMES  = 'N'    
    
SELECT @valordolar = vmvalor     
 FROM BactraderSuda..VIEW_VALOR_MONEDA     
 WHERE vmfecha = @dFechaProceso     
 AND     vmcodigo = 994    
    
 /****************    
***********************************************************************************************/  
 /***************************************************************************************************************/  
 DECLARE @FechaBusquedaValorizacion DATETIME    
    
 IF SUBSTRING(CONVERT(CHAR(8), @dFechaProceso ,112),1,6) <> SUBSTRING(CONVERT(CHAR(8), @acfecprox ,112),1,6) BEGIN -- EJEMPLO '200512' < '200601'    
            SELECT @FechaBusquedaValorizacion = DATEADD(DAY,-1,SUBSTRING(CONVERT(CHAR(8),@acfecprox,112),1,6) + '01') --FIN DE MES (ACTUAL) HABIL O NO HABIL    
 END    
 ELSE BEGIN    
    SELECT @FechaBusquedaValorizacion = @dFechaProceso --FECHA HOY    
 END    
    
 IF MONTH(@FECHAFINMES ) <> MONTH(@acfecprox )     
        BEGIN    
  SELECT @PrimerDiaMes = SUBSTRING( ( convert(char(8), @acfecprox , 112))  ,1,6)  + '01'    
  SELECT @UltimoDiaMes = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(DAY,-1,@PrimerDiaMes)),112)    
  SELECT @FECHAFINMES = CONVERT(DATETIME,  @UltimoDiaMes ,112)    
    
  SELECT @FECHAdolar      = @FECHAFINMES    
         IF @FECHAFINMES <> @dFechaProceso BEGIN -- FIN DE MES ESPECIAL    
   SELECT @FINMES ='S'    
  END     
 END ELSE     
        BEGIN    
  SELECT @valordolarant  = ISNULL( dolarObsFinMes , 0 ) FROM bacbonosextsuda..text_arc_ctl_dri       
     
  SELECT @PrimerDiaMes   = SUBSTRING( ( convert(char(8), @dFechaProceso , 112))  ,1,6)  + '01'    
  SELECT @UltimoDiaMes   = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(DAY,-1,@PrimerDiaMes)),112)    
  SELECT @FECHA_MX       = CONVERT(DATETIME,  @UltimoDiaMes ,112)    
        END     
            
        --> UTILIZACION DE TIPO DE CAMBIO CONTABLE <--    
  --> MAP 20061221 Crea solamente la estructura <--  


Insert Into @VM 
Select vmfecha, vmcodigo, vmvalor FROM         BacParamSuda..VALOR_MONEDA
Where vmfecha			 = @dFechaProceso AND   vmcodigo In (997,998,994,995,142,72,13,102)

Insert Into @VM  
SELECT 
				vmfecha		  = Fecha	
		 ,		vmcodigo      = Codigo_Moneda     
         ,      vmvalor       = Tipo_Cambio    
FROM   BacParamSuda..VALOR_MONEDA_CONTABLE     
         WHERE  Fecha         = @dFechaProceso    
         AND    Codigo_Moneda NOT IN (995,997,998,999)  --> Descartar monedas reajustables    
    
SELECT @Valor_13        = vmvalor FROM @VM WHERE vmcodigo = 994    
SELECT @valor_142       = vmvalor FROM @VM WHERE vmcodigo = 142     
SELECT @valor_72        = vmvalor FROM @VM WHERE vmcodigo = 72    
SELECT @valor_102       = vmvalor FROM @VM WHERE vmcodigo = 102    
 -------**********   CARTERA PROPIA ***************    
 ---------------------- MONTO CAPITAL CARTERA PROPIA -----------------------------------    
  
  --select * from @VM
  
 IF @FINMES ='N'     
 BEGIN    
   
   
  INSERT INTO @CARTERA     
  SELECT 'MD01'    
   , cpmascara    
   , cpnumdocu     
   , cpnumdocu     
   , cpcorrela     
   , cpcodigo      
   , cpvptirc      
   , CASE WHEN cpseriado='N' THEN ISNULL((SELECT       nsmonemi FROM bactradersuda..VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)    
        ELSE                    ISNULL((SELECT TOP 1 semonemi FROM bactradersuda..VIEW_SERIE   WHERE semascara=cpmascara),0)     
                        END    
   , cpseriado     
   , 'MD01' --'CP'          
   , 'MDCP'      
   , CtaContable    
   , cpfeccomp          
   , DATEDIFF(DAY,acfecproc,cpfecven)    
   , cpfecpcup      
   , cpinteresc    
   , cpvptirc  --monto    
  , '0'    
   , TipoLinea    
   , cpvptirc    
  , 'CP'    
  FROM bactradersuda..MDCP   
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  WHERE cpnominal > 0     
  AND cprutcart > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion = 'CP'    
  AND NumDocu  = cpnumdocu    
  AND Correla  = cpcorrela    
  AND NumOper  = cpnumdocu     
  AND     variable        = CASE WHEN cpcodigo = 20 AND Moneda <> 997 THEN 'valor_tasa_emision'    
                                               ELSE                                      'valor_compra'    
                                          END    
      
  -------************* VENTAS CON PACTO *****************    
  ---------------------- MONTO CAPITAL CARTERA VENTA CON PACTO -----------------------------------    
  INSERT INTO @CARTERA_VI     
  SELECT 'MD01'     
   , vimascara    
   , vinumoper     
   , vinumoper    
   , vicorrela     
   , vicodigo      
   , vivptirV     
  , vimonpact    
   , viseriado     
   , 'MD01'     
   , 'MDVI'        
   , CtaContable    
   , 0          
   , DATEDIFF(DAY,acfecproc,vifecvenp)    
   , vifecvenp      
   , vivalinip-- viinteresv    
   , vivalinip --monto    
  , '0'    
   , TipoLinea    
   , CASE WHEN vimonpact  =  13     THEN ROUND(vivalinip*@Valor_13,0)    
    WHEN vimonpact  =  142    THEN ROUND(vivalinip*@valor_142,0)    
    WHEN vimonpact  =  102    THEN ROUND(vivalinip*@valor_102,0)    
    WHEN vimonpact  =  72     THEN ROUND(vivalinip*@valor_72 ,0)    
    ELSE                                 vivalinip     
                        END    
  , ''    
  FROM bactradersuda..MDVI
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  WHERE vinominal > 0     
  AND Sistema  = 'BTR'    
  AND NumDocu  = vinumdocu    
  AND Correla  = vicorrela    
  AND NumOper  = vinumoper     
  AND variable = 'valor_venta'     
      
  ---------------------- MONTO REAJUSTE CARTERA VENTA CON PACTO -----------------------------------    
  INSERT INTO @CARTERA_VI    
  SELECT 'MD01'     
  , vimascara    
  , vinumoper       
  , vinumoper    
  , vicorrela     
  , vicodigo      
  , vivptirV     
  , vimonpact    
  , viseriado     
  , 'MD01'     
  , 'MDVI'        
  , CtaContable    
  , 0          
  , DATEDIFF(DAY,acfecproc,vifecvenp)    
  , vifecvenp      
  , viinteresv    
  , monto    
  , '1'    
  , TipoLinea    
  , vireajustv    
  , ''    
 FROM bactradersuda..MDVI
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  WHERE vinominal > 0     
  AND Sistema  = 'BTR'    
  AND NumDocu  = vinumdocu    
  AND Correla  = vicorrela    
  AND NumOper  = vinumoper     
  AND Variable = 'Reajuste_papel'    
  AND vimonpact      NOT IN ( 999, 13 )    
  ---------------------- MONTO INTERES CARTERA VENTA CON PACTO -----------------------------------    
  
  
  INSERT INTO @CARTERA_VI    
  SELECT 'MD01'     
  , vimascara    
  , vinumoper     
  , vinumoper    
  , vicorrela     
  , vicodigo      
  , viinteresv     
  , vimonpact    
  , viseriado     
  , 'MD01'     
  , 'MDVI'        
  , CtaContable    
  , 0          
  , DATEDIFF(DAY,acfecproc,vifecvenp)    
  , vifecvenp      
  , viinteresvi    
  , viinteresvi    
  , '2'    
  , TipoLinea    
  , CASE WHEN vimonpact  =  13     THEN ROUND(viinteresvi*@Valor_13,0)    
    WHEN vimonpact  =  142    THEN ROUND(viinteresvi*@valor_142,0)    
    WHEN vimonpact  =  102    THEN ROUND(viinteresvi*@valor_102,0)    
    WHEN vimonpact  =  72     THEN ROUND(viinteresvi*@valor_72 ,0)    
    ELSE                           viinteresvi     
                        END    
  , ''    
  FROM bactradersuda..MDVI
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  WHERE vinominal > 0     
  AND Sistema  = 'BTR'    
  AND NumDocu  = vinumdocu    
  AND Correla  = vicorrela    
  AND NumOper  = vinumoper     
  AND Variable = 'Interes_papel'    
  AND t_operacion = 'dvvi'    
      
  ---------------------- MONTO CAPITAL CARTERA INTERMEDIADA -----------------------------------    
  INSERT INTO @CARTERA     
  SELECT 'MD01'     
  , vimascara    
  , vinumdocu        
  , vinumoper     
  , vicorrela     
  , vicodigo      
  , vivalcomp         
  , CASE WHEN viseriado='N' THEN ISNULL((SELECT       nsmonemi FROM bactradersuda..VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)    
        ELSE                    ISNULL((SELECT TOP 1 semonemi FROM bactradersuda..VIEW_SERIE   WHERE semascara=vimascara),0)     
                        END      
  , viseriado     
  , 'MD01'     
  , 'MDCP'    
  , CtaContable    
  , 0          
  , DATEDIFF(DAY,acfecproc,vifecvenp)    
  , vifecvenp      
  , viinteresv    
  , vivptirc  --monto    
  , '0'    
  , TipoLinea    
  , vivptirc    
  , ''    
  FROM bactradersuda..MDVI
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  WHERE vinominal > 0     
  AND Sistema  = 'BTR'    
  AND NumDocu  = vinumdocu    
  AND Numoper  = vinumoper    
  AND Correla  = vicorrela    
  AND variable = 'valor_compra'    
       
  ---------------------- MONTO CAPITAL CARTERA COMPRAS CON PACTO -----------------------------------    
  --INTERBANCARIOS    
  INSERT INTO @CARTERA     
  SELECT 'MD01'     
  , cimascara    
  , cinumdocu     
  , cinumdocu     
  , cicorrela     
  , cicodigo      
  , civptirc         
  , cimonpact    
  , ciseriado     
  , 'MD01'    
  , 'MDCI'    
  , CtaContable    
  , cifeccomp          
  , DATEDIFF(DAY,acfecproc,cifecvenp)    
  , cifecvenp      
  , ciinteresc    
  , CASE WHEN cimonemi  =  13      THEN ROUND(monto*@Valor_13,0)    
    WHEN cimonemi  =  142     THEN ROUND(monto*@valor_142,0)    
    WHEN cimonemi  =  102     THEN ROUND(monto*@valor_102,0)    
    WHEN cimonemi  =  72      THEN ROUND(monto*@valor_72 ,0)    
    ELSE                                 monto     
                        END    
  , '0'    
  , CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END    
  , civalcomp    
  , ''    
  FROM bactradersuda..MDCI 
  , bactradersuda..CARTERA_CUENTA    
  , bactradersuda..MDAC    
  WHERE cinominal > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion = 'CP'     
  AND t_movimiento = 'MOV'    
  AND cicodigo = CodigoInst    
  AND NumDocu  = cinumdocu    
  AND Correla  = cicorrela    
  AND variable = 'valor_compra'    
  AND ciinstser IN('ICOL' , 'ICAP')    
      
  ---------------------- MONTO REAJUSTE CARTERA COMPRAS CON PACTO -----------------------------------    
  INSERT INTO @CARTERA     
  SELECT  'MD01'     
  , cimascara    
  , cinumdocu     
  , cinumdocu     
  , cicorrela     
  , cicodigo      
  , civptirc         
  , cimonpact    
  , ciseriado     
  , 'MD01'    
  , 'MDCI'    
  , CtaContable    
  , cifeccomp          
  , DATEDIFF(DAY,acfecproc,cifecvenp)    
  , cifecvenp      
  , CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then cireajustc ELSE cireajustci END    
  , monto    
  , '1'    
  , CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END    
  , CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then cireajustc ELSE cireajustci END    
  , ''    
  FROM bactradersuda..MDCI 
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  WHERE cinominal > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO'     
      WHEN ciinstser = 'ICAP' THEN 'DICA'     
      ELSE 'DVCI' END)    
  AND cicodigo =  CodigoInst    
  AND t_movimiento =  'DEV'    
  AND NumDocu  =  cinumdocu    
  AND Correla  =  cicorrela    
  AND variable =  'reajuste_papel'    
  AND ciinstser IN ('ICOL' , 'ICAP' )      
      
  ---------------------- MONTO INTERES CARTERA COMPRAS CON PACTO -----------------------------------    
  INSERT INTO @CARTERA     
  SELECT  'MD01'     
  , cimascara    
  , cinumdocu     
  , cinumdocu     
  , cicorrela     
  , cicodigo      
  , CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then ciinteresc ELSE ciinteresci END    
  , cimonpact    
  , ciseriado     
  , 'MD01'    
  , 'MDCI'    
  , CtaContable    
  , cifeccomp          
  , DATEDIFF(DAY,acfecproc,cifecvenp)    
  , cifecvenp      
  , CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then ciinteresc ELSE ciinteresci END    
  , CASE WHEN cimonemi  =  13     THEN ROUND(monto*@Valor_13,0)    
    WHEN cimonemi  =  142    THEN ROUND(monto*@valor_142,0)    
    WHEN cimonemi  =  102    THEN ROUND(monto*@valor_102,0)    
    WHEN cimonemi  =  72     THEN ROUND(monto*@valor_72 ,0)    
    ELSE monto END    
  , '2'    
  , CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END    
  , CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then ciinteresc ELSE ciinteresci END    
  , ''    
  FROM bactradersuda..MDCI
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  WHERE cinominal > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO'     
      WHEN ciinstser = 'ICAP' THEN 'DICA'     
      ELSE 'DVCI' END)    
  AND cicodigo = CodigoInst    
  AND t_movimiento = 'DEV'    
  AND NumDocu  = cinumdocu    
  AND Correla  = cicorrela    
  AND variable = 'interes_papel'    
  AND ciinstser IN ('ICOL' , 'ICAP')      
      
  INSERT INTO @CARTERA_CI     
  SELECT  'MD01'     
  , cimascara    
  , cinumdocu     
  , cinumdocu     
  , cicorrela     
  , cicodigo      
  , civptirci     
  , cimonpact    
  , ciseriado     
  , 'MD01'    
  , 'MDCI'    
  , CtaContable    
  , cifeccomp          
  , DATEDIFF(DAY,acfecproc,cifecvenp)    
  , cifecvenp      
  , ciinteresci     
  , monto      
  , '0'    
  , CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END    
  , civalcomp       
  , ''              
  FROM bactradersuda..MDCI 
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  WHERE cinominal > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion = 'CI'     
  AND t_movimiento = 'MOV'    
  AND cicodigo = CodigoInst    
  AND NumDocu  = cinumdocu    
  AND Correla  = cicorrela    
  AND variable = 'valor_compra'    
  AND ciinstser NOT IN ('ICOL'  , 'ICAP')      
      
  INSERT INTO @CARTERA_CI     
  SELECT  'MD01'     
  , cimascara    
  , cinumdocu     
  , cinumdocu     
  , cicorrela     
  , cicodigo      
  , civptirc         
  , cimonpact    
  , ciseriado     
  , 'MD01'    
  , 'MDCI'    
  , CtaContable    
  , cifeccomp          
  , DATEDIFF(DAY,acfecproc,cifecvenp)    
  , cifecvenp      
  , CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then cireajustc ELSE cireajustci END    
  , monto    
  , '1'    
  , CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END    
  , CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then cireajustc ELSE cireajustci END    
  , ''    
  FROM bactradersuda..MDCI
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  WHERE cinominal > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO'           WHEN ciinstser = 'ICAP' THEN 'DICA'     
     ELSE 'DVCI' END)    
  AND cicodigo = CodigoInst    
  AND t_movimiento = 'DEV'    
  AND NumDocu  = cinumdocu    
  AND Correla  = cicorrela    
  AND variable = 'reajuste_papel'    
  AND ciinstser NOT IN('ICOL' , 'ICAP')    
      
  ---------------------- MONTO INTERES CARTERA COMPRAS CON PACTO -----------------------------------    
  INSERT @CARTERA_CI     
  SELECT  'MD01'     
  , cimascara    
  , cinumdocu     
  , cinumdocu     
  , cicorrela     
  , cicodigo     
  , CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then ciinteresc ELSE ciinteresci END    
  , cimonpact    
  , ciseriado     
  , 'MD01'    
  , 'MDCI'    
  , CtaContable    
  , cifeccomp          
  , DATEDIFF(DAY,acfecproc,cifecvenp)    
  , cifecvenp      
  , CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then ciinteresc ELSE ciinteresci END    
  , monto    
  , '2'    
  , CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END    
  , CASE WHEN cimonpact  =  13     THEN ROUND(ciinteresci*@Valor_13,0)    
    WHEN cimonpact  =  142    THEN ROUND(ciinteresci*@valor_142,0)    
    WHEN cimonpact  =  102    THEN ROUND(ciinteresci*@valor_102,0)    
    WHEN cimonpact  =  72     THEN ROUND(ciinteresci*@valor_72 ,0)    
    ELSE       ciinteresci    
                        END    
  , ''    
  FROM bactradersuda..MDCI 
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  WHERE cinominal > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO'     
      WHEN ciinstser = 'ICAP' THEN 'DICA'     
      ELSE 'DVCI' END)    
  AND cicodigo = CodigoInst    
  AND t_movimiento = 'DEV'    
  AND NumDocu  = cinumdocu    
  AND Correla  = cicorrela    
  AND variable = 'interes_papel'    
  AND ciinstser NOT IN('ICOL' , 'ICAP')    
      
  UPDATE @CARTERA_CI     
  SET corre = 1    
      
  INSERT INTO @CARTERA     
  SELECT  tip_oper                                            
  , ''    
  , numdocu    
  , numoper          
  , corre            
  , 0    
  , SUM(tir)              
  , moneda    
  , ''    
  , tipoper          
  , tabla            
  , cuenta           
  , fecha_compra     
  , dias_dife        
  , campo_26         
  , SUM(interes)          
  , SUM(monto_oper)     
  , Cod_Evento       
  , TipoLinea        
  , SUM(monto_origen)       
  , tipo    
  FROM @CARTERA_CI     
            GROUP BY tip_oper     
  , numoper     
  , numdocu    
  , corre       
  , moneda    
  , tipoper     
  , tabla            
  , cuenta      
  , fecha_compra     
  , dias_dife    
  , campo_26    
  , Cod_Evento    
  , TipoLinea        
  , tipo    
    
  UPDATE @CARTERA_VI     
  SET numdocu = numoper     
  WHERE tabla = 'MDVI'       
    
  INSERT INTO @CARTERA     
  SELECT  tip_oper        
  , '' -- mascara          
  , numdocu    
  , numoper          
  , '1'   --corre            
  , 0    
  , SUM(tir)              
  , moneda           
  , ''    
  , tipoper          
  , tabla           
  , cuenta           
  , fecha_compra     
  , dias_dife        
  , campo_26         
  , SUM(interes)          
  , SUM(monto_oper)     
  , Cod_Evento       
  , TipoLinea        
  , SUM(monto_origen)       
  , tipo    
  FROM @CARTERA_VI     
  GROUP     
  BY tip_oper     
  , numoper     
  , numdocu    
  , moneda    
  , tipoper     
  , tabla            
  , cuenta      
  , fecha_compra     
  , dias_dife    
  , campo_26    
  , Cod_Evento    
  , TipoLinea        
  , tipo    
      
 END     
 ELSE BEGIN -- DBO,Sp_interfaz_Balance_Trader    
    
  INSERT INTO @CARTERA     
  SELECT 'MD01'    
  , cpmascara    
  , cpnumdocu     
  , cpnumdocu     
  , cpcorrela     
  , cpcodigo      
  , rsvppresenx    
  , CASE WHEN cpseriado='N' THEN ISNULL((SELECT nsmonemi FROM bactradersuda..VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)    
    ELSE ISNULL((SELECT TOP 1  semonemi FROM bactradersuda..VIEW_SERIE WHERE semascara=cpmascara),0) END          
  , cpseriado     
  , 'MD01' --'CP'          
  , 'MDCP'      
  , CtaContable    
  , cpfeccomp          
  , DATEDIFF(DAY,acfecproc,cpfecven)    
  , cpfecpcup      
  , rsinteres_acum      
  , rsvppresenx    
  , '0'    
  , TipoLinea    
  , rsvppresenx     
  , 'CP'    
  FROM bactradersuda..MDCP
  , bactradersuda..CARTERA_CUENTA    
  , bactradersuda..MDAC     
  , bactradersuda..MDRS     
  WHERE cpnominal > 0     
  AND cprutcart > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion = 'CP'    
  AND NumDocu  = cpnumdocu    
  AND Correla  = cpcorrela    
  AND NumOper  = cpnumdocu     
  AND CASE WHEN cpcodigo = 20 AND Moneda <> 997  THEN 'valor_tasa_emision'     
    ELSE 'valor_compra' END  = variable    
  AND rsfecha  = @fechafinmes    
  AND rsnumdocu = cpnumdocu    
  AND rscorrela = cpcorrela    
  AND rsnumoper = cpnumdocu    
  AND rstipoper = 'DEV'     
  -------************* VENTAS CON PACTO *****************      
  ---------------------- MONTO CAPITAL CARTERA VENTA CON PACTO -----------------------------------    
  INSERT INTO @CARTERA_VI     
  SELECT 'MD01'     
  , vimascara    
  , vinumoper       
  , vinumoper    
  , vicorrela     
  , vicodigo      
  , rsvppresen    
  , vimonpact    
  , viseriado     
  , 'MD01'     
  , 'MDVI'        
  , CtaContable    
  , 0          
  , DATEDIFF(DAY,acfecproc,vifecvenp)    
  , vifecvenp      
  , rsvalinip    
  , rsvalinip    
  , '0'    
  , TipoLinea    
  , CASE WHEN vimonpact  =  13     THEN ROUND(rsvalinip*@Valor_13,0)    
    WHEN vimonpact  =  142    THEN ROUND(rsvalinip*@valor_142,0)    
    WHEN vimonpact  =  102    THEN ROUND(rsvalinip*@valor_102,0)    
    WHEN vimonpact  =  72     THEN ROUND(rsvalinip*@valor_72 ,0)    
    ELSE rsvalinip END    
  , ''    
  FROM bactradersuda..MDVI
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC       
  , bactradersuda..MDRS    
  WHERE vinominal > 0     
  AND Sistema  = 'BTR'    
  AND NumDocu  = vinumdocu    
  AND Correla  = vicorrela    
  AND NumOper  = vinumoper     
  AND variable = 'valor_venta'     
  AND rsfecha  = @FECHAFINMES    
  AND rsnumdocu = vinumdocu    
  AND rscorrela = vicorrela    
  AND rsnumoper = vinumoper    
  AND rsTIPOPER = 'DEV'     
  AND rscartera = 114    
    
  ---------------------- MONTO REAJUSTE CARTERA VENTA CON PACTO -----------------------------------    
  INSERT INTO @CARTERA_VI    
  SELECT 'MD01'     
  , vimascara    
  , vinumoper    
  , vinumoper    
  , vicorrela     
  , vicodigo      
  , vivptirV     
  , vimonpact    
  , viseriado     
  , 'MD01'     
  , 'MDVI'        
  , CtaContable    
  , 0          
  , DATEDIFF(DAY,acfecproc,vifecvenp)    
  , vifecvenp      
  , RSINTERES_ACUM     
  , RSREAJUSTE_ACUM    
  , '1'    
  , TipoLinea    
  , RSREAJUSTE_ACUM     
  , ''    
  FROM bactradersuda..MDVI
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  , bactradersuda..MDRS    
  WHERE vinominal > 0     
  AND vimonpact NOT IN ( 999, 13 )    
  AND Sistema  = 'BTR'    
  AND NumDocu  = vinumdocu    
  AND Correla  = vicorrela    
  AND NumOper  = vinumoper     
  AND Variable = 'Reajuste_papel'    
  AND rsfecha  = @FECHAFINMES    
  AND rsnumdocu = vinumdocu    
  AND rscorrela = vicorrela    
  AND rsnumoper = vinumoper    
  AND rsTIPOPER = 'DEV'     
  AND rscartera = 114    
  ---------------------- MONTO INTERES CARTERA VENTA CON PACTO -----------------------------------    
  INSERT @CARTERA_VI    
  SELECT 'MD01'     
  , vimascara    
  , vinumoper  --vinumdocu     
  , vinumoper    
  , vicorrela     
  , vicodigo      
  , viinteresv     
  , vimonpact    
  , viseriado     
  , 'MD01'     
  , 'MDVI'        
  , CtaContable    
  , 0          
  , DATEDIFF(DAY,acfecproc,vifecvenp)    
  , vifecvenp      
  , viinteresvi     
  , viinteresvi     
  , '2'    
  , TipoLinea    
  , CASE WHEN vimonpact  =  13     THEN ROUND(viinteresvi*@Valor_13,0)    
    WHEN vimonpact  =  142    THEN ROUND(viinteresvi*@valor_142,0)    
    WHEN vimonpact  =  102    THEN ROUND(viinteresvi*@valor_102,0)    
    WHEN vimonpact  =  72     THEN ROUND(viinteresvi*@valor_72 ,0)    
    ELSE viinteresvi END    
  , ''      
  FROM bactradersuda..MDVI
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  , bactradersuda..MDRS    
  WHERE vinominal > 0     
  AND Sistema  = 'BTR'    
  AND NumDocu  = vinumdocu    
  AND Correla  = vicorrela    
  AND NumOper  = vinumoper     
  AND Variable = 'Interes_papel'    
  AND t_operacion = 'dvvi' --         
  AND rsfecha  = @FECHAFINMES    
  AND rsnumdocu = vinumdocu    
  AND rscorrela = vicorrela    
  AND rsnumoper = vinumoper    
  AND rsTIPOPER = 'DEV'     
  AND rscartera = 114    

  ---------------------- MONTO CAPITAL CARTERA INTERMEDIADA -----------------------------------    
  INSERT INTO @CARTERA     
  SELECT DISTINCT    
   'MD01'     
  , vimascara    
  , vinumdocu        
  , vinumoper     
  , vicorrela     
  , vicodigo      
  , vivalcomp         
  , CASE WHEN viseriado='N' THEN ISNULL((SELECT nsmonemi FROM bactradersuda..VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)    
    ELSE ISNULL((SELECT TOP 1  semonemi FROM bactradersuda..VIEW_SERIE WHERE semascara=vimascara),0) END          
  , viseriado     
  , 'MD01'     
  , 'MDCP'    
  , CtaContable    
  , 0          
  , DATEDIFF(DAY,acfecproc,vifecvenp)    
  , vifecvenp      
  , RSINTERES_ACUM     
  ,  rsvppresenx     
  , '0'    
  , TipoLinea    
  ,  rsvppresenx     
  , ''    
  FROM bactradersuda..MDVI
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  , bactradersuda..MDRS    
  WHERE vinominal > 0     
  AND Sistema  = 'BTR'    
  AND NumDocu  = vinumdocu    
  AND Numoper  = vinumoper    
  AND Correla  = vicorrela    
  AND variable = 'valor_compra' -- valor_presente    
  AND rsfecha  = @FECHAFINMES    
  AND rsnumdocu = vinumdocu    
  AND rsnumoper = vinumoper    
  AND rscorrela = vicorrela    
  AND rsTIPOPER = 'DEV'     
  AND RSCARTERA = 114     
  ---------------------- MONTO CAPITAL CARTERA COMPRAS CON PACTO -----------------------------------    
  INSERT INTO @CARTERA     
  SELECT  'MD01'     
  , cimascara    
  , cinumdocu     
  , cinumdocu     
  , cicorrela     
  , cicodigo      
  , RSVPPRESEN     
  , cimonpact    
  , ciseriado     
  , 'MD01'    
  , 'MDCI'    
  , CtaContable    
  , cifeccomp          
  , DATEDIFF(DAY,acfecproc,cifecvenp)    
  , cifecvenp      
  , RSINTERES_ACUM    
  , CASE WHEN cimonemi  =  13     THEN ROUND(civalcomp*@Valor_13,0)    
    WHEN cimonemi  =  142 THEN ROUND(civalcomp*@valor_142,0)    
    WHEN cimonemi  =  102     THEN ROUND(civalcomp*@valor_102,0)    
    WHEN cimonemi  =  72      THEN ROUND(civalcomp*@valor_72 ,0)    
    ELSE civalcomp END    
  , '0'    
  , CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END    
  , CIVALCOMP     
  , ''    
  FROM bactradersuda..MDCI 
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  , bactradersuda..MDRS    
  WHERE cinominal > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion = (CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then 'CP' else 'CI' end)    
  AND cicodigo = CodigoInst    
  AND t_movimiento = 'MOV'    
  AND NumDocu  = cinumdocu    
  AND Correla  = cicorrela    
  AND variable = 'valor_compra'    
  AND rsfecha  = @FECHAFINMES    
  AND rsnumdocu = cinumdocu    
  AND rscorrela = cicorrela    
  AND rsTIPOPER = 'DEV'     
  AND ciinstser IN ('ICOL' , 'ICAP')    
  ---------------------- MONTO REAJUSTE CARTERA COMPRAS CON PACTO -----------------------------------    
  INSERT INTO @CARTERA     
  SELECT  'MD01'     
  , cimascara    
  , cinumdocu     
  , cinumdocu     
  , cicorrela     
  , cicodigo      
  , rsvppresen        
  , cimonpact    
  , ciseriado     
  , 'MD01'    
  , 'MDCI'    
  , CtaContable    
  , cifeccomp          
  , DATEDIFF(DAY,acfecproc,cifecvenp)    
  , cifecvenp      
  , rsreajuste_acum    
  , rsreajuste_acum    
  , '1'    
  , CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END    
  , rsreajuste_acum    
  , ''    
  FROM bactradersuda..MDCI 
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  , bactradersuda..MDRS    
  WHERE cinominal > 0    
  AND t_operacion = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO'     
      WHEN ciinstser = 'ICAP' THEN 'DICA'     
      ELSE 'DVCI' END)    
  AND cicodigo = CodigoInst    
  AND Sistema  = 'BTR'    
  AND t_movimiento = 'DEV'    
  AND NumDocu  = cinumdocu    
  AND Correla  = cicorrela    
  AND variable = 'reajuste_papel'    
  AND rsfecha  = @FECHAFINMES    
  AND rsnumdocu = cinumdocu    
  AND rscorrela = cicorrela    
  AND rsTIPOPER = 'DEV'     
  AND ciinstser IN ('ICOL' , 'ICAP')      
  ---------------------- MONTO INTERES CARTERA COMPRAS CON PACTO -----------------------------------    
  INSERT @CARTERA     
  SELECT  'MD01'     
  , cimascara    
  , cinumdocu     
  , cinumdocu     
  , cicorrela     
  , cicodigo      
  , RSINTERES_ACUM     
  , cimonpact    
  , ciseriado     
  , 'MD01'    
  , 'MDCI'    
  , CtaContable    
  , cifeccomp          
  , DATEDIFF(DAY,acfecproc,cifecvenp)    
  , cifecvenp      
  , RSINTERES_ACUM    
  , CASE WHEN cimonemi  =  13     THEN ROUND(RSINTERES_ACUM*@Valor_13,0)    
    WHEN cimonemi  =  142    THEN ROUND(RSINTERES_ACUM*@valor_142,0)    
    WHEN cimonemi  =  102    THEN ROUND(RSINTERES_ACUM*@valor_102,0)    
    WHEN cimonemi  =  72     THEN ROUND(RSINTERES_ACUM*@valor_72 ,0)    
    ELSE RSINTERES_ACUM END    
  , '2'    
  , CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END    
  , RSINTERES_ACUM     
  , ''    
  FROM bactradersuda..MDCI 
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  , bactradersuda..MDRS    
  WHERE cinominal > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO'     
      WHEN ciinstser = 'ICAP' THEN 'DICA'     
      ELSE 'DVCI' END)    
  AND cicodigo = CodigoInst    
  AND t_movimiento = 'DEV'    
  AND NumDocu  = cinumdocu    
  AND Correla  = cicorrela    
  AND variable = 'interes_papel'    
  AND rsfecha  = @FECHAFINMES    
  AND rsnumdocu = cinumdocu    
  AND rscorrela = cicorrela    
  AND rsTIPOPER = 'DEV'     
  AND ciinstser IN ('ICOL' , 'ICAP')    
  
  
  INSERT INTO @CARTERA_CI     
  SELECT  'MD01'     
  , cimascara    
  , cinumdocu     
  , cinumdocu     
  , cicorrela     
  , cicodigo      
  , RSVPPRESEN     
  , cimonpact    
  , ciseriado     
  , 'MD01'    
  , 'MDCI'    
  , CtaContable    
  , cifeccomp          
  , DATEDIFF(DAY,acfecproc,cifecvenp)    
  , cifecvenp      
  ,  RSINTERES_ACUM    
  , civalinip     
  , '0'    
  , CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END    
  , CASE WHEN cimonpact  =  13     THEN ROUND(civalinip*@Valor_13,0)    
    WHEN cimonpact  =  142    THEN ROUND(civalinip*@valor_142,0)    
    WHEN cimonpact  =  102    THEN ROUND(civalinip*@valor_102,0)    
    WHEN cimonpact  =  72     THEN ROUND(civalinip*@valor_72 ,0)    
    ELSE civalinip END    
  , ''    
  FROM bactradersuda..MDCI 
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  , bactradersuda..MDRS    
  WHERE cinominal > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion  = (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)    
  AND cicodigo       = CodigoInst    
  AND t_movimiento   = 'MOV'    
  AND NumDocu        = cinumdocu    
  AND Correla        = cicorrela    
  AND variable       = 'valor_compra'    
  AND rsfecha = @FECHAFINMES    
  AND rsnumdocu = cinumdocu    
  AND rscorrela = cicorrela    
  AND rsTIPOPER = 'DEV'     
  AND ciinstser NOT IN('ICOL' , 'ICAP')    
  -- SELECT * FROM MDCI 
  ---------------------- MONTO REAJUSTE CARTERA COMPRAS CON PACTO -----------------------------------    
  INSERT @CARTERA_CI     
  SELECT  'MD01'     
  , cimascara    
  , cinumdocu     
  , cinumdocu     
  , cicorrela     
  , cicodigo      
  , rsvppresen        
  , cimonpact    
  , ciseriado     
  , 'MD01'    
  , 'MDCI'    
  , CtaContable    
  , cifeccomp          
  , DATEDIFF(DAY,acfecproc,cifecvenp)    
  , cifecvenp      
  , rsreajuste_acum    
  , rsreajuste_acum    
  , '1'    
  , CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END    
  , rsreajuste_acum    
  , ''    
  FROM bactradersuda..MDCI 
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  , bactradersuda..MDRS    
  WHERE cinominal > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion  = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO' WHEN ciinstser = 'ICAP' Then 'DICA' else 'DVCI' end)    
  AND cicodigo       = CodigoInst    
  AND t_movimiento   = 'DEV'    
  AND NumDocu        = cinumdocu    
  AND Correla        = cicorrela    
  AND variable       = 'reajuste_papel'    
  AND rsfecha = @FECHAFINMES    
  AND rsnumdocu = cinumdocu    
  AND rscorrela = cicorrela    
  AND rsTIPOPER = 'DEV'     
  AND ciinstser NOT IN('ICOL' , 'ICAP')    
  ---------------------- MONTO INTERES CARTERA COMPRAS CON PACTO -----------------------------------      
  INSERT INTO @CARTERA_CI     
  SELECT  'MD01'     
  , cimascara    
  , cinumdocu     
  , cinumdocu     
  , cicorrela     
  , cicodigo      
  , RSINTERES_ACUM     
  , cimonpact    
  , ciseriado     
  , 'MD01'    
  , 'MDCI'    
  , CtaContable    
  , cifeccomp          
  , DATEDIFF(DAY,acfecproc,cifecvenp)    
  , cifecvenp      
  , RSINTERES_ACUM    
  , RSINTERES_ACUM    
  , '2'    
  , CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END    
  , CASE WHEN cimonpact  =  13     THEN ROUND(RSINTERES_ACUM*@Valor_13,0)    
    WHEN cimonpact  =  142    THEN ROUND(RSINTERES_ACUM*@valor_142,0)    
    WHEN cimonpact  =  102    THEN ROUND(RSINTERES_ACUM*@valor_102,0)    
    WHEN cimonpact  =  72     THEN ROUND(RSINTERES_ACUM*@valor_72 ,0)    
    ELSE RSINTERES_ACUM END    
  , ''    
  FROM bactradersuda..MDCI 
  , bactradersuda..CARTERA_CUENTA     
  , bactradersuda..MDAC    
  , bactradersuda..MDRS    
  WHERE cinominal > 0    
  AND Sistema  = 'BTR'    
  AND t_operacion  = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO' WHEN ciinstser = 'ICAP' Then 'DICA' else 'DVCI' end)    
  AND cicodigo       = CodigoInst    
  AND t_movimiento   = 'DEV'    
  AND NumDocu      = cinumdocu    
  AND Correla        = cicorrela    
  AND variable       = 'interes_papel'    
  AND rsfecha = @FECHAFINMES    
  AND rsnumdocu = cinumdocu    
  AND rscorrela = cicorrela    
  AND rsTIPOPER = 'DEV'     
  AND ciinstser NOT IN('ICOL' , 'ICAP')   
   
  UPDATE @CARTERA_CI     
  SET corre = 1    
      
  INSERT @CARTERA     
  SELECT  tip_oper                                            
  , '' -- mascara          
  , numdocu    
  , numoper          
  , corre            
  , 0    
  , SUM(tir)              
  , moneda           
  , ''    
  , tipoper          
  , tabla            
  , cuenta           
  , fecha_compra     
  , dias_dife        
  , campo_26         
  , SUM(interes)          
  , SUM(monto_oper)     
  , Cod_Evento       
  , TipoLinea        
  , SUM(monto_origen)       
  , tipo    
  FROM @CARTERA_CI     
  GROUP     
  BY tip_oper , numoper , numdocu    
  , corre  , moneda , tipoper     
  , tabla  , cuenta , fecha_compra     
  , dias_dife , campo_26 , Cod_Evento    
  , TipoLinea , tipo    
    
  UPDATE @CARTERA_VI     
  SET numdocu = numoper     
  WHERE tabla = 'MDVI'   --OJO    
    
  INSERT INTO @CARTERA     
  SELECT  tip_oper                                            
  , '' -- mascara          
  , numdocu    
  , numoper          
  , '1' --corre            
  , 0    
  , SUM(tir)              
  , moneda           
  , ''    
  , tipoper          
  , tabla            
  , cuenta           
  , fecha_compra     
  , dias_dife        
  , campo_26         
  , SUM(interes)          
  , SUM(monto_oper)     
  , Cod_Evento       
  , TipoLinea        
  , SUM(monto_origen)       
  , tipo    
  FROM @CARTERA_VI     
  GROUP     
  BY tip_oper , numoper , numdocu    
  , moneda  , tipoper , tabla            
  , cuenta  , fecha_compra , dias_dife    
  , campo_26 , Cod_Evento , TipoLinea        
  , tipo    
    
 END    
    
    
      
 -------**********   TASA MERCADO ***************    
 ---------------------- ********* -----------------------------------    
    
        DECLARE @feriado          NUMERIC (01)    
 , @feriadoIniMes    NUMERIC (01)    
 , @dfecfmes1         DATETIME    
 , @dfecImes         DATETIME    
 , @Fecha_Hoy        DATETIME    
 , @Fecha_prox       DATETIME    
    
 sELECT @Fecha_Hoy = acfecproc    
 , @Fecha_prox = acfecprox    
        FROM bactradersuda..MDAC      
    
SELECT @dfecfmes1 = DATEADD(DAY,DATEPART(DAY,@Fecha_prox) * -1,@Fecha_prox)       
SELECT @dfecImes = DATEADD(DAY,DATEPART(DAY,@Fecha_Hoy)* -1,DATEADD(DAY, 1, @Fecha_Hoy))             
     
EXECUTE bactradersuda..sp_feriado @dfecfmes1,6 , @feriado output    
EXECUTE bactradersuda..sp_feriado @dfecImes,6 , @feriadoIniMes output    
    
 SELECT 'MDIR'  = 'MD01'    
 , 'tmmascara' = CONVERT(VARCHAR(13),ISNULL(VALORIZACION_MERCADO.tmmascara,''))               
 , 'rmnumoper' = ISNULL (VALORIZACION_MERCADO.rmnumoper,0)    
 , 'rmnumdocu' = ISNULL (VALORIZACION_MERCADO.rmnumdocu,0)     
 , 'rmcorrela' = ISNULL(VALORIZACION_MERCADO.rmcorrela,0)             
 , 'rmcodigo' = ISNULL(VALORIZACION_MERCADO.rmcodigo,0)    
 , 'tasa_mercado' = ISNULL(VALORIZACION_MERCADO.tasa_mercado,0)       
 , 'moneda_emision'= ISNULL(VALORIZACION_MERCADO.moneda_emision,0)        
 , 'inserie' = CONVERT(CHAR(25), CASE WHEN INCODIGO = 15 AND emtipo ='2'  THEN 'BONOS INST. FINANCIERAS'     
        ELSE inserie END)     
 , 'tmseriado' = ISNULL(VALORIZACION_MERCADO.tmseriado,'')               
 , 'MD01'  = 'MD01'    
 , 'MDTM'  = 'MDTM'    
 , 'Cta'  = 0         
 , 'fecha_valorizacion'  = ISNULL(VALORIZACION_MERCADO.fecha_valorizacion,0)       
 , 'tmfecemi' = ISNULL(VALORIZACION_MERCADO.tmfecemi,0)       
 , 'tmfecven' = ISNULL(VALORIZACION_MERCADO.tmfecven,0)       
 , 'INTERES' = 0    
 , 'DIFERENCIA' = CASE WHEN VALORIZACION_MERCADO.codigo_carterasuper = 'A' THEN CONVERT(NUMERIC(19,4),0.0)    
                                       ELSE                                CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO.diferencia_mercado,0))    
                                  END  
 , 'tipo_linea' = ' '  
 , 'Monto Oper' = CASE WHEN VALORIZACION_MERCADO.codigo_carterasuper = 'A' THEN CONVERT(NUMERIC(19,4), 0.0 )    
                                       ELSE                                CONVERT(NUMERIC(19,4),ISNULL(VALORIZACION_MERCADO.diferencia_mercado,0))    
                                  END  
 , 'Tipo'  = 'TM'    
 INTO #TEMPORAL    
 FROM  bactradersuda..VALORIZACION_MERCADO    
 , bactradersuda..VIEW_MONEDA    
 , bactradersuda..VIEW_EMISOR    
 , bactradersuda..VIEW_INSTRUMENTO     
 , bactradersuda..MDCP  
 WHERE VALORIZACION_MERCADO.id_sistema  = 'BTR'     
 AND VALORIZACION_MERCADO.fecha_valorizacion = @FechaBusquedaValorizacion --@dfecfmes1    
 AND VIEW_MONEDA.mncodmon   = VALORIZACION_MERCADO.moneda_emision    
 AND VIEW_INSTRUMENTO.incodigo  = VALORIZACION_MERCADO.rmcodigo     
 AND emrut     =   rut_emisor    
 AND     VALORIZACION_MERCADO.rut_emisor  <>  97023000       
 AND     VALORIZACION_MERCADO.rmnumdocu  = cpnumdocu     
 AND VALORIZACION_MERCADO.rmcorrela  = cpcorrela    
 AND     VALORIZACION_MERCADO.valor_nominal > 0     
 AND rmrutcart    > 0    
        and     VALORIZACION_MERCADO.codigo_carterasuper <> 'A'  
  
    
 INSERT @CARTERA     
 SELECT DISTINCT    
  'MD01'    
 , tmmascara    
 , rmnumdocu     
 , rmnumoper     
 , rmcorrela     
 , rmcodigo      
 , tasa_mercado      
 , 'moneda' = CASE WHEN tmseriado='N' THEN ISNULL((SELECT nsmonemi FROM bactradersuda..VIEW_NOSERIE WHERE nsnumdocu=rmnumdocu AND nscorrela=rmcorrela),0)    
    ELSE ISNULL((SELECT TOP 1  semonemi FROM bactradersuda..VIEW_SERIE WHERE semascara=tmmascara),0) END    
 , tmseriado     
 , 'MD01'     
 , 'MDTM'        
 , CtaContable    
 , fecha_valorizacion          
 , DATEDIFF(DAY,acfecproc,tmfecven)    
 , tmfecemi    
 , 0    
 , DIFERENCIA  --diferencia_mercado  --monto    
 , '0'    
 , TipoLinea    
 , DIFERENCIA    
 , Tipo     
 FROM #TEMPORAL      
 , bactradersuda..CARTERA_CUENTA     
 , bactradersuda..MDAC    
 WHERE t_movimiento  = 'TMF'     
 AND Sistema   = 'BTR'    
 AND NumDocu   = rmnumdocu    
 AND Correla   = rmcorrela    
 AND NumOper   = rmnumdocu     
 AND variable  = CASE WHEN DIFERENCIA >= 0 THEN 'dif_valor_mercado_pos'     
      ELSE 'dif_valor_mercado_neg' END    
 AND fecha_valorizacion = @FechaBusquedaValorizacion --@dfecfmes1    
 -------**********   TASA MERCADO ***************    
 ---------------------- ********* -----------------------------------    
   
   
 UPDATE @CARTERA     
 SET tipolinea = CONVERT(CHAR(3) ,b.tipo_cuenta)    
 FROM @CARTERA A    
 INNER JOIN bactradersuda..VIEW_PLAN_DE_CUENTA B ON B.cuenta = A.cuenta    
    
 DECLARE CURSOR_INTER CURSOR FOR     
 SELECT tip_oper     
 , mascara     
 , numdocu       
 , numoper     
 , corre       
 , codigo    
 , tir       
 , moneda      
 , seriado       
 , tipoper     
 , tabla       
 , cuenta    
 , fecha_compra      
 , dias_dife         
 , campo_26      
 , interes     
 , monto_oper    
 , Cod_Evento    
 , monto_origen      
 , TipoLinea     
 , tipo    
 FROM @CARTERA    
    
 OPEN CURSOR_INTER    
 FETCH NEXT FROM CURSOR_INTER    
 INTO @tip_oper , @mascara , @numdocu , @numoper , @corre       
 , @codigo  , @tir   , @moneda , @seriado , @tipoper     
 , @tabla  , @cuenta , @fecha_compra , @dias_dife    , @campo_26       
 , @interes , @monto_oper , @Cod_Evento , @monto_origen , @TipoLinea        
 , @tipo    
    
 WHILE @@FETCH_STATUS  = 0   
 BEGIN     
    
  SELECT @NumCuenta    = ''    
  , @Ccuenta      = '0'    
  , @Monto        = 0    
  , @NumValor     = ''    
  , @NumReajuste  = ''    
  , @NumInteres   = ''    
  , @indicador    = ''    
      
  IF @Moneda IN (998,997,994,995,999)     
                BEGIN    
     SELECT @cMoneda = '00'    
  END ELSE     
                BEGIN    
     SELECT @cMoneda = (SELECT mncodfox FROM bactradersuda..VIEW_MONEDA WHERE @Moneda = mncodmon)    
  END      
    
  IF @TipoLinea = 'ACT'     
     SELECT @indicador = 'D'    
  ELSE IF @TipoLinea = 'PER'      
     SELECT @indicador = 'D'    
  ELSE IF @TipoLinea = 'PAS'      
     SELECT @indicador = 'C'    
  ELSE IF @TipoLinea = 'UTI'      
     SELECT @indicador = 'C'    
    
  IF @moneda <> 999     
     BEGIN    
     SELECT @vDolar_obs = 0    
     -- Se recupera este código para no afectar las monedas reajustables:    
                   -- contabilizacion en el día.    
     SELECT @vDolar_obs = ISNULL((select vmvalor FROM @vm  WHERE vmcodigo = @Moneda AND vmfecha = @dFechaProceso),0)    
    
      IF @Moneda NOT IN(994,998)    
        BEGIN    
         SELECT @vDolar_obs = 1    
		END   
		
		--select '@Monto_oper:'+ cast(@Monto_oper as varchar(20)) 
		--select '@vDolar_obs:'+ cast(@vDolar_obs as varchar(20)) 

     SELECT @monto_oper = @Monto_oper/@vDolar_obs    
     SELECT @interes    = @interes/@vDolar_obs    
    
  END ELSE     
     SELECT @monto_oper = @Monto_oper /1    
     IF @cuenta <> '0' AND @cuenta <> ''     
                   BEGIN    
        IF @monto_origen < 0     
                      BEGIN    
           IF @indicador = 'D'     
                         BEGIN    
       SELECT @indicador = 'C'    
    END ELSE     
        IF @indicador = 'C'     
        BEGIN    
            SELECT @indicador = 'D'    
      END    
    END   
	 
    if (@Monto_oper!=0) 
	BEGIN
			INSERT INTO @BO15 VALUES
			(
				'CL '																	--		1	
		,		LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))								--		2	
		,		'BO15' + SPACE(10)														--		3	
		,		'001'																	--		4	
		,		'MD01'   + SPACE(12)													--		5
		,		ltrim(rtrim(CAST(@numdocu AS VARCHAR(8)) +  cast(@corre AS VARCHAR(4)) 
				+ CAST( @numoper AS VARCHAR(8))	))										--		6
		,		convert(char(8),@dFechaProceso,112)										--		7	
		,		@cuenta																	--		8	
		,		@indicador																--		9
		,		@Cod_Evento																--		10	
		,		CASE WHEN @Monto_oper < 0 THEN '-' ELSE '+' END							--		11
		,		@Monto_oper																--		12
		,		CASE WHEN @monto_origen < 0 THEN '-' ELSE '+' END						--		13
		,		@monto_origen															--		14
		,		CASE WHEN @monto_origen < 0 THEN '-' ELSE '+' END   					--		15
		,		@monto_origen															--		16
		,		'0011'																	--		17	
		,		REPLICATE('0',10)														--		18	
		)
	END
        
   END    
    
  FETCH NEXT FROM CURSOR_INTER    
  INTO @tip_oper , @mascara , @numdocu , @numoper , @corre       
  , @codigo  , @tir   , @moneda , @seriado , @tipoper     
  , @tabla  , @cuenta , @fecha_compra , @dias_dife    , @campo_26       
  , @interes , @monto_oper , @Cod_Evento , @monto_origen , @TipoLinea        
  , @tipo    
          
 END    
    
 CLOSE CURSOR_INTER    
 DEALLOCATE  CURSOR_INTER    
 
 DROP TABLE #TEMPORAL

 Declare @TipoSalida bit = 0

if @TipoSalida != 0
		SELECT  
				   ctry																																						--		1					
				, intf_dt																																					--		2	
				, src_id																																					--		3	
				, cem																																						--		4	
				, prod																																						--		5	
				, left(con_no+space(20), 20) -- con_no + replicate(char(160), 20 - len(con_no))																																					--		6	
				, book_dt																																					--		7
				, isnull(ain, REPLICATE(char(160),20))																																						--		8	
				, dr_cr_ind																																					--		9	
				, REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(actg_evnt_cod))))) + LTRIM(RTRIM(STR(actg_evnt_cod)))														--		10
				, ocy_bal_sign																																				--		11	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(ocy_bal*10000))),19)
				, lcy_bal_sign																																				--		13
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_bal*100))),19)
				, lcy_agg_bal_sign																																			--		15
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_agg_bal*100))),19)
				, br																																						--		17
				, cc	
	FROM @BO15

	Order by cem , ain , prod , con_no
 else
 begin
		INSERT INTO @BO15_SALIDA
		select 
				  ctry																																						--		1					
				+ intf_dt																																					--		2	
				+ src_id																																					--		3	
				+ cem																																						--		4	
				+ prod																																						--		5	
				+ left(con_no+space(20), 20) --con_no + replicate(char(160), 20 - len(con_no))																																					--		6	
				+ book_dt																																					--		7
				+ isnull(ain, REPLICATE(char(160),20))																																								--		8	
				+ dr_cr_ind																																					--		9	
				+ REPLICATE('0', 3 - DATALENGTH(LTRIM(RTRIM(STR(actg_evnt_cod))))) + LTRIM(RTRIM(STR(actg_evnt_cod)))														--		10
				+ ocy_bal_sign																																				--		11	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(ocy_bal*10000))),19)
				+ lcy_bal_sign																																				--		13
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_bal*100))),19)
				+ lcy_agg_bal_sign																																			--		15
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_agg_bal*100))),19)
				+ br																																						--		17
				+ cc																																						--		18
				from @BO15
			Order by cem , ain , prod , con_no
		
--		insert into @BO15_SALIDA
--		select @Pie_Archivo

		select * from @BO15_SALIDA

		--drop table #TEMPORAL
End
   
 SET NOCOUNT OFF    
    
END  
GO
