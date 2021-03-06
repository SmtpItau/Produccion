USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_CURVAS_PRODUCTO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RETORNA_CURVAS_PRODUCTO] 
   (   @cModulo             CHAR(3)  
   ,   @cProducto           VARCHAR(5)  
   ,   @cTipoOperacion      CHAR(1)  
   ,   @iMoneda             INTEGER  
   ,   @cInstrumento        VARCHAR(20)  
   ,   @cEmisor             VARCHAR(20)  
   ,   @iDias               FLOAT  
   ,   @cCurvaPrincipal     VARCHAR(20)   OUTPUT  
   ,   @cCurvaAlternativa   VARCHAR(20)   OUTPUT  
   ,   @sSpread             CHAR(1)       OUTPUT  
   ,   @cCurvaSpread        VARCHAR(20)   OUTPUT  
   ,   @ValorCurvaProducto  FLOAT         OUTPUT  
   ,   @ValorCurvaSpread    FLOAT         OUTPUT  
   ,   @iCurvasHoy          INTEGER       = 0  
   ,   @iTasaEmision        FLOAT         = 0  
   ,   @cTipoTasa           CHAR(1)       = 'N'  
   ,   @iTipoFlujo          INTEGER       = -1  
   ,   @iTipoBase           INTEGER       = 0  
   ,   @iIndicador          INTEGER       = -1  
   ,   @TipoCurva           VARCHAR(5)    = ''  
   ,   @Accion              CHAR(8)       = 'Descont'--'DescCol'   
   ,   @CurvaUsada          VARCHAR(20)   = 'CURVA' OUTPUT  
   ,   @FechaAlternativa    DATETIME      = '19000101' -- SE UTILIZA PARA BACK TEST  
   )  
