USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPALETA_INTERBANCARIO]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[SP_PAPALETA_INTERBANCARIO]
   (   @dFechacartera   DATETIME
   ,   @nNumoper	FLOAT
   ,   @cTipoImp	CHAR(01)
   ,   @cTitulo	        VARCHAR(100)
   ,   @cApoderado1	VARCHAR(60)
   ,   @cApoderado2	VARCHAR(60)
   ,   @RutApoderado1	VARCHAR(15)
   ,   @RutApoderado2	VARCHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nRutcart	 FLOAT 
   SELECT  @nRutcart	 = acrutprop
   FROM    MDAC

   DECLARE @Cat_Libro	 CHAR(10) 
   SELECT  @Cat_Libro	 = '1552'

   DECLARE @iOperDia     INTEGER

   SELECT  @iOperDia     = 1
   SELECT  @iOperDia     = 0
   FROM    MDMO
   WHERE   monumoper     = @nNumoper

   DECLARE @nDiaSem      INTEGER  ,
           @Iniumt       NUMERIC (19,4) ,
           @nDia         INTEGER  ,
           @nMes         INTEGER  ,
           @nAnn         INTEGER  ,
           @nDia1        INTEGER  ,
           @nMes1        INTEGER  ,
           @nAnn1        INTEGER  ,
           @cFecEmis     CHAR (40) ,
           @cFecVens     CHAR (40) ,
           @cFecEmi      CHAR (40) ,
           @cFecVen      CHAR (40) ,
           @Forpai       CHAR (25)  ,
           @Forpav       CHAR (25) ,
           @Cust         CHAR (01) ,
           @Custodia     CHAR (25) ,
           @Rutcli       NUMERIC (9,0) ,
           @Dig          CHAR (01) ,
           @Nomcli       CHAR (40) ,
           @Dircli       CHAR (40) ,
           @Nomoper      CHAR (40) ,
           @Ret          CHAR (01) ,
           @Retiro       CHAR (15) ,
           @nRutcar      NUMERIC (09,0) ,
           @nomemp       CHAR (40) ,
           @diremp       CHAR (40) ,
           @rutpro       CHAR (11) ,
           @fecpro       CHAR (10) ,
           @monpac       CHAR (05) ,
           @mtoesc       CHAR (170) ,
           @TotalC       NUMERIC (19,4) ,
           @IntESC       CHAR (170) ,
           @Interes      NUMERIC (19,4) ,
           @Obser        CHAR (80) ,
           @NumSol       NUMERIC (9,0) ,
           @linea1       CHAR (255) ,
           @linea2       CHAR (255) ,
           @linea3       CHAR (255) ,
           @linea4       CHAR (255) ,
           @linea5       CHAR (255) ,
           @glocopia     CHAR (25) ,
           @nCopia       INTEGER  ,
           @nMoneda      INTEGER  ,
           @nValinip     NUMERIC (19,4) ,
           @nValvtop     NUMERIC (19,4) ,
           @hora         CHAR(8) ,
           @nValmon      NUMERIC (19,4) ,
           @dFecinip     DATETIME ,
           @cMonLet      CHAR (120) ,
           @cPalab1      CHAR (115) ,
           @cPalab2      CHAR (115) ,
           @cPalab3      CHAR (115) ,
           @cPalab4      CHAR (115) ,
           @cValinip     CHAR (20) ,
           @cInteres     CHAR (20) ,
           @cDato        CHAR (01) ,
           @nLargo       INTEGER  ,
           @nMtopal      NUMERIC (19,4) ,
           @cSettlement  CHAR(50) ,
           @cPFE         CHAR(50) ,
           @cCCE         CHAR(50) ,
           @cEmisorInstPlazo CHAR(255) ,
           @xMiinstser   CHAR(12) ,
           @EstadoPeracion VARCHAR (100) ,
           @cApoNom1     CHAR (50) ,
           @cApoRut1     CHAR (20) ,
           @cApoNom2     CHAR (50) ,
           @cApoRut2     CHAR (20) ,
           @cApofono1    CHAR (20) ,
           @cMx          CHAR (01) 

   DECLARE @firma1       CHAR(15)
   DECLARE @firma2       CHAR(15)

   /*=======================================================================*/
   SELECT @firma1        = res.Firma1
   ,      @firma2        = res.Firma2
   FROM   BacLineas..DETALLE_APROBACIONES res
   WHERE  res.Numero_Operacion=@nNumoper
   /*=======================================================================*/

 SET ROWCOUNT 1

 SELECT @cApoRut1  = LTRIM(RTRIM(CONVERT(CHAR(9),aprutapo))) + '-' + apdvapo
   ,    @cApoNom1  = apnombre 
   ,    @cApofono1 = apfono
 FROM   VIEW_MDAPODERADO WHERE aprutcli = 97018000 ORDER BY apnombre

 SET ROWCOUNT 2

 SELECT @cApoRut2 = LTRIM(RTRIM(CONVERT(CHAR(9),aprutapo))) + '-' + apdvapo
   ,    @cApoNom2 = apnombre 
 FROM   VIEW_MDAPODERADO WHERE aprutcli = 97018000 ORDER BY apnombre

 SET ROWCOUNT 0

 IF @cTipoImp = 'P'
     SELECT @nCopia = papapimp FROM MDPA WHERE panumoper = @nNumoper
 ELSE
     SELECT @nCopia = paconimp FROM MDPA WHERE panumoper = @nNumoper
 
 IF @cTipoImp = 'P'
   SELECT  @glocopia = CASE WHEN @nCopia = 1 THEN 'COPIA MESA'
                            WHEN @nCopia = 2 THEN 'COPIA INVERSIONES'
                            WHEN @nCopia = 3 THEN 'COPIA CUSTODIA'
                            ELSE                  ' '
                       END
 ELSE
    SELECT @glocopia = CASE WHEN @nCopia = 1 THEN 'ORIGINAL CLIENTE'
                            WHEN @nCopia = 2 THEN 'COPIA CLIENTE'
                            ELSE                  ' '
                       END

 DECLARE @NumeroCorre_Detalle INTEGER
 DECLARE @nMontoError         NUMERIC(19,4)
 DECLARE @cMontoFMT           CHAR(20)

 CREATE TABLE #paso_error 
 (   Mensaje_Error       VARCHAR(255)
 ,   Monto               NUMERIC(19,4)
 ,   sw                  CHAR(1)
 ,   NumeroCorre_Detalle NUMERIC(19,0) Identity(1,1)
 )

IF @iOperDia = 0 --> Operacion esta en tabla del Día
BEGIN

   SELECT @nDiaSem        = DATEPART(WEEKDAY,mofecinip) 
   ,      @nDia           = DATEPART(DAY,mofecinip) 
   ,      @nMes           = DATEPART(MONTH,mofecinip) 
   ,      @nAnn           = DATEPART(YEAR,mofecinip) 
   ,      @nDia1          = DATEPART(DAY,mofecinip) 
   ,      @nMes1          = DATEPART(MONTH,mofecinip) 
   ,      @nAnn1          = DATEPART(YEAR,mofecinip) 
   ,      @dFecinip       = mofecinip   
   ,      @NumSol         = monsollin   
   ,      @Obser          = moobserv   
   ,      @nMoneda        = momonpact   
   ,      @hora           = mohora   
   ,      @xMiinstser     = moinstser   
   ,      @EstadoPeracion = CASE WHEN mostatreg = 'P' THEN 'OPERACION PENDIENTE DE APROBACION' ELSE '' END 
   ,      @TotalC         = movalinip  
   ,      @nValinip       = movalinip  
   ,      @Cust           = mocondpacto  
   ,      @Rutcli         = morutcli  
   ,      @Ret            = motipret   
   ,      @Interes        = movalvenp - movalinip 
   ,      @nValvtop       = movalvenp
   ,      @Monpac         = mnnemo
   ,      @Forpai         = i.glosa 
   ,      @Forpav         = v.glosa
   ,      @Nomoper        = usr.nombre
   ,      @Nomcli         = clnombre 
   ,      @Dircli         = cldirecc 
   ,      @Dig            = cldv
   ,      @cMx            = CASE WHEN mnmx = 'C' THEN 'S' ELSE 'N' END 
   FROM   MDMO
          INNER JOIN BacParamSuda..CLIENTE         ON clrut     = morutcli and clcodigo = mocodcli
          INNER JOIN BacParamSuda..MONEDA          ON mncodmon  = momonpact
          INNER JOIN BacParamSuda..FORMA_DE_PAGO i ON i.codigo  = moforpagi
          INNER JOIN BacParamSuda..FORMA_DE_PAGO v ON v.codigo  = moforpagv
          LEFT  JOIN BacParamSuda..USUARIO     usr ON SUBSTRING(usr.usuario,1,12) = mousuario
   WHERE  monumoper       = @nNumoper  
   AND    morutcart       = @nRutcart  
   AND    motipoper       = 'IB' 

   IF @nMes =  1  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Enero de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  2  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Febrero de '    + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  3  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Marzo de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  4  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Abril de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  5  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Mayo de '       + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  6  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Junio de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  7  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Julio de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  8  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Agosto de '     + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  9  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Septiembre de ' + CONVERT(CHAR(4),@nAnn)
   IF @nMes = 10  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Octubre de '    + CONVERT(CHAR(4),@nAnn)
   IF @nMes = 11  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Noviembre de '  + CONVERT(CHAR(4),@nAnn)
   IF @nMes = 12  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Diciembre de '  + CONVERT(CHAR(4),@nAnn)

   IF @nDiaSem = 1 SELECT @cFecEmis = 'Domingo '   + @cFecEmis
   IF @nDiaSem = 2 SELECT @cFecEmis = 'Lunes '     + @cFecEmis
   IF @nDiaSem = 3 SELECT @cFecEmis = 'Martes '    + @cFecEmis
   IF @nDiaSem = 4 SELECT @cFecEmis = 'Miercoles ' + @cFecEmis
   IF @nDiaSem = 5 SELECT @cFecEmis = 'Jueves '    + @cFecEmis
   IF @nDiaSem = 6 SELECT @cFecEmis = 'Viernes '   + @cFecEmis
   IF @nDiaSem = 7 SELECT @cFecEmis = 'Sabado '    + @cFecEmis

   SELECT @nDiaSem  = DATEPART(WEEKDAY,mofecvenp) 
   ,      @nDia     = DATEPART(DAY,mofecvenp) 
   ,      @nMes     = DATEPART(MONTH,mofecvenp) 
   ,      @nAnn     = DATEPART(YEAR,mofecvenp) 
   ,      @nDia1    = DATEPART(DAY,mofecvenp) 
   ,      @nMes1    = DATEPART(MONTH,mofecvenp) 
   ,      @nAnn1    = DATEPART(YEAR,mofecvenp) 
   FROM   MDMO
   WHERE  monumoper = @nNumoper 
   AND    morutcart = @nRutcart 
   AND    motipoper = 'IB' 

   IF @nMes =  1  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Enero de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  2  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Febrero de '    + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  3  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Marzo de '      + CONVERT(CHAR(4),@nAnn) 
   IF @nMes =  4  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Abril de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  5  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Mayo de '       + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  6  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Junio de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  7  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Julio de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  8  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Agosto de '     + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  9  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Septiembre de ' + CONVERT(CHAR(4),@nAnn)
   IF @nMes = 10  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Octubre de '    + CONVERT(CHAR(4),@nAnn)
   IF @nMes = 11  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Noviembre de '  + CONVERT(CHAR(4),@nAnn)
   IF @nMes = 12  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Diciembre de '  + CONVERT(CHAR(4),@nAnn)

   IF @nDiaSem = 1 SELECT @cFecVens = 'Domingo '   + @cFecVens
   IF @nDiaSem = 2 SELECT @cFecVens = 'Lunes '     + @cFecVens
   IF @nDiaSem = 3 SELECT @cFecVens = 'Martes '    + @cFecVens
   IF @nDiaSem = 4 SELECT @cFecVens = 'Miercoles ' + @cFecVens
   IF @nDiaSem = 5 SELECT @cFecVens = 'Jueves '    + @cFecVens
   IF @nDiaSem = 6 SELECT @cFecVens = 'Viernes '   + @cFecVens
   IF @nDiaSem = 7 SELECT @cFecVens = 'Sabado '    + @cFecVens

   IF @nmoneda  = 999 
      SELECT @cMonLet = 'Pesos   m/l,   por  concepto   de   intereses, ' 
      ,      @cPalab4 = 'valores   que   me   obligo   a   pagar    en   esta   ciudad   calle'
   ELSE
      IF @nmoneda  = 13 
         SELECT @cMonLet = 'Dólares de los Estados Unidos de Norteamérica, por concepto de intereses, '
         ,      @cPalab4 = 'valores que me obligo a pagar en '

   SELECT @nMtopal = @TotalC
   SELECT @Iniumt  = @TotalC


   IF @nMoneda <> 999 AND @cMx <> 'S'
   BEGIN 
      SELECT @nValmon = ISNULL(vmvalor,0.0) FROM BacParamSuda..VALOR_MONEDA WHERE vmcodigo = @nMoneda AND vmfecha=@dfecinip
      IF @nValmon>0
      BEGIN 
         SELECT @nValinip  = @TotalC
         SELECT @Interes   = @nValvtop - ROUND(@TotalC/@nValmon,4)
         ,      @nMtopal   = @nValinip
         ,      @Iniumt    = ROUND(@TotalC/@nValmon,4)
      END 

      IF @nmoneda = 998
         SELECT @cMonlet = 'Unidades de Fomento m/l,  por concepto de  intereses, '
         ,      @cPalab4 = 'valores  que  me  obligo a  pagar  en  esta  ciudad  calle'
      ELSE
         SELECT @cMonLet = 'Dólares de los Estados Unidos de Norteamérica, por concepto de intereses, '
         ,      @cPalab4 = 'valores que me obligo a pagar en'
   END

   SELECT @nValinip = CONVERT(NUMERIC(19,4),@nValinip)
   SELECT @cValinip = CONVERT(CHAR,CONVERT(NUMERIC(19,0),@nValinip))
   SELECT @nLargo   = DATALENGTH(LTRIM(RTRIM(@cValinip)))
   SELECT @cInteres = CASE WHEN @nmoneda = 999 THEN CONVERT(CHAR,CONVERT(NUMERIC(19,0),@Interes))
                           WHEN @nmoneda = 998 THEN CONVERT(CHAR,CONVERT(NUMERIC(19,4),@Interes))
                           ELSE                     CONVERT(CHAR,CONVERT(NUMERIC(19,2),@Interes))
                      END
   IF @nmoneda = 999 
      SELECT @nLargo  = DATALENGTH(LTRIM(RTRIM(@cInteres)))
   ELSE
      SELECT @nLargo  = DATALENGTH(SUBSTRING(@cInteres,1,CHARINDEX('.',@cInteres)-1))

   IF @nmoneda <> 999 
      SELECT @cInteres = STUFF(@cInteres,CHARINDEX('.',@cInteres),1,',')

   WHILE @nLargo-3 > 0
   BEGIN
      SELECT @cDato = SUBSTRING(@cInteres,@nLargo-3,1)

      IF @cDato <> ''
         SELECT @cInteres = STUFF(@cInteres, @nLargo-3,1,@cDato+'.')

      SELECT @nLargo   = DATALENGTH(SUBSTRING(@cInteres,1,CHARINDEX('.',@cInteres)-1))
   END

   IF @nMoneda = 999
   BEGIN
      IF @nRutcart <> 97029000
         SELECT @cPalab1 = '$' + @cValinip 
         ,      @cPalab3 = '' 
         ,      @cPalab2 = '' 
      ELSE 
         SELECT @cPalab1 = 'la suma de $ ' +@cValinip+'.-'     
         ,      @cPalab3 = 'Pesos m/l, por concepto de capital, '
         ,      @cPalab2 = 'más la suma de $  ' + @cInteres
   END ELSE
   BEGIN
      IF @nMoneda=998
         SELECT @cPalab1 = 'la suma de dinero equivalente en pesos moneda legal de ' + RTRIM(@Monpac) + ' ' + @cValinip + '.-'
         ,      @cPalab3 = 'Unidades de Fomento, por concepto de capital, '
         ,      @cPalab2 = 'más la suma de dinero equivalente en moneda legal de UF ' + @cInteres
     ELSE
         SELECT @cPalab1 = 'la cantidad en pesos moneda nacional equivalente a US$ ' + @cValinip + '.-'
         ,      @cPalab3 = 'Dólares de los Estados Unidos de América, por concepto de capital que he recibido en préstamo,  '
         ,      @cPalab2 = 'más intereses del '
   END

   IF @Cust='S'
      SELECT @Custodia = 'Con Custodia'
   ELSE
      SELECT @Custodia = 'Sin Custodia'
     
   IF @Ret='V'
      SELECT @Retiro = 'VAMOS'
   ELSE
      SELECT @Retiro = 'VIENEN'
        
   SELECT @nomemp = ISNULL(acnomprop,'')
   ,      @diremp = acdirprop
   ,      @rutpro = ISNULL(RTRIM(CONVERT(CHAR(09),acrutprop)) + '-' + acdigprop,'')
   ,      @fecpro = CONVERT(CHAR(10),@dFechacartera,103) -- ISNULL(CONVERT(CHAR(10),acfecproc,103),'')
   FROM   MDAC

   -- EXECUTE Sp_MontoEscrito @nValinip , @mtoesc OUTPUT
   -- EXECUTE Sp_MontoEscrito @Interes  , @Intesc OUTPUT
   SET @mtoesc		= dbo.Fx_MontoEscrito(@nValinip , @mtoesc) --> FUSION
	SET @Intesc		= dbo.Fx_MontoEscrito(@Interes  , @Intesc) --> FUSION

   EXECUTE Sp_Papeleta_Limites 'IB' , @nNumoper , @cSettlement OUTPUT , @cPFE OUTPUT , @cEmisorInstPlazo OUTPUT , @cCCE OUTPUT

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
      SET    Mensaje_Error        = LTRIM(RTRIM(Mensaje_Error)) + '  ' + @cMontoFMT
      ,      sw                   = 'S'
      WHERE  @NumeroCorre_Detalle = NumeroCorre_Detalle
   END

   SELECT @linea1 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 1
   SELECT @linea2 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 2
   SELECT @linea3 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 3

   IF EXISTS(SELECT Operador_Ap_LINEAS FROM view_aprobacion_operaciones, mdac WHERE id_sistema = 'BTR' AND NumeroOperacion = @nNumoper AND FechaOperacion = acfecproc)
   BEGIN
      SELECT @EstadoPeracion = CASE WHEN Estado  = 'A' THEN 'OPERACION APROBADA POR :   '  + Operador_AP_LINEAS 
                                    WHEN Estado  = 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_LINEAS
                                    ELSE ''
                               END
      FROM   VIEW_APROBACION_OPERACIONES, MDAC
      WHERE  id_sistema      = 'BTR' 
      AND    NumeroOperacion = @nNumoper 
      AND    FechaOperacion  = acfecproc
   END
 
   SELECT @cFecVens = RTRIM(CONVERT(CHAR(2),@nDia1)) + '/'  + RTRIM(CONVERT(CHAR(4),@NMES1)) + '/' + RTRIM(CONVERT(CHAR(4),@NANN1))

   SELECT 'nomemp'    = ISNULL(@nomemp,'')          
   ,      'rutemp'    = ISNULL(@rutpro,'')          
   ,      'fecpro'    = CONVERT(CHAR(10),mofecinip,103) --> ISNULL(mofecinip,'') --> ISNULL(@fecpro,'')          
   ,      'nomope'    = ISNULL(@Nomoper,'')          
   ,      'nominal'   = ISNULL(@nValinip,0.0)
   ,      'Mtoesc'    = ISNULL(SUBSTRING(@mtoesc,1,120),'')        
   ,      'numdocu'   = RTRIM(CONVERT(CHAR(10),ISNULL(monumoper,0)))+'-'+RTRIM(CONVERT(CHAR(3),ISNULL(mocorrela,0))) 
   ,      'mtofin'    = ISNULL(movalvenp,0)          
   ,      'Tir'       = ISNULL(motaspact,0)          
   ,      'fecvto'    = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')       
   ,      'plazo'     = CONVERT(CHAR(05),ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0) )    
   ,      'interes'   = ROUND(ISNULL(@Interes,0),4)        
   ,      'nomcli'    = ISNULL(@Nomcli,'')          
   ,      'dircli'    = ISNULL(@Dircli,'')          
   ,      'forpai'    = ISNULL(@forpai,'')          
   ,      'CtaCte'    = CONVERT(CHAR(10),'0')          
   ,      'rutcli'    = ISNULL(RTRIM(CONVERT(CHAR(09),@Rutcli))+'-'+@Dig,'')      
   ,      'custodia'  = ISNULL(@Custodia,'')          
   ,      'forpav'    = ISNULL(@forpav,'')          
   ,      'tipret'    = ISNULL( @Retiro,'')          
   ,      'Numoper'   = CONVERT(CHAR(10),monumoper)         
   ,      'serie'     = ISNULL(moinstser,'')          
   ,      'titulo'    = CASE moinstser WHEN 'ICOL' THEN 'INTERBANCARIO COLOCACION' ELSE 'INTERBANCARIO CAPTACION' END 
   ,      'Monpacto'  = ISNULL(mnnemo,'')          
   ,      'glomon'    = ISNULL(mnglosa,'')          
   ,      'Base'      = ISNULL(CONVERT(CHAR(03),mobaspact),'')       
   ,      'fecemi'    = ISNULL(@cFecEmis,'')          
   ,      'fecven'    = ISNULL(@cFecvens,'')          
   ,      'interesesc'= ISNULL(@intesc,'')          
   ,      'Obser'     = ISNULL(@Obser,'')          
   ,      'Linea1'    = ISNULL(@linea1,'')          
   ,      'Linea2'    = ISNULL(@linea2,'')          
   ,      'Linea3'    = ISNULL(@linea3,'')          
   ,      'Linea4'    = ISNULL(@linea4,'')          
   ,      'Linea5'    = ISNULL(@linea5,'')          
   ,      'copia'     = ISNULL(@glocopia,'')          
   ,      'valinium'  = ISNULL(@iniumt,0.0)
   ,      'palabras'  = ISNULL(@cMonlet,'')
   ,      'palab1'    = ISNULL(@cPalab1,'')
   ,      'palab2'    = ISNULL(@cPalab2,'')
   ,      'palab3'    = ISNULL(@cPalab3,'')
  ,      'palab4'    = ISNULL(@cPalab4,'')
   ,      'hora'      = @hora
   ,      'Lim_Settle'= @cSettlement
   ,      'Lim_EMIPLZ'= @cEmisorInstPlazo
   ,      'PlazoBase' = CASE WHEN mobaspact = 360   THEN 'anual' ELSE 'mensual' END
   ,      'Linea6'    = CASE WHEN mnnemo    = 'CLP' THEN 'El  deudor  podrá anticipar  el  pago  de  esta  obligación,  siempre  que  pague   íntegramente   el  capital   más  los intereses estipulados, calculados hasta el vencimiento del plazo pactado, a
 menos que el Banco acreedor renuncie'
                             ELSE                        'Las sumas adeudadas, tanto en lo referente a capital como intereses, se calcularán por su equivalente en moneda nacional chilena al día del pago efectivo. En caso de mora o simple retardo en el cum
