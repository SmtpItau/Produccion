USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_stock_cartera_volckerRule]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_stock_cartera_volckerRule] 
(		
		@cFecRep CHAR(08)
)  
AS   


/* LD1-COR-035 FUSION CORPBANCA - ITAU --> REPORTE CARTERA VOLCKER RULE **/
/***********************************************************************/
/*HOMOLOGADO POR: MARIA PAZ GARCES	 */
/*SISTEMA: BACTRADERSUDA */

BEGIN  
  
 SET NOCOUNT ON  
  
 DECLARE @FECPROC     CHAR(10),   
  @dFecPrx     DATETIME  
 DECLARE @xSistema    CHAR(03),  
   @xTipoMov    CHAR(03),   
   @TipOpe      CHAR(03),   
   @codins      CHAR(6),  
   @xMoneda     NUMERIC(03),  
   @TipoCartera CHAR(01),  
   @xRutCli     NUMERIC(09),  
   @xCodCli     Numeric(9),  
   @dFecini     Datetime,  
   @dFecFin     Datetime,  
   @xGarantia   Char(01),  
   @NumDocu     Numeric(10),  
   @Correla     Numeric(03),  
   @cOpe        CHAR(08),  
   @cEstado     CHAR(01),  
   @cCond      CHAR(02),  
   @cCondi      CHAR(02),   
   @cLlave      CHAR(21),  
   @indice      INT,  
   @cCustodia   CHAR(01),  
   @nReg       INT,  
   @nn      INT,  
   @cCampoVar   CHAR(10),  
   @nmoneda     NUMERIC(3),  
   @nValCont    FLOAT,  
   @dFecinicial DATETIME,  
   @nValMon     FLOAT,   
   @nMtoPe      FLOAT,  
   @nNominal    FLOAT,  
   @Valini      FLOAT,  
   @ValVen      FLOAT,  
   @cRtEm       NUMERIC(09),  
   @cNumcta     CHAR(08),  
   @nCont      INT,  
   @n      INT,  
   @nValOpePe   FLOAT,  
   @xMonemi     NUMERIC(03),  
   @dFecRep     DATETIME,  
   @nDolObs     FLOAT    , -- VGS (17/08/2005)  
   @nRutcart    NUMERIC(10) -- VGS (10/09/2006)  
    
  -------UPDATE saldos_cartera SET SALDO = 0  
  
  SELECT @dFecRep = CONVERT(Datetime,@cFecRep)  
          
        SELECT @FECPROC =convert(char(10),acfecproc,112),  
        @dFecPrx = acfecprox,  
        @nRutcart = acrutprop  
  FROM MDAC  
  
  SELECT @nDolObs = vmvalor FROM View_Valor_Moneda where vmcodigo = 994 and vmfecha = @FECPROC   -- VGS (17/08/2005)  
 
 SELECT  NUMDOCU		= cpnumdocu,  
	   CORRELA			= cpcorrela,  
	   FECHA_EMISION	= CONVERT(CHAR(12), cpfecemi, 103),  
	   SERIE			= RTRIM(cpinstser) + (case when Fecha_pagomañana > @dFecRep THEN ' *' ELSE '' END),  
	   TCORRELA			= 1,  
	   SERIADO			= cpseriado,  
	   CODIGO_BOLSA		= 0,  
	   NUM_CLI			= Codigo_as400, 
	   RUT_EMISOR		= (CASE WHEN UPPER(cpseriado) = 'S' 
									THEN ISNULL((SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara ),0)
										WHEN UPPER(a.cpseriado) = 'N' 
											THEN ISNULL((SELECT nsrutemi 
														  FROM VIEW_NOSERIE 
														  WHERE a.cpnumdocu = nsnumdocu AND a.cpcorrela = nscorrela) ,0) 
											 END),  
	   COD_EMISOR		= cpcodcli,  
	   NOM_EMISOR		= SPACE(50),  
	   CONTRATO			= ISNULL(a.Numero_Contrato,0),  
	   NOM_MONEDA		= SPACE(10),  
	   COD_MONEDA		= (CASE WHEN UPPER(a.cpseriado) = 'S' 
									THEN ISNULL((SELECT semonemi FROM VIEW_SERIE WHERE semascara = a.cpmascara),0) 
								WHEN UPPER(a.cpseriado) = 'N' 
									THEN ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE a.cpnumdocu = nsnumdocu AND a.cpcorrela = nscorrela),0)
								 END),  
	   NOMINAL			= a.cpnominal + isnull((select sum(vinominal) from mdvi where a.cpnumdocu = vinumdocu and a.cpcorrela = vicorrela),0),  
	   PRECIO_OP_UM		= isnull(a.valor_contable,0) + isnull((select sum(valor_contable) from mdvi where a.cpnumdocu = vinumdocu and a.cpcorrela = vicorrela),0),  
	   PRECIO_OP		= isnull(a.valor_contable,0) + isnull((select sum(valor_contable) from mdvi where a.cpnumdocu = vinumdocu and a.cpcorrela = vicorrela),0),  
	   TASA_CON			= ISNULL(a.tasa_contrato,0),  
	   FECHA_VENCI		= cpfecven,--CONVERT(CHAR(12),cpfecven,103),  
	   INTERES			= (a.valor_contable) + isnull((select sum(valor_contable) from mdvi where vinumdocu = a.cpnumdocu and vicorrela = a.cpcorrela),0),   
	   OP_PROVENIENTE	= ' ',  
	   FAMILIA_SERIE	= ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = a.cpcodigo),''),  
	   GLOSA			= 'STOCK PROPIO     ',  
	   OPERACION		= 'STOCK TOTAL ' + (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = a.cptipcart AND tbcateg = '204'),  
	   orden			= 1,  
	   tip    = cptipcart,  
	 --  fecha_operacion = Fecha_pagomañana, --cpfeccomp  ,  
	 --  fecha_operacion = cpfeccomp  ,  
	   -- Esto es momentaneo ya que no se especifico en ningun momento que el nuevo calculo se deberia aplicar a la cartera  
	   -- de operaciones posterior al dia de instalacion 15/01/2007  
	   fecha_operacion	= CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN Fecha_pagomañana ELSE cpfeccomp END,  
	   tipoper			= 'CP'   ,  
	   valor_venc		= convert(float,0) ,  
	   fecha_pacto		= ''   ,  
	 --  dias  =  datediff(day,(CASE WHEN cpseriado = ''S'' THEN (CASE WHEN cpfecucup > Fecha_pagomañana And (Charindex(''*'', cpinstser)=0 And Charindex(''&'', cpinstser)=0 )  THEN cpfecucup ELSE Fecha_pagomañana END)  
	 --            ELSE Fecha_PagoMañana END) ,@dFecRep), --acfecproc),  
	 --  dias  =  datediff(day,(CASE WHEN cpseriado = ''S'' THEN (CASE WHEN cpfecucup > cpfeccomp And (Charindex(''*'', cpinstser)=0 And Charindex(''&'', cpinstser)=0 )  THEN cpfecucup ELSE cpfeccomp END)  
	 --            ELSE cpfeccomp END) ,@dFecRep), --acfecproc),  
	   -- Esto es momentaneo ya que no se especifico en ningun momento que el nuevo calculo se deberia aplicar a la cartera  
	   -- de operaciones posterior al dia de instalacion 15/01/2007  
	   dias				= CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') 
								THEN datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > Fecha_pagomañana And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE Fecha_pagomañana END) ELSE Fecha_PagoMañana END) ,@dFecRep)  
								ELSE datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > cpfeccomp And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE cpfeccomp END) ELSE cpfeccomp END) ,@dFecRep)  
							END,  
	   tipopero			= 'CP',  
	   valor_ini		= convert(numeric(19,4),0),  
	   OprRes			= 'STOCKCP',  
	   ModInv			= CASE WHEN cptipcart = 1 THEN 'T'   
							 WHEN cptipcart = 2 THEN 'A'  
							 WHEN cptipcart = 4 THEN 'H'  
							 ELSE 'P' END,  
	   ValorCont		= a.Valor_Contable + isnull((select sum(Valor_Contable) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),  
	   RutEmi			= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara ),0)  
							WHEN UPPER(cpseriado) = 'N' THEN ISNULL((SELECT nsrutemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela),0)  END),  
	   VerVp			= (CASE WHEN (EXISTS(Select * from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) Or cpnominal > 0) THEN ' ' ELSE 'X' END),  
	   monemi			= (CASE WHEN UPPER(cpseriado) = 'S' 
								THEN ISNULL((SELECT semonemi FROM VIEW_SERIE WHERE semascara = cpmascara),0) 
									WHEN UPPER(cpseriado) = 'N' 
										THEN ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela),0
							) END),  
	   FecaPagoOrig		= Fecha_pagomañana,  
	   Tasapacto		= 0.0,  
	   VctoPacto		= CPFECVEN  
	   ,'Volcker_Rule'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = Volcker_Rule AND tbcateg = '1623'),'')  
	   ,Flag			= IDENTITY(INT)  
	  INTO #PASO  
  FROM mdcp a,mdac  , VIEW_CLIENTE  
  WHERE (clrut = a.cprutcli and clcodigo = a.cpcodcli )  
                AND  (cpnominal>0 or EXISTS(Select * from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela))  
                  
 -- Se eliminan los instrumento que estan con nominal en 0 porque si no se encontro en la   
        -- tabla de ventas con pacto se asume que el papel esta vendido definitivo  
        delete #paso where VerVp = 'X' and Orden = 1  
  
  
        UPDATE #PASO  
  Set interes = interes/(CAse when COD_MONEDA = 999 OR COD_MONEDA = 13 Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN Fecha_Pagomañana ELSE cpfeccomp END
) End) -- CBG 18/08/2004  
        FROM Mdcp   
  WHERE numdocu = cpnumdocu and correla = cpcorrela and orden = 1  
  
  
 /*-- DISPONIBILIDAD   
  INSERT #PASO  
  SELECT NUMDOCU  = dinumdocu,  
   CORRELA   = dicorrela,  
   FECHA_EMISION  = 0,  
   SERIE   = RTRIM(diinstser)  + (case when Fecha_pagomañana > @dFecRep THEN ' *' ELSE '' END),  
   TCORRELA  = 2,  
   SERIADO         = ' ',  
   CODIGO_BOLSA   = 0,  
   NUM_CLI   = 0,  
   RUT_EMISOR      = 0,  
   COD_EMISOR  = 0,  
   NOM_EMISOR  = ' ',  
   CONTRATO  = 0,  
   NOM_MONEDA  = 0,  
   COD_MONEDA  = 0,  
   NOMINAL   = dinominal,   
   PRECIO_OP_UM = isnull(a.valor_contable,0),   
   PRECIO_OP  = isnull(a.valor_contable,0),  
   TASA_CON       = 0.0,  
   FECHA_VENCI    = '',  
   INTERES   = convert(float,0),  
   OP_PROVENIENTE = 0,  
   FAMILIA_SERIE   = diserie,  
   GLOSA           = 'DISPONIBILIDAD ',  
   OPERACION   = 'DISPONIBILIDAD ' + (CASE WHEN ditipoper = 'CI' THEN 'COMPRAS CON PACTO ' ELSE ' ' END)  
        + (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = ditipcart AND tbcateg = '204'),  
   orden   = (CASE WHEN ditipoper = 'CP' THEN 2 ELSE 4 END),  
   tip    = ditipcart             ,  
   fecha_operacion = '',  
   tipoper   = ditipoper,  
   valor_venc  = 0.0,---convert(float,0),  
   fecha_pacto  = '' ,  
   dias    =0   ,  
   tipopero  =ditipoper ,  
   valor_ini  = convert(numeric(19,4),0),  
   OprRes   = (CASE WHEN ditipoper= 'CP' THEN 'DISPOCP' ELSE 'DISPOCI' END),  
   ModInv   = CASE WHEN ditipoper= 'CP' THEN (CASE WHEN ditipcart = 1 THEN 'T'   
          WHEN ditipcart = 2 THEN 'A'  
          WHEN ditipcart = 4 THEN 'H'  
                   ELSE 'P'  
             END)  
        ELSE 'P' END,  
   ValorCont  = a.Valor_Contable,  
   RutEmi   = 0,  
   VerVp   = (CASE WHEN (EXISTS(Select * from mdvi Where vinumdocu = dinumdocu and vicorrela = dicorrela) Or dinominal > 0) THEN ' ' ELSE 'X' END),  
   monemi   = 0,  
   FecaPagoOrig    = Fecha_pagomañana,  
   Tasapacto       = 0.0,  
   VctoPacto  = difecsal  
   ,'Volcker_Rule' = ''  
  FROM MDDI a   
  WHERE Difecsal > @Fecproc  AND   
   dinominal>0  
*/  
 -- DISPONIBLE PROPIO  
 UPDATE #PASO  
 SET FECHA_EMISION  = CONVERT(CHAR(12), cpfecemi, 103),  
  RUT_EMISOR      = (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara),0)   
            ELSE ISNULL((SELECT nsrutemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela) ,0) END),  
  NUM_CLI  = ISNULL((SELECT Codigo_AS400 FROM VIEW_CLIENTE WHERE clrut = cprutcli and clcodigo = cpcodcli ),0),  
  COD_EMISOR  = cpcodcli,  
  CONTRATO = Isnull(Numero_Contrato,0),  
  COD_MONEDA = (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT semonemi FROM VIEW_SERIE WHERE semascara = cpmascara),0)   
     ELSE ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela) ,0) END),  
  TASA_CON       = isnull(tasa_contrato,0.0),  
  FECHA_VENCI    = cpfecven,--CONVERT(CHAR(12),cpfecven,103),  