AS  
BEGIN  
/*
  declare @CurvaUsada varchar(50)
  EXECUTE BACFWDSUDA..SP_RETORNATASAMONEDA 13, 5, 'PCS', 'SM', 1, 2, 2, 'C', 7, 'CERO', 'DescMXmn', @CurvaUsada OUTPUT      
  select '@CurvaUsada', @CurvaUsada

  declare @CurvaUsada varchar(50)
  EXECUTE BACFWDSUDA..SP_RETORNATASAMONEDAMAP 13, 5, 'PCS', 'SM', 1, 2, 2, 'C', 7, 'CERO', 'Descont', @CurvaUsada OUTPUT      
  select '@CurvaUsada', @CurvaUsada


  declare @CurvaUsada varchar(50)
  EXECUTE BACFWDSUDA..SP_RETORNATASAMONEDAMAP 13, 5, 'PCS', 'SM', 1, 2, 2, 'C', 7, 'CERO', 'Forward', @CurvaUsada OUTPUT      
  select '@CurvaUsada', @CurvaUsada


  declare @CurvaUsada varchar(50)
  EXECUTE BACFWDSUDA..SP_RETORNATASAMONEDAMAP 13, 5, 'PCS', 'ST', 1, 2, 2, 'C', 7, 'CERO', 'DescMXmn', @CurvaUsada OUTPUT      
  select '@CurvaUsada', @CurvaUsada

    declare @CurvaUsada varchar(50)
  EXECUTE BACFWDSUDA..SP_RETORNATASAMONEDAMAP 13, 5, 'PCS', 'SM', 1, 2, 2, 'C', 7, 'CERO', 'Descont', @CurvaUsada OUTPUT      
  select '@CurvaUsada', @CurvaUsada

  declare @CurvaUsada varchar(50)
  EXECUTE BACFWDSUDA..SP_RETORNATASAMONEDAMAP 13, 5, 'PCS', 'ST', 1, 2, 2, 'C', 7, 'CERO', 'Forward', @CurvaUsada OUTPUT      
  select '@CurvaUsada', @CurvaUsada




 */ 
   SET NOCOUNT ON  
  
   DECLARE @FechaAnterior  DATETIME  
   DECLARE @FechaProceso   DATETIME  
  
    SELECT @FechaAnterior = acfecante  
         , @FechaProceso  = acfecproc  
      FROM BacTraderSuda..MDAC  with (nolock)  
     WHERE acrutprop      = 97023000  

	 --freddy
    SEt @FechaAnterior = '20220428'
    set  @FechaProceso  = '20220429'

  
   IF @cModulo <> 'PCS'  
      SET @TipoCurva = ''  
   ELSE  
      IF @TipoCurva = ''  
         SET @TipoCurva = 'CERO'  
  
   --> Campo TasaEmision, es solo para Renta Fija; Setea para otro Sistema  
   IF @cModulo NOT IN('BTR','BEX')  
   BEGIN  
      SET @iTasaEmision = 0.0  
   END  
   SET @iTasaEmision = 0.0  
  
   --> Redefine los productos para el Swap  
   IF @cModulo = 'PCS' AND @cProducto IN('1','2','3','4')  
   BEGIN  
      SET @cProducto = CASE WHEN @cProducto = '1' THEN 'ST'  
                            WHEN @cProducto = '2' THEN 'SM'  
                            WHEN @cProducto = '3' THEN 'FR'  
                            WHEN @cProducto = '4' THEN 'SP'  
                       END  
   END  
  
   --> Valida el Ingreso del Tipo de tasa solo para los Swap  
   IF @cModulo <> 'PCS'  
   BEGIN  
      SET @cTipoTasa  = 'N'  
      SET @iTipoBase  = 0  
      SET @iTipoFlujo = -1  
      SET @iIndicador = -1  
   END  
  
   IF @cModulo = 'PCS'  
   BEGIN  
      SET @iTipoBase = 0  
   END  
   -->    (0.0) Define El Tipo de Operación  
   DECLARE @iDefineValorBidAsk INTEGER  
  
   IF @cModulo = 'BTR' OR @cModulo = 'BEX'  
   BEGIN  
      SET @iDefineValorBidAsk = 1  
      SET @iIndicador         = -1   --> 0
   END  
  
   IF @cModulo = 'PCS' OR @cModulo = 'BFW'  
   BEGIN  
      SET @iDefineValorBidAsk = CASE WHEN @cTipoOperacion = 'C' THEN 1 ELSE 2 END  
   END  
  
   -->   Define Valor a Tomar. BID o ASK  
   IF @iTipoFlujo <> -1  
   BEGIN  
      SET @iDefineValorBidAsk = CASE WHEN @iTipoFlujo = 1 AND @cTipoTasa = 'F' THEN 1  
                                     WHEN @iTipoFlujo = 1 AND @cTipoTasa = 'V' THEN 2  
                                     WHEN @iTipoFlujo = 2 AND @cTipoTasa = 'V' THEN 1  
                                     WHEN @iTipoFlujo = 2 AND @cTipoTasa = 'F' THEN 2  
                                END  
   END  
  
   -->    (1.0) Inicializa el Retorno. Para evitar Null  
   SET @cCurvaPrincipal    = ''  
   SET @cCurvaAlternativa  = ''  
   SET @sSpread            = ''  
   SET @cCurvaSpread       = ''  
   SET @ValorCurvaProducto = 0.0  
   SET @ValorCurvaSpread   = 0.0  
  
   -->     (2.0) Lee la Fecha de Proceso  
   DECLARE @FechaCurva        DATETIME  
       SET @FechaCurva        = CASE WHEN @iCurvasHoy = 0 THEN @FechaProceso ELSE @FechaAnterior END  
  
   IF @FechaAlternativa <> '19000101'   
   BEGIN  
  SET @FechaCurva = @FechaAlternativa  
   END ELSE   
   BEGIN  
      SET @FechaCurva   = CASE WHEN @iCurvasHoy = 0 THEN @FechaProceso  ELSE @FechaAnterior END  
   END  
  
   -->     Variable de Existencia y Asiganción  
   DECLARE @iFound        INTEGER  
   DECLARE @Curva_Producto    VARCHAR(20)  
       SET @Curva_Producto    = ''  
  
   -->     (2.1) Genera Mensaje Genérico  
   DECLARE @cMensaje          VARCHAR(200)  
   SET     @cMensaje          = ' MOD:' + LTRIM(RTRIM(@cModulo))      + ' ; '  
                              + ' PRD:' + LTRIM(RTRIM(@cProducto))    + ' ; '  
                              + ' MON:' + LTRIM(RTRIM(@iMoneda))      + ' ; '  
                              + ' INT:' + LTRIM(RTRIM(@cInstrumento)) + ' ; '  
                              + ' EMI:' + LTRIM(RTRIM(@cEmisor))      + ' ; '  
                              + ' PER:' + LTRIM(RTRIM(@iDias))        + ' ; '   
                              + ' TAS:' + LTRIM(RTRIM(@iTasaEmision)) + ' . '   
                              + ' IND:' + LTRIM(RTRIM(@iIndicador  )) + ' . '   
                              + ' TBA:' + LTRIM(RTRIM(@iTipoBase   )) + ' . '   
                              + ' ACT:' + LTRIM(RTRIM(@Accion      )) + ' . '   
  
  
  
   --> Degfine la Glosa del Tipo de Tasa que se envía solo para los Swap  
   DECLARE @GlosaTasa         CHAR(15)  
   SET     @GlosaTasa         = CASE WHEN @cTipoTasa = 'N' THEN 'NO REQUERIDA'  
                                     WHEN @cTipoTasa = 'F' THEN 'FIJA'  
                                     WHEN @cTipoTasa = 'V' THEN 'VARIABLE'  
                                END  
   IF @cTipoTasa <> 'N'  
   BEGIN  
      SET @cMensaje = @cMensaje + ' TIP:' + LTRIM(RTRIM(@GlosaTasa))  + ' . '  
   END  
   -->  
  
   /*  
   -->     (3.0) Verifica la Existencia de Datos para la Fecha.  
   INSERT INTO #TMP_CURVAS  
   SELECT FechaGeneracion  
   ,      CodigoCurva  
   ,      Dias  
   ,      ValorBid  
   ,      ValorAsk  
   ,      Tipo  
   ,      Origen  
   FROM   CURVAS             with (nolock)   
   WHERE  FechaGeneracion    = @FechaCurva  
   AND    Tipo               = @TipoCurva  
  
   IF @@ROWCOUNT = 0  
   BEGIN     
      RETURN  
   END  
   */  
  
   -- DMV 13/05/2008: Comentado por el requerimiento de Arbitraje MX/CLP (En certificación)  
   -->     (3.0) Verifica la Existencia de Datos para la Fecha.  
      SET  @iFound            = -1  
   SELECT  @iFound            = 0  
   FROM    CURVAS             with (nolock) --> (INDEX = Curvas_FechaGeneracion) with (nolock)  
   WHERE   FechaGeneracion    = @FechaCurva  
   AND     Tipo               = @TipoCurva  
  
  
      IF @iFound = -1  
      BEGIN  
      -- SELECT @iFound , '1.- No Existen Curvas Definidas para Hoy.' + CHAR(10) + @cMensaje  
      -- RAISERROR('No Existen Curvas Definidas para Hoy.',16,1,'Error')  
         RETURN  
      END  
  
   -->     (5.0) Determina Existencia de Definición de Curva para el Producto  
      SET  @iFound                = -1  
   SELECT  @iFound                = 0  
   ,       @cCurvaPrincipal       = CP.CodigoCurva  
   ,       @cCurvaAlternativa     = CurAlter  
   ,       @sSpread               = Spread  
   ,       @cCurvaSpread          = CurSpread  
   FROM    CURVAS_PRODUCTO   CP   with (nolock)  
      ,    DEFINICION_CURVAS DC   with (nolock) --> (INDEX = CurvaProducto_Llave)  
   WHERE  (Modulo                 = @cModulo)  
   AND    (Producto               = @cProducto    OR @cProducto  = '')  
   AND    (CP.CodigoCurva         = DC.CodigoCurva)   
   AND    (Moneda                 = @iMoneda)  
   AND    (Instrumento            = @cInstrumento OR Instrumento = '*')  
   AND    (Emisor                 = @cEmisor      OR Emisor      = '*')  
   AND    (@iTasaEmision          BETWEEN TasaDesde AND TasaHasta)  