plimiento de esta obligación, ésta'
                        END
   ,      'Linea7'    = CASE WHEN mnnemo    = 'CLP' THEN 'parcial o totalmente a ese plazo. En caso de mora o simple retardo en el cumplimiento de esta obligación, ésta devengará en favor del acreedor  o de quién sus derechos  represente y a partir  de  e
sa  misma  fecha,  el  interés'
                             ELSE                        'devengará en favor del acreedor  o de quién sus derechos  represente y a partir  de  esa  misma  fecha,  el  interés máximo que la ley permita estipular durante  la mora o  simple  retardo para obl
igaciones de esta naturaleza,'
                        END
   ,      'Linea8'    = CASE WHEN mnnemo    = 'CLP' THEN 'máximo que la ley permita estipular durante  la mora o  simple  retardo para obligaciones de esta naturaleza,  intereses que  correrán sobre todo el saldo insoluto incluyendo los intereses capitali
zados en conformidad'
                             ELSE                        'intereses que  correrán sobre todo el saldo insoluto incluyendo los intereses capitalizados en conformidad al artículo 9º de la LEY 18.010,  hasta la fecha  de   su pago total. Para  todos los efec
tos  legales,  judiciales'
                        END
   ,      'Linea9'    = CASE WHEN mnnemo    = 'CLP' THEN 'al artículo 9º de la LEY 18.010,  hasta la fecha  de   su pago total. Para  todos los efectos  legales,  judiciales o extrajudiciales derivados de este pagaré,  prorrogo expresamente  la competenci
