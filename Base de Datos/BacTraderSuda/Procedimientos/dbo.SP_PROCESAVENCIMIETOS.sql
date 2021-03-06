USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROCESAVENCIMIETOS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PROCESAVENCIMIETOS]
AS
BEGIN
 DECLARE @ntotreg NUMERIC(10,0) ,
  @nregact NUMERIC(10,0) ,
  @idiasrenov INTEGER  ,
  @dfecvcto  DATETIME ,
  @dfecsist DATETIME ,
  @dfecorig DATETIME ,
  @ndifdia INTEGER  ,
  @nnumoper NUMERIC(10,0) ,
  @ctipoper  CHAR(10) ,
  @nrutcli   NUMERIC(10,0) ,
  @ncodcli   NUMERIC(10,0) ,
  @nentidad  NUMERIC(10,0) ,
  @iforpago  INTEGER  ,
  @cretiro   CHAR(01) ,
  @nmontoini   NUMERIC(19,4) ,
  @imoneda   INTEGER  ,
  @ftasa    FLOAT  ,
  @ftasatran FLOAT  ,
  @iplazo    INTEGER  ,
  @ccustodia  CHAR(01) ,
  @nvalpres  NUMERIC(19,0) ,
  @nmontofin NUMERIC(19,4) ,
  @nvalmoneda NUMERIC(19,4) , 
  @nnewoper NUMERIC(10,0) ,
  @ncantrenov INTEGER  ,
  @ibase  INTEGER  ,
  @iredondeo INTEGER
  
     /* Creo tabla temporal para poder mantener integridad del proceso 
 _______________________________________________________________*/
 SELECT * INTO #TEMPORAL_RENOVADAS FROM GEN_CAPTACION  WHERE 1 = 2
     /* selecciona constante de dias para renovaci¢n */
 SELECT @idiasrenov  = folio  FROM GEN_FOLIOS WHERE codigo ='RENOV'
 SELECT @dfecsist = acfecproc     FROM MDAC 
 SELECT @ntotreg = COUNT(*)  FROM GEN_CAPTACION  WHERE estado = ' ' AND estado = 'V'
 SELECT @nregact = 1
 BEGIN TRANSACTION 
 WHILE @nregact < @ntotreg 
 BEGIN
  SET ROWCOUNT @nregact
  SELECT 
   @nnumoper  = numero_operacion ,
   @dfecvcto  = fecha_vencimiento  ,
   @ctipoper  = tipo_operacion  ,
   @nrutcli   = rut_cliente   ,
   @ncodcli   = codigo_rut   ,
   @nentidad = entidad   ,
   @iforpago  = CONVERT(INTEGER,forma_pago)   ,
   @cretiro  = retiro   ,
   @imoneda   = moneda   ,
   @ftasa   = tasa    ,
   @ftasatran = tasa_tran   ,
   @iplazo   = plazo   ,
   @ccustodia  = custodia  ,
   @nvalpres = valor_presente ,
   @ibase    = mnbase  ,
   @dfecorig  = fecha_origen  ,
   @ncantrenov = control_renov  ,
   @iredondeo = mnredondeo
  FROM  
   GEN_CAPTACION ,
   VIEW_MONEDA
  WHERE 
   estado = ' ' 
  AND  estado = 'V'
  AND  mncodmon = moneda 
  SET ROWCOUNT 0 
  SELECT @nregact =  @nregact  + 1
  SELECT @ndifdia = DATEDIFF( day, @dfecsist, @dfecvcto )
  IF @imoneda = 999  SELECT @nvalmoneda = 1 
  ELSE
  SELECT @nvalmoneda  =  ISNULL(vmvalor,1)  
  FROM   VIEW_VALOR_MONEDA 
  WHERE  vmcodigo = @imoneda 
            AND vmfecha = @dfecsist
     /*  Procedimiento de renovacion automatica de caprtacion
  ====================================================  */
  IF  @ndifdia  > @idiasrenov       
  BEGIN
   UPDATE GEN_CAPTACION SET estado = 'R'   -- Cambio estado de regitro original 
   WHERE numero_operacion = @nnumoper 
   IF @@ERROR<> 0 
   BEGIN
    ROLLBACK TRANSACTION  
    SELECT 'NO', 'PROBLEMAS EN RENOVACION DE OPERACI¢N DE CAPTACION, << CAPTACI¢N >>'
    RETURN
   END
   SELECT @nnewoper=acnumoper FROM MDAC
   UPDATE MDAC
   SET acnumoper = acnumoper + 1
   IF @@ERROR<> 0 
   BEGIN
    ROLLBACK TRANSACTION  
    SELECT 'NO', 'PROBLEMAS EN RENOVACION DE OPERACI¢N DE CAPTACION, << CONTROL >>'
    RETURN
   END
   SELECT @nmontoini = ( @nvalpres / @nvalmoneda )                      -- New purchase UM
   SELECT @nmontofin = @nmontoini * (1+((@ftasa*@iplazo)/(@ibase*100))) -- New Purchase express in CLP
   SELECT @dfecvcto  = DATEADD( day, @iplazo, @dfecvcto )              -- New maturity date
   INSERT INTO 
   #TEMPORAL_RENOVADAS
    (
    fecha_operacion  ,
    fecha_vencimiento  ,
    tipo_operacion   ,
    numero_operacion  ,
    correla_operacion ,
    correla_corte  ,
    rut_cliente   ,
    codigo_rut   ,
    entidad   ,
    forma_pago   ,
    retiro    ,
    monto_inicio   ,
    monto_inicio_pesos  ,
    moneda    ,
    tasa    ,
    tasa_tran   ,
    plazo    ,
    monto_final   ,
    estado   ,
    fecha_origen   ,
    control_renov  ,
    custodia  ,
    valor_presente  ,
    control_renov 
    )
      VALUES
       (
    @dfecsist  ,
    @dfecvcto  ,
    'CAP'   ,
    @nnewoper  ,
    1   ,
    1   ,
    @nrutcli  ,
    @ncodcli  ,
    @nentidad  ,
    CONVERT(CHAR(04),@iforpago), 
    @cretiro  , 
    @nmontoini  ,
    @nvalpres  , 
    @imoneda  ,
    @ftasa   , 
    @ftasatran  , 
    @iplazo   , 
    @nmontofin  , 
    ' '   , 
    @dfecorig  , 
    0   ,
    @ccustodia  , 
    @nvalpres  ,
    @ncantrenov+1
    )
   IF @@ERROR<> 0 
   BEGIN
    ROLLBACK TRANSACTION  
    SELECT 'NO', 'PROBLEMAS EN GRABACION DE OPERACION DE CAPTACI¢N, << CAPTACI¢N >>'
    RETURN
   END
       /* Actualizo Tabla de movimiento  
   =============================  */
   INSERT INTO 
   MDMO(
    mofecpro   ,
    morutcart   ,
    motipcart   ,
    monumdocu   ,
    mocorrela   ,
    motipoper   ,
    moinstser   ,
    momascara   ,
    mocodigo   ,
    moseriado   ,
    mofecemi   ,
    mofecven   ,
    momonemi   ,
    mobasemi   ,
    monominal   ,
    movpresen   ,
    motir    ,
    mofecinip   ,
    mofecvenp   ,
    movalinip   ,
    movalvenp   ,
    motaspact   ,
    mobaspact   ,
    momonpact   ,
    moforpagi   ,
    moforpagv   ,
    mopagohoy   ,
    morutcli   ,
    mocodcli   ,
    motipret   ,
    mohora    ,
    mousuario   ,
    moterminal   ,
    movalcomp   ,
    monumdocuo   ,
    mocorrelao   ,
    monumoper   ,
    motipopero   ,
    monominalp   ,
    mostatreg                        )
   VALUES 
    (
    @dfecsist   ,
    @nentidad   ,
    0    ,
    @nnewoper   ,
    1    ,
    'IC'    ,
    'CAP'    ,
    'CAP'    ,
    0    ,
    'N'    ,
    @dfecsist   ,
    @dfecvcto   ,
    @imoneda   ,
    @iBase    ,
    @nmontofin   ,
    @nmontoini   ,
    @ftasa    ,
    @dfecsist   ,
    @dfecvcto   ,
    @nmontoini   ,
    @nmontofin   ,
    @ftasa    ,
    @iBase    ,
    @imoneda   ,
    @iforpago   , 
    0    ,
    'N'    ,
    @nrutcli   ,
    @ncodcli   ,
    @cretiro   ,
    CONVERT(CHAR(15),GETDATE(),108) ,
    ''     ,
    'TERMINAL 1'   ,
    @nmontoini   ,
    @nnewoper   ,
    1                               ,
    @nnewoper   ,
    'IC'    ,
    @nmontofin   ,
    ' '      
    )
   IF @@ERROR<> 0 
   BEGIN
    ROLLBACK TRANSACTION  
    SELECT 'NO', 'PROBLEMAS EN GRABACI¢N DE OPERACION DE CAPTACION, << MOVIMIENTO >>'
    RETURN
   END
  END
  ELSE
  BEGIN
   UPDATE GEN_CAPTACION SET estado = 'V'  WHERE numero_operacion = @nnumoper AND  estado = ' '
   IF @@ERROR<> 0 
   BEGIN
    ROLLBACK TRANSACTION  
    SELECT 'NO', 'PROBLEMAS EN GRABACION DE OPERACI¢N DE CAPTACION, << CAPTACI¢N >>'
    RETURN
   END
  END  
 END
 IF EXISTS( SELECT * FROM #TEMPORAL_RENOVADAS )
 BEGIN
  SELECT @ntotreg = COUNT (*) FROM #TEMPORAL_RENOVADAS
  INSERT INTO GEN_CAPTACION 
  SELECT * FROM #TEMPORAL_RENOVADAS
 END 
 SELECT 'SI' , 'SE REALIZARON ' + RTRIM( CONVERT(CHAR(10),@ntotreg)) + ' RENOVACIONES DE CAPTACIONES '
 COMMIT TRANSACTION
END

GO
