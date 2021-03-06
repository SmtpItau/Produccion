USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETA_REVENTA_ANT]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PAPELETA_REVENTA_ANT]
   (   @dFechacartera   DATETIME
   ,   @nnumoper        NUMERIC(10,0)
   ,   @ctipoImp        CHAR(01)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nrutcart     NUMERIC(09,0)
   SELECT  @nrutcart = acrutprop
   FROM    MDAC

   DECLARE @iOperDia     INTEGER
   SELECT  @iOperDia = 1
   SELECT  @iOperDia = 0
   FROM    MDMO
   WHERE   monumoper = @nNumoper
   AND     motipoper = 'RVA' 

   DECLARE @firma1          CHAR(15)
   DECLARE @firma2          CHAR(15)

   SELECT  @firma1          = Firma1
   ,       @firma2          = Firma2
   FROM    BacLineas..DETALLE_APROBACIONES
   WHERE   Numero_Operacion = @nnumoper

CREATE TABLE #paso_error 
   (      Mensaje_Error       VARCHAR(255)
   ,      Monto               NUMERIC(19,4)
   ,      sw                  CHAR(1)
   ,      NumeroCorre_Detalle NUMERIC(19,0) Identity(1,1)
   )

   DECLARE @NumeroCorre_Detalle INTEGER
   DECLARE @nMontoError         NUMERIC(19,4)
   DECLARE @cMontoFMT           CHAR(20)

   DECLARE @Tipcart        CHAR(25)
   ,       @nDiaSem        INTEGER
   ,       @nDia           INTEGER
   ,       @nMes           INTEGER
   ,       @nAnn           INTEGER
   ,       @cFecEmi        CHAR(40)
   ,       @cFecVen        CHAR(40)
   ,       @Forpai         CHAR(25)
   ,       @Forpav         CHAR(25)
   ,       @Tipocli        CHAR(25)
   ,       @Tipcli         NUMERIC(05)
   ,       @Cust           CHAR(01)
   ,       @Custodia       CHAR(25)
   ,       @Rutcli         NUMERIC(9,0)
   ,       @Dig            CHAR(01)
   ,       @Codcli         NUMERIC(9,0)
   ,       @Nomcli         CHAR(40)
   ,       @Comcli         CHAR(25)
   ,       @Dircli         CHAR(40)
   ,       @Foncli         CHAR(15)
   ,       @Faxcli         CHAR(15)
   ,       @Nomoper        CHAR(40)
   ,       @Ret            CHAR(01)
   ,       @Retiro         CHAR(15)
   ,       @nRutcar        NUMERIC(09,0)
   ,       @nomemp         CHAR(40)
   ,       @rutpro         CHAR(12)
   ,       @comemp         CHAR(25)
   ,       @Diremp         CHAR(40)
   ,       @fecpro         CHAR(10)
   ,       @Totalc         NUMERIC(19,2)
   ,       @Totalv         NUMERIC(19,2)
   ,       @monpac         CHAR(05)
   ,       @monpacto       NUMERIC(03,0)
   ,       @monglo         CHAR(20)
   ,       @mtoesc         CHAR(170)
   ,       @Obser          CHAR(60)
   ,       @valmon         NUMERIC(19,4)
   ,       @NumSol         NUMERIC(9,0)
   ,       @linea1         CHAR(65)
   ,       @linea2         CHAR(65)
   ,       @linea3         CHAR(65)
   ,       @linea4         CHAR(65)
   ,       @linea5         CHAR(65)
   ,       @glocopia       CHAR(25)
   ,       @nCopia         INTEGER
   ,       @Pagina         INTEGER
   ,       @nTotPagina     INTEGER
   ,       @contador       NUMERIC(19,0)
   ,       @contador2      NUMERIC(19,0)
   ,       @nUfhoy         FLOAT
   ,       @EstadoPeracion VARCHAR(100)
   ,       @nRedondeo	   INTEGER

   SELECT  @glocopia = '.'

   IF @cTipoImp='P'
      SELECT @nTotPagina = 12
   ELSE
      SELECT @nTotPagina = 10

IF @iOperDia = 0
BEGIN

   SELECT @Totalc   = SUM(movalinip) 
   ,      @Totalv   = SUM(movalvenp)
   FROM   MDMO
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'

   SELECT DISTINCT 
          @tipcart  = ISNULL(rcnombre,'')
   FROM   MDMO
          LEFT JOIN BacParamSuda..TIPO_CARTERA ON rcsistema = 'BTR' AND rcrut = motipcart 
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'

   SELECT @nDiaSem  = DATEPART(WEEKDAY,mofecpro)
   ,      @nDia     = DATEPART(DAY,mofecpro)
   ,      @nMes     = DATEPART(MONTH,mofecpro)
   ,      @nAnn     = DATEPART(YEAR,mofecpro)
   FROM   MDMO
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA' 

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

   SELECT @linea2   = ' ' 
   ,      @linea3   = ' ' 
   ,      @linea4   = ' ' 
   ,      @nUfhoy   = 1.0

   SELECT @nDiaSem  = DATEPART(WEEKDAY,mofecvenp) 
   ,      @nDia     = DATEPART(DAY,mofecvenp) 
   ,      @nMes     = DATEPART(MONTH,mofecvenp) 
   ,      @nAnn     = DATEPART(YEAR,mofecvenp)
   FROM   MDMO
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'

   IF @nMes= 1 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 2 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 3 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Marzo de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 4 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Abril de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 5 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Mayo de '      +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 6 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Junio de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 7 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Julio de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 8 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Agosto de '    +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 9 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+CONVERT(CHAR(4),@nAnn)
   IF @nMes=10 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Octubre de '   +CONVERT(CHAR(4),@nAnn)
   IF @nMes=11 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' +CONVERT(CHAR(4),@nAnn)
   IF @nMes=12 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' +CONVERT(CHAR(4),@nAnn)

   IF @nDiaSem=1 SELECT @cFecVen = 'Domingo '  +@cFecVen
   IF @nDiaSem=2 SELECT @cFecVen = 'Lunes '    +@cFecVen
   IF @nDiaSem=3 SELECT @cFecVen = 'Martes '   +@cFecVen
   IF @nDiaSem=4 SELECT @cFecVen = 'Miercoles '+@cFecVen
   IF @nDiaSem=5 SELECT @cFecVen = 'Jueves '   +@cFecVen
   IF @nDiaSem=6 SELECT @cFecVen = 'Viernes '  +@cFecVen
   IF @nDiaSem=7 SELECT @cFecVen = 'Sabado '   +@cFecVen

   SELECT @Forpai   = glosa 
   FROM   MDMO 
          LEFT JOIN VIEW_FORMA_DE_PAGO ON codigo = moforpagv
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'

   SELECT @Forpav   = glosa
   FROM   MDMO
          LEFT JOIN VIEW_FORMA_DE_PAGO ON codigo = moforpagv
   WHERE  monumoper = @nNumoper
  AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'

   SELECT @Cust           = mocondpacto 
   ,      @Obser          = moobserv 
   ,      @linea1         = moobserv2 
   ,      @NumSol         = monsollin 
   ,      @Codcli         = mocodcli 
   ,      @Rutcli         = morutcli 
   ,      @Ret            = motipret 
   ,      @Nomoper        = nombre 
   ,      @EstadoPeracion = CASE WHEN mostatreg = 'P' THEN 'OPERACION PENDIENTE DE APROBACION' ELSE '' END 
   FROM   MDMO
          LEFT JOIN VIEW_USUARIO ON SUBSTRING(usuario,1,12) = mousuario
   WHERE  monumoper       = @nNumoper 
   AND    morutcart       = @nRutcart 
   AND    motipoper       = 'RVA' 

   IF @Cust='S'
      SELECT @Custodia = 'Con Custodia'
   ELSE
      SELECT @Custodia = 'Sin Custodia'
          
   SELECT @Nomcli  = clnombre  
   ,      @Dircli  = cldirecc  
   ,      @Foncli  = clfono  
   ,      @Faxcli  = clfax   
   ,      @Tipcli  = cltipcli  
   ,      @Dig     = ISNULL(cldv,'')
   FROM   VIEW_CLIENTE
   WHERE  clrut    = @Rutcli
   AND    clcodigo = @codcli

   SELECT @Comcli                    = ISNULL(view_ciudad_comuna.nom_ciu,'')
   FROM   VIEW_CLIENTE
   ,      VIEW_CIUDAD_COMUNA
   WHERE  clrut                      = @Rutcli 
   AND    view_ciudad_comuna.cod_ciu = clciudad 
   AND    view_ciudad_comuna.cod_com = clcomuna

   SELECT @Tipocli = tbglosa 
   FROM   VIEW_TABLA_GENERAL_DETALLE
   WHERE  tbcateg  = 207 
   AND    convert(integer,tbcodigo1) = CONVERT(INTEGER,@Tipcli)

   IF @Ret='V'
      SELECT @Retiro = 'Vamos'
   ELSE
      SELECT @Retiro = 'Vienen'

   SELECT @nomemp = ISNULL(acnomprop,'')    
   ,      @rutpro = STR(acrutprop)+'-'+acdigprop   
   ,      @comemp = ISNULL(accomprop,'')    
   ,      @diremp = ISNULL(acdirprop,'')    
   ,      @fecpro = ISNULL(CONVERT(CHAR(10),acfecproc,103),'')
   FROM   MDAC

   SELECT @Monpac    = mnnemo  
   ,      @Monpacto  = momonpact  
   ,      @monglo    = RTRIM(mnGLOSA)
   FROM   MDMO   
          LEFT JOIN VIEW_MONEDA ON mncodmon = momonpact
   WHERE  morutcart  = @nRutcart 
   AND    monumoper  = @nNumoper 
   AND    motipoper  = 'RVA'

   SELECT @valmon   = vmvalor
   FROM   MDMO
   ,      VIEW_VALOR_MONEDA
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'
   AND    vmfecha   = mofecinip 
   AND    vmcodigo  = (CASE WHEN momonpact = 13 THEN 994 ELSE momonpact END) 

   SELECT @nUfhoy   = vmvalor
   FROM   MDMO
   ,      VIEW_VALOR_MONEDA 
   ,      MDAC
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'
   AND    vmfecha   = acfecproc 
   AND    vmcodigo  = (CASE WHEN momonpact = 13 THEN 994 ELSE momonpact END) 

   IF @valmon=NULL
      SELECT @valmon = 1.0   SELECT @nRedondeo = mndecimal
   FROM   MDMO
          LEFT JOIN VIEW_MONEDA ON mncodmon = momonpact 
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'

   EXECUTE Sp_MontoEscrito @TotalC, @Mtoesc OUTPUT

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
      SET    Mensaje_Error        = LTRIM(RTRIM(Mensaje_Error)) + '  ' + @cMontoFMT
      ,      sw                   = 'S'
      WHERE  @NumeroCorre_Detalle = NumeroCorre_Detalle
   END

   SELECT @linea1 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 1
   SELECT @linea2 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 2
   SELECT @linea3 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 3

   IF EXISTS(SELECT Operador_Ap_LINEAS FROM view_aprobacion_operaciones, mdac WHERE id_sistema = 'BTR' AND NumeroOperacion = @nNumoper AND FechaOperacion = acfecproc)
   BEGIN
      SELECT @EstadoPeracion = CASE Estado WHEN 'A' THEN 'OPERACION APROBABA POR :   '  + Operador_Ap_LINEAS
                                           WHEN 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_LINEAS
                                           ELSE ''
                               END
      FROM   VIEW_APROBACION_OPERACIONES, MDAC
      WHERE id_sistema       = 'BTR'
      AND   NumeroOperacion  = @nNumoper
      AND   FechaOperacion   = acfecproc
   END

   SELECT 'nomemp'        = ISNULL(@nomemp,'')     
   ,      'rutemp'        = ISNULL(@rutpro,'')     
   ,      'fecpro'        = ISNULL(@fecpro,'')     
   ,      'tipcart'       = ISNULL(@tipcart,'')     
   ,      'fecemision'    = ISNULL(@cFecEmi,'')     
   ,      'numoper'       = ISNULL(monumoper,0)     
   ,      'totalc'        = ISNULL(movalinip, 0)     
   ,      'forpai'        = ISNULL(@forpai,'')      
   ,      'totalv'        = ISNULL(movalvenp,0)     
   ,      'forpav'        = ISNULL(@forpav,'')      
   ,      'tasapacto'     = ISNULL(motaspact,0)      
   ,      'base'          = ISNULL(mobaspact,0)     
   ,      'plazo'         = ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0)  
   ,      'fecvto'        = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')  
   ,      'correla'       = ISNULL(mocorrela,0)     
   ,      'serie'         = ISNULL(moinstser,'')     
   ,      'emisor'        = ISNULL(emgeneric,'')     
   ,      'Moneda'        = ISNULL(mnnemo,'')                        
   ,      'nominal'       = ISNULL(monominal,0)     
   ,      'tasa'          = ISNULL(motir,0)     
   ,      'totalcum'      = ISNULL(ROUND(movalinip/@valmon,@nRedondeo),0)   
   ,      'custodia'      = ISNULL(@Custodia,'')     
   ,      'tipcli'        = ISNULL(@Tipocli,'')     
   ,      'tipret'        = ISNULL(@Retiro,'')     
   ,      'rutcli'        = STR(@Rutcli)+'-'+@Dig     
   ,      'codcli'        = ISNULL(@Codcli,0)     
   ,      'nomcli'        = ISNULL(@Nomcli,'')     
   ,      'dircli'        = ISNULL(@Dircli,'')        
   ,      'foncli'        = ISNULL(@Foncli,'')     
   ,      'faxcli'        = ISNULL(@Faxcli,'')     
   ,      'observa'       = ISNULL(@Obser,'')     
   ,      'nomope'        = ISNULL(@Nomoper,'')     
   ,      'Monpacto'      = ISNULL(@monpac,'')     
   ,      'Fec_emi'       = ISNULL(CONVERT(CHAR(10),mofecemi,103),'')  
   ,      'Fec_ven'       = ISNULL(CONVERT(CHAR(10),mofecven,103),'')  
   ,      'Mtoesc'        = ISNULL(SUBSTRING(@mtoesc,1,120),'')   
   ,      'Fec_Compra'    = ISNULL(CONVERT(CHAR(10),mofecinip,103),'')  
   ,      'sFecven'       = ISNULL(@cFecven,'')     
   ,      'comcli'        = ISNULL(@monglo,'')            
   ,      'comemp'        = ISNULL(@comemp,'')     
   ,      'Diremp'        = ISNULL(@diremp,'')     
   ,      'Linea1'        = ISNULL(@linea1,'')     
   ,      'Linea2'        = ISNULL(@linea2,'')     
   ,      'Linea3'        = ISNULL(@linea3,'')     
   ,      'Linea4'        = ISNULL(@linea4,'')     
   ,      'Linea5'        = ISNULL(@linea5,'')     
   ,      'copia'         = ISNULL(@glocopia,'')     
   ,      'Pagina'        = 0       
   ,      'contador'      = ISNULL(mocorrela,0)     
   ,      'vvista'        = ISNULL(movvista,0)     
   ,      'TotalPag'      = 0       
   ,      'fecharva'      = CONVERT(CHAR(10),mofecpro,103)   
   ,      'tasarva'       = ISNULL(motasant,0)     
   ,      'totalrv'       = ISNULL(movalvenp,0)
   ,      'diferenciarva' = CONVERT(FLOAT,0)     
   ,      'fechainicial'  = CONVERT(CHAR(10),mofecinip,103)   
   ,   'plazorva'      = DATEDIFF(DAY,mofecinip,mofecpro)   
   ,      'totalrvum'     = ISNULL(ROUND(movpresen/@nUfhoy,@nRedondeo),0)   
   ,      'hora'          = mohora      
   ,      'EstadoPeracion'= @EstadoPeracion 
   ,      'Firma1'        = @firma1 
   ,      'Firma2'        = @firma2 
   INTO   #Temp
   FROM   MDMO
          LEFT JOIN VIEW_EMISOR ON emrut    = morutemi
          LEFT JOIN VIEW_MONEDA ON mncodmon = momonemi
   ,      MDAC
   WHERE  morutcart       = @nRutcart 
   AND    monumoper       = @nNumoper 
   AND    motipoper       = 'RVA' 
   ORDER BY mocorrela
   
   UPDATE #TEMP      SET totalv = ISNULL((SELECT SUM(movalvenp) FROM MDMH WHERE monumoper = @nnumoper AND motipoper = 'CI'),0)

   SELECT @contador  = 0 
   ,      @contador2 = 0 
   ,      @pagina    = 1

   WHILE @pagina<>NULL
   BEGIN
  
      SET ROWCOUNT 1

      SELECT @tipcart  = '*'
      SELECT @tipcart  = tipcart 
      ,      @contador = contador
      FROM   #Temp
      WHERE  contador  > @contador
      ORDER BY contador

      SET ROWCOUNT 0

      IF @tipcart='*'
         BREAK

      SELECT @contador2 = @contador2 + 1

      UPDATE #TEMP SET pagina   = @pagina WHERE contador = @Contador
      UPDATE #TEMP SET TotalPag = @pagina

      IF @contador2=@nTotPagina
         SELECT @pagina    = @pagina + 1 
         ,      @contador2 = 0
   END
 
   SELECT 'nomemp'       = nomemp 
   ,      'rutemp'       = rutemp 
   ,      'fecpro'       = fecpro 
   ,      'tipcart'      = tipcart 
   ,      'fecemision'   = fecemision 
   ,      'numoper'      = numoper 
   ,      'totalc'       = totalc 
   ,      'forpai'       = forpai 
   ,      'totalv'       = totalv 
   ,      'forpav'       = forpav 
   ,      'tasapacto'    = tasapacto 
   ,      'base'         = base  
   ,      'plazo'        = plazo  
   ,      'fecvto'       = fecvto 
   ,      'correla'      = correla 
   ,      'serie'        = serie  
   ,      'emisor'       = emisor 
   ,      'Moneda'       = moneda 
   ,      'nominal'      = nominal 
   ,      'tasa'         = tasa  
   ,      'totalcum'     = totalcum 
   ,      'custodia'     = Custodia 
   ,      'tipcli'       = Tipcli 
   ,      'tipret'       = tipret 
   ,      'rutcli'       = rutcli 
   ,      'codcli'       = Codcli 
   ,      'nomcli'       = Nomcli 
   ,      'dircli'       = Dircli 
   ,      'foncli'       = Foncli 
   ,      'faxcli'       = Faxcli 
   ,      'observa'      = Observa 
   ,      'nomope'       = Nomope 
   ,      'Monpacto'     = monpacto 
   ,      'Fec_emi'      = Fec_emi 
   ,      'Fec_ven'      = Fec_ven 
   ,      'Mtoesc'       = mtoesc 
   ,      'Fec_Compra'   = Fec_Compra    
   ,      'sFecven'      = sFecven 
   ,      'comcli'       = comcli 
   ,      'comemp'       = comemp 
   ,      'Diremp'       = diremp 
   ,      'Linea1'       = linea1 
   ,      'Linea2'       = linea2 
   ,      'Linea3'       = linea3 
   ,      'Linea4'       = linea4 
   ,      'Linea5'       = linea5 
   ,      'copia'        = copia  
   ,      'Pagina'       = pagina 
   ,      'contador'     = contador 
   ,      'vvista'       = vvista 
   ,      'TotalPag'     = totalpag 
   ,      'fecharva'     = fecharva 
   ,      'tasarva'      = tasarva 
   ,      'totalrv'      = totalrv 
   ,      'diferenciarva'= diferenciarva 
   ,      'fechainicial' = fechainicial  
   ,      'plazorva'     = plazorva 
   ,      'totalrvum'    = totalrvum 
   ,      'hora'         = hora
   ,      'Firma1'       = @firma1 
   ,      'Firma2'       = @firma2 
   FROM   #Temp