a  para los Tribunales de'
                             ELSE                        'o extrajudiciales derivados de este pagaré,  prorrogo expresamente  la competencia  para los Tribunales de Justicia con asiento en la comuna de Santiago.'
                        END
   ,       'Linea10'  = CASE WHEN mnnemo    = 'CLP' THEN 'Justicia con asiento en la comuna de Santiago.'
                             ELSE                        ''
                        END
   ,      'EstadoPeracion'= @EstadoPeracion
   ,      'ApoRut1'       = @cApoRut1
   ,      'ApoNom1'       = @cApoNom1
   ,      'Apofono1'      = @cApofono1
   ,      'ApoRut2'       = @cApoRut2
   ,      'ApoNom2'       = @cApoNom2
   ,      'diremp'        = @diremp
   ,      'Titulo'        = @cTitulo
   ,      'Apoderado1'    = @cApoderado1
   ,      'Apoderado2'    = @cApoderado2
   ,      'RutApoderado1' = @RutApoderado1
   ,      'RutApoderado2' = @RutApoderado2
   ,      'Valor Inicio'  = @nValinip
   ,      'banco'         = (SELECT acnomprop FROM MDAC)
   ,      'Firma1'        = @firma1
   ,      'Firma2'        = @firma2
   ,      'Codigo_Libro'  = id_libro
   ,      'Nombre_Libro'  = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_Libro AND TBCODIGO1 = id_libro),'')
   FROM   MDMO
   ,      VIEW_MONEDA 
   WHERE  morutcart       = @nRutcart 
   AND    monumoper       = @nNumoper 
   AND    motipoper       = 'IB'  
   AND    momonpact       = mncodmon