--   AND    (@cTipoTasa             = CASE WHEN @cModulo = 'PCS' AND @cProducto = 'SM' THEN TipoTasa          -- MAP 20081202 Uso de curvas locales  
--                                         ELSE                                             @cTipoTasa        -- MAP 20081202 Uso de curvas locales  
--                                    END)  
   AND    (TipoBase               = @iTipoBase    OR @iTipoBase  = 0)  
   AND    (Indicador              = @iIndicador   OR @iIndicador = -1)  
   -- Activacion para derivados FWD y SWAP
   AND    ( (		@Accion		 = 'DescCol' and CurvaLocal = 'N'   
              OR	@Accion     <> 'DescCol' and CurvaLocal = 'S'
	         )
	        and modulo in ( 'PCS', 'BFW' )
			or modulo not in ( 'PCS',  'BFW' )
	        )       
  
      IF @iFound = -1  
      BEGIN  
         --> SELECT @iFound , '2.- No Existe Definición para el registro : ' + @cMensaje  
      -- RAISERROR('No Existen Curvas Definidas para el Registro.',16,1,'Error')n  
           
         RETURN @iFound  
      END  
  
   -- Verificar si hay que cambiar la curva  
   -- porque se está utilizando para descontar  
   -- y se ha establecido curva de costo alternativo  

  
   if @cModulo = 'PCS'   
         --if @Accion = 'DescMxMn'                                          -- MAP 20081202 Usao de curvas Locales  
         --     select @cCurvaPrincipal = 'CURVASWAPUSDLOCAL'               -- MAP 20081202 Usao de curvas Locales  
         --else                                                             -- MAP 20081202 Usao de curvas Locales  
              if @Accion <> 'Descont' and @Accion <> 'DescCol'
                  if @cCurvaAlternativa <> ''  
                      select @cCurvaPrincipal = @cCurvaAlternativa  
			  
   
   select @CurvaUsada = @cCurvaPrincipal             
  
   -->     (6.0) Verifica la Exsistencia de la Valores para la Curva Primaria Asignada a la Fecha de Proceso.  
   DECLARE @iFoundCurva       INTEGER  
       SET @iFoundCurva       = -1  
  
   SELECT  TOP 1  
           @iFoundCurva       = 0  
   ,       @Curva_Producto    = CodigoCurva  
   FROM    CURVAS             with (nolock)  
