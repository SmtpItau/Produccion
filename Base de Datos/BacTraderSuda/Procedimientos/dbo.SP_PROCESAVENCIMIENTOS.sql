USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROCESAVENCIMIENTOS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PROCESAVENCIMIENTOS]
                     ( @user   CHAR (12) ,
   @terminal  CHAR (12)    )
AS
BEGIN
set nocount on
 DECLARE @ntotreg NUMERIC(10,0) ,
  @ntotreg1 NUMERIC(10,0) ,
  @nregact INTEGER         ,
  @idiasrenov INTEGER  ,
  @dfecvcto  DATETIME ,
  @dfecsist DATETIME ,
  @dfecvctold DATETIME ,
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
  @nnumoriginal NUMERIC(10,0) ,
  @nmontofin NUMERIC(19,4) ,
  @nvalmoneda NUMERIC(19,4) , 
  @nnewoper NUMERIC(10,0) ,
  @ncantrenov INTEGER  ,
  @ibase  INTEGER  ,
  @iredondeo INTEGER  ,
  @CTIPO   char(1)
  
     /* Creo tabla temporal para poder mantener integridad del proceso 
 _______________________________________________________________*/
 SELECT * INTO #TEMPORAL_RENOVADAS FROM GEN_CAPTACION  WHERE 1 = 2
     /* selecciona constante de dias para renovaci>n */
 SELECT @idiasrenov  = folio  FROM GEN_FOLIOS WHERE codigo ='RENOV'
 SELECT @dfecsist = acfecproc     FROM MDAC 
 SELECT @ntotreg = COUNT(*) FROM GEN_CAPTACION WHERE (estado = ' ' OR estado = 'V') AND tipo_deposito = 'R'
 SELECT @nregact = 1
 BEGIN TRANSACTION 
 WHILE @nregact <= @ntotreg 
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
   @dfecvctold = fecha_vencimiento ,
   @ncantrenov = control_renov  ,
   @iredondeo = mnredondeo  ,
   @nnumoriginal   = numero_original  ,
   @CTIPO  = tipo_deposito 
  FROM  
   GEN_CAPTACION ,
   VIEW_MONEDA
  WHERE   (estado = ' ' OR estado = 'V') 
  AND tipo_deposito = 'R'  
               AND  mncodmon  = moneda 
  SET ROWCOUNT 0 
  SELECT @nregact =  @nregact  + 1
             /* 
  =========================================================
                Si es igual 0 es la fecha de vencimiento,
  Si es menor 0 todav-a no vence aun
                Si es mayor 0 ya venci>
  ========================================================= */
  SELECT @ndifdia = DATEDIFF( day,  @dfecvcto, @dfecsist ) 
      -- ========================================================= 
  IF @imoneda = 999  SELECT @nvalmoneda = 1 
  ELSE
  SELECT @nvalmoneda  =  ISNULL(vmvalor,1)  
  FROM VIEW_VALOR_MONEDA 
  WHERE vmcodigo = @imoneda 
  AND vmfecha = @dfecsist
     /*  ================================================================== 
  Procedimiento de renovacion automatica de captaciones vencidas 
  ==================================================================  */
  IF  @ndifdia  > @idiasrenov       
  BEGIN
   UPDATE GEN_CAPTACION SET estado = 'R'   -- Cambio estado de registro original 
   WHERE numero_operacion = @nnumoper 
   IF @@ERROR<> 0 
   BEGIN
    ROLLBACK TRANSACTION  
                                SET NOCOUNT OFF
    SELECT 'NO', 'PROBLEMAS EN RENOVACI>N DE OPERACI>N DE CAPTACI>N, << CAPTACI>N >>'
    RETURN
   END
       /* ===================================================================
   I Extract new operation number for renovate automatic
   =================================================================== */
   SELECT @nnewoper=acnumoper FROM MDAC
   UPDATE MDAC
   SET acnumoper = acnumoper + 1
   IF @@ERROR<> 0 
   BEGIN
    ROLLBACK TRANSACTION  
    SET NOCOUNT OFF
                                SELECT 'NO', 'PROBLEMAS EN RENOVACI>N DE OPERACI>N DE CAPTACI>N, << CONTROL >>'
    RETURN
   END
       /* ================================================================== */
   SELECT @nmontoini = ( @nvalpres / @nvalmoneda )                      -- New purchase UM
   SELECT @nmontofin = @nmontoini * (1+((@ftasa*@iplazo)/(@ibase*100))) -- New Purchase express in CLP
   SELECT @dfecvcto  = DATEADD( day, @iplazo, @dfecvcto )               -- New maturity date
   INSERT INTO #TEMPORAL_RENOVADAS
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
    interes_diario  ,
    reajuste_diario  ,
    interes_acumulado ,
    reajuste_acumulado ,
    interes_extra  ,
    reajuste_extra  ,
    valor_ant_presente  ,
    tipo_deposito   ,
    numero_original  
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
    @dfecvctold  , 
    @ncantrenov+1  ,
    @ccustodia  , 
    @nvalpres  ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,   
    0   ,
    0   ,
    @CTIPO   ,
    @nnumoriginal
    )
   IF @@ERROR<> 0 
   BEGIN
    ROLLBACK TRANSACTION  
                                SET NOCOUNT OFF
                    SELECT 'NO', 'PROBLEMAS EN GRABACI>N DE OPERACI>N DE CAPTACI>N, << CAPTACI>N >>'
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
    movalcomp   ,
    monumdocuo   ,
    mocorrelao   ,
    monumoper   ,
    motipopero   ,
    monominalp   ,
    mousuario                       ,
    moterminal                      ,
    mostatreg                       ,
    modcv
    )
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
    @nmontoini   ,
    @nnumoriginal   , -- Grabo numero de captaci¢n original 
    1                               ,
    @nnewoper   ,
    'IC'    ,
    @nmontofin   ,
    @user     ,
    @terminal    ,
    ' '    , 
    @ccustodia   
    )
   IF @@ERROR<> 0 
   BEGIN
    ROLLBACK TRANSACTION  
           SET NOCOUNT OFF
                        SELECT 'NO', 'PROBLEMAS EN GRABACI>N DE OPERACI>N DE CAPTACI>N, << MOVIMIENTO >>'
    RETURN
   END
  END
  ELSE
  BEGIN
       -- Actualizo las operaciones que vencen   
   IF  @ndifdia =0 OR ( @ndifdia >0  AND @ndifdia < @idiasrenov )      
   BEGIN
    UPDATE GEN_CAPTACION SET estado = 'V'  WHERE numero_operacion = @nnumoper AND  estado =' '
    IF @@ERROR<> 0 
    BEGIN
     ROLLBACK TRANSACTION  
                                        SET NOCOUNT OFF
     SELECT 'NO', 'PROBLEMAS EN GRABACI>N DE OPERACI>N DE CAPTACI>N, << CAPTACI>N >>'
     RETURN
    END
   END
  END  
 END
 IF EXISTS( SELECT * FROM #TEMPORAL_RENOVADAS )
 BEGIN
  SELECT @ntotreg = COUNT (*) FROM #TEMPORAL_RENOVADAS
  INSERT INTO 
  GEN_CAPTACION( 
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
   valor_ant_presente ,
   valor_presente  ,
                 tipo_deposito  )
  SELECT 
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
   valor_ant_presente ,
   valor_presente  ,
                 tipo_deposito
  FROM 
   #TEMPORAL_RENOVADAS
  SELECT @ntotreg1 = COUNT(*) FROM GEN_CAPTACION WHERE tipo_deposito ='F' AND fecha_vencimiento = @dfecsist  
  IF @ntotreg1 <> 0  UPDATE GEN_CAPTACION SET estado ='V' WHERE tipo_deposito ='F' and fecha_vencimiento = @dfecsist  
  IF @ntotreg1 <> 0
  SELECT 'SI', 'SE REALIZARON ' + RTRIM( CONVERT(CHAR(10),@ntotreg)) + ' RENOVACIONES Y ' +  RTRIM( CONVERT(CHAR(10),@ntotreg)) + ' VENCIMIENTOS DE CAPTACIONES '
  ELSE
  SELECT 'SI', 'SE REALIZARON ' + RTRIM( CONVERT(CHAR(10),@ntotreg)) + ' RENOVACIONES DE CAPTACIONES '
 END
 ELSE 
 BEGIN
  SELECT @ntotreg = COUNT(*) FROM GEN_CAPTACION WHERE tipo_deposito ='F' and fecha_vencimiento = @dfecsist  
  IF @ntotreg <> 0  UPDATE GEN_CAPTACION SET estado ='V' WHERE tipo_deposito ='F' and fecha_vencimiento = @dfecsist  
  IF @ntotreg= 0  SELECT 'SI', 'SE REALIZARON ' + RTRIM( CONVERT(CHAR(10),@ntotreg)) + ' VENCIMIENTOS DE CAPTACIONES '
  ELSE SELECT 'SI', 'NO SE REGISTRARON VENCIMIENTOS Y/O RENOVACIONES DE CAPTACIONES '
 END
   COMMIT TRANSACTION
   SET NOCOUNT OFF
   SELECT 'OK'
END



GO