END

IF @iOperDia = 1 --> Operacion esta en tabla del Día
BEGIN

   SELECT @nDiaSem        = DATEPART(WEEKDAY,mofecinip) 
   ,      @nDia           = DATEPART(DAY,mofecinip) 
   ,      @nMes           = DATEPART(MONTH,mofecinip) 
   ,      @nAnn           = DATEPART(YEAR,mofecinip) 
   ,      @nDia1          = DATEPART(DAY,mofecinip) 
   ,      @nMes1          = DATEPART(MONTH,mofecinip) 
   ,      @nAnn1          = DATEPART(YEAR,mofecinip) 
   ,      @dFecinip       = mofecinip   
   ,      @NumSol         = monsollin   
   ,      @Obser          = moobserv   
   ,      @nMoneda        = momonpact   
   ,      @hora           = mohora   
   ,      @xMiinstser     = moinstser   
   ,      @EstadoPeracion = CASE WHEN mostatreg = 'P' THEN 'OPERACION PENDIENTE DE APROBACION' ELSE '' END 
   ,      @TotalC         = movalinip  
   ,      @nValinip       = movalinip  
   ,      @Cust           = mocondpacto  
   ,      @Rutcli         = morutcli  
   ,      @Ret            = motipret   
   ,      @Interes        = movalvenp - movalinip 
   ,      @nValvtop       = movalvenp
   ,      @Monpac         = mnnemo
   ,      @Forpai         = i.glosa 
   ,      @Forpav         = v.glosa
   ,      @Nomoper        = usr.nombre
   ,      @Nomcli         = clnombre 
   ,      @Dircli         = cldirecc 
   ,      @Dig            = cldv
   ,      @cMx            = CASE WHEN mnmx = 'C' THEN 'S' ELSE 'N' END 
   FROM   MDMH
          INNER JOIN BacParamSuda..CLIENTE         ON clrut     = morutcli and clcodigo = mocodcli
          INNER JOIN BacParamSuda..MONEDA          ON mncodmon  = momonpact
          INNER JOIN BacParamSuda..FORMA_DE_PAGO i ON i.codigo  = moforpagi
          INNER JOIN BacParamSuda..FORMA_DE_PAGO v ON v.codigo  = moforpagv
          LEFT  JOIN BacParamSuda..USUARIO     usr ON SUBSTRING(usr.usuario,1,12) = mousuario
   WHERE  mofecpro        = @dFechacartera
   AND    monumoper       = @nNumoper  
   AND    morutcart       = @nRutcart  
   AND    motipoper       = 'IB' 

   IF @nMes =  1  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Enero de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  2  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Febrero de '    + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  3  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Marzo de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  4  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Abril de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  5  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Mayo de '       + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  6  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Junio de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  7  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Julio de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  8  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Agosto de '     + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  9  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Septiembre de ' + CONVERT(CHAR(4),@nAnn)
   IF @nMes = 10  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Octubre de '    + CONVERT(CHAR(4),@nAnn)
   IF @nMes = 11  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Noviembre de '  + CONVERT(CHAR(4),@nAnn)
   IF @nMes = 12  SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Diciembre de '  + CONVERT(CHAR(4),@nAnn)

   IF @nDiaSem = 1 SELECT @cFecEmis = 'Domingo '   + @cFecEmis
   IF @nDiaSem = 2 SELECT @cFecEmis = 'Lunes '     + @cFecEmis
   IF @nDiaSem = 3 SELECT @cFecEmis = 'Martes '    + @cFecEmis
   IF @nDiaSem = 4 SELECT @cFecEmis = 'Miercoles ' + @cFecEmis
   IF @nDiaSem = 5 SELECT @cFecEmis = 'Jueves '    + @cFecEmis
   IF @nDiaSem = 6 SELECT @cFecEmis = 'Viernes '   + @cFecEmis
   IF @nDiaSem = 7 SELECT @cFecEmis = 'Sabado '    + @cFecEmis

   SELECT @nDiaSem  = DATEPART(WEEKDAY,mofecvenp) 
   ,      @nDia     = DATEPART(DAY,mofecvenp) 
   ,      @nMes     = DATEPART(MONTH,mofecvenp) 
   ,      @nAnn     = DATEPART(YEAR,mofecvenp) 
   ,      @nDia1    = DATEPART(DAY,mofecvenp) 
   ,      @nMes1    = DATEPART(MONTH,mofecvenp) 
   ,      @nAnn1    = DATEPART(YEAR,mofecvenp) 
   FROM   MDMH
   WHERE  mofecpro  = @dFechacartera
   AND    monumoper = @nNumoper 