--  FECHA_OPERACION = Fecha_Pagomañana,  
--  FECHA_OPERACION = cpfeccomp,  
  -- Esto es momentaneo ya que no se especifico en ningun momento que el nuevo calculo se deberia aplicar a la cartera  
  -- de operaciones posterior al dia de instalacion 15/01/2007  
  fecha_operacion = CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN Fecha_pagomañana ELSE cpfeccomp END,  
  valor_venc = convert(float,0),  
  fecha_pacto = '',  
--  dias  = datediff(day,(CASE WHEN cpseriado = ''S'' THEN (CASE WHEN cpfecucup > Fecha_pagomañana And (Charindex(''*'', cpinstser)=0 And Charindex(''&'', cpinstser)=0 )  THEN cpfecucup ELSE Fecha_pagomañana END)  
--            ELSE Fecha_PagoMañana END) ,@dFecRep), --acfecproc),  
--  dias  = datediff(day,(CASE WHEN cpseriado = ''S'' THEN (CASE WHEN cpfecucup > cpfeccomp And (Charindex(''*'', cpinstser)=0 And Charindex(''&'', cpinstser)=0 )  THEN cpfecucup ELSE cpfeccomp END)  
--            ELSE cpfeccomp END) ,@dFecRep), --acfecproc),  
  -- Esto es momentaneo ya que no se especifico en ningun momento que el nuevo calculo se deberia aplicar a la cartera  
  -- de operaciones posterior al dia de instalacion 15/01/2007  
  dias  = CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > Fecha_pagomañana And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE Fecha_pagomañana
 END) ELSE Fecha_PagoMañana END) ,@dFecRep)  
     ELSE  
         datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > cpfeccomp And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE cpfeccomp END) ELSE cpfeccomp END) ,@dFecRep)  
     END,  
  RutEmi  = (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara),0)   
            ELSE ISNULL((SELECT nsrutemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela) ,0) END),  
  SERIADO         = cpseriado  
 FROM mdcp,mdac  
 WHERE cpnumdocu = numdocu AND cpcorrela = correla AND orden = 2  
  
 DELETE #paso where VerVp = 'X' and Orden = 2  
  
  
 UPDATE #PASO  
 SET interes = a.valor_contable/ (Case When COD_MONEDA = 999 OR COD_MONEDA = 13 THEN 1 ELSE (Select vmvalor From View_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = CASE WHEN cpfeccomp <= CONVERT(DATETIME,'20070115') THEN a.Fecha_Pagomañana ELSE a
.cpfeccomp END) END)-- cpvalcomu -CBG 18/08/2004  
 FROM MDCP a,mdac  
 WHERE cpnumdocu = numdocu AND cpcorrela = correla AND orden = 2  
  
 /*  
--- Disponibilidades Pacto  
 UPDATE #PASO  
 SET FECHA_EMISION  = CONVERT(CHAR(12), cifecemi, 103),  
  RUT_EMISOR      = cirutcli,  
  COD_EMISOR = cicodcli,  
  NUM_CLI  = ISNULL((SELECT codigo_as400 FROM VIEW_CLIENTE WHERE clrut = cirutcli and clcodigo = cicodcli ),0),  
  CONTRATO = Isnull(Numero_Contrato,0),  
  COD_MONEDA = cimonpact,  
  TASA_CON       = isnull(citaspact,0.0),  
  FECHA_VENCI    = cifecven,--CONVERT(CHAR(12),cifecven,103),  
  FECHA_OPERACION = cifecinip,  
  valor_venc = CASE WHEN nominal = 0 Then 0 ELSE ((nominal * civalvenp) /cinominal) END,  
  fecha_pacto = cifecvenp,--convert(char(10),cifecvenp,112),  
  dias  = datediff(day,cifecinip,@dFecRep), --acfecproc),  
  interes  = CASE WHEN nominal = 0 Then 0 ELSE (nominal*civalinip)/(Isnull((Select sum(vinominal) From Mdvi Where vinumdocu = cinumdocu and vicorrela = cicorrela) ,cinominal)) END,  
  Tasapacto       = citaspact,  
  VctoPacto = cifecvenp,  
                SERIADO         = ciseriado,  
  PRECIO_OP_UM = civalinip, --  + isnull((select sum(vivalinip) from mdvi where cinumdocu = vinumdocu and cicorrela = vicorrela),0),  
  PRECIO_OP = isnull(civalinip,0) -- + isnull((select sum(vivalinip) from mdvi where cinumdocu = vinumdocu and cicorrela = vicorrela),0),    
 FROM MDCI,mdac  
 WHERE cinumdocu = numdocu AND cicorrela = correla AND orden = 4   
 */  
   
