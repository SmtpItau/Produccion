USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETA_COMPRAS_PROPIA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_PAPELETA_COMPRAS_PROPIA '20190618',218105,'P'
CREATE PROCEDURE [dbo].[SP_PAPELETA_COMPRAS_PROPIA]
   (   @dFechacartera DATETIME  
   ,   @nNumoper      FLOAT    
   ,   @cTipoImp      CHAR(01)   
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @nRutcart      FLOAT  
   ,       @Cat_CartFin   CHAR(10)  
   ,       @Cat_CartNorm  CHAR(10)  
   ,       @Cat_Libro     CHAR(10)  
  
   SELECT  @nRutcart      = acrutprop  
   ,       @Cat_CartFin   = '204'  
   ,       @Cat_CartNorm  = '1111'  
   ,       @Cat_Libro     = '1552'  
   FROM    MDAC  
  
   /*=======================================================================*/  
   DECLARE @Firma1 char(15)  
   DECLARE @Firma2 char(15)  
  
   SELECT  @Firma1          = Firma1  
   ,       @Firma2          = Firma2  
   FROM    BacLineas..detalle_aprobaciones  
   WHERE   Numero_Operacion = @nNumoper  
   /*=======================================================================*/  
  
   DECLARE @iOperDia     INTEGER  
  
   SELECT  @iOperDia     = 1  
   SELECT  @iOperDia     = 0  
   FROM    MDMO  
   WHERE   monumoper     = @nNumoper  
 and motipoper    = 'CP'  
  
   DECLARE @cFecEmi          VARCHAR(40)   
   ,       @nDiaSem          INTEGER  
   ,       @nDia             INTEGER  
   ,       @nMes             INTEGER  
   ,       @nAnn             INTEGER  
   ,       @tipcart          CHAR(25)  
   ,       @Forpa            CHAR(25)  
   ,       @Tipocli          CHAR(25)  
   ,       @Tipcli           NUMERIC(05)  
   ,       @Tipret           CHAR(15)  
   ,       @Rutcli           NUMERIC(9,0)  
   ,       @Codcli           NUMERIC(9,0)  
   ,       @Nomcli           CHAR(40)  
   ,       @Dircli           CHAR(40)  
   ,       @Foncli           CHAR(15)  
   ,       @Faxcli           CHAR(15)  
   ,       @Obser            CHAR(70)  
   ,       @Nomoper          CHAR(40)  
   ,       @DigVeri          CHAR(01)  
   ,       @Nompro           VARCHAR(40)  
   ,       @Rutpro           CHAR(12)  
   ,       @Fecpro           VARCHAR(10)  
   ,       @Dirpro           VARCHAR(40)  
   ,       @Cust             CHAR(15)  
   ,       @claveDCV         CHAR(15)  
   ,       @Total            NUMERIC(19,2)  
   ,       @NumSol           NUMERIC(9,0)  
   ,       @linea1           CHAR(255)  
   ,       @linea2           CHAR(255)  
   ,       @linea3           CHAR(255)  
   ,       @linea4           CHAR(255)  
   ,       @linea5           CHAR(255)  
   ,       @glocopia         CHAR(25)  
   ,       @nCopia           INTEGER  
   ,       @Pagina           INTEGER  
   ,       @nTotPagina       INTEGER  
   ,       @contador         NUMERIC(19,0)  
   ,       @contador2        NUMERIC(19,0)  
   ,       @nMtoComi         NUMERIC(19,0)  
   ,       @fComision        FLOAT  
   ,       @nIva             NUMERIC(19,0)  
   ,       @hora             CHAR(8)  
   ,       @cSettlement      CHAR(50)  
   ,       @cPFE             CHAR(50)  
   ,       @cCCE             CHAR(50)  
   ,       @cEmisorInstPlazo CHAR(255)  
   ,       @MtoEsc           VARCHAR(100)  
   ,       @EstadoPeracion   VARCHAR(100)  
   ,       @Codmon           NUMERIC(3)  
   ,       @Fecprox      DATETIME   
  
   DECLARE @nCodEsc         NUMERIC(03,0)  
   DECLARE @NumeroCorre_Detalle INTEGER  
   DECLARE @nMontoError         NUMERIC(19,4)  
   DECLARE @cMontoFMT           CHAR(20)  
  
   DECLARE @iRegistro           INTEGER  
   ,       @iRegistros          INTEGER  
   ,       @iContador           INTEGER  
   ,       @iPagina             INTEGER  
  
   SELECT 'acfecproc'   = acfecproc  
   ,      'acfecprox'   = acfecprox  
   ,      'uf_hoy'      = CONVERT(FLOAT, 0)  
   ,      'uf_man'      = CONVERT(FLOAT, 0)  
   ,      'ivp_hoy'     = CONVERT(FLOAT, 0)  
   ,      'ivp_man'     = CONVERT(FLOAT, 0)  
   ,      'do_hoy'      = CONVERT(FLOAT, 0)  
   ,      'do_man'      = CONVERT(FLOAT, 0)  
   ,      'da_hoy'      = CONVERT(FLOAT, 0)  
   ,      'da_man'      = CONVERT(FLOAT, 0)  
   ,      'pmnomprop'   = acnomprop  
   ,      'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop  
   ,      'Firma1'      = @Firma1  
   ,    'Firma2'      = @Firma2   
  INTO    #PARAMETROS  
   FROM    MDAC  
  
   CREATE TABLE #paso_error   
   (   Mensaje_Error       VARCHAR(255)  
   ,   Monto               NUMERIC(19,4)  
   ,   sw                  CHAR(1)  
   ,   NumeroCorre_Detalle NUMERIC(19,0) Identity(1,1)  
   )  
  
   SELECT @Fecprox = acfecprox FROM MDAC  
  
   /* RESCATA VALOR DE UF -------------------------------------------------------------- */  
   UPDATE #PARAMETROS SET uf_hoy     = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
     FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
    WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc  
      AND VIEW_VALOR_MONEDA.vmcodigo = 998  
  
   UPDATE #PARAMETROS SET uf_man     = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
     FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
    WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox  
      AND VIEW_VALOR_MONEDA.vmcodigo = 998  
  
   /* RESCATA VALOR DE IVP ------------------------------------------------------------- */  
   UPDATE #PARAMETROS SET ivp_hoy    = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
     FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
    WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc  
      AND VIEW_VALOR_MONEDA.vmcodigo = 997  
  
   UPDATE #PARAMETROS SET ivp_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
     FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
    WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox  
      AND VIEW_VALOR_MONEDA.vmcodigo = 997  
  
   /* RESCATA VALOR DE DO -------------------------------------------------------------- */  
   UPDATE #PARAMETROS SET do_hoy     = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
     FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
    WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc  
      AND VIEW_VALOR_MONEDA.vmcodigo = 994  
  
   UPDATE #PARAMETROS SET do_man     = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
     FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
    WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox  
      AND VIEW_VALOR_MONEDA.vmcodigo = 994  
  
   /* RESCATA VALOR DE DA -------------------------------------------------------------- */  
   UPDATE #PARAMETROS SET da_hoy     = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
     FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
    WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc  
      AND VIEW_VALOR_MONEDA.vmcodigo = 995  
  
   UPDATE #PARAMETROS SET da_man     = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)  
     FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA  
    WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox  
      AND VIEW_VALOR_MONEDA.vmcodigo = 995  
  
   IF @cTipoImp='P'  
      SELECT @nCopia = papapimp FROM MDPA WHERE panumoper=@nNumoper  
   ELSE  
      SELECT @nCopia = paconimp FROM MDPA WHERE panumoper=@nNumoper  
  
   IF @cTipoImp='P'  
      SELECT @nTotPagina = 16  
   ELSE  
      SELECT @nTotPagina = 23  
  
   IF @cTipoImp='P'  
      SELECT @glocopia = CASE WHEN @nCopia=1 THEN 'COPIA MESA'  
                              WHEN @nCopia=2 THEN 'COPIA INVERSIONES'  
                              WHEN @nCopia=3 THEN 'COPIA CUSTODIA'  
                              ELSE ' '  
                         END  
   ELSE  
      SELECT @glocopia = CASE WHEN @nCopia=1 THEN 'ORIGINAL CLIENTE'  
                              WHEN @nCopia=2 THEN 'COPIA CLIENTE'  
                              ELSE ' '  
                         END  
  
IF @iOperDia = 0  
BEGIN  
   SELECT @Obser          = ISNULL(moobserv,'')       
   ,      @linea1         = ISNULL(moobserv2,'')       
   ,      @Rutcli         = ISNULL(morutcli,0)       
   ,      @Codcli         = ISNULL(mocodcli,0)       
   ,      @Tipret         = CASE motipret WHEN 'I' THEN 'VIENEN' ELSE 'VAMOS' END  
   ,      @Nomoper        = nombre        
   ,      @Nompro         = ISNULL(acnomprop,'')       
   ,      @Rutpro         = STR(acrutprop)+'-'+acdigprop      
   ,      @Dirpro         = ISNULL(acdirprop,'')       
   ,      @Fecpro         = CONVERT(CHAR(10),acfecproc,103)     
   ,      @nMtoComi       = ISNULL(momtocomi,0)       
   ,      @fComision      = accomision/CONVERT(FLOAT,100)      
   ,      @nIva           = ISNULL(momtocomi,0)       
   ,      @hora           = mohora        
   ,      @EstadoPeracion = CASE mostatreg WHEN 'P' THEN 'OPERACION PENDIENTE DE APROBACION' ELSE '' END   
   ,      @Forpa          = glosa   
   ,      @nDiaSem        = DATEPART(WEEKDAY,mofecpro)   
   ,      @nDia           = DATEPART(DAY,mofecpro)   
   ,      @nMes           = DATEPART(MONTH,mofecpro)   
   ,      @nAnn           = DATEPART(YEAR,mofecpro)  
   FROM   MDMO  
          INNER JOIN BacParamSuda..USUARIO       ON mousuario = SUBSTRING(usuario,1,12)  
          LEFT  JOIN BacParamSuda..FORMA_DE_PAGO ON codigo = moforpagi  
   ,      MDAC  
   WHERE  monumoper       = @nNumoper   
   AND    morutcart       = @nRutcart   
   AND    motipoper       = 'CP'   
  
   SELECT @Total    = (SELECT SUM(movalcomp) FROM MDMO WHERE monumoper = @nNumoper AND morutcart = @nRutcart AND motipoper = 'CP')  
  
   IF @nMes= 1 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Enero de '     + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 2 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Febrero de '   + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 3 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Marzo de '     + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 4 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Abril de '     + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 5 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Mayo de '      + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 6 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Junio de '     + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 7 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Julio de '     + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 8 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Agosto de '    + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 9 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+ CONVERT(CHAR(4),@nAnn)  
   IF @nMes=10 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Octubre de '   + CONVERT(CHAR(4),@nAnn)  
   IF @nMes=11 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' + CONVERT(CHAR(4),@nAnn)  
   IF @nMes=12 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' + CONVERT(CHAR(4),@nAnn)  
  
   IF @nDiaSem=1 SELECT @cFecEmi = 'Domingo '  + @cFecEmi  
   IF @nDiaSem=2 SELECT @cFecEmi = 'Lunes '    + @cFecEmi  
   IF @nDiaSem=3 SELECT @cFecEmi = 'Martes '   + @cFecEmi  
   IF @nDiaSem=4 SELECT @cFecEmi = 'Miercoles '+ @cFecEmi  
   IF @nDiaSem=5 SELECT @cFecEmi = 'Jueves '   + @cFecEmi  
   IF @nDiaSem=6 SELECT @cFecEmi = 'Viernes '  + @cFecEmi  
   IF @nDiaSem=7 SELECT @cFecEmi = 'Sabado '   + @cFecEmi  
  
   SELECT @NumSol   = monsollin   
   ,      @Codmon   = MOMONEMI  
   FROM   MDMO   
   WHERE  monumoper = @nNumoper  
   AND    morutcart = @nRutcart  
   AND    motipoper = 'CP'  
  
   SELECT @linea2 = ' '   
   ,      @linea3 = ' '   
   ,      @linea4 = ' '  
  
   SELECT @Nomcli  = clnombre  
   ,      @Dircli  = cldirecc  
   ,      @Foncli  = clfono  
   ,      @Faxcli  = clfax  
   ,      @Tipcli  = cltipcli  
   ,      @Digveri = ISNULL(cldv,' ')  
   FROM   VIEW_CLIENTE  
   WHERE  clrut    = @Rutcli  
   AND    clcodigo = @Codcli  
  
   IF @nMtoComi = 0  
      SELECT @nIva      = 0   
      ,      @nMtoComi  = 0   
      ,      @fComision = 0  
  
   SELECT @Tipocli  = tbglosa     
   ,      @nMtoComi = ROUND(@Total*@fComision,0)  
   FROM   VIEW_TABLA_GENERAL_DETALLE  
   WHERE  tbcateg   = 207   
   AND    CONVERT(INTEGER,tbcodigo1) = CONVERT(INTEGER,@Tipcli)  
  
   EXECUTE SP_PAPELETA_LIMITES 'CP' , @nNumoper , @cSettlement OUTPUT , @cPFE OUTPUT , @cEmisorInstPlazo OUTPUT , @cCCE OUTPUT   
  
   SELECT @nCodEsc = CASE WHEN @Codmon = 13 THEN @Codmon ELSE 999 END  
  
   EXECUTE SP_MONTOESCRITO_MONEDA @Total, @MtoEsc OUTPUT, @nCodEsc  
  
   WHILE 1=1  
   BEGIN  
      SET ROWCOUNT 1  
      SELECT @NumeroCorre_Detalle = 0  
      SELECT @NumeroCorre_Detalle = NumeroCorre_Detalle  
      ,      @nMontoError         = Monto  
      FROM   #paso_error  
      WHERE  sw                   = 'N'  
  
      SET ROWCOUNT 0  
      IF @NumeroCorre_Detalle = 0   
         BREAK  
  
      EXECUTE SP_RETORNA_MONTO_FORMATEADO @nMontoError, 0, @cMontoFMT OUTPUT  
  
      UPDATE #paso_error SET Mensaje_Error = LTRIM(RTRIM(Mensaje_Error)) + '  ' + @cMontoFMT , sw = 'S' WHERE @NumeroCorre_Detalle = NumeroCorre_Detalle  
   END  
  
   SELECT @linea1 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 1  
   SELECT @linea2 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 2  
   SELECT @linea3 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 3  
  
   IF EXISTS(SELECT Operador_Ap_Lineas FROM view_aprobacion_operaciones, mdac WHERE id_sistema = 'BTR' AND NumeroOperacion = @nNumoper AND FechaOperacion = acfecproc)  
   BEGIN  
      SELECT @EstadoPeracion = CASE Estado WHEN 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_Lineas ELSE '' END FROM VIEW_APROBACION_OPERACIONES, MDAC WHERE id_sistema = 'BTR' AND NumeroOperacion = @nNumoper AND FechaOperacion = acfecproc  
   END  
  
   SELECT 'cNompro'       = ISNULL(@Nompro,'')       
   ,      'nRutpro'       = ISNULL(@Rutpro,'')       
   ,      'dFecpro'       = ISNULL(@Fecpro,'')       
   ,      'TipoCart'      = ISNULL(( SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_CartFin AND TBCODIGO1 = MOTIPCART),'')  
   ,      'fecemi'        = ISNULL(@cFecemi,'')       
   ,      'nooper'        = ISNULL(monumoper,0)  
   ,      'Total'         = ISNULL(@Total,0)  
   ,      'fpago'         = ISNULL(@Forpa,'')  
   ,      'Correla'       = ISNULL(mocorrela,0)  
   ,      'I_Seri'        = ISNULL(moinstser,'')  
   ,      'Nominal'       = ISNULL(monominal,0)  
   ,      'tir'           = ISNULL(motir,0)  
   ,      'MtPs'          = ISNULL(movalcomp,0)  
   ,      'custodia'      = CASE WHEN modcv = 'P' THEN 'PROPIA'   
                                 WHEN modcv = 'C' THEN 'CLIENTE'   
                                 WHEN modcv = 'D' THEN 'DCV'   
                                 ELSE                  ''   
                            END  
   ,      'Tipcli'        = ISNULL(@TipoCli,'')  
   ,      'Tipret'        = ISNULL(@Tipret,'')  
   ,      'Rutcli'        = STR(@Rutcli) + '-' + @Digveri  
   ,      'Codcli'        = ISNULL(CONVERT(CHAR(9),@Codcli),'')  
   ,      'Nomcli'        = ISNULL(@Nomcli,'')  
   ,      'Dircli'        = ISNULL(@Dircli,'')  
   ,      'Foncli'        = ISNULL(@FonCli,'')  
   ,      'Faxcli'        = ISNULL(@Faxcli,'')  
   ,      'Obser'         = ISNULL(@Obser,'')  
   ,      'Operador'      = ISNULL(@Nomoper,'')  
   ,      'emisor'        = CASE WHEN mocodigo = 98 THEN (SELECT clgeneric FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = mocodcli)  
                                 ELSE                    (SELECT emgeneric FROM VIEW_EMISOR  WHERE emrut = morutemi)  
                            END  
   ,      'Moneda'        = ISNULL(mnnemo,'')  
   ,      'Linea1'        = ISNULL(@linea1,'')  
   ,      'Linea2'        = ISNULL(@linea2,'')  
   ,      'Linea3'        = ISNULL(@linea3,'')  
   ,      'Linea4'        = ISNULL(@linea4,'')  
   ,      'Linea5'        = ISNULL(@linea5,'')  
   ,      'vpb'           = ISNULL(mopvp,0)  
   ,      'vpc'           = ISNULL(movpar,0)  
   ,      'cDirpro'       = ISNULL(@Dirpro,'')  
   ,      'copia'         = ISNULL(@glocopia,'')  
   ,      'Pagina'        = 0  
   ,      'contador'      = ISNULL(mocorrela,0)  
   ,      'vvista'        = ISNULL(movvista,0)  
   ,      'TotalPag'      = 0  
   ,      'comision'      = @nMtoComi  
   ,      'iva'           = @nIva-@nMtoComi  
   ,      'vvcomi'        = ISNULL(movviscom,0)  
   ,      'hora'          = @hora  
   ,      'clavedcv'      = moclave_dcv  
   ,      'Lim_PFE'       = @cPFE  
   ,      'Lim_Settle'    = @cSettlement  
   ,      'Lim_EmiPlz'    = @cEmisorInstPlazo  
   ,      'Lim_CCE'       = @cCCE  
   ,      'Valor Par'     = isnull(mdmo.mopvp,0)  
   ,      'Fecha_inicio'  = CONVERT(CHAR(10),mdmo.mofecemi,103)  
   ,      'Fecha_vencim'  = CONVERT(CHAR(10),mdmo.mofecven,103)  
   ,      'MtoEscrito'    = @MtoEsc  
   ,      'EstadoPeracion'= @EstadoPeracion  
   ,      'SERIE'         = SUBSTRING(moinstser,1,3)  
   ,      'totalString'   = convert(char(19),@Total)  
   ,      'Tipo_cartera'  = codigo_carterasuper  
   ,      'Firma1'        = @Firma1  
   ,      'Firma2'        = CASE WHEN @Firma2 = @Firma1 THEN 'FALTA' ELSE @Firma2 END  
--   ,      'PagoMañana'    = CASE WHEN Fecha_PagoMañana = @Fecprox THEN 'Operación Pago Mañana' ELSE ' ' END  
--fmo 20190820 se corrige glosa tipo operacion
--   ,      'PagoMañana'    = CASE WHEN Fecha_PagoMañana = @Fecprox THEN 'Operación Pago Mañana' WHEN Fecha_PagoMañana > @Fecprox then 'Operación T+2' ELSE ' ' END  
   ,     'PagoMañana'     = case when BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(mofecpro, 1, 6) = Fecha_PagoMañana then 'Operación Pago Mañana' 
								when BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(mofecpro, 1, 6) < Fecha_PagoMañana then 'Operación T+2' 
							else ' ' end 
--fmo 20190820 se corrige glosa tipo operacion
   ,      'Nombre_CartSuper'= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_CartNorm AND tbcodigo1 = codigo_carterasuper),'')  
   ,      'Codigo_Libro'  = id_libro  
   ,      'Nombre_Libro'  = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro    AND tbcodigo1 = id_libro),'')  
   INTO    #TEMP  
   FROM    MDMO  
           LEFT JOIN VIEW_MONEDA ON momonemi = mncodmon  
   WHERE   monumoper = @nNumoper  
   AND     morutcart = @nRutcart  
   AND     motipoper = 'CP'  
   ORDER BY mocorrela  
  
   SELECT @contador = 0 , @contador2 = 0 , @pagina = 1  
  
   SELECT @iRegistro   = MIN(contador)  
   ,      @iRegistros  = MAX(contador)  
   ,      @iContador   = 1  
   ,      @iPagina     = 1  
   FROM   #TEMP   
  
   WHILE @iRegistros   >= @iRegistro  
   BEGIN  
      UPDATE #TEMP   
      SET    pagina     = @iPagina  
      WHERE  contador   = @iRegistro  
  
      IF (@iContador)   = 10  
      BEGIN  
         SET @iPagina   = @iPagina   + 1  
         SET @iContador = 0  
      END  
      SET @iRegistro    = @iRegistro + 1  
      SET @iContador    = @iContador + 1  
   END  
  
   UPDATE #TEMP SET TotalPag = @iPagina  
  
   SELECT * FROM #TEMP, #PARAMETROS  