AND    morutcart = @nRutcart 
   AND    motipoper = 'IB' 

   IF @nMes =  1  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Enero de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  2  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Febrero de '    + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  3  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Marzo de '      + CONVERT(CHAR(4),@nAnn) 
   IF @nMes =  4  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Abril de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  5  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Mayo de '       + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  6  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Junio de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  7  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Julio de '      + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  8  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Agosto de '     + CONVERT(CHAR(4),@nAnn)
   IF @nMes =  9  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Septiembre de ' + CONVERT(CHAR(4),@nAnn)
   IF @nMes = 10  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Octubre de '    + CONVERT(CHAR(4),@nAnn)
   IF @nMes = 11  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Noviembre de '  + CONVERT(CHAR(4),@nAnn)
   IF @nMes = 12  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Diciembre de '  + CONVERT(CHAR(4),@nAnn)

   IF @nDiaSem = 1 SELECT @cFecVens = 'Domingo '   + @cFecVens
   IF @nDiaSem = 2 SELECT @cFecVens = 'Lunes '     + @cFecVens
   IF @nDiaSem = 3 SELECT @cFecVens = 'Martes '    + @cFecVens
   IF @nDiaSem = 4 SELECT @cFecVens = 'Miercoles ' + @cFecVens
   IF @nDiaSem = 5 SELECT @cFecVens = 'Jueves '    + @cFecVens
   IF @nDiaSem = 6 SELECT @cFecVens = 'Viernes '   + @cFecVens
   IF @nDiaSem = 7 SELECT @cFecVens = 'Sabado '    + @cFecVens

   IF @nmoneda  = 999 
      SELECT @cMonLet = 'Pesos   m/l,   por  concepto   de   intereses, ' 
      ,      @cPalab4 = 'valores   que   me   obligo   a   pagar    en   esta   ciudad   calle'
   ELSE
      IF @nmoneda  = 13 
         SELECT @cMonLet = 'Dólares de los Estados Unidos de Norteamérica, por concepto de intereses, '
         ,      @cPalab4 = 'valores que me obligo a pagar en '

   SELECT @nMtopal = @TotalC
   SELECT @Iniumt  = @TotalC


   IF @nMoneda <> 999 AND @cMx <> 'S'
   BEGIN 
      SELECT @nValmon = ISNULL(vmvalor,0.0) FROM BacParamSuda..VALOR_MONEDA WHERE vmcodigo = @nMoneda AND vmfecha=@dfecinip
      IF @nValmon>0
      BEGIN 
         SELECT @nValinip  = @TotalC
         SELECT @Interes   = @nValvtop - ROUND(@TotalC/@nValmon,4)
         ,      @nMtopal   = @nValinip
         ,      @Iniumt    = ROUND(@TotalC/@nValmon,4)
      END 

      IF @nmoneda = 998
         SELECT @cMonlet = 'Unidades de Fomento m/l,  por concepto de  intereses, '
         ,      @cPalab4 = 'valores  que  me  obligo a  pagar  en  esta  ciudad  calle'
      ELSE
         SELECT @cMonLet = 'Dólares de los Estados Unidos de Norteamérica, por concepto de intereses, '
         ,      @cPalab4 = 'valores que me obligo a pagar en'
   END

   SELECT @nValinip = CONVERT(NUMERIC(19,4),@nValinip)
   SELECT @cValinip = CONVERT(CHAR,CONVERT(NUMERIC(19,0),@nValinip))
   SELECT @nLargo   = DATALENGTH(LTRIM(RTRIM(@cValinip)))
   SELECT @cInteres = CASE WHEN @nmoneda = 999 THEN CONVERT(CHAR,CONVERT(NUMERIC(19,0),@Interes))
                           WHEN @nmoneda = 998 THEN CONVERT(CHAR,CONVERT(NUMERIC(19,4),@Interes))
                           ELSE                     CONVERT(CHAR,CONVERT(NUMERIC(19,2),@Interes))
                      END
   IF @nmoneda = 999 
      SELECT @nLargo  = DATALENGTH(LTRIM(RTRIM(@cInteres)))
   ELSE
      SELECT @nLargo  = DATALENGTH(SUBSTRING(@cInteres,1,CHARINDEX('.',@cInteres)-1))

   IF @nmoneda <> 999 
      SELECT @cInteres = STUFF(@cInteres,CHARINDEX('.',@cInteres),1,',')

   WHILE @nLargo-3 > 0
   BEGIN
      SELECT @cDato = SUBSTRING(@cInteres,@nLargo-3,1)

      IF @cDato <> ''
         SELECT @cInteres = STUFF(@cInteres, @nLargo-3,1,@cDato+'.')

      SELECT @nLargo   = DATALENGTH(SUBSTRING(@cInteres,1,CHARINDEX('.',@cInteres)-1))
   END

   IF @nMoneda = 999
   BEGIN
      IF @nRutcart <> 97029000
         SELECT @cPalab1 = '$' + @cValinip 
         ,      @cPalab3 = '' 
         ,      @cPalab2 = '' 
      ELSE 
         SELECT @cPalab1 = 'la suma de $ ' +@cValinip+'.-'     
         ,      @cPalab3 = 'Pesos m/l, por concepto de capital, '
         ,      @cPalab2 = 'más la suma de $  ' + @cInteres
   END ELSE
   BEGIN
      IF @nMoneda=998
         SELECT @cPalab1 = 'la suma de dinero equivalente en pesos moneda legal de ' + RTRIM(@Monpac) + ' ' + @cValinip + '.-'
         ,      @cPalab3 = 'Unidades de Fomento, por concepto de capital, '
         ,      @cPalab2 = 'más la suma de dinero equivalente en moneda legal de UF ' + @cInteres
     ELSE
         SELECT @cPalab1 = 'la cantidad en pesos moneda nacional equivalente a US$ ' + @cValinip + '.-'
         ,      @cPalab3 = 'Dólares de los Estados Unidos de América, por concepto de capital que he recibido en préstamo,  '
         ,      @cPalab2 = 'más intereses del '
   END

   IF @Cust='S'
      SELECT @Custodia = 'Con Custodia'
   ELSE
      SELECT @Custodia = 'Sin Custodia'
     
   IF @Ret='V'
      SELECT @Retiro = 'VAMOS'
   ELSE
      SELECT @Retiro = 'VIENEN'
        
   SELECT @nomemp = ISNULL(acnomprop,'')
   ,      @diremp = acdirprop
   ,      @rutpro = ISNULL(RTRIM(CONVERT(CHAR(09),acrutprop)) + '-' + acdigprop,'')
   ,      @fecpro = ISNULL(CONVERT(CHAR(10),acfecproc,103),'')
   FROM   MDAC

   --EXECUTE Sp_MontoEscrito @nValinip , @mtoesc OUTPUT
   --EXECUTE Sp_MontoEscrito @Interes  , @Intesc OUTPUT
      SET @mtoesc		= dbo.Fx_MontoEscrito(@nValinip , @mtoesc) --> FUSION
	SET @Intesc		= dbo.Fx_MontoEscrito(@Interes  , @Intesc) --> FUSION

   EXECUTE Sp_Papeleta_Limites 'IB' , @nNumoper , @cSettlement OUTPUT , @cPFE OUTPUT , @cEmisorInstPlazo OUTPUT , @cCCE OUTPUT

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
      SET    Mensaje_Error        = LTRIM(RTRIM(Mensaje_Error)) + '  ' + @cMontoFMT
      ,      sw                   = 'S'
      WHERE  @NumeroCorre_Detalle = NumeroCorre_Detalle
   END

   SELECT @linea1 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 1
   SELECT @linea2 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 2
   SELECT @linea3 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 3

   IF EXISTS(SELECT Operador_Ap_LINEAS FROM view_aprobacion_operaciones, mdac WHERE id_sistema = 'BTR' AND NumeroOperacion = @nNumoper AND FechaOperacion = acfecproc)
   BEGIN
      SELECT @EstadoPeracion = CASE WHEN Estado  = 'A' THEN 'OPERACION APROBADA POR :   '  + Operador_AP_LINEAS 
                                    WHEN Estado  = 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_LINEAS
                                    ELSE ''
                               END
      FROM   VIEW_APROBACION_OPERACIONES, MDAC
      WHERE  id_sistema      = 'BTR' 
      AND    NumeroOperacion = @nNumoper 
      AND    FechaOperacion  = acfecproc
   END
 
   SELECT @cFecVens = RTRIM(CONVERT(CHAR(2),@nDia1)) + '/'  + RTRIM(CONVERT(CHAR(4),@NMES1)) + '/' + RTRIM(CONVERT(CHAR(4),@NANN1))
         
   SELECT 'nomemp'    = ISNULL(@nomemp,'')          
   ,      'rutemp'    = ISNULL(@rutpro,'')          
   ,      'fecpro'    = CONVERT(CHAR(10),mofecinip,103) --> ISNULL(mofecinip,'') --> ISNULL(@fecpro,'')          
   ,      'nomope'    = ISNULL(@Nomoper,'')          
   ,      'nominal'   = ISNULL(@nValinip,0.0)
   ,      'Mtoesc'    = ISNULL(SUBSTRING(@mtoesc,1,120),'')        
   ,      'numdocu'   = RTRIM(CONVERT(CHAR(10),ISNULL(monumoper,0)))+'-'+RTRIM(CONVERT(CHAR(3),ISNULL(mocorrela,0))) 
   ,      'mtofin'    = ISNULL(movalvenp,0)          
   ,      'Tir'       = ISNULL(motaspact,0)          
   ,      'fecvto'    = ISNULL(CONVERT(CHAR(10),mofecvenp,103),'')       
   ,      'plazo'     = CONVERT(CHAR(05),ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0) )    
   ,      'interes'   = ROUND(ISNULL(@Interes,0),4)        
   ,      'nomcli'    = ISNULL(@Nomcli,'')          
   ,      'dircli'    = ISNULL(@Dircli,'')          
   ,      'forpai'    = ISNULL(@forpai,'')          
   ,      'CtaCte'    = CONVERT(CHAR(10),'0')          
   ,      'rutcli'    = ISNULL(RTRIM(CONVERT(CHAR(09),@Rutcli))+'-'+@Dig,'')      
   ,      'custodia'  = ISNULL(@Custodia,'')          
   ,      'forpav'    = ISNULL(@forpav,'')          
   ,      'tipret'    = ISNULL( @Retiro,'')          
   ,      'Numoper'   = CONVERT(CHAR(10),monumoper)         
   ,      'serie'     = ISNULL(moinstser,'')          
   ,      'titulo'    = CASE moinstser WHEN 'ICOL' THEN 'INTERBANCARIO COLOCACION' ELSE 'INTERBANCARIO CAPTACION' END 
   ,      'Monpacto'  = ISNULL(mnnemo,'')          
   ,      'glomon'    = ISNULL(mnglosa,'')          
   ,      'Base'      = ISNULL(CONVERT(CHAR(03),mobaspact),'')       
   ,      'fecemi'    = ISNULL(@cFecEmis,'')          
   ,      'fecven'    = ISNULL(@cFecvens,'')          
   ,      'interesesc'= ISNULL(@intesc,'')          
   ,      'Obser'     = ISNULL(@Obser,'')          
   ,      'Linea1'    = ISNULL(@linea1,'')          
   ,      'Linea2'    = ISNULL(@linea2,'')          
   ,      'Linea3'    = ISNULL(@linea3,'')          
   ,      'Linea4'    = ISNULL(@linea4,'')          
   ,      'Linea5'    = ISNULL(@linea5,'')          
   ,      'copia'     = ISNULL(@glocopia,'')          
   ,      'valinium'  = ISNULL(@iniumt,0.0)
   ,      'palabras'  = ISNULL(@cMonlet,'')
   ,      'palab1'    = ISNULL(@cPalab1,'')
   ,      'palab2'    = ISNULL(@cPalab2,'')
   ,      'palab3'    = ISNULL(@cPalab3,'')
   ,      'palab4'    = ISNULL(@cPalab4,'')
   ,      'hora'      = @hora
   ,      'Lim_Settle'= @cSettlement
   ,      'Lim_EMIPLZ'= @cEmisorInstPlazo
   ,      'PlazoBase' = CASE WHEN mobaspact = 360   THEN 'anual' ELSE 'mensual' END
   ,      'Linea6'    = CASE WHEN mnnemo    = 'CLP' THEN 'El  deudor  podrá anticipar  el  pago  de  esta  obligación,  siempre  que  pague   íntegramente   el  capital   más  los intereses estipulados, calculados hasta el vencimiento del plazo pactado, 