--calculo de interes disponibilidad propia  
 UPDATE #PASO SET PRECIO_OP_UM  = Round(isnull((precio_op  / (CASE WHEN COD_MONEDA = 999 OR COD_MONEDA = 13 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = fecha_operacion) END)),0), (CASE WHEN COD_MONEDA = 999
 Then 0 ELSE 4 END)), --CBG 18/08/2004)  ,  
   INTERES   = round(  interes * tasa_con / 36000 * (1+dias)  , (CASE WHEN COD_MONEDA = 999 then 0 ELSE 4 END) )  
 WHERE (orden = 2  or orden = 1)  
  
 UPDATE #PASO SET --INTERES  = Round( interes * tasa_con / CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 END * (1+dias) , CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END ), -- Round((interes * ((tasa_con * (1+dias)) / (CASE WHEN COD_MONEDA = 999 THEN 3000 
--ELSE 36000 END) )),CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END),  
     PRECIO_OP_UM  = isnull((interes  / (CASE WHEN cod_moneda = 999 OR cod_moneda = 13 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = @fecproc) END)),0) -- CBG 18/08/2004  
 WHERE orden = 3 Or Orden = 4  
  
  
 UPDATE #PASO SET INTERES  = Round( PRECIO_OP_UM * tasa_con / CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 END * (1+dias) , CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END ) --CBG REVISAR PARA DOLARES  