-- FROM    #TMP_CURVAS        with (nolock)   --> CURVAS             with (nolock)  
   WHERE   FechaGeneracion    = @FechaCurva  
   AND     CodigoCurva        = @cCurvaPrincipal  
   AND     Tipo               = @TipoCurva  
  
      -->     (7.0) Si No Existe Curva Principal Busca la Curva Alternativa Siempre Que Esta Estubiese Asignada  
      -->           Por mientras SWAP queda sin curva alternativa, hasta la segunda etapa.  
      IF @iFoundCurva = -1 AND @cCurvaAlternativa <> '' and @cmodulo <> 'PCS'  
      BEGIN  
         -->     (7.1) Verifica la Exsistencia de la Valores para la Curva Alternativa a la Fecha de Proceso.  
            SET  @iFoundCurva    = -1  
         SELECT  TOP 1 
                 @iFoundCurva    = 0  
         ,       @Curva_Producto = CodigoCurva  
         FROM    CURVAS          with (nolock)  
      -- FROM    #TMP_CURVAS     with (nolock)   --> CURVAS          with (nolock)  
         WHERE   FechaGeneracion = @FechaCurva   
         AND     CodigoCurva     = @cCurvaAlternativa  
         AND     Tipo            = @TipoCurva  
      END  
  
      IF @iFoundCurva = -1  
      BEGIN  
         -->    Si no hay definidas curvas (Principal y Alternativa) se Aborta el Proceso.  
         -->    SELECT @iFoundCurva , 'No Existe Curva Definida para. : ' + @cMensaje   
         RETURN @iFoundCurva  
      END  
  
   --> (8.0) Si Solicita Curva Spread y Además se encuentra definida. Verifíca la Existencia de Datos Cargados a la Fecha para la Curva.  
   IF @sSpread = 'S' AND @cCurvaSpread <> ''  
   BEGIN  
         SET  @iFound         = -1  
      SELECT  @iFound         = 0  
      FROM    CURVAS          with (nolock)  
   -- FROM    #TMP_CURVAS     with (nolock)   --> CURVAS          with (nolock)  
      WHERE   FechaGeneracion = @FechaCurva   
      AND     CodigoCurva     = @cCurvaSpread  
      AND     Tipo            = @TipoCurva  
  
      --> (8.1) Si no existe información para la curva Spread, Continua solo con la información para Curvas Principales.  
      IF @iFound = -1  
      BEGIN  
         SET @sSpread = 'N'  
      END  
   END  
  
   -->     (9.0) Variables de Cálculo de la Curva Principal o Alternativa (CurvaProducto)  
   DECLARE @bInterpolacion  CHAR(1)  
   DECLARE @iTasa           FLOAT  
   DECLARE @iPuntoMenor     FLOAT  
   DECLARE @iValorMenor     FLOAT  
   DECLARE @iPuntoMayor     FLOAT  
   DECLARE @iValorMayor     FLOAT  
  
   -->     Identifica el Proceso de Calculo (CurvaProducto o CurvaSpread)  
   DECLARE @iVueltas        INTEGER  
   DECLARE @iContador       INTEGER  
  
   SET     @iVueltas        = CASE WHEN @sSpread = 'S' THEN 2 ELSE 1 END  
   SET     @iContador       = 1  
  
   WHILE  (@iVueltas >= @iContador)   
   BEGIN  
  
      -->     (9.1) Determina Si Debe Interpolar o No  
      SET     @bInterpolacion  = 'S'  
      SET     @iTasa           = 0.0  
  
      SELECT  @bInterpolacion  = 'N'  
      ,       @iTasa           = CASE WHEN @iDefineValorBidAsk = 1 THEN ValorBid ELSE ValorAsk END  
      FROM    CURVAS           with (nolock)  
   -- FROM    #TMP_CURVAS      with (nolock)   --> CURVAS           with (nolock)  
      WHERE   FechaGeneracion  = @FechaCurva   
      AND     CodigoCurva      = CASE WHEN @iContador = 1 THEN @Curva_Producto ELSE @cCurvaSpread END  
      AND     Dias             = @iDias  
      AND     Tipo             = @TipoCurva  
  
      -->  Se Debe Interpolar  
      IF @bInterpolacion = 'S' --> PROCESO DE INTERPOLACIÓN :  
      BEGIN  
         -->     Lee el Punto Inmediatamente Anteriro al Plazo Informado (a)  
         SELECT  @iPuntoMenor    = isnull(CONVERT(FLOAT,MAX(Dias)),0)  
         FROM    CURVAS          with (nolock)  
      -- FROM    #TMP_CURVAS     with (nolock)   --> CURVAS          with (nolock)  
         WHERE   FechaGeneracion = @FechaCurva   
         AND     CodigoCurva     = CASE WHEN @iContador = 1 THEN @Curva_Producto ELSE @cCurvaSpread END  
         AND     Dias            < @iDias  
         AND     Tipo            = @TipoCurva  
  
         -->     Lee el Punto Inmediatamente Posterior al Plazo Informado (b)  
         SELECT  @iPuntoMayor    = isnull(CONVERT(FLOAT,MIN(Dias)),0)  
         FROM    CURVAS          with (nolock)  
      -- FROM    #TMP_CURVAS     with (nolock)   --> CURVAS          with (nolock)  
         WHERE   FechaGeneracion = @FechaCurva   
         AND     CodigoCurva     = CASE WHEN @iContador = 1 THEN @Curva_Producto ELSE @cCurvaSpread END  
         AND     Dias            > @iDias  
         AND     Tipo            = @TipoCurva  
  
         IF @iPuntoMenor = 0  
         BEGIN  
            SET    @iPuntoMenor    = @iPuntoMayor  
  
            SELECT @iPuntoMayor    = CONVERT(FLOAT,MIN(Dias))  
            FROM   CURVAS          with (nolock)  
         -- FROM   #TMP_CURVAS     with (nolock)   --> CURVAS          with (nolock)  
            WHERE  FechaGeneracion = @FechaCurva   
            AND    CodigoCurva     = CASE WHEN @iContador = 1 THEN @Curva_Producto ELSE @cCurvaSpread END  
            AND    Dias            > @iPuntoMenor  
            AND    Tipo            = @TipoCurva  
         END  
  
         IF @iPuntoMayor = 0  
         BEGIN  
            SELECT @iPuntoMayor    = CONVERT(FLOAT,MAX(Dias))  
            FROM   CURVAS          with (nolock)  
         -- FROM   #TMP_CURVAS     with (nolock)   --> CURVAS          with (nolock)  
            WHERE  FechaGeneracion = @FechaCurva  
            AND    CodigoCurva     = CASE WHEN @iContador = 1 THEN @Curva_Producto ELSE @cCurvaSpread END  
            AND    Tipo            = @TipoCurva  
           
            SELECT @iPuntoMenor    = CONVERT(FLOAT,MAX(Dias))  
            FROM   CURVAS          with (nolock)  
         -- FROM   #TMP_CURVAS     with (nolock)   --> CURVAS          with (nolock)  
            WHERE  FechaGeneracion = @FechaCurva  
            AND    CodigoCurva     = CASE WHEN @iContador = 1 THEN @Curva_Producto ELSE @cCurvaSpread END  
            AND    Dias            < @iPuntoMayor  
            AND    Tipo            = @TipoCurva  
         END  
  
         -->     Lee el Valor al Punto Encontrado (a)  
         SELECT  @iValorMenor    = CASE WHEN @iDefineValorBidAsk = 1 THEN CONVERT(FLOAT,ValorBid)  
                                        ELSE                              CONVERT(FLOAT,ValorAsk)  
                                   END  
         FROM    CURVAS          with (nolock)  
      -- FROM    #TMP_CURVAS     with (nolock)   --> CURVAS          with (nolock)  
         WHERE   FechaGeneracion = @FechaCurva   
         AND     CodigoCurva     = CASE WHEN @iContador = 1 THEN @Curva_Producto ELSE @cCurvaSpread END  
         AND     Dias            = @iPuntoMenor  
         AND     Tipo            = @TipoCurva  
  
         -->     Lee el Valor al Punto Encontrado (b)  
         SELECT  @iValorMayor    = CASE WHEN @iDefineValorBidAsk = 1 THEN CONVERT(FLOAT,ValorBid)  
                           ELSE                              CONVERT(FLOAT,ValorAsk)  
                                   END  
         FROM    CURVAS          with (nolock)  
      -- FROM    #TMP_CURVAS     with (nolock)   --> CURVAS          with (nolock)  
         WHERE   FechaGeneracion = @FechaCurva   
         AND     CodigoCurva     = CASE WHEN @iContador = 1 THEN @Curva_Producto ELSE @cCurvaSpread END  
         AND     Dias            = @iPuntoMayor  
         AND     Tipo            = @TipoCurva  
  
         --> Interpolación  
         DECLARE @iDifDias       INTEGER  
             SET @iDifDias       = (@iPuntoMayor - @iPuntoMenor)  
  
         IF @iDifDias <> 0  
            SET @iTasa = ((@iValorMayor - @iValorMenor) / @iDifDias)  
         ELSE  
            SET @iTasa = 0.0  
  
         IF @iPuntoMenor <= @iDias AND @iDias <= @iPuntoMayor  
         BEGIN  
            SET @iTasa = @iValorMenor + (@iTasa * (@iDias - @iPuntoMenor))  
         END ELSE  
         BEGIN  
            IF @iPuntoMenor > @iDias  
            BEGIN  
               SET @iTasa = @iValorMenor - (@iTasa * (@iPuntoMenor - @iDias))  
            END ELSE  
            BEGIN  
               SET @iTasa = @iValorMayor + (@iTasa * (@iDias - @iPuntoMayor))  
            END  
         END  
         --> Interpolación        
  
      END --> PROCESO DE INTERPOLACIÓN :  
  
      if @iDias < 0 and abs(@iTasa) >= 100   -- solucion
		set @iTasa = 100.00

      IF @iContador = 1  
         SET @ValorCurvaProducto = isnull(@iTasa,0.0)  
      ELSE  
         SET @ValorCurvaSpread   = isnull(@iTasa,0.0)  
  
      SET @iContador = @iContador + 1  
   END  
  
END 
GO