END

IF @iOperDia = 1
BEGIN

   SELECT @Totalc   = SUM(movalinip) 
   ,      @Totalv   = SUM(movalvenp)
   FROM   MDMH
   WHERE  mofecpro  = @dFechacartera 
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'

   SELECT DISTINCT 
          @tipcart  = ISNULL(rcnombre,'')
   FROM   MDMH
          LEFT JOIN BacParamSuda..TIPO_CARTERA ON rcsistema = 'BTR' AND rcrut = motipcart 
   WHERE  mofecpro  = @dFechacartera 
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'

   SELECT @nDiaSem  = DATEPART(WEEKDAY,mofecpro)
   ,      @nDia     = DATEPART(DAY,mofecpro)
   ,      @nMes     = DATEPART(MONTH,mofecpro)
   ,      @nAnn     = DATEPART(YEAR,mofecpro)
   FROM   MDMH
   WHERE  mofecpro  = @dFechacartera 
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA' 

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

   SELECT @linea2   = ' ' 
   ,      @linea3   = ' ' 
   ,      @linea4   = ' ' 
   ,      @nUfhoy   = 1.0

   SELECT @nDiaSem  = DATEPART(WEEKDAY,mofecvenp) 
   ,      @nDia     = DATEPART(DAY,mofecvenp) 
   ,      @nMes     = DATEPART(MONTH,mofecvenp) 
   ,      @nAnn     = DATEPART(YEAR,mofecvenp)
   FROM   MDMH
   WHERE  mofecpro  = @dFechacartera 
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'

   IF @nMes= 1 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 2 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 3 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Marzo de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 4 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Abril de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 5 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Mayo de '      +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 6 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Junio de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 7 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Julio de '     +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 8 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Agosto de '    +CONVERT(CHAR(4),@nAnn)
   IF @nMes= 9 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+CONVERT(CHAR(4),@nAnn)
   IF @nMes=10 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Octubre de '   +CONVERT(CHAR(4),@nAnn)
   IF @nMes=11 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' +CONVERT(CHAR(4),@nAnn)
   IF @nMes=12 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' +CONVERT(CHAR(4),@nAnn)

   IF @nDiaSem=1 SELECT @cFecVen = 'Domingo '  +@cFecVen
   IF @nDiaSem=2 SELECT @cFecVen = 'Lunes '    +@cFecVen
   IF @nDiaSem=3 SELECT @cFecVen = 'Martes '   +@cFecVen
   IF @nDiaSem=4 SELECT @cFecVen = 'Miercoles '+@cFecVen
   IF @nDiaSem=5 SELECT @cFecVen = 'Jueves '   +@cFecVen
   IF @nDiaSem=6 SELECT @cFecVen = 'Viernes '  +@cFecVen
   IF @nDiaSem=7 SELECT @cFecVen = 'Sabado '   +@cFecVen

   SELECT @Forpai   = glosa 
   FROM   MDMH
          LEFT JOIN VIEW_FORMA_DE_PAGO ON codigo = moforpagv
   WHERE  mofecpro  = @dFechacartera 
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'

   SELECT @Forpav   = glosa
   FROM   MDMH
          LEFT JOIN VIEW_FORMA_DE_PAGO ON codigo = moforpagv
   WHERE  mofecpro  = @dFechacartera 
   AND    monumoper = @nNumoper
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'

   SELECT @Cust           = mocondpacto 
   ,      @Obser          = moobserv 
   ,      @linea1         = moobserv2 
   ,      @NumSol         = monsollin 
   ,      @Codcli         = mocodcli 
   ,      @Rutcli         = morutcli 
   ,      @Ret            = motipret 
   ,      @Nomoper        = nombre 
   ,      @EstadoPeracion = CASE WHEN mostatreg = 'P' THEN 'OPERACION PENDIENTE DE APROBACION' ELSE '' END 
   FROM   MDMH
          LEFT JOIN VIEW_USUARIO ON SUBSTRING(usuario,1,12) = mousuario
   WHERE  mofecpro        = @dFechacartera 
   AND    monumoper       = @nNumoper 
   AND    morutcart       = @nRutcart 
   AND    motipoper       = 'RVA' 

   IF @Cust='S'
      SELECT @Custodia = 'Con Custodia'
   ELSE
      SELECT @Custodia = 'Sin Custodia'
          
   SELECT @Nomcli  = clnombre  
   ,      @Dircli  = cldirecc  
   ,      @Foncli  = clfono  
   ,      @Faxcli  = clfax   
   ,      @Tipcli  = cltipcli  
   ,      @Dig     = ISNULL(cldv,'')
   FROM   VIEW_CLIENTE
   WHERE  clrut    = @Rutcli
   AND    clcodigo = @codcli

   SELECT @Comcli                    = ISNULL(view_ciudad_comuna.nom_ciu,'')
   FROM   VIEW_CLIENTE
   ,      VIEW_CIUDAD_COMUNA
   WHERE  clrut                      = @Rutcli 
   AND    view_ciudad_comuna.cod_ciu = clciudad 
   AND    view_ciudad_comuna.cod_com = clcomuna

   SELECT @Tipocli = tbglosa 
   FROM   VIEW_TABLA_GENERAL_DETALLE
   WHERE  tbcateg  = 207 
   AND    convert(integer,tbcodigo1) = CONVERT(INTEGER,@Tipcli)

   IF @Ret='V'
      SELECT @Retiro = 'Vamos'
   ELSE
      SELECT @Retiro = 'Vienen'

   SELECT @nomemp = ISNULL(acnomprop,'')    
   ,      @rutpro = STR(acrutprop)+'-'+acdigprop   
   ,      @comemp = ISNULL(accomprop,'')    
   ,      @diremp = ISNULL(acdirprop,'')    
   ,      @fecpro = ISNULL(CONVERT(CHAR(10),acfecproc,103),'')
   FROM   MDAC

   SELECT @Monpac    = mnnemo  
   ,      @Monpacto  = momonpact  
   ,      @monglo    = RTRIM(mnGLOSA)
   FROM   MDMH
          LEFT JOIN VIEW_MONEDA ON mncodmon = momonpact
   WHERE  mofecpro   = @dFechacartera 
   AND    monumoper  = @nNumoper 
   AND    morutcart  = @nRutcart 
   AND    motipoper  = 'RVA'

   SELECT @valmon   = vmvalor
   FROM   MDMH
   ,      VIEW_VALOR_MONEDA
   WHERE  mofecpro  = @dFechacartera 
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'
   AND    vmfecha   = mofecinip 
   AND    vmcodigo  = (CASE WHEN momonpact = 13 THEN 994 ELSE momonpact END) 

   SELECT @nUfhoy   = vmvalor
   FROM   MDMH
   ,      VIEW_VALOR_MONEDA 
   ,      MDAC
   WHERE  mofecpro  = @dFechacartera 
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'
   AND    vmfecha   = acfecproc 
   AND    vmcodigo  = (CASE WHEN momonpact = 13 THEN 994 ELSE momonpact END) 

   IF @valmon=NULL
      SELECT @valmon = 1.0   SELECT @nRedondeo = mndecimal
   FROM   MDMH
          LEFT JOIN VIEW_MONEDA ON mncodmon = momonpact 
   WHERE  mofecpro  = @dFechacartera 
   AND    monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'RVA'

   EXECUTE Sp_MontoEscrito @TotalC, @Mtoesc OUTPUT

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
      SET    Mensaje_Error        = LTRIM(RTRIM(Mensaje_Error)) + '  ' + @cMontoFMT
      ,      sw                   = 'S'
      WHERE  @NumeroCorre_Detalle = NumeroCorre_Detalle
   END

   SELECT @linea1 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 1
   SELECT @linea2 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 2
   SELECT @linea3 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 3

   IF EXISTS(SELECT Operador_Ap_LINEAS FROM view_aprobacion_operaciones, mdac WHERE id_sistema = 'BTR' AND NumeroOperacion = @nNumoper AND FechaOperacion = acfecproc)
   BEGIN
      SELECT @EstadoPeracion = CASE Estado WHEN 'A' THEN 'OPERACION APROBABA POR :   '  + Operador_Ap_LINEAS
                                           WHEN 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_LINEAS
                                           ELSE ''
                               END
      FROM   VIEW_APROBACION_OPERACIONES, MDAC
      WHERE id_sistema       = 'BTR'
      AND   NumeroOperacion  = @nNumoper
      AND   FechaOperacion   = acfecproc
   END

   SELECT 'nomemp'        = ISNULL(@nomemp,'')     
   ,      'rutemp'        = ISNULL(@rutpro,'')     
   ,      'fecpro'        = ISNULL(@fecpro,'')     
   ,      'tipcart'       = ISNULL(@tipcart,'')     
   ,      'fecemision'    = ISNULL(@cFecEmi,'')     
   ,      'numoper'       = ISNULL(monumoper,0)     
   ,      'totalc'        = ISNULL(movalinip, 0)     
   ,      'forpai'        = ISNULL(@forpai,'')      
   ,      'totalv'        = ISNULL(movalvenp,0)     
   ,      'forpav'        = ISNULL(@forpav,'')      
   ,      'tasapacto'     = ISNULL(motaspact,0)      
   ,      'base'          = ISNULL(mobaspact,0)     
   ,      'plazo'         = ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0)  
   ,      'fecvto'        = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')  
   ,      'correla'       = ISNULL(mocorrela,0)     
   ,      'serie'         = ISNULL(moinstser,'')     
   ,      'emisor'        = ISNULL(emgeneric,'')     
   ,      'Moneda'        = ISNULL(mnnemo,'')                        
   ,      'nominal'       = ISNULL(monominal,0)     
   ,      'tasa'          = ISNULL(motir,0)     
   ,      'totalcum'      = ISNULL(ROUND(movalinip/@valmon,@nRedondeo),0)   
   ,      'custodia'      = ISNULL(@Custodia,'')     
   ,      'tipcli'        = ISNULL(@Tipocli,'')     
   ,      'tipret'        = ISNULL(@Retiro,'')     
   ,      'rutcli'        = STR(@Rutcli)+'-'+@Dig     
   ,      'codcli'        = ISNULL(@Codcli,0)     
   ,      'nomcli'        = ISNULL(@Nomcli,'')     
   ,      'dircli'        = ISNULL(@Dircli,'')        
   ,      'foncli'        = ISNULL(@Foncli,'')     
   ,      'faxcli'        = ISNULL(@Faxcli,'')     
   ,      'observa'       = ISNULL(@Obser,'')     
   ,      'nomope'        = ISNULL(@Nomoper,'')     
   ,      'Monpacto'      = ISNULL(@monpac,'')     
   ,      'Fec_emi'       = ISNULL(CONVERT(CHAR(10),mofecemi,103),'')  
   ,      'Fec_ven'       = ISNULL(CONVERT(CHAR(10),mofecven,103),'')  
   ,      'Mtoesc'        = ISNULL(SUBSTRING(@mtoesc,1,120),'')   
   ,      'Fec_Compra'    = ISNULL(CONVERT(CHAR(10),mofecinip,103),'')  
   ,      'sFecven'       = ISNULL(@cFecven,'')     
   ,      'comcli'        = ISNULL(@monglo,'')            
   ,      'comemp'        = ISNULL(@comemp,'')     
   ,      'Diremp'        = ISNULL(@diremp,'')     
   ,      'Linea1'        = ISNULL(@linea1,'')     
   ,      'Linea2'        = ISNULL(@linea2,'')     
   ,      'Linea3'        = ISNULL(@linea3,'')     
   ,      'Linea4'        = ISNULL(@linea4,'')     
   ,      'Linea5'        = ISNULL(@linea5,'')     
   ,      'copia'         = ISNULL(@glocopia,'')     
   ,      'Pagina'        = 0       
   ,      'contador'      = ISNULL(mocorrela,0)     
   ,      'vvista'        = ISNULL(movvista,0)     
   ,      'TotalPag'      = 0       
   ,      'fecharva'      = CONVERT(CHAR(10),mofecpro,103)   
   ,      'tasarva'       = ISNULL(motasant,0)     
   ,      'totalrv'       = ISNULL(movalvenp,0)
   ,      'diferenciarva' = CONVERT(FLOAT,0)     
   ,      'fechainicial'  = CONVERT(CHAR(10),mofecinip,103)   
   ,      'plazorva'      = DATEDIFF(DAY,mofecinip,mofecpro)   
   ,      'totalrvum'     = ISNULL(ROUND(movpresen/@nUfhoy,@nRedondeo),0)   
   ,      'hora'          = mohora      
   ,      'EstadoPeracion'= @EstadoPeracion 
   ,      'Firma1'        = @firma1 
   ,      'Firma2'        = @firma2 
   INTO   #Temp_ii
   FROM   MDMH
          LEFT JOIN VIEW_EMISOR ON emrut    = morutemi
          LEFT JOIN VIEW_MONEDA ON mncodmon = momonemi
   ,      MDAC
   WHERE  mofecpro        = @dFechacartera 
   AND    morutcart       = @nRutcart 
   AND    monumoper       = @nNumoper 
   AND    motipoper       = 'RVA' 
   ORDER BY mocorrela
   
   UPDATE #TEMP_ii   SET totalv = ISNULL((SELECT SUM(movalvenp) FROM MDMH WHERE monumoper = @nnumoper AND motipoper = 'CI'),0)

   SELECT @contador  = 0 
   ,      @contador2 = 0 
   ,      @pagina    = 1

   WHILE @pagina<>NULL
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

      UPDATE #TEMP_ii SET pagina   = @pagina WHERE contador = @Contador
      UPDATE #TEMP_ii SET TotalPag = @pagina

      IF @contador2 = @nTotPagina
         SELECT @pagina    = @pagina + 1 
         ,      @contador2 = 0
   END
 
   SELECT 'nomemp'       = nomemp 
   ,      'rutemp'       = rutemp 
   ,      'fecpro'       = fecpro 
   ,      'tipcart'      = tipcart 
   ,      'fecemision'   = fecemision 
   ,      'numoper'      = numoper 
   ,      'totalc'       = totalc 
   ,      'forpai'       = forpai 
   ,      'totalv'       = totalv 
   ,      'forpav'       = forpav 
   ,      'tasapacto'    = tasapacto 
   ,      'base'         = base  
   ,      'plazo'        = plazo  
   ,      'fecvto'       = fecvto 
   ,      'correla'      = correla 
   ,      'serie'        = serie  
   ,      'emisor'       = emisor 
   ,      'Moneda'       = moneda 
   ,      'nominal'      = nominal 
   ,      'tasa'         = tasa  
   ,      'totalcum'     = totalcum 
   ,      'custodia'     = Custodia 
   ,      'tipcli'       = Tipcli 
   ,      'tipret'       = tipret 
   ,      'rutcli'       = rutcli 
   ,      'codcli'       = Codcli 
   ,      'nomcli'       = Nomcli 
   ,      'dircli'       = Dircli 
   ,      'foncli'       = Foncli 
   ,      'faxcli'       = Faxcli 
   ,      'observa'      = Observa 
   ,      'nomope'       = Nomope 
   ,      'Monpacto'     = monpacto 
   ,      'Fec_emi'      = Fec_emi 
   ,      'Fec_ven'      = Fec_ven 
   ,      'Mtoesc'       = mtoesc 
   ,      'Fec_Compra'   = Fec_Compra    
   ,      'sFecven'      = sFecven 
   ,      'comcli'       = comcli 
   ,      'comemp'       = comemp 
   ,      'Diremp'       = diremp 
   ,      'Linea1'       = linea1 
   ,      'Linea2'       = linea2 
   ,      'Linea3'       = linea3 
  ,      'Linea4'       = linea4 
   ,      'Linea5'       = linea5 
   ,      'copia'        = copia  
   ,      'Pagina'       = pagina 
   ,      'contador'     = contador 
   ,      'vvista'       = vvista 
   ,      'TotalPag'     = totalpag 
   ,      'fecharva'     = fecharva 
   ,      'tasarva'      = tasarva 
   ,      'totalrv'      = totalrv 
   ,      'diferenciarva'= diferenciarva 
   ,      'fechainicial' = fechainicial  
   ,      'plazorva'     = plazorva 
   ,      'totalrvum'    = totalrvum 
   ,      'hora'         = hora
   ,      'Firma1'       = @firma1 
   ,      'Firma2'       = @firma2 
   FROM   #TEMP_ii

END


END

GO