--     PRECIO_OP_UM  = isnull((precio_op  / (CASE WHEN cod_moneda = 999 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = @fecproc) END)),0)  
 WHERE orden = 3 Or Orden = 4  
  
-- UPDATE #PASO SET  
--      INTERES  = Round(interes * tasa_con / CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 END * (1+dias), CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END ), -- , round((interes * ((tasa_con * (1+dias)) / (CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 E
--ND)  )),CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END),  
--    PRECIO_OP  = isnull((precio_op_um  * (CASE WHEN cod_moneda = 999 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = @fecproc) END)),0)-- WHERE orden = 4   
  
 UPDATE #PASO SET NOM_EMISOR = CONVERT(CHAR(50),clnombre) FROM VIEW_CLIENTE  WHERE CONVERT(NUMERIC(15),RUT_EMISOR) = clrut and clcodigo = cod_emisor and orden in(3,4,5,6)  
 UPDATE #PASO SET NOM_EMISOR = CONVERT(CHAR(50),emnombre) FROM VIEW_EMISOR  WHERE CONVERT(NUMERIC(15),RUT_EMISOR) = emrut and orden not in (3,4,5,6)  
 UPDATE #PASO SET NOM_MONEDA = mnnemo FROM VIEW_MONEDA WHERE COD_MONEDA = mncodmon  
  
 -- VMGS Se debe eliminar de este reporte las letras de credito hiopotecarias propia emision debido a la nueva normativa  
        -- contable (Octubre del 2002)  
 -- *******************************************************************************************  
        DELETE #PASO WHERE SUBSTRING (SERIE,1,3) = 'ITA' AND FAMILIA_SERIE = 'LCHR'  
 -- *******************************************************************************************  
  
 SELECT  numdocu,   
  FECHA_EMISION = CASE WHEN Seriado = 'N' THEN '  /  /    ' ELSE FECHA_EMISION END,  
  SERIE,  
  SERIADO,  
  CODIGO_BOLSA,  
  NUM_CLI ,  
  RUT_EMISOR,  
  NOM_EMISOR,  
  CONTRATO,  
  NOM_MONEDA,  
  COD_MONEDA,  
  NOMINAL,  
  PRECIO_OP_UM ,  
  PRECIO_OP ,  
  TASA_CON,  
  FECHA_VENCI,  
  INTERES,  
  OP_PROVENIENTE,  
  FAMILIA_SERIE = (CASE WHEN 'ITA' = (SELECT SUBSTRING (SERIE,1,3)) AND FAMILIA_SERIE = 'LCHR' THEN 'LCHR BOSTON' ELSE FAMILIA_SERIE END),  
  GLOSA,  
  OPERACION,  
  'HORA'    = CONVERT(CHAR(8),getdate(),108),  
                orden,  
  CLAVE = (CASE WHEN 'ITA' = (SELECT SUBSTRING (SERIE,1,3)) AND FAMILIA_SERIE = 'LCHR' THEN 'LCHR BOSTON' ELSE FAMILIA_SERIE END) + ' '  +  convert(char(2),tip) + ' ' + convert(char(1),orden),  
  fecha_operacion,  
  tipoper,  
  'acfecproc' = @dFecRep, --acfecproc,  
  valor_venc,  
  fecha_pacto,  
  dias  ,  
  tipopero ,  
  tip  ,  
  valor_ini ,  
  Tasapacto ,  
  ModInv  ,  
                'NomProp' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --@acnomprop    
                'RutProp' = Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop,  
  VctoPacto,  
  OprRes,  
  TotMonNomi_CLP = CONVERT(Float,0),  
  TotMonValIni_Um_CLP = CONVERT(Float,0),  
  TotMonValIni_Pe_CLP = CONVERT(Float,0),  
  TotMonVinicial_CLP  = CONVERT(Float,0),  
  TotMonValVcto_CLP   = CONVERT(Float,0),  
  TotMonInteres_CLP   = CONVERT(Float,0),  
  
  TotMonNomi_UF = CONVERT(Float,0),  
  TotMonValIni_Um_UF = CONVERT(Float,0),  
  TotMonValIni_Pe_UF = CONVERT(Float,0),  
  TotMonVinicial_UF  = CONVERT(Float,0),  
  TotMonValVcto_UF   = CONVERT(Float,0),  
  TotMonInteres_UF   = CONVERT(Float,0),  
  
  TotMonNomi_DO = CONVERT(Float,0),  
  TotMonValIni_Um_DO = CONVERT(Float,0),  
  TotMonValIni_Pe_DO = CONVERT(Float,0),  
  TotMonVinicial_DO  = CONVERT(Float,0),  
  TotMonValVcto_DO   = CONVERT(Float,0),  
  TotMonInteres_DO   = CONVERT(Float,0),  
  
  TotMonNomi_USD = CONVERT(Float,0),  
  TotMonValIni_Um_USD = CONVERT(Float,0),  
  TotMonValIni_Pe_USD = CONVERT(Float,0),  
  TotMonVinicial_USD  = CONVERT(Float,0),  
  TotMonValVcto_USD   = CONVERT(Float,0),  
  TotMonInteres_USD   = CONVERT(Float,0),  
  
  TotMonNomi_BCCH = CONVERT(Float,0),  
  TotMonValIni_Um_BCCH = CONVERT(Float,0),  
  TotMonValIni_Pe_BCCH = CONVERT(Float,0),  
  TotMonVinicial_BCCH  = CONVERT(Float,0),  
  TotMonValVcto_BCCH   = CONVERT(Float,0),  
  TotMonInteres_BCCH   = CONVERT(Float,0)  
  ,Volcker_Rule  
 into #paso1   
 FROM #PASO a,mdac  
   WHERE CHARINDEX(OprRes,'VENTACP -VENTACI') = 0  
 ORDER BY  orden,operacion,FAMILIA_SERIE,OprRes,Modinv,FECHA_VENCI--TCORRELA  
  
  SELECT  Clave1 = clave ,  
   rut   = 1 ,  
   cod_moneda1 = 0,  
   nominal1 = sum(nominal),  
   op_um1  = sum(precio_op_um)  ,   
   op1   = sum(precio_op)     ,  
   valor_ini1 = sum (valor_ini)    ,  
   valor_venc1 = sum(valor_venc)  ,  
   interes1    = sum(interes)       
  INTO #totales  
  FROM #paso1  
  WHERE rut_emisor =97029000 and orden in(5,6)  
  GROUP BY clave  
  ORDER BY clave  
  
  INSERT INTO #totales  
  SELECT  clave ,  
   rut = 0 ,  
   cod_moneda ,  
   nominal= sum(nominal)   ,  
   op_um = sum(precio_op_um)   ,  
   op = sum(precio_op)      ,    
   valor_ini = sum (valor_ini)     ,  
   valor_venc = sum(valor_venc) ,  
   interes    = sum(interes)   
  FROM #paso1  
  WHERE rut_emisor <> 97029000 and orden in(3,4,5,6)  
  GROUP BY clave ,cod_moneda   
  ORDER BY clave ,cod_moneda   
  
  UPDATE #Paso1  
  SET TotMonNomi_CLP = nominal1,  
   TotMonValIni_Um_CLP = op_um1,  
   TotMonValIni_Pe_CLP = op1,  
   TotMonVinicial_CLP  = valor_ini1,  
   TotMonValVcto_CLP   = valor_venc1,  
   TotMonInteres_CLP   = interes1  
  FROM #totales  
  WHERE clave = Clave1 and cod_moneda1 = 999  
    
  UPDATE #Paso1  
  SET TotMonNomi_UF = nominal1,  
   TotMonValIni_Um_UF = op_um1,  
   TotMonValIni_Pe_UF = op1,  
   TotMonVinicial_UF  = valor_ini1,  
   TotMonValVcto_UF   = valor_venc1,  
   TotMonInteres_UF   = interes1  
  FROM #totales  
  WHERE clave = Clave1 and cod_moneda1 = 998  
  
  UPDATE #Paso1  
  SET  TotMonNomi_DO = nominal1,  
   TotMonValIni_Um_DO = op_um1,  
   TotMonValIni_Pe_DO = op1,  
   TotMonVinicial_DO  = valor_ini1,  
   TotMonValVcto_DO   = valor_venc1,  
   TotMonInteres_DO   = interes1  
  FROM #totales  
  WHERE clave = Clave1 and cod_moneda1 = 994  
  
  UPDATE #Paso1  
  SET  TotMonNomi_USD = nominal1,  
   TotMonValIni_Um_USD = op_um1,  
   TotMonValIni_Pe_USD = op1,  
   TotMonVinicial_USD  = valor_ini1,  
   TotMonValVcto_USD   = valor_venc1,  
   TotMonInteres_USD   = interes1  
  FROM #totales  
  WHERE clave = Clave1 and cod_moneda1 = 13  
  
  UPDATE #Paso1  
  SET  TotMonNomi_BCCH = nominal1,  
   TotMonValIni_Um_BCCH = op_um1,  
   TotMonValIni_Pe_BCCH = op1,  
   TotMonVinicial_BCCH  = valor_ini1,  
   TotMonValVcto_BCCH   = valor_venc1,  
   TotMonInteres_BCCH   = interes1  
  FROM #totales  
  WHERE clave = Clave1 and cod_moneda1 = 0 and Rut = 1  
  
  DELETE #Paso Where SUBSTRING(OprRes,1,5) = 'DISPO'  
  
  
  SELECT @nCont = Max(Flag) From #Paso --WHERE right(SERIE,1) <> ''*''  -- Excluye del resumen contable las operaciones PM  
  SELECT @n = Min(Flag) from #Paso --WHERE right(SERIE,1) <> ''*'' -- Excluye del resumen contable las operaciones PM  
