USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETA_FLI_PAGOS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PAPELETA_FLI_PAGOS]
   (   @dFechacartera  DATETIME
   ,   @nNumoper       FLOAT  
   ,   @cTipoImp       CHAR (01)
   ,   @cCorrelativo   FLOAT
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nRutcart   NUMERIC(9)
   SELECT  @nRutcart = acrutprop
   FROM    MDAC

   DECLARE @iOperDia   INTEGER
   SELECT  @iOperDia = 1
   SELECT  @iOperDia = 0
   FROM    MDMO
   WHERE   monumoper = @nNumoper
   AND     motipoper = 'FLI' 

   DECLARE @NumeroCorre_Detalle INTEGER
   DECLARE @nMontoError         NUMERIC(19,4)
   DECLARE @cMontoFMT           CHAR(20)

   DECLARE @tipcart 	      VARCHAR(25)
   ,       @nDiaSem 	      INTEGER
   ,       @nDia  	      INTEGER
   ,       @nMes  	      INTEGER
   ,       @nAnn  	      INTEGER
   ,       @cFecEmi 	      VARCHAR(40)
   ,       @Forpac  	      VARCHAR(20)
   ,       @Forpav  	      VARCHAR(20)
   ,       @Tipocli 	      VARCHAR(25)
   ,       @Tipcli  	      NUMERIC(05)
   ,       @Cust  	      VARCHAR(01)
   ,       @Custodia 	      VARCHAR(25)
   ,       @Rutcli  	      NUMERIC(9,0)
   ,       @Dig  	      VARCHAR(01)
   ,       @Codcli  	      NUMERIC(9,0)
   ,       @Nomcli  	      VARCHAR(40)
   ,       @Dircli  	      VARCHAR(40)
   ,       @Foncli  	      VARCHAR(15)
   ,       @Faxcli  	      VARCHAR(15)
   ,       @Nomoper 	      VARCHAR(40)
   ,       @Ret  	      VARCHAR(01)
   ,       @hora  	      CHAR(08)
   ,       @Retiro  	      VARCHAR(15)
   ,       @Totalc  	      NUMERIC(19,4)
   ,       @Totalv  	      NUMERIC(19,4)
   ,       @Monpact 	      CHAR(05)
   ,       @monpacto 	      NUMERIC(03,0)
   ,       @monglo  	      CHAR(20)
   ,       @Observ  	      CHAR(70)
   ,       @valmon  	      NUMERIC(19,4)
   ,       @nValIniP 	      FLOAT
   ,       @nValVenP 	      FLOAT
   ,       @nMtoVenta 	      FLOAT
   ,       @MtoEsc  	      VARCHAR(200)
   ,       @MtoEscf 	      VARCHAR(200)
   ,       @MtoRecompra       FLOAT
   ,       @cFecVen 	      VARCHAR(100)
   ,       @comcli  	      CHAR(20)
   ,       @Pagina  	      INTEGER
   ,       @nTotPagina 	      INTEGER
   ,       @contador 	      NUMERIC(19,0)
   ,       @contador2 	      NUMERIC(19,0)
   ,       @NumSol  	      NUMERIC(9,0)
   ,       @linea1  	      CHAR(255)
   ,       @linea2  	      CHAR(255)
   ,       @linea3  	      CHAR(255)
   ,       @linea4  	      CHAR(255)
   ,       @linea5  	      CHAR(255)
   ,       @glocopia 	      CHAR(25)
   ,       @nCopia  	      INTEGER
   ,       @cSettlement       CHAR(50)
   ,       @cPFE  	      CHAR(50)
   ,       @cCCE  	      CHAR(50)
   ,       @cEmisorInstPlazo  CHAR(255)
   ,       @CodForpac 	      INTEGER
   ,       @Sucursal 	      CHAR(50)
   ,       @EstadoPeracion    VARCHAR(100)

CREATE TABLE #paso_error 
   (   Mensaje_Error       VARCHAR(255)
   ,   Monto               NUMERIC(19,4)
   ,   sw                  CHAR(1)
   ,   NumeroCorre_Detalle NUMERIC(19,0) Identity(1,1)
   )

   SELECT 'acfecproc' 	= acfecproc
   ,      'acfecprox' 	= acfecprox
   ,      'uf_hoy' 	= CONVERT(FLOAT,0)
   ,      'uf_man' 	= CONVERT(FLOAT,0)
   ,      'ivp_hoy' 	= CONVERT(FLOAT,0)
   ,      'ivp_man' 	= CONVERT(FLOAT,0)
   ,      'do_hoy' 	= CONVERT(FLOAT,0)
   ,      'do_man' 	= CONVERT(FLOAT,0)
   ,      'da_hoy' 	= CONVERT(FLOAT,0)
   ,      'da_man' 	= CONVERT(FLOAT,0)
   ,      'pmnomprop' 	= acnomprop
   ,      'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop))+'-'+acdigprop
   INTO    #PARAMETROS
   FROM    MDAC

   UPDATE #PARAMETROS SET uf_hoy  = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha=acfecproc AND vmcodigo=998
   UPDATE #PARAMETROS SET uf_man  = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha=acfecprox AND vmcodigo=998
   UPDATE #PARAMETROS SET ivp_hoy = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha=acfecproc AND vmcodigo=997
   UPDATE #PARAMETROS SET ivp_man = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha=acfecprox AND vmcodigo=997
   UPDATE #PARAMETROS SET do_hoy  = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha=acfecproc AND vmcodigo=994
   UPDATE #PARAMETROS SET do_man  = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha=acfecprox AND vmcodigo=994
   UPDATE #PARAMETROS SET da_hoy  = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha=acfecproc AND vmcodigo=995
   UPDATE #PARAMETROS SET da_man  = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha=acfecprox AND vmcodigo=995

   IF @cTipoImp='P'
      SELECT @nCopia = papapimp FROM MDPA WHERE panumoper=  @nNumoper
   ELSE
      SELECT @nCopia = paconimp FROM MDPA WHERE panumoper= @nNumoper

   IF @cTipoImp='P'
      SELECT @glocopia = CASE WHEN @nCopia = 1 THEN 'COPIA MESA'
                              WHEN @nCopia = 2 THEN 'COPIA INVERSIONES'
                              WHEN @nCopia = 3 THEN 'COPIA CUSTODIA'
                              ELSE ' '
                         END
   ELSE
      SELECT @glocopia = CASE WHEN @nCopia = 1 THEN 'ORIGINAL CLIENTE'
                              WHEN @nCopia = 2 THEN 'COPIA CLIENTE'
                              ELSE                  ' '
                         END

IF @iOperDia = 0
BEGIN

   IF @cTipoImp='P'
      SELECT @nTotPagina = 9
   ELSE
      SELECT @nTotPagina = 15
      SELECT @Monpact  = ISNULL(mnnemo,'') 
      ,      @Monpacto = momonpact
      FROM   MDMO
             LEFT JOIN VIEW_MONEDA ON mncodmon = momonpact
      WHERE  monumoper = @nNumoper 
      AND    morutcart = @nRutcart 
      AND    motipoper = 'FLI' 

   IF @monpacto=999
      SELECT @monglo = 'PESOS'
   IF @monpacto=998
      SELECT @monglo = 'UNIDADES DE FOMENTO'
   IF @monpacto=994
      SELECT @monglo = 'DOLARES'
   IF @monpacto=995
      SELECT @monglo = 'DOLARES'

   SELECT @Totalc     = SUM(PAVPRESEN) 
   ,      @Totalv     = SUM(PAVPRESEN)
   FROM   PAGOS_FLI
   WHERE  panumoper   = @nNumoper 
   AND    panumpago   = @cCorrelativo 
   AND    paptipopago = 'S'

   SELECT @tipcart    = tbglosa 
   FROM   VIEW_TABLA_GENERAL_DETALLE
   ,      MDMO
   WHERE  tbcateg     = 204 
   AND    CONVERT(NUMERIC(6),tbcodigo1) = motipcart 
   AND    monumoper   = @nNumoper 
   AND    morutcart   = @nRutcart 
   AND    motipoper   = 'FLI'

   SELECT @nDiaSem  = DATEPART(WEEKDAY,mofecinip) 
   ,      @nDia     = DATEPART(DAY,mofecinip) 
   ,      @nMes     = DATEPART(MONTH,mofecinip) 
   ,      @nAnn     = DATEPART(YEAR,mofecinip)
   FROM   MDMO
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'FLI'

   IF @nMes= 1 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 2 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 3 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Marzo de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 4 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Abril de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 5 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Mayo de '      +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 6 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Junio de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 7 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Julio de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 8 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Agosto de '    +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 9 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+CONVERT(CHAR(4),@nAnn)
   IF @nMes=10 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Octubre de '   +CONVERT(CHAR(4),@nAnn)
   IF @nMes=11 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' +CONVERT(CHAR(4),@nAnn)
   IF @nMes=12 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' +CONVERT(CHAR(4),@nAnn)
 
   IF @nDiaSem=1 SELECT @cFecEmi = 'Domingo '  +@cFecEmi
   IF @nDiaSem=2 SELECT @cFecEmi = 'Lunes '    +@cFecEmi
   IF @nDiaSem=3 SELECT @cFecEmi = 'Martes '   +@cFecEmi
   IF @nDiaSem=4 SELECT @cFecEmi = 'Miercoles '+@cFecEmi
   IF @nDiaSem=5 SELECT @cFecEmi = 'Jueves '   +@cFecEmi
   IF @nDiaSem=6 SELECT @cFecEmi = 'Viernes '  +@cFecEmi
   IF @nDiaSem=7 SELECT @cFecEmi = 'Sabado '   +@cFecEmi

   SELECT @NumSol   = monsollin
   FROM   MDMO
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'FLI'

   SELECT @linea2 = ' ' 
   ,      @linea3 = ' ' 
   ,      @linea4 = ' '

   SELECT @Forpac   = glosa 
   FROM   MDMO
          LEFT JOIN VIEW_FORMA_DE_PAGO ON codigo = moforpagi 
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'FLI'

   SELECT @CodForpac = moforpagi
   FROM   MDMO
          LEFT JOIN VIEW_FORMA_DE_PAGO ON codigo = moforpagi 
   WHERE  monumoper  = @nNumoper 
   AND    morutcart  = @nRutcart 
   AND    motipoper  = 'FLI'

   SELECT @Forpav   = glosa 
   FROM   MDMO
          LEFT JOIN  VIEW_FORMA_DE_PAGO ON codigo = moforpagv 
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'FLI'

   SELECT @Cust        = ISNULL(mocondpacto,'')  
   ,      @Observ      = ISNULL(moobserv,'')  
   ,      @linea1      = ISNULL(moobserv2,'')  
   ,      @Ret         = motipret   
   ,      @nDiaSem     = DATEPART(WEEKDAY,mofecvenp) 
   ,      @nDia        = DATEPART(DAY,mofecvenp) 
   ,      @nMes        = DATEPART(MONTH,mofecvenp) 
   ,      @nAnn        = DATEPART(YEAR,mofecvenp) 
   ,      @Rutcli      = morutcli   
   ,      @Codcli      = mocodcli   
   ,      @Nomoper     = nombre 
   ,   @EstadoPeracion = CASE mostatreg WHEN 'P' THEN 'OPERACION PENDIENTE DE APROBACION' ELSE '' END 
   FROM   MDMO
          LEFT JOIN VIEW_USUARIO ON SUBSTRING(usuario,1,12) = mousuario
   WHERE  monumoper    = @nNumoper 
   AND    morutcart    = @nRutcart 
   AND    motipoper    = 'FLI'
       
   IF @Cust='S'
      SELECT @Custodia = 'Con Custodia'
   ELSE
      SELECT @Custodia = 'Sin Custodia'

   SELECT @Nomcli  = clnombre  
   ,      @Dircli  = cldirecc  
   ,      @Foncli  = clfono    
   ,      @Faxcli  = clfax     
   ,      @Codcli  = clcodigo  
   ,      @Tipcli  = cltipcli  
   ,      @Dig     = ISNULL(cldv,'') 
   ,      @comcli  = (SELECT nom_ciu FROM VIEW_CIUDAD_COMUNA WHERE cod_pai=clpais AND cod_ciu=clciudad AND cod_com=clcomuna)
   FROM   VIEW_CLIENTE
   WHERE  clrut    = @Rutcli 
   AND    clcodigo = @codcli

   SELECT @Tipocli = ISNULL(tbglosa ,'')
   FROM   VIEW_TABLA_GENERAL_DETALLE
   WHERE  tbcateg  = 207 
   AND    CONVERT(INTEGER,tbcodigo1) = CONVERT(INTEGER,@Tipcli)

   IF @Ret='V'
      SELECT @Retiro = 'Vamos'
   ELSE
      SELECT @Retiro = 'Vienen'

   SELECT @nMtoVenta   = ISNULL(SUM(PAVPRESEN),0) 
   ,      @MtoRecompra = ISNULL(SUM(PAVPRESEN),0)
   FROM   PAGOS_FLI
   WHERE  panumoper    = @nNumoper 
   AND    parutcart    = @nRutcart 
   AND    panumpago    = @cCorrelativo 
   AND    paptipopago  = 'S'

   SET @MtoEsc = ''

   IF @nMtoVenta > 0 
      EXECUTE SP_MONTOESCRITO_MONEDA @nMtoVenta, @MtoEsc OUTPUT, 999

   SET @MtoEscf = ''        

   IF @MtoRecompra > 0 
      EXECUTE SP_MONTOESCRITO_MONEDA @MtoRecompra, @MtoEscf OUTPUT, @Monpacto 
       
   IF @nMes= 1 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 2 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 3 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Marzo de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 4 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Abril de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 5 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Mayo  de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 6 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Junio de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 7 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Julio de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 8 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Agosto de '    +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 9 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+CONVERT(CHAR(4),@nAnn)
   IF @nMes=10 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Octubre de '   +CONVERT(CHAR(4),@nAnn) 
   IF @nMes=11 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' +CONVERT(CHAR(4),@nAnn)
   IF @nMes=12 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' +CONVERT(CHAR(4),@nAnn)

   IF @nDiaSem=1 SELECT @cFecVen = 'Domingo '  + @cFecVen
   IF @nDiaSem=2 SELECT @cFecVen = 'Lunes '    + @cFecVen
   IF @nDiaSem=3 SELECT @cFecVen = 'Martes '   + @cFecVen
   IF @nDiaSem=4 SELECT @cFecVen = 'Miercoles '+ @cFecVen
   IF @nDiaSem=5 SELECT @cFecVen = 'Jueves '   + @cFecVen
   IF @nDiaSem=6 SELECT @cFecVen = 'Viernes '  + @cFecVen
   IF @nDiaSem=7 SELECT @cFecVen = 'Sabado '   + @cFecVen

   SELECT @valmon = 1.0

   SELECT @valmon   = vmvalor
   FROM   MDMO
          LEFT JOIN VIEW_VALOR_MONEDA ON vmfecha = mofecinip AND vmcodigo = momonpact 
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'FLI'

   IF @valmon = NULL
      SELECT @valmon = 1


   INSERT INTO #paso_error
   SELECT Mensaje_Error
   ,      MontoExceso
   ,      'N'
   FROM   VIEW_LINEA_TRANSACCION_DETALLE
   WHERE  NumeroOperacion = @nnumoper
   AND    id_sistema      = 'BTR'
   AND    Mensaje_Error  <> ''

   INSERT INTO #paso_error
   SELECT Mensaje
   ,      Monto
   ,      'N'
   FROM   VIEW_LIMITE_TRANSACCION_ERROR
   WHERE  NumeroOperacion = @nnumoper
   AND    id_sistema      = 'BTR'

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

      EXECUTE sp_retorna_monto_formateado @nMontoError, 0, @cMontoFMT OUTPUT

      UPDATE #paso_error
      SET    Mensaje_Error       = LTRIM(RTRIM(Mensaje_Error)) + '  ' + @cMontoFMT
      ,      sw                  = 'S'
      WHERE  NumeroCorre_Detalle = @NumeroCorre_Detalle
   END

   SELECT @linea1 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 1
   SELECT @linea2 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 2
   SELECT @linea3 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 3

   IF EXISTS(SELECT operador_ap_LINEAS FROM VIEW_APROBACION_OPERACIONES, MDAC WHERE id_sistema='BTR' AND NumeroOperacion=@nNumoper AND FechaOperacion=acfecproc)
   BEGIN
      SELECT @EstadoPeracion = CASE Estado WHEN 'A' THEN 'OPERACION APROBADA POR :   '  + Operador_Ap_LINEAS
                                           WHEN 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_LINEAS
                                           ELSE          ''
                               END
      FROM   VIEW_APROBACION_OPERACIONES, MDAC
      WHERE  id_sistema      = 'BTR' 
      AND    NumeroOperacion = @nNumoper 
      AND    FechaOperacion  = acfecproc
   END

   SELECT @Sucursal = CASE WHEN @CodForpac > 20 THEN @Forpac ELSE '' END

   SELECT 'nomemp'        = ISNULL(acnomprop,'')     
   ,      'rutemp'        = STR(acrutprop)+'-' +acdigprop 
   ,      'fecpro'        = ISNULL(CONVERT(CHAR(10),acfecproc,103),CHAR(10))      
   ,      'tipcart'       = ISNULL(@tipcart,'')     
   ,      'fecemi'        = ISNULL(@cFecEmi,'')     
   ,      'numoper'       = ISNULL(panumoper,0)     
   ,      'totalV'        = ISNULL(@TotalC,0)       
   ,      'forpai'        = ISNULL(@forpac,'')      
   ,      'totalc'        = ISNULL(@TotalV,0)       
   ,      'forpav'        = ISNULL(@forpav,'')      
   ,      'tasapacto'     = ISNULL(motaspact,0)     
   ,      'base'          = ISNULL(mobaspact,0)     
   ,      'dias'          = ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0)  
   ,      'fecven'        = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')  
   ,      'correla'       = ISNULL(mocorrela,0)     
   ,      'serie'         = ISNULL(painstser,'')    
   ,      'nominal'       = ISNULL(panominal,0)     
   ,      'tasa'          = ISNULL(patir,0)         
   ,      'total'         = ISNULL(pavpresen,0)     
   ,      'custodia'      = CASE modcv WHEN  'C' THEN 'CLIENTE' WHEN 'P' THEN 'PROPIA' WHEN 'D' THEN 'DCV' END
   ,      'tipcli'        = ISNULL(@Tipocli,'')     
   ,      'tipcon'        = ISNULL(@Retiro,'')      
   ,      'rut'           = STR(@Rutcli)+'-'+@Dig   
   ,      'codcli'        = ISNULL(@Codcli,0)       
   ,      'nomcli'        = ISNULL(@Nomcli,'')      
   ,      'dircli'        = ISNULL(@Dircli,'')      
   ,      'fono'          = ISNULL(@Foncli,'')      
   ,      'faxcli'        = ISNULL(@Faxcli,'')      
   ,      'observa'       = ISNULL(@Observ,'')      
   ,      'nomope'        = ISNULL(@Nomoper,'')     
   ,      'Emisor'        = ISNULL(emgeneric,'')    
   ,      'Moneda'        = ISNULL(mnnemo,'')       
   ,      'MonPact'       = ISNULL(@Monpact,'')     
   ,      'Fecha_Emi'     = CONVERT(CHAR(10),mofecemi,103) 
   ,      'Fecha_Ven'     = CONVERT(CHAR(10),mofecven,103)   
   ,      'ValInip'       = ISNULL(PAVPRESEN,0)     
   ,      'ValVenp'       = ISNULL(PAVPRESEN,0)     
   ,      'MtoVenta'      = ISNULL(PAVPRESEN,0) 
   ,      'MtoEscrito'    = @MtoEsc                
   ,      'MtoRecompra'   = ISNULL(PAVPRESEN,0)   
   ,      'Fec_Ven'       = @cFecVen                
   ,      'diremp'        = ISNULL(acdirprop,'')    
   ,      'comemp'        = ISNULL(accomprop,'')    
   ,      'comcli'        = ISNULL(@monglo,'')      
   ,      'copia'         = ISNULL(@glocopia,'')    
   ,      'Pagina'        = 0                       
   ,      'contador'      = ISNULL(mocorvent,0)     
   ,      'numdocu'       = ISNULL(panumdocu,0)     
   ,      'TotalPag'      = 0                       
   ,      'linea1'        = ISNULL(@linea1,'')      
   ,      'linea2'        = ISNULL(@linea2,'')      
   ,      'linea3'        = ISNULL(@linea3,'')      
   ,      'linea4'        = ISNULL(@linea3,'')      
   ,      'hora'          = ISNULL(SUBSTRING(mohora,1,8),'')     
   ,      'Lim_Settle'    = @cSettlement        
   ,      'Lim_PFE'       = @cPFE               
   ,      'clave_dcv'     = moclave_dcv         
   ,      'Lim_CCE'       = @cCCE               
   ,      'MtoEscritoRec' = @mtoEscf            
   ,      'Sucursal'      = @Sucursal           
   ,      'EstadoPeracion'= @EstadoPeracion     
   ,      'CtaCteInicio'  = Cuenta_Corriente_Inicio 
   ,      'CtaCteFinal'   = Cuenta_Corriente_Final  
   ,      'Tipo_cartera'  = codigo_carterasuper 
   ,      'Correlativo'   = @cCorrelativo
   INTO    #TEMP
   FROM    MDMO
           LEFT  JOIN VIEW_EMISOR ON emrut       = morutemi
           LEFT  JOIN VIEW_MONEDA ON mncodmon    = momonemi
           INNER JOIN PAGOS_FLI   ON panumoper   = @nNumoper 
                                 AND panumpago   = @cCorrelativo 
                                 AND paptipopago = 'S' 
                                 AND panumdocu   = monumdocu 
                                 AND pacorrela   = mocorrela
   ,       MDAC
   WHERE   morutcart      = @nRutcart 
   AND     monumoper      = @nNumoper 
   AND     motipoper      = 'FLI' 
   ORDER BY mocorrela

   SELECT @contador   = 0 
   ,      @contador2  = 0 
   ,      @pagina     = 1
 
   WHILE @pagina<>0
   BEGIN

      SET ROWCOUNT 1

      SELECT @tipcart  = '*'
      SELECT @tipcart  = tipcart 
      ,      @contador = contador
      FROM   #TEMP
      WHERE  contador  > @contador
      ORDER BY contador

      SET ROWCOUNT 0

      IF @tipcart='*'
         BREAK

      SELECT @contador2 = @contador2 + 1

      UPDATE #TEMP SET pagina = @pagina WHERE contador=@Contador
      UPDATE #TEMP SET TotalPag = @pagina

      IF @contador2 = @nTotPagina
         SELECT @pagina    = @pagina + 1 
         ,      @contador2 = 0
   END

   SELECT * FROM #TEMP, #PARAMETROS