END  
  
IF @iOperDia = 1  
BEGIN  
   SELECT @Obser          = ISNULL(moobserv,'')       
   ,      @linea1         = ISNULL(moobserv2,'')       
   ,      @Rutcli         = ISNULL(morutcli,0)       
   ,      @Codcli         = ISNULL(mocodcli,0)       
   ,      @Tipret         = CASE motipret WHEN 'I' THEN 'VIENEN' ELSE 'VAMOS' END  
   ,      @Nomoper        = nombre        
   ,      @Nompro         = ISNULL(acnomprop,'')       
   ,      @Rutpro         = STR(acrutprop)+'-'+acdigprop      
   ,      @Dirpro         = ISNULL(acdirprop,'')       
   ,      @Fecpro         = CONVERT(CHAR(10),acfecproc,103)     
   ,      @nMtoComi       = ISNULL(momtocomi,0)       
   ,      @fComision      = accomision/CONVERT(FLOAT,100)      
   ,      @nIva           = ISNULL(momtocomi,0)       
   ,      @hora           = mohora        
   ,      @EstadoPeracion = CASE mostatreg WHEN 'P' THEN 'OPERACION PENDIENTE DE APROBACION' ELSE '' END   
   ,      @Forpa          = glosa   
   ,      @nDiaSem        = DATEPART(WEEKDAY,mofecpro)   
   ,      @nDia           = DATEPART(DAY,mofecpro)   
   ,      @nMes           = DATEPART(MONTH,mofecpro)   
   ,      @nAnn           = DATEPART(YEAR,mofecpro)  
   FROM   MDMH  
          INNER JOIN BacParamSuda..USUARIO       ON mousuario = SUBSTRING(usuario,1,12)  
          LEFT  JOIN BacParamSuda..FORMA_DE_PAGO ON codigo = moforpagi  
   ,      MDAC  
   WHERE  mofecpro        = @dFechacartera  
   AND    monumoper       = @nNumoper   
   AND    morutcart       = @nRutcart   
   AND    motipoper       = 'CP'   
  
   SELECT @Total    = (SELECT SUM(movalcomp) FROM MDMH WHERE mofecpro = @dFechacartera and monumoper = @nNumoper AND morutcart = @nRutcart AND motipoper = 'CP')  
  
   IF @nMes= 1 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Enero de '     + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 2 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Febrero de '   + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 3 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Marzo de '     + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 4 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Abril de '     + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 5 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Mayo de '      + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 6 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Junio de '     + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 7 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Julio de '     + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 8 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Agosto de '    + CONVERT(CHAR(4),@nAnn)  
   IF @nMes= 9 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+ CONVERT(CHAR(4),@nAnn)  
   IF @nMes=10 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Octubre de '   + CONVERT(CHAR(4),@nAnn)  
   IF @nMes=11 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' + CONVERT(CHAR(4),@nAnn)  
   IF @nMes=12 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' + CONVERT(CHAR(4),@nAnn)  
  
   IF @nDiaSem=1 SELECT @cFecEmi = 'Domingo '  + @cFecEmi  
   IF @nDiaSem=2 SELECT @cFecEmi = 'Lunes '    + @cFecEmi  
   IF @nDiaSem=3 SELECT @cFecEmi = 'Martes '   + @cFecEmi  
   IF @nDiaSem=4 SELECT @cFecEmi = 'Miercoles '+ @cFecEmi  
   IF @nDiaSem=5 SELECT @cFecEmi = 'Jueves '   + @cFecEmi  
   IF @nDiaSem=6 SELECT @cFecEmi = 'Viernes '  + @cFecEmi  
   IF @nDiaSem=7 SELECT @cFecEmi = 'Sabado '   + @cFecEmi  
  
   SELECT @NumSol   = monsollin   
   ,      @Codmon   = MOMONEMI  
   FROM   MDMH  
   WHERE  mofecpro  = @dFechacartera  
   and    monumoper = @nNumoper  
   AND    morutcart = @nRutcart  
   AND    motipoper = 'CP'  
  
   SELECT @linea2 = ' '   
   ,      @linea3 = ' '   
   ,      @linea4 = ' '  
  
   SELECT @Nomcli  = clnombre  
   ,      @Dircli  = cldirecc  
   ,      @Foncli  = clfono  
   ,      @Faxcli  = clfax  
   ,      @Tipcli  = cltipcli  
   ,      @Digveri = ISNULL(cldv,' ')  
   FROM   VIEW_CLIENTE  
   WHERE  clrut    = @Rutcli  
   AND    clcodigo = @Codcli  
  
   IF @nMtoComi = 0  
      SELECT @nIva      = 0   
      ,      @nMtoComi  = 0   
      ,      @fComision = 0  
  
   SELECT @Tipocli  = tbglosa     
   ,      @nMtoComi = ROUND(@Total*@fComision,0)  
   FROM   VIEW_TABLA_GENERAL_DETALLE  
   WHERE  tbcateg   = 207   
   AND    CONVERT(INTEGER,tbcodigo1) = CONVERT(INTEGER,@Tipcli)  
  
   EXECUTE SP_PAPELETA_LIMITES 'CP' , @nNumoper , @cSettlement OUTPUT , @cPFE OUTPUT , @cEmisorInstPlazo OUTPUT , @cCCE OUTPUT   
  
   SELECT @nCodEsc = CASE WHEN @Codmon = 13 THEN @Codmon ELSE 999 END  
  
   EXECUTE SP_MONTOESCRITO_MONEDA @Total, @MtoEsc OUTPUT, @nCodEsc  
  
   WHILE 1=1  
   BEGIN  
      SET ROWCOUNT 1  
      SELECT @NumeroCorre_Detalle = 0  
      SELECT @NumeroCorre_Detalle = NumeroCorre_Detalle  
      ,      @nMontoError         = Monto  
      FROM   #paso_error  
      WHERE  sw                   = 'N'  
  
      SET ROWCOUNT 0  
      IF @NumeroCorre_Detalle = 0   
         BREAK  
  
      EXECUTE SP_RETORNA_MONTO_FORMATEADO @nMontoError, 0, @cMontoFMT OUTPUT  
  
      UPDATE #paso_error SET Mensaje_Error = LTRIM(RTRIM(Mensaje_Error)) + '  ' + @cMontoFMT , sw = 'S' WHERE @NumeroCorre_Detalle = NumeroCorre_Detalle  
   END  
  
   SELECT @linea1 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 1  
   SELECT @linea2 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 2  
   SELECT @linea3 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 3  
  
   IF EXISTS(SELECT Operador_Ap_Lineas FROM view_aprobacion_operaciones, mdac WHERE id_sistema = 'BTR' AND NumeroOperacion = @nNumoper AND FechaOperacion = acfecproc)  
   BEGIN  
      SELECT @EstadoPeracion = CASE Estado WHEN 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_Lineas ELSE '' END FROM VIEW_APROBACION_OPERACIONES, MDAC WHERE id_sistema = 'BTR' AND NumeroOperacion = @nNumoper AND FechaOperacion = acfecproc  
   END  
  
   SELECT 'cNompro'       = ISNULL(@Nompro,'')       
   ,      'nRutpro'       = ISNULL(@Rutpro,'')       
   ,      'dFecpro'       = ISNULL(@Fecpro,'')       
   ,      'TipoCart'      = ISNULL(( SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_CartFin AND TBCODIGO1 = MOTIPCART),'')  
   ,      'fecemi'        = ISNULL(@cFecemi,'')       
   ,      'nooper'        = ISNULL(monumoper,0)  
   ,      'Total'         = ISNULL(@Total,0)  
   ,      'fpago'         = ISNULL(@Forpa,'')  
   ,      'Correla'       = ISNULL(mocorrela,0)  
   ,      'I_Seri'        = ISNULL(moinstser,'')  
   ,      'Nominal'       = ISNULL(monominal,0)  
   ,      'tir'           = ISNULL(motir,0)  
   ,      'MtPs'          = ISNULL(movalcomp,0)  
   ,      'custodia'      = CASE WHEN modcv = 'P' THEN 'PROPIA'   
                                 WHEN modcv = 'C' THEN 'CLIENTE'   
                                 WHEN modcv = 'D' THEN 'DCV'   
                                 ELSE                  ''   
                            END  
   ,      'Tipcli'        = ISNULL(@TipoCli,'')  
   ,      'Tipret'        = ISNULL(@Tipret,'')  
   ,      'Rutcli'        = STR(@Rutcli) + '-' + @Digveri  
   ,      'Codcli'        = ISNULL(CONVERT(CHAR(9),@Codcli),'')  
   ,      'Nomcli'        = ISNULL(@Nomcli,'')  
   ,      'Dircli'        = ISNULL(@Dircli,'')  
   ,      'Foncli'        = ISNULL(@FonCli,'')  
   ,      'Faxcli'        = ISNULL(@Faxcli,'')  
   ,      'Obser'         = ISNULL(@Obser,'')  
   ,      'Operador'      = ISNULL(@Nomoper,'')  
   ,      'emisor'        = CASE WHEN mocodigo = 98 THEN (SELECT clgeneric FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = mocodcli)  
                                 ELSE                    (SELECT emgeneric FROM VIEW_EMISOR  WHERE emrut = morutemi)  
                            END  
   ,      'Moneda'        = ISNULL(mnnemo,'')  
   ,      'Linea1'        = ISNULL(@linea1,'')  
   ,      'Linea2'        = ISNULL(@linea2,'')  
   ,      'Linea3'        = ISNULL(@linea3,'')  
   ,      'Linea4'        = ISNULL(@linea4,'')  
   ,      'Linea5'        = ISNULL(@linea5,'')  
   ,      'vpb'           = ISNULL(mopvp,0)  
   ,      'vpc'           = ISNULL(movpar,0)  
   ,      'cDirpro'       = ISNULL(@Dirpro,'')  
   ,      'copia'         = ISNULL(@glocopia,'')  
   ,      'Pagina'        = 0  
   ,      'contador'      = ISNULL(mocorrela,0)  
   ,      'vvista'        = ISNULL(movvista,0)  
   ,      'TotalPag'      = 0  
   ,      'comision'      = @nMtoComi  
   ,      'iva'           = @nIva-@nMtoComi  
   ,      'vvcomi'        = ISNULL(movviscom,0)  
   ,      'hora'          = @hora  
   ,      'clavedcv'      = moclave_dcv  
   ,      'Lim_PFE'       = @cPFE  
   ,      'Lim_Settle'    = @cSettlement  
   ,      'Lim_EmiPlz'    = @cEmisorInstPlazo  
   ,      'Lim_CCE'       = @cCCE  
   ,      'Valor Par'     = isnull(mdmo.mopvp,0)  
   ,      'Fecha_inicio'  = CONVERT(CHAR(10),mdmo.mofecemi,103)  
   ,      'Fecha_vencim'  = CONVERT(CHAR(10),mdmo.mofecven,103)  
   ,      'MtoEscrito'    = @MtoEsc  
   ,      'EstadoPeracion'= @EstadoPeracion  
   ,      'SERIE'         = SUBSTRING(moinstser,1,3)  
   ,      'totalString'   = convert(char(19),@Total)  
   ,      'Tipo_cartera'  = codigo_carterasuper  
   ,      'Firma1'        = @Firma1  
   ,      'Firma2'        = CASE WHEN @Firma2 = @Firma1 THEN 'FALTA' ELSE @Firma2 END  