--  SELECT @n, @nCont  
  
  WHILE @n <= @nCont  
   BEGIN  
   SELECT @cEstado = '*'  
   SELECT @nValOpePe=0,@nValCont=0,@nNominal=0,@ValVen = 0,@Valini=0 -- CBG  
   SELECT @xSistema = 'BTR',  
          @xTipoMov = 'MOV',  
          @TipOpe   = (CASE WHEN CharIndex(OprRes,'INTERCP ') > 0 THEN 'CP'   
                            ELSE (CASE WHEN CharIndex(OprRes,'INTERCI ') > 0 THEN 'CZZZZ' ELSE tipoper END)   
                            END),  
   @codins   = Ltrim(Rtrim(FAMILIA_SERIE)) + CASE WHEN FAMILIA_SERIE = 'LCHR' THEN (CASE WHEN RUT_EMISOR = @nRutcart THEN 'BO' ELSE 'DI' END) ELSE '' END,  
   @xMoneda  = CASE WHEN CHARINDEX(OprRes,'STOCKCP -INTERCP ') > 0 THEN monemi ELSE (CASE WHEN CHARINDEX(OprRes,'STOCKCI -VENTACI -INTERCI -VENTACP ') > 0  THEN COD_MONEDA ELSE 0 END) END ,  
   @TipoCartera = CONVERT(CHAR(01),LTRIm(RTRIM(ModInv))),  
   @xRutCli     = RUT_EMISOR,  
   @cRtEm        =RutEmi,  
   @xCodCli     = COD_EMISOR,  -- (Select clcodigo From View_Cliente Where Clrut = RUT_EMISOR And ),  
   @dFecini     = Fecha_Operacion,  
   @dFecFin     = Fecha_pacto,  
   @xGarantia   = 'N',  
   @NumDocu     = NUMDOCU,  
   @Correla     = CORRELA,  
   @cOpe        = OprRes,  
   @nValCont    = PRECIO_OP_UM, -- ValorCont,  
   @nValOpePe   = PRECIO_OP,  
   @nNominal    = Nominal,  
   @dFecinicial = FECHA_OPERACION,  
   @Valini      = valor_ini,  
   @ValVen      = valor_venc,  
   @xMonemi     = monemi,  
   @cEstado = ' '  
   FROM #PASO  
   WHERE Flag = @n   
  
   SELECT @cCond = ''  
  
   If CharIndex(@TipOpe,'CP   ') > 0  OR @cOpe = 'INTERCP' Begin --  OR @cOpe = ''VENTACP'' Begin  
 SELECT @cCondi = CASE WHEN @xRutCli = 97029000 and @cOpe = 'INTERGA' THEN '0' ELSE (Select Isnull(Emtipo,'') From view_emisor Where emrut = @cRtEm) END  
  
   End Else Begin  
  EXECUTE dbo.sp_cond_vi @Tipope,@xRutCli,@xCodCli,@dFecini,@dFecFin,@xGarantia,@cCondi OUTPUT  
   End  
  
   SELECT @cCondi = CASE WHEN LEN(@cCondi) = 0 THEN '0' ELSE @cCondi END  
  
   SELECT @cCond = CASE WHEN CONVERT(NUMERIC(2),@cCondi) <= 9 THEN ' '+ltrim(rtrim(@cCondi)) ELSE ltrim(rtrim(@cCondi)) END  
   SELECT @cCustodia = CASE WHEN CHARINDEX(@cOpe,'INTERCP -STOCKCP -VENTACP -STOCKCI -VENTACI ') > 0 THEN '1' ELSE '2' END  
   SELECT @indice = 1  
  
   SELECT @cLlave = ''  
  
   SELECT @cLlave = CASE WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+Space(6)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN  
    @cOpe+Space(6)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia  
         WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+CONVERT(CHAR(06),@codins)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN  
    @cOpe+CONVERT(CHAR(06),@codins)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia  
         WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+CONVERT(CHAr(06),@codins)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia) ) THEN  
    @cOpe+CONVERT(CHAr(06),@codins)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia  
         WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+Space(6)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia) )THEN  
    @cOpe+Space(6)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia  
         WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+Space(6)+@TipoCartera+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN  
    @cOpe+Space(6)+@TipoCartera+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia  
         WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+CONVERT(CHAR(06),@codins)+' '+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN  
    @cOpe+CONVERT(CHAR(06),@codins)+' '+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia  
      END  
  
   SELECT *,'Filas'=IDENTITY(INT) INTO #TmpCta  
   FROM saldos_Cartera WHERE LLAVE = @cLlave  
  
   IF CHARINDEX(@cOpe,'INTERCI -STOCKCI -VENTACI ') > 0 Begin  
    DECLARE  @cLlaveDos CHAR(21)  
 SELECT @cLlaveDos = ''  
    SELECT @cCustodia = '2'  
 select @xMoneda = @xMonemi  
  
    SELECT @cLlaveDos = CASE WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+Space(6)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN  
    @cOpe+Space(6)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia  
         WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+CONVERT(CHAR(06),@codins)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN  
    @cOpe+CONVERT(CHAR(06),@codins)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia  
         WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+CONVERT(CHAr(06),@codins)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia) ) THEN  
    @cOpe+CONVERT(CHAr(06),@codins)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia  
         WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+Space(6)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia) )THEN  
    @cOpe+Space(6)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia  
         WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+Space(6)+@TipoCartera+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN  
    @cOpe+Space(6)+@TipoCartera+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia  
         WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+CONVERT(CHAR(06),@codins)+' '+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN  
    @cOpe+CONVERT(CHAR(06),@codins)+' '+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia  
      END  
  
    INSERT #TmpCta  
    SELECT * FROM saldos_Cartera WHERE LLAVE = @cLlavedos  
   End  
   SELECT @nValMon = CASE WHEN @xMoneda = 999 THEN 1   
     WHEN @xMoneda = 13  THEN Isnull((SELECT vmvalor FROM View_VALOR_MONEDA Where vmcodigo =994 ANd vmfecha =@dFecinicial),1)  -- VGS (17/08/2005)  
   ELSE Isnull((SELECT vmvalor FROM View_VALOR_MONEDA Where vmcodigo =@xMoneda ANd vmfecha =@dFecinicial),1) END --CBG 18/08/2004  
  
   SELECT @nReg = COUNT(*) FROM #TmpCta  
   SELECT @nn = 1  
  
   WHILE @nn <= @nReg BEGIN  
  
 SELECT @cEstado = '*'  
 SELECT @cCampoVar = Upper(NMONTO),  
        @nmoneda   = UMMONTO,  
        @cNumcta   = Cuenta,  
        @cLlave     = Llave,  
       @cEstado  = ' '  
 FROM #TmpCta  
 WHERE Filas = @nn  
  
  
 If @cEstado = '*' BREAK   
  
 SELECT @nMtoPe = 0  
  
 if Not (@xRutCli = 97029000 and @cOpe = 'INTERCP') Begin  