END


IF @iOperDia = 1
BEGIN

   IF @cTipoImp='P'
      SELECT @nTotPagina = 9
   ELSE
      SELECT @nTotPagina = 15
      SELECT @Monpact  = ISNULL(mnnemo,'') 
      ,      @Monpacto = momonpact
      FROM   MDMH
             LEFT JOIN VIEW_MONEDA ON mncodmon = momonpact
      WHERE  mofecpro  = @dFechacartera
      AND    monumoper = @nNumoper 
      AND    morutcart = @nRutcart 
      AND    motipoper = 'FLI' 

   IF @monpacto=999
      SELECT @monglo = 'PESOS'
   IF @monpacto=998
      SELECT @monglo = 'UNIDADES DE FOMENTO'
   IF @monpacto=994
      SELECT @monglo = 'DOLARES'
   IF @monpacto=995
      SELECT @monglo = 'DOLARES'

   SELECT @Totalc     = SUM(PAVPRESEN) 
   ,      @Totalv     = SUM(PAVPRESEN)
   FROM   PAGOS_FLI
   WHERE  panumoper   = @nNumoper 
   AND    panumpago   = @cCorrelativo 
   AND    paptipopago = 'S'

   SELECT @tipcart    = tbglosa 
   FROM   MDMH
          LEFT JOIN VIEW_TABLA_GENERAL_DETALLE ON tbcateg = 204 AND CONVERT(NUMERIC(6),tbcodigo1) = motipcart 
   WHERE  mofecpro    = @dFechacartera
   AND    monumoper   = @nNumoper 
   AND    morutcart   = @nRutcart 
   AND    motipoper   = 'FLI'

   SELECT @nDiaSem  = DATEPART(WEEKDAY,mofecinip) 
   ,      @nDia     = DATEPART(DAY,mofecinip) 
   ,      @nMes     = DATEPART(MONTH,mofecinip) 
   ,      @nAnn     = DATEPART(YEAR,mofecinip)
   FROM   MDMH
   WHERE  mofecpro  = @dFechacartera
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'FLI'

   IF @nMes= 1 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 2 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 3 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Marzo de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 4 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Abril de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 5 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Mayo de '      +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 6 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Junio de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 7 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Julio de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 8 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Agosto de '    +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 9 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+CONVERT(CHAR(4),@nAnn)
   IF @nMes=10 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Octubre de '   +CONVERT(CHAR(4),@nAnn)
   IF @nMes=11 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' +CONVERT(CHAR(4),@nAnn)
   IF @nMes=12 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' +CONVERT(CHAR(4),@nAnn)
 
   IF @nDiaSem=1 SELECT @cFecEmi = 'Domingo '  +@cFecEmi
   IF @nDiaSem=2 SELECT @cFecEmi = 'Lunes '    +@cFecEmi
   IF @nDiaSem=3 SELECT @cFecEmi = 'Martes '   +@cFecEmi
   IF @nDiaSem=4 SELECT @cFecEmi = 'Miercoles '+@cFecEmi
   IF @nDiaSem=5 SELECT @cFecEmi = 'Jueves '   +@cFecEmi
   IF @nDiaSem=6 SELECT @cFecEmi = 'Viernes '  +@cFecEmi
   IF @nDiaSem=7 SELECT @cFecEmi = 'Sabado '   +@cFecEmi

   SELECT @NumSol   = monsollin
   FROM   MDMH
   WHERE  mofecpro  = @dFechacartera
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'FLI'

   SELECT @linea2 = ' ' 
   ,      @linea3 = ' ' 
   ,      @linea4 = ' '

   SELECT @Forpac   = glosa 
   FROM   MDMH
          LEFT JOIN VIEW_FORMA_DE_PAGO ON codigo = moforpagi 
   WHERE  mofecpro  = @dFechacartera
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'FLI'

   SELECT @CodForpac = moforpagi
   FROM   MDMH
          LEFT JOIN VIEW_FORMA_DE_PAGO ON codigo = moforpagi 
   WHERE  mofecpro   = @dFechacartera
   AND    monumoper  = @nNumoper 
   AND    morutcart  = @nRutcart 
   AND    motipoper  = 'FLI'

   SELECT @Forpav   = glosa 
   FROM   MDMH
          LEFT JOIN  VIEW_FORMA_DE_PAGO ON codigo = moforpagv 
   WHERE  mofecpro  = @dFechacartera
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'FLI'

   SELECT @Cust        = ISNULL(mocondpacto,'')  
   ,      @Observ      = ISNULL(moobserv,'')  
   ,      @linea1      = ISNULL(moobserv2,'')  
   ,      @Ret         = motipret   
   ,      @nDiaSem     = DATEPART(WEEKDAY,mofecvenp) 
   ,      @nDia        = DATEPART(DAY,mofecvenp) 
   ,      @nMes        = DATEPART(MONTH,mofecvenp) 
   ,      @nAnn        = DATEPART(YEAR,mofecvenp) 
   ,      @Rutcli      = morutcli   
   ,      @Codcli      = mocodcli   
   ,      @Nomoper     = nombre 
   ,   @EstadoPeracion = CASE mostatreg WHEN 'P' THEN 'OPERACION PENDIENTE DE APROBACION' ELSE '' END 
   FROM   MDMH
          LEFT JOIN VIEW_USUARIO ON SUBSTRING(usuario,1,12) = mousuario
   WHERE  mofecpro     = @dFechacartera
   AND    monumoper    = @nNumoper 
   AND    morutcart    = @nRutcart 
   AND    motipoper    = 'FLI'
       
   IF @Cust='S'
      SELECT @Custodia = 'Con Custodia'
   ELSE
      SELECT @Custodia = 'Sin Custodia'

   SELECT @Nomcli  = clnombre  
   ,      @Dircli  = cldirecc  
   ,      @Foncli  = clfono    
   ,      @Faxcli  = clfax     
   ,      @Codcli  = clcodigo  
   ,      @Tipcli  = cltipcli  
   ,      @Dig     = ISNULL(cldv,'') 
   ,      @comcli  = (SELECT nom_ciu FROM VIEW_CIUDAD_COMUNA WHERE cod_pai=clpais AND cod_ciu=clciudad AND cod_com=clcomuna)
   FROM   VIEW_CLIENTE
   WHERE  clrut    = @Rutcli 
   AND    clcodigo = @codcli

   SELECT @Tipocli = ISNULL(tbglosa ,'')
   FROM   VIEW_TABLA_GENERAL_DETALLE
   WHERE  tbcateg  = 207 
   AND    CONVERT(INTEGER,tbcodigo1) = CONVERT(INTEGER,@Tipcli)

   IF @Ret='V'
      SELECT @Retiro = 'Vamos'
   ELSE
      SELECT @Retiro = 'Vienen'

   SELECT @nMtoVenta   = ISNULL(SUM(PAVPRESEN),0) 
   ,      @MtoRecompra = ISNULL(SUM(PAVPRESEN),0)
   FROM   PAGOS_FLI
   WHERE  panumoper    = @nNumoper 
   AND    parutcart    = @nRutcart 
   AND    panumpago    = @cCorrelativo 
   AND    paptipopago  = 'S'

   SET @MtoEsc = ''

   IF @nMtoVenta > 0 
      EXECUTE SP_MONTOESCRITO_MONEDA @nMtoVenta, @MtoEsc OUTPUT, 999

   SET @MtoEscf = ''        

   IF @MtoRecompra > 0 
      EXECUTE SP_MONTOESCRITO_MONEDA @MtoRecompra, @MtoEscf OUTPUT, @Monpacto 
       
   IF @nMes= 1 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 2 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 3 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Marzo de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 4 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Abril de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 5 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Mayo  de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 6 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Junio de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 7 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Julio de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 8 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Agosto de '    +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 9 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+CONVERT(CHAR(4),@nAnn)
   IF @nMes=10 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Octubre de '   +CONVERT(CHAR(4),@nAnn) 
   IF @nMes=11 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' +CONVERT(CHAR(4),@nAnn)
   IF @nMes=12 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' +CONVERT(CHAR(4),@nAnn)

   IF @nDiaSem=1 SELECT @cFecVen = 'Domingo '  + @cFecVen
   IF @nDiaSem=2 SELECT @cFecVen = 'Lunes '    + @cFecVen
   IF @nDiaSem=3 SELECT @cFecVen = 'Martes '   + @cFecVen
   IF @nDiaSem=4 SELECT @cFecVen = 'Miercoles '+ @cFecVen
   IF @nDiaSem=5 SELECT @cFecVen = 'Jueves '   + @cFecVen
   IF @nDiaSem=6 SELECT @cFecVen = 'Viernes '  + @cFecVen
   IF @nDiaSem=7 SELECT @cFecVen = 'Sabado '   + @cFecVen

   SELECT @valmon = 1.0

   SELECT @valmon   = vmvalor
   FROM   MDMH
          LEFT JOIN VIEW_VALOR_MONEDA ON vmfecha = mofecinip AND vmcodigo = momonpact 
   WHERE  mofecpro  = @dFechacartera
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'FLI'

   IF @valmon = NULL
      SELECT @valmon = 1


   INSERT INTO #paso_error
   SELECT Mensaje_Error
   ,      MontoExceso
   ,      'N'
   FROM   VIEW_LINEA_TRANSACCION_DETALLE
   WHERE  NumeroOperacion = @nnumoper
   AND    id_sistema      = 'BTR'
   AND    Mensaje_Error  <> ''

   INSERT INTO #paso_error
   SELECT Mensaje
   ,      Monto
   ,      'N'
   FROM   VIEW_LIMITE_TRANSACCION_ERROR
   WHERE  NumeroOperacion = @nnumoper
   AND    id_sistema      = 'BTR'

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

      EXECUTE sp_retorna_monto_formateado @nMontoError, 0, @cMontoFMT OUTPUT

      UPDATE #paso_error
      SET    Mensaje_Error       = LTRIM(RTRIM(Mensaje_Error)) + '  ' + @cMontoFMT
      ,      sw                  = 'S'
      WHERE  NumeroCorre_Detalle = @NumeroCorre_Detalle
   END

   SELECT @linea1 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 1
   SELECT @linea2 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 2
   SELECT @linea3 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 3

   IF EXISTS(SELECT operador_ap_LINEAS FROM VIEW_APROBACION_OPERACIONES, MDAC WHERE id_sistema='BTR' AND NumeroOperacion=@nNumoper AND FechaOperacion=acfecproc)
   BEGIN
      SELECT @EstadoPeracion = CASE Estado WHEN 'A' THEN 'OPERACION APROBADA POR :   '  + Operador_Ap_LINEAS
                                           WHEN 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_LINEAS
                                           ELSE          ''
                               END
      FROM   VIEW_APROBACION_OPERACIONES, MDAC
      WHERE  id_sistema      = 'BTR' 
      AND    NumeroOperacion = @nNumoper 
      AND    FechaOperacion  = acfecproc
   END

   SELECT @Sucursal = CASE WHEN @CodForpac > 20 THEN @Forpac ELSE '' END

   SELECT 'nomemp'        = ISNULL(acnomprop,'')     
   ,      'rutemp'        = STR(acrutprop)+'-' +acdigprop 
   ,      'fecpro'        = ISNULL(CONVERT(CHAR(10),acfecproc,103),CHAR(10))      
   ,      'tipcart'       = ISNULL(@tipcart,'')     
   ,      'fecemi'        = ISNULL(@cFecEmi,'')     
   ,      'numoper'       = ISNULL(panumoper,0)     
   ,      'totalV'        = ISNULL(@TotalC,0)       
   ,      'forpai'        = ISNULL(@forpac,'')      
   ,      'totalc'        = ISNULL(@TotalV,0)       
   ,      'forpav'        = ISNULL(@forpav,'')      
   ,      'tasapacto'     = ISNULL(motaspact,0)     
   ,      'base'          = ISNULL(mobaspact,0)     
   ,      'dias'          = ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0)  
   ,      'fecven'        = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')  
   ,      'correla'       = ISNULL(mocorrela,0)     
   ,      'serie'         = ISNULL(painstser,'')    
   ,      'nominal'       = ISNULL(panominal,0)     
   ,      'tasa'          = ISNULL(patir,0)         
   ,      'total'         = ISNULL(pavpresen,0)     
   ,      'custodia'      = CASE modcv WHEN  'C' THEN 'CLIENTE' WHEN 'P' THEN 'PROPIA' WHEN 'D' THEN 'DCV' END
   ,      'tipcli'        = ISNULL(@Tipocli,'')  
   ,      'tipcon'        = ISNULL(@Retiro,'')      
   ,      'rut'           = STR(@Rutcli)+'-'+@Dig   
   ,      'codcli'        = ISNULL(@Codcli,0)       
   ,      'nomcli'        = ISNULL(@Nomcli,'')      
   ,      'dircli'        = ISNULL(@Dircli,'')      
   ,      'fono'          = ISNULL(@Foncli,'')      
   ,      'faxcli'        = ISNULL(@Faxcli,'')      
   ,      'observa'       = ISNULL(@Observ,'')      
   ,      'nomope'        = ISNULL(@Nomoper,'')     
   ,      'Emisor'        = ISNULL(emgeneric,'')    
   ,      'Moneda'        = ISNULL(mnnemo,'')       
   ,      'MonPact'       = ISNULL(@Monpact,'')     
   ,      'Fecha_Emi'     = CONVERT(CHAR(10),mofecemi,103) 
   ,      'Fecha_Ven'     = CONVERT(CHAR(10),mofecven,103)   
   ,      'ValInip'       = ISNULL(PAVPRESEN,0)     
   ,      'ValVenp'       = ISNULL(PAVPRESEN,0)     
   ,      'MtoVenta'      = ISNULL(PAVPRESEN,0) 
   ,      'MtoEscrito'    = @MtoEsc                
   ,      'MtoRecompra'   = ISNULL(PAVPRESEN,0)   
   ,      'Fec_Ven'       = @cFecVen                
   ,      'diremp'        = ISNULL(acdirprop,'')    
   ,      'comemp'        = ISNULL(accomprop,'')    
   ,      'comcli'        = ISNULL(@monglo,'')      
   ,      'copia'         = ISNULL(@glocopia,'')    
   ,      'Pagina'        = 0                       
   ,      'contador'      = ISNULL(mocorvent,0)     
   ,      'numdocu'       = ISNULL(panumdocu,0)     
   ,      'TotalPag'      = 0                       
   ,      'linea1'        = ISNULL(@linea1,'')      
   ,      'linea2'        = ISNULL(@linea2,'')      
   ,      'linea3'        = ISNULL(@linea3,'')      
   ,      'linea4'        = ISNULL(@linea3,'')      
   ,      'hora'          = ISNULL(SUBSTRING(mohora,1,8),'')     
   ,      'Lim_Settle'    = @cSettlement        
   ,      'Lim_PFE'       = @cPFE               
   ,      'clave_dcv'     = moclave_dcv         
   ,      'Lim_CCE'       = @cCCE               
   ,      'MtoEscritoRec' = @mtoEscf            
   ,      'Sucursal'      = @Sucursal           
   ,      'EstadoPeracion'= @EstadoPeracion     
   ,      'CtaCteInicio'  = Cuenta_Corriente_Inicio 
   ,      'CtaCteFinal'   = Cuenta_Corriente_Final  
   ,      'Tipo_cartera'  = codigo_carterasuper 
   ,      'Correlativo'   = @cCorrelativo
   INTO    #TEMP_ii
   FROM    MDMH
           LEFT  JOIN VIEW_EMISOR ON emrut       = morutemi
           LEFT  JOIN VIEW_MONEDA ON mncodmon    = momonemi
           INNER JOIN PAGOS_FLI   ON panumoper   = @nNumoper 
                                 AND panumpago   = @cCorrelativo 
                                 AND paptipopago = 'S' 
                                 AND panumdocu   = monumdocu 
                                 AND pacorrela   = mocorrela
   ,       MDAC
   WHERE   mofecpro       = @dFechacartera
   AND     morutcart      = @nRutcart 
   AND     monumoper      = @nNumoper 
   AND     motipoper      = 'FLI' 
   ORDER BY mocorrela

   SELECT @contador   = 0 
   ,      @contador2  = 0 
   ,      @pagina     = 1
 
   WHILE @pagina<>0
   BEGIN

      SET ROWCOUNT 1

      SELECT @tipcart  = '*'
      SELECT @tipcart  = tipcart 
      ,      @contador = contador
      FROM   #TEMP_ii
      WHERE  contador  > @contador
      ORDER BY contador

      SET ROWCOUNT 0

      IF @tipcart='*'
         BREAK

      SELECT @contador2 = @contador2 + 1

      UPDATE #TEMP_ii SET pagina = @pagina WHERE contador=@Contador
      UPDATE #TEMP_ii SET TotalPag = @pagina

      IF @contador2 = @nTotPagina
         SELECT @pagina    = @pagina + 1 
         ,      @contador2 = 0
   END

   SELECT * FROM #TEMP_ii , #PARAMETROS

END

END



GO