a menos que el Banco acreedor renuncie'
                             ELSE                        'Las sumas adeudadas, tanto en lo referente a capital como intereses, se calcularán por su equivalente en moneda nacional chilena al día del pago efectivo. En caso de mora o simple retardo en el cum
plimiento de esta obligación, ésta'
                        END
   ,      'Linea7'    = CASE WHEN mnnemo    = 'CLP' THEN 'parcial o totalmente a ese plazo. En caso de mora o simple retardo en el cumplimiento de esta obligación, ésta devengará en favor del acreedor  o de quién sus derechos  represente y a partir  de  e
sa  misma  fecha,  el  interés'
                             ELSE                        'devengará en favor del acreedor  o de quién sus derechos  represente y a partir  de  esa  misma  fecha,  el  interés máximo que la ley permita estipular durante  la mora o  simple  retardo para obl
igaciones de esta naturaleza,'
                        END
   ,      'Linea8'    = CASE WHEN mnnemo    = 'CLP' THEN 'máximo que la ley permita estipular durante  la mora o  simple  retardo para obligaciones de esta naturaleza,  intereses que  correrán sobre todo el saldo insoluto incluyendo los intereses capitali
zados en conformidad'
                             ELSE                        'intereses que  correrán sobre todo el saldo insoluto incluyendo los intereses capitalizados en conformidad al artículo 9º de la LEY 18.010,  hasta la fecha  de   su pago total. Para  todos los efec