-- if Not (@xRutCli = 97029000 and CHARINDEX(@cLlave,''INTERCP'')>0 ) Begin  
  SELECT @nMtoPe = CASE WHEN @cCampoVar = 'VALCONU'  THEN @nValCont-- @nValCont/@nValMon  
       WHEN @cCampoVar = 'VALCONP'  THEN @nValOpePe -- @nValCont -- @nValCont  
    WHEN @cCampoVar = 'NOMINAL'  THEN @nNominal  
    WHEN @cCampoVar = 'NOMINALP' THEN Round(@nNominal*@nValMon,0)  
    WHEN @cCampoVar = 'VALINIC'  THEN @nValCont-- @Valini  
    WHEN @cCampoVar = 'VALINIP'  THEN @Valini END  
          
  
  UPDATE saldos_cartera  
  SET Saldo = Saldo + @nMtoPe  
  WHERE Llave = @cLlave AND NMONTO = @cCampoVar AND UMMONTO = @nmoneda AND Cuenta = @cNumcta  
 end  
        select @nn= @nn +1  
   End  
   drop table #TmpCta  
   SELECT @n = @n +1  
  End  
  
  DECLARE @COUNT INt
  SET @COUNT = (SELECT COUNT(*) from #paso1)


  IF @COUNT <> 0
  BEGIn


  SELECT * from #paso1  ORDER BY CLAVE,OprRes,ModInv,VctoPacto,fecha_operacion   

  END

  ELSE

  BEGIN

   SELECT  numdocu = '',   
  FECHA_EMISION = '',
  SERIE = '',  
  SERIADO = '',  
  CODIGO_BOLSA = '',  
  NUM_CLI  = '',  
  RUT_EMISOR = '',  
  NOM_EMISOR = '',  
  CONTRATO = '',  
  NOM_MONEDA = '',  
  COD_MONEDA = '',  
  NOMINAL = '',  
  PRECIO_OP_UM  = '',  
  PRECIO_OP  = '',  
  TASA_CON = '',  
  FECHA_VENCI = '',  
  INTERES = '',  
  OP_PROVENIENTE = '',  
  FAMILIA_SERIE  = '',  
  GLOSA = '',  
  OPERACION = '',  
  'HORA'    =   '',  
                orden = '',  
  CLAVE   = '',
  fecha_operacion = '',  
  tipoper = '',  
  'acfecproc' =  '',  
  valor_venc = '',  
  fecha_pacto = '',  
  dias   = '',  
  tipopero  = '',  
  tip   = '',  
  valor_ini  = '',  
  Tasapacto  = '',  
  ModInv   = '',  
                'NomProp' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --@acnomprop    
                'RutProp' =  ''  ,
  VctoPacto = '',  
  OprRes = '',  
  TotMonNomi_CLP      =   '',  
  TotMonValIni_Um_CLP =   '',  
  TotMonValIni_Pe_CLP =   '',  
  TotMonVinicial_CLP  =   '',  
  TotMonValVcto_CLP   =   '',  
  TotMonInteres_CLP   =   '',  
  
  TotMonNomi_UF       = '',  
  TotMonValIni_Um_UF  = '',  
  TotMonValIni_Pe_UF  = '',  
  TotMonVinicial_UF   = '',  
  TotMonValVcto_UF    = '',  
  TotMonInteres_UF    = '',  
  
  TotMonNomi_DO       = '',  
  TotMonValIni_Um_DO  = '',  
  TotMonValIni_Pe_DO  = '',  
  TotMonVinicial_DO   = '',  
  TotMonValVcto_DO    = '',  
  TotMonInteres_DO    = '',  
  
  TotMonNomi_USD       = '',  
  TotMonValIni_Um_USD  = '',  
  TotMonValIni_Pe_USD  = '',  
  TotMonVinicial_USD   = '',  
  TotMonValVcto_USD    = '',  
  TotMonInteres_USD    = '',  
  
  TotMonNomi_BCCH       = '',  
  TotMonValIni_Um_BCCH  = '',  
  TotMonValIni_Pe_BCCH  = '',  
  TotMonVinicial_BCCH   = '',  
  TotMonValVcto_BCCH    = '',  
  TotMonInteres_BCCH    = ''  
  ,Volcker_Rule  = ''


  END







  
END  

GO