-- -------------------------------------------------------------------------------
-- +++ VFBF 11072018 modificacion de datos en tabla de pago mañaana     
-- -------------------------------------------------------------------------------
--   ,     'PagoMañana'     = case when Fecha_PagoMañana = mofecpro then 'Operación Pago Mañana' 
--								when Fecha_PagoMañana > mofecpro then 'Operación T+2' 
--fmo 20190820 problemas en papeleta
   ,     'PagoMañana'     = case when BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(mofecpro, 1, 6) = Fecha_PagoMañana then 'Operación Pago Mañana' 
								when BacTraderSuda.dbo.Fx_Buscar_Fecha_Habil(mofecpro, 1, 6) < Fecha_PagoMañana then 'Operación T+2' 
							else ' ' end 
--fmo 20190820 problemas en papeleta
-- -------------------------------------------------------------------------------
-- --- VFBF 11072018 modificacion de datos en tabla de pago mañaana     
-- -------------------------------------------------------------------------------

   ,      'Nombre_CartSuper'= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_CartNorm AND tbcodigo1 = codigo_carterasuper),'')  
   ,      'Codigo_Libro'  = moid_libro  
   ,      'Nombre_Libro'  = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro    AND tbcodigo1 = moid_libro),'')  
   INTO    #TEMP_ii    
   FROM    MDMH mdmo  
           LEFT JOIN VIEW_MONEDA ON momonemi = mncodmon  
   WHERE   mofecpro  = @dFechacartera  
   and     monumoper = @nNumoper  
   AND     morutcart = @nRutcart  
   AND     motipoper = 'CP'  
   ORDER BY mocorrela  
  
   SELECT @contador = 0 , @contador2 = 0 , @pagina = 1  
  
   SELECT @iRegistro   = MIN(contador)  
   ,      @iRegistros  = MAX(contador)  
   ,      @iContador   = 1  
   ,      @iPagina     = 1  
   FROM   #TEMP_ii  
  
   WHILE @iRegistros   >= @iRegistro  
   BEGIN  
      UPDATE #TEMP_ii  
      SET    pagina     = @iPagina  
      WHERE  contador   = @iRegistro  
  
      IF (@iContador)   = 10  
      BEGIN  
         SET @iPagina   = @iPagina   + 1  
         SET @iContador = 0  
      END  
      SET @iRegistro    = @iRegistro + 1  
      SET @iContador    = @iContador + 1  
   END  
  
   UPDATE #TEMP_ii SET TotalPag = @iPagina  
  
   SELECT * FROM #TEMP_ii , #PARAMETROS  
 
END  
  
END  
GO