tos  legales,  judiciales'
                        END
   ,      'Linea9'    = CASE WHEN mnnemo    = 'CLP' THEN 'al artículo 9º de la LEY 18.010,  hasta la fecha  de   su pago total. Para  todos los efectos  legales,  judiciales o extrajudiciales derivados de este pagaré,  prorrogo expresamente  la competenci
a  para los Tribunales de'
                             ELSE                        'o extrajudiciales derivados de este pagaré,  prorrogo expresamente  la competencia  para los Tribunales de Justicia con asiento en la comuna de Santiago.'
                        END
   ,       'Linea10'  = CASE WHEN mnnemo    = 'CLP' THEN 'Justicia con asiento en la comuna de Santiago.'
                             ELSE                        ''
                        END
   ,      'EstadoPeracion'= @EstadoPeracion
   ,      'ApoRut1'       = @cApoRut1
   ,      'ApoNom1'       = @cApoNom1
   ,      'Apofono1'      = @cApofono1
   ,      'ApoRut2'       = @cApoRut2
   ,      'ApoNom2'       = @cApoNom2
   ,      'diremp'        = @diremp
   ,      'Titulo'        = @cTitulo
   ,      'Apoderado1'    = @cApoderado1
   ,      'Apoderado2'    = @cApoderado2
   ,      'RutApoderado1' = @RutApoderado1
   ,      'RutApoderado2' = @RutApoderado2
   ,      'Valor Inicio'  = @nValinip
   ,      'banco'         = (SELECT acnomprop FROM MDAC)
   ,      'Firma1'        = @firma1
   ,      'Firma2'        = @firma2
   ,      'Codigo_Libro'  = moid_libro
   ,      'Nombre_Libro'  = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Cat_Libro AND TBCODIGO1 = moid_libro),'')
   FROM   MDMH
   ,      VIEW_MONEDA 
   WHERE  mofecpro        = @dFechacartera
   AND    morutcart       = @nRutcart 
   AND    monumoper       = @nNumoper 
   AND    motipoper       = 'IB'  
   AND    momonpact       = mncodmon
END

END

GO
