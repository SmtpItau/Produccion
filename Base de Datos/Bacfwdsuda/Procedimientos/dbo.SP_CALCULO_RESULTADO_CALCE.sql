USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULO_RESULTADO_CALCE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CALCULO_RESULTADO_CALCE]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @cartera_activo  NUMERIC(03) ,
  @numero_activo  NUMERIC(10) ,
  @cartera_pasivo  NUMERIC(03) ,
  @numero_pasivo  NUMERIC(10) ,
  @monto_calce  NUMERIC(21,04) ,
  @fecha_vcto  DATETIME ,
  @fecha_inicio  DATETIME ,
  @fecha_proceso  DATETIME ,
  @fecha_anterior  DATETIME ,
  @fecha_pasivo  DATETIME ,
  @fecha_activo  DATETIME ,
  @monto_moneda1   NUMERIC(21,04) ,
  @factor   NUMERIC(21,10) ,
  @reajuste_tc  NUMERIC(21,00) ,
  @reajuste_uf  NUMERIC(21,00) ,  
  @devengo  NUMERIC(21,00) ,
  @devengo_dolares NUMERIC(21,00) ,  
  @devengo_pesos  NUMERIC(21,00) ,  
  @devengo_uf  NUMERIC(21,00) ,
  @interes_dolares NUMERIC(21,00) ,
  @inicio_moneda1  NUMERIC(21,00) ,
  @moneda   NUMERIC(03,00) ,
  @resultado_activo NUMERIC(21,00) ,
  @resultado_pasivo NUMERIC(21,00) ,
  @saldo_dolares_activo  NUMERIC(21,00) ,
  @saldo_dolares_pasivo NUMERIC(21,00) ,
  @reajuste_tc_activo NUMERIC(21,00) ,
  @reajuste_uf_activo NUMERIC(21,00) ,
  @devengo_activo  NUMERIC(21,00) ,
  @devengo_dolares_activo NUMERIC(21,00) ,
  @devengo_pesos_activo NUMERIC(21,00) , 
  @devengo_uf_activo NUMERIC(21,00) ,
  @reajuste_tc_pasivo NUMERIC(21,00) ,
  @reajuste_uf_pasivo NUMERIC(21,00) ,
  @devengo_pasivo  NUMERIC(21,00) ,
  @devengo_dolares_pasivo NUMERIC(21,00) ,
  @devengo_pesos_pasivo NUMERIC(21,00) ,
  @devengo_uf_pasivo NUMERIC(21,00) ,
  @activo_de_hoy  CHAR(02) ,
  @pasivo_de_hoy  CHAR(02) ,
  @llave_activo  CHAR(9)  ,
  @llave_pasivo  CHAR(9)  ,
  @llave_general  CHAR(9)  ,
  @llave_resultado_activo CHAR(9)  ,
  @llave_resultado_pasivo CHAR(9)  ,
         @PrimerDiaMes       CHAR(8)
 SELECT  @fecha_proceso = acfecproc ,
  @fecha_anterior = acfecante
 FROM mfac
 SELECT @PrimerDiaMes   = SUBSTRING(CONVERT(CHAR(8),@Fecha_Proceso,112),1,6) + '01'
 --|--------------------------------------------------------------------
 --| Actualiza los Resultados del Día Antes de Proceder con los Cálculos
 --|--------------------------------------------------------------------
 UPDATE  resultado_calce 
 SET  activo_saldo_usd   = 0,
  activo_variacion_tc   = 0,
  activo_variacion_uf   = 0,
  activo_devengo    = 0,
  activo_devengo_dolares   = 0,
  activo_devengo_pesos   = 0,
  activo_devengo_uf   = 0,
  pasivo_saldo_usd   = 0,
  pasivo_variacion_tc   = 0,
  pasivo_variacion_uf   = 0,
  pasivo_devengo    = 0,
  pasivo_devengo_dolares   = 0,
  pasivo_devengo_pesos   = 0,
  pasivo_devengo_uf   = 0,
  neto_dia     = 0,
  neto_acumulado     = 0
 WHERE fecha = @fecha_proceso
 SELECT * INTO #temp_c FROM resultado_calce WHERE @fecha_anterior = fecha
 UPDATE  a SET  a.activo_acumulado_tc   = b.activo_acumulado_tc   ,
   a.activo_acumulado_uf   = b.activo_acumulado_uf   ,
   a.activo_acumulado_devengo  = b.activo_acumulado_devengo  ,
   a.activo_acumulado_devengo_dolares = b.activo_acumulado_devengo_dolares ,
   a.activo_acumulado_devengo_pesos = b.activo_acumulado_devengo_pesos ,
   a.activo_acumulado_devengo_uf  = b.activo_acumulado_devengo_uf  ,
   a.pasivo_acumulado_tc   = b.pasivo_acumulado_tc   ,
   a.pasivo_acumulado_uf   = b.pasivo_acumulado_uf   ,
   a.pasivo_acumulado_devengo  = b.pasivo_acumulado_devengo  ,
   a.pasivo_acumulado_devengo_dolares = b.pasivo_acumulado_devengo_dolares ,
   a.pasivo_acumulado_devengo_pesos = b.pasivo_acumulado_devengo_pesos ,
   a.pasivo_acumulado_devengo_uf  = b.pasivo_acumulado_devengo_uf  
 FROM  resultado_calce a,
  #temp_c  b  
 WHERE @fecha_proceso = a.fecha AND a.tipo = b.tipo 
 ----<< Chequea si es el Primer dia del Mes
 IF SUBSTRING(@PrimerDiaMes,5,2) <> SUBSTRING(CONVERT(CHAR(8),@fecha_anterior,112),5,2)
  BEGIN
    --   PRINT 'Hoy es el Primer dia del Mes'
   UPDATE  a SET  a.activo_acumulado_tc   = 0 ,
     a.activo_acumulado_uf   = 0 ,
     a.activo_acumulado_devengo  = 0 ,
     a.activo_acumulado_devengo_dolares = 0 ,
     a.activo_acumulado_devengo_pesos = 0 ,
     a.activo_acumulado_devengo_uf  = 0 ,
     a.pasivo_acumulado_tc   = 0 ,
     a.pasivo_acumulado_uf   = 0 ,
     a.pasivo_acumulado_devengo  = 0 ,
     a.pasivo_acumulado_devengo_dolares = 0 ,
     a.pasivo_acumulado_devengo_pesos = 0 ,
     a.pasivo_acumulado_devengo_uf  = 0
   FROM  resultado_calce a,
    #temp_c  b  
   WHERE @fecha_proceso = a.fecha 
       
  END
 BEGIN TRANSACTION
   DECLARE Tmp_CurCALCE   SCROLL CURSOR
   FOR  SELECT ccposcmp ,
    ccopecmp ,
    ccposvta ,
    ccopevta ,
    ccmonto  ,
    ccfecven  ,
    ccfecuact
  FROM  mfcc
  
  OPEN Tmp_CurCALCE
  FETCH FIRST FROM Tmp_CurCALCE
   INTO @cartera_activo ,
    @numero_activo ,
    @cartera_pasivo ,
    @numero_pasivo ,
    @monto_calce ,
    @fecha_vcto ,
    @fecha_inicio
    
  WHILE ( @@FETCH_STATUS = 0 ) 
   BEGIN
   SELECT @activo_de_hoy = 'NO'
   SELECT @pasivo_de_hoy = 'NO'
   IF @fecha_vcto >= @fecha_proceso
    BEGIN
     --|-----------------------------------------------------------
     --| Cálculo de Resultado del Activo
     --|-----------------------------------------------------------
     IF @cartera_activo = 7 
      SELECT @cartera_activo = 1 -- Esto Porque se Tratan como un Seguro de Cambio
     SELECT  @monto_moneda1   = camtomon1     ,
      @reajuste_tc  = cadiftipcam    ,
      @reajuste_uf  = cadifuf * -1     ,
      @devengo  = ( cautildevenga + caperddevenga ) ,--( cautildiferir + caperddiferir ) ,
      @devengo_dolares = pesos_devengo_usd , --diferido_usd     ,
      @devengo_pesos  = ( CASE cacodmon2 WHEN 999 THEN pesos_devengo_cnv ELSE 0 END ) ,
      @devengo_uf  = ( CASE cacodmon2 WHEN 998 THEN pesos_devengo_cnv ELSE 0 END ) ,
      @interes_dolares = ABS( devengo_acum_usd_hoy )  ,
      @inicio_moneda1  = camtomon1ini    ,
      @moneda   = ( CASE WHEN cacodpos1 = 1 OR cacodpos1 = 3 OR cacodpos1 = 7 THEN cacodmon2 ELSE cacodmon1 END ),
      @fecha_activo  = cafecha
     FROM  mfca 
     WHERE  canumoper = @numero_activo
     SELECT @saldo_dolares_activo = @monto_calce
     IF @fecha_activo = @fecha_proceso
      SELECT @activo_de_hoy = 'SI'
     
     EXECUTE sp_div @monto_calce , @monto_moneda1 , @factor OUTPUT
     IF @cartera_activo = 4 OR @cartera_activo = 5 OR @cartera_activo = 6
      SELECT @saldo_dolares_activo = ( @inicio_moneda1 + @interes_dolares ) * @factor
     IF @fecha_vcto <= @fecha_proceso
      SELECT @saldo_dolares_activo = 0
     SELECT  @reajuste_tc_activo   = @reajuste_tc * @factor
     SELECT  @reajuste_uf_activo  = @reajuste_uf * @factor
     SELECT  @devengo_activo   = @devengo * @factor
     SELECT  @devengo_dolares_activo  = @devengo_dolares * @factor
     SELECT @devengo_pesos_activo  = @devengo_pesos * @factor
     SELECT  @devengo_uf_activo  = @devengo_uf * @factor
     SELECT  @resultado_activo  = @reajuste_tc + @reajuste_uf + @devengo + @devengo_dolares + @devengo_pesos +  @devengo_uf 
     SELECT  @llave_activo    = 'C-' + CONVERT(CHAR(3),@cartera_activo) + '-' + CONVERT(CHAR(3),@moneda)
     --|-----------------------------------------------------------
     --| Cálculo de Resultado del Pasivo
     --|-----------------------------------------------------------
     IF @cartera_pasivo = 7 
      SELECT @cartera_pasivo = 1 -- Esto Porque se Tratan como un Seguro de Cambio
     SELECT  @monto_moneda1   = camtomon1     ,
      @reajuste_tc  = cadiftipcam * -1   ,
      @reajuste_uf  = cadifuf    ,
      @devengo  = ( cautildevenga + caperddevenga ), --( cautildiferir + caperddiferir ) ,
      @devengo_dolares = pesos_devengo_usd   ,
      @devengo_pesos  = ( CASE cacodmon2 WHEN 999 THEN pesos_devengo_cnv ELSE 0 END ) ,
      @devengo_uf  = ( CASE cacodmon2 WHEN 998 THEN pesos_devengo_cnv ELSE 0 END ) ,
      @interes_dolares = ABS( devengo_acum_usd_hoy )  ,
      @inicio_moneda1  = camtomon1ini    ,
      @moneda   = ( CASE WHEN cacodpos1 = 1 OR cacodpos1 = 3 OR cacodpos1 = 7 THEN cacodmon2 ELSE cacodmon1 END ),
      @fecha_pasivo  = cafecha
     FROM  mfca 
     WHERE  canumoper = @numero_pasivo
     SELECT @saldo_dolares_pasivo = @monto_calce
     IF @fecha_pasivo = @fecha_proceso
      SELECT @pasivo_de_hoy = 'SI'
     
     EXECUTE sp_div @monto_calce , @monto_moneda1 , @factor OUTPUT
     IF @cartera_pasivo = 4 OR @cartera_pasivo = 5 OR @cartera_pasivo = 6
      SELECT @saldo_dolares_pasivo = ( @inicio_moneda1 + @interes_dolares ) * @factor
     IF @fecha_vcto <= @fecha_proceso
      SELECT @saldo_dolares_pasivo = 0
     SELECT  @reajuste_tc_pasivo   = @reajuste_tc * @factor
     SELECT  @reajuste_uf_pasivo  = @reajuste_uf * @factor
     SELECT  @devengo_pasivo   = @devengo * @factor
     SELECT  @devengo_dolares_pasivo  = @devengo_dolares * @factor
     SELECT @devengo_pesos_pasivo  = @devengo_pesos * @factor
     SELECT  @devengo_uf_pasivo  = @devengo_uf * @factor
     SELECT  @resultado_pasivo  = @reajuste_tc + @reajuste_uf + @devengo + @devengo_dolares + @devengo_pesos +  @devengo_uf 
     SELECT  @llave_pasivo    = 'V-' + CONVERT(CHAR(3),@cartera_pasivo) + '-' + CONVERT(CHAR(3),@moneda)
     SELECT  @llave_general    = CONVERT(CHAR(3),@cartera_activo) + '-' + CONVERT(CHAR(3),@cartera_pasivo) 
     --|-----------------------------------------------------
     --| Grabación de los Calces
     --|-----------------------------------------------------
     IF @activo_de_hoy = 'SI' AND @pasivo_de_hoy = 'NO'
      BEGIN
       UPDATE  resultado_calce 
       SET  activo_variacion_tc   = activo_variacion_tc + @reajuste_tc_activo   ,
        activo_variacion_uf   = activo_variacion_uf + @reajuste_uf_activo   ,
        activo_devengo_dolares   = activo_devengo_dolares + @devengo_dolares_activo  ,
        activo_devengo_pesos   = activo_devengo_pesos + @devengo_pesos_activo   ,
        activo_devengo_uf   = activo_devengo_uf + @devengo_uf_activo   ,
        activo_acumulado_tc   = activo_acumulado_tc + @reajuste_tc_activo   ,
        activo_acumulado_uf   = activo_acumulado_uf + @reajuste_uf_activo   ,
        activo_acumulado_devengo_dolares = activo_acumulado_devengo_dolares + @devengo_dolares_activo ,
        activo_acumulado_devengo_pesos  = activo_acumulado_devengo_pesos + @devengo_pesos_activo ,
        activo_acumulado_devengo_uf  = activo_acumulado_devengo_uf + @devengo_uf_activo  ,
        neto_dia     = activo_variacion_tc + activo_variacion_uf + activo_devengo + activo_devengo_dolares + activo_devengo_pesos + activo_devengo_uf + pasivo_variacion_tc + pasivo_variacion_uf + pasivo_devengo + pasivo_devengo_dolares + pasivo_devengo_pesos + pasivo_devengo_uf,
        neto_acumulado    = activo_acumulado_tc + activo_acumulado_uf + activo_acumulado_devengo + activo_acumulado_devengo_dolares + activo_acumulado_devengo_pesos + activo_acumulado_devengo_uf + pasivo_acumulado_tc + pasivo_acumulado_uf + pasivo_acumulado_devengo + pasivo_acumulado_devengo_dolares + pasivo_acumulado_devengo_pesos + pasivo_acumulado_devengo_uf 
       WHERE tipo = @llave_activo AND
        fecha = @fecha_proceso         
       UPDATE  resultado_calce 
       SET  pasivo_saldo_usd   = pasivo_saldo_usd + @saldo_dolares_pasivo   ,
        pasivo_variacion_tc   = pasivo_variacion_tc + @reajuste_tc_pasivo   ,
        pasivo_variacion_uf   = pasivo_variacion_uf + @reajuste_uf_pasivo   ,
        pasivo_devengo    = pasivo_devengo + @devengo_pasivo    ,
        pasivo_devengo_dolares   = pasivo_devengo_dolares + @devengo_dolares_pasivo  ,
        pasivo_devengo_pesos   = pasivo_devengo_pesos + @devengo_pesos_pasivo   ,
        pasivo_devengo_uf   = pasivo_devengo_uf + @devengo_uf_pasivo   ,
        pasivo_acumulado_tc   = pasivo_acumulado_tc + @reajuste_tc_pasivo   ,
        pasivo_acumulado_uf   = pasivo_acumulado_uf + @reajuste_uf_pasivo   ,
        pasivo_acumulado_devengo  = pasivo_acumulado_devengo + @devengo_pasivo   ,
        pasivo_acumulado_devengo_dolares = pasivo_acumulado_devengo_dolares + @devengo_dolares_pasivo ,
        pasivo_acumulado_devengo_pesos  = pasivo_acumulado_devengo_pesos + @devengo_pesos_pasivo ,
        pasivo_acumulado_devengo_uf  = pasivo_acumulado_devengo_uf + @devengo_uf_pasivo  ,
        neto_dia     = activo_variacion_tc + activo_variacion_uf + activo_devengo + activo_devengo_dolares + activo_devengo_pesos + activo_devengo_uf + pasivo_variacion_tc + pasivo_variacion_uf + pasivo_devengo + pasivo_devengo_dolares + pasivo_devengo_pesos + pasivo_devengo_uf,
        neto_acumulado    = activo_acumulado_tc + activo_acumulado_uf + activo_acumulado_devengo + activo_acumulado_devengo_dolares + activo_acumulado_devengo_pesos + activo_acumulado_devengo_uf + pasivo_acumulado_tc + pasivo_acumulado_uf + pasivo_acumulado_devengo + pasivo_acumulado_devengo_dolares + pasivo_acumulado_devengo_pesos + pasivo_acumulado_devengo_uf 
       WHERE tipo = @llave_pasivo AND
        fecha = @fecha_proceso
       UPDATE  resultado_calce 
       SET  activo_saldo_usd   = activo_saldo_usd + @saldo_dolares_activo ,
        activo_devengo    = activo_devengo + @devengo_activo  ,
        activo_acumulado_devengo  = activo_acumulado_devengo + @devengo_activo ,      
        pasivo_saldo_usd   = pasivo_saldo_usd + @saldo_dolares_pasivo ,
        neto_dia     = activo_variacion_tc + activo_variacion_uf + activo_devengo + activo_devengo_dolares + activo_devengo_pesos + activo_devengo_uf + pasivo_variacion_tc + pasivo_variacion_uf + pasivo_devengo + pasivo_devengo_dolares + pasivo_devengo_pesos + pasivo_devengo_uf,
        neto_acumulado    = activo_acumulado_tc + activo_acumulado_uf + activo_acumulado_devengo + activo_acumulado_devengo_dolares + activo_acumulado_devengo_pesos + activo_acumulado_devengo_uf + pasivo_acumulado_tc + pasivo_acumulado_uf + pasivo_acumulado_devengo + pasivo_acumulado_devengo_dolares + pasivo_acumulado_devengo_pesos + pasivo_acumulado_devengo_uf 
       WHERE tipo = @llave_general AND
        fecha = @fecha_proceso
       --|-----------------------------------------------
       -- Resultado Netos del Día Se Guardan en Resultado
       --|-----------------------------------------------
       UPDATE  resultado 
       SET  neto_dia = acumulado_neto + @resultado_activo ,
        acumulado_neto  = acumulado_neto + @resultado_activo 
       WHERE tipo = 'C-' + CONVERT(CHAR(3),@cartera_activo) + '-CAL' AND
        fecha = @fecha_proceso
       UPDATE  resultado 
       SET  neto_dia = acumulado_neto + @resultado_pasivo ,
        acumulado_neto  = acumulado_neto + @resultado_pasivo 
       WHERE tipo = 'V-' + CONVERT(CHAR(3),@cartera_pasivo) + '-ABI' AND
        fecha = @fecha_proceso
      END
     ELSE IF @pasivo_de_hoy = 'SI' AND @activo_de_hoy = 'NO'
      BEGIN
       UPDATE  resultado_calce 
       SET  activo_variacion_tc   = activo_variacion_tc + @reajuste_tc_activo   ,
        activo_variacion_uf   = activo_variacion_uf + @reajuste_uf_activo   ,
        activo_devengo    = activo_devengo + @devengo_activo    ,
        activo_devengo_dolares   = activo_devengo_dolares + @devengo_dolares_activo  ,
        activo_devengo_pesos   = activo_devengo_pesos + @devengo_pesos_activo   ,
        activo_devengo_uf   = activo_devengo_uf + @devengo_uf_activo   ,
        activo_acumulado_tc   = activo_acumulado_tc + @reajuste_tc_activo   ,
        activo_acumulado_uf   = activo_acumulado_uf + @reajuste_uf_activo   ,
        activo_acumulado_devengo  = activo_acumulado_devengo + @devengo_activo   ,
        activo_acumulado_devengo_dolares = activo_acumulado_devengo_dolares + @devengo_dolares_activo ,
        activo_acumulado_devengo_pesos  = activo_acumulado_devengo_pesos + @devengo_pesos_activo ,
        activo_acumulado_devengo_uf  = activo_acumulado_devengo_uf + @devengo_uf_activo  ,
        neto_dia     = activo_variacion_tc + activo_variacion_uf + activo_devengo + activo_devengo_dolares + activo_devengo_pesos + activo_devengo_uf + pasivo_variacion_tc + pasivo_variacion_uf + pasivo_devengo + pasivo_devengo_dolares + pasivo_devengo_pesos + pasivo_devengo_uf,
        neto_acumulado    = activo_acumulado_tc + activo_acumulado_uf + activo_acumulado_devengo + activo_acumulado_devengo_dolares + activo_acumulado_devengo_pesos + activo_acumulado_devengo_uf + pasivo_acumulado_tc + pasivo_acumulado_uf + pasivo_acumulado_devengo + pasivo_acumulado_devengo_dolares + pasivo_acumulado_devengo_pesos + pasivo_acumulado_devengo_uf 
       WHERE tipo = @llave_activo AND
        fecha = @fecha_proceso
       UPDATE  resultado_calce 
       SET  pasivo_saldo_usd   = pasivo_saldo_usd + @saldo_dolares_pasivo   ,
        pasivo_variacion_tc   = pasivo_variacion_tc + @reajuste_tc_pasivo   ,
        pasivo_variacion_uf   = pasivo_variacion_uf + @reajuste_uf_pasivo   ,
        pasivo_devengo_dolares   = pasivo_devengo_dolares + @devengo_dolares_pasivo  ,
        pasivo_devengo_pesos   = pasivo_devengo_pesos + @devengo_pesos_pasivo   ,
        pasivo_devengo_uf   = pasivo_devengo_uf + @devengo_uf_pasivo   ,
        pasivo_acumulado_tc   = pasivo_acumulado_tc + @reajuste_tc_pasivo   ,
        pasivo_acumulado_uf   = pasivo_acumulado_uf + @reajuste_uf_pasivo   ,
        pasivo_acumulado_devengo_dolares = pasivo_acumulado_devengo_dolares + @devengo_dolares_pasivo ,
        pasivo_acumulado_devengo_pesos  = pasivo_acumulado_devengo_pesos + @devengo_pesos_pasivo ,
        pasivo_acumulado_devengo_uf  = pasivo_acumulado_devengo_uf + @devengo_uf_pasivo  ,
        neto_dia     = activo_variacion_tc + activo_variacion_uf + activo_devengo + activo_devengo_dolares + activo_devengo_pesos + activo_devengo_uf + pasivo_variacion_tc + pasivo_variacion_uf + pasivo_devengo + pasivo_devengo_dolares + pasivo_devengo_pesos + pasivo_devengo_uf,
        neto_acumulado    = activo_acumulado_tc + activo_acumulado_uf + activo_acumulado_devengo + activo_acumulado_devengo_dolares + activo_acumulado_devengo_pesos + activo_acumulado_devengo_uf + pasivo_acumulado_tc + pasivo_acumulado_uf + pasivo_acumulado_devengo + pasivo_acumulado_devengo_dolares + pasivo_acumulado_devengo_pesos + pasivo_acumulado_devengo_uf 
       WHERE tipo = @llave_pasivo AND
        fecha = @fecha_proceso
       UPDATE  resultado_calce 
       SET  activo_saldo_usd   = activo_saldo_usd + @saldo_dolares_activo ,
        pasivo_saldo_usd   = pasivo_saldo_usd + @saldo_dolares_pasivo ,
        pasivo_devengo    = pasivo_devengo + @devengo_pasivo  ,
        pasivo_acumulado_devengo  = pasivo_acumulado_devengo + @devengo_pasivo ,
        neto_dia     = activo_variacion_tc + activo_variacion_uf + activo_devengo + activo_devengo_dolares + activo_devengo_pesos + activo_devengo_uf + pasivo_variacion_tc + pasivo_variacion_uf + pasivo_devengo + pasivo_devengo_dolares + pasivo_devengo_pesos + pasivo_devengo_uf,
        neto_acumulado    = activo_acumulado_tc + activo_acumulado_uf + activo_acumulado_devengo + activo_acumulado_devengo_dolares + activo_acumulado_devengo_pesos + activo_acumulado_devengo_uf + pasivo_acumulado_tc + pasivo_acumulado_uf + pasivo_acumulado_devengo + pasivo_acumulado_devengo_dolares + pasivo_acumulado_devengo_pesos + pasivo_acumulado_devengo_uf 
       WHERE tipo = @llave_general AND
        fecha = @fecha_proceso
       --|-----------------------------------------------
       -- Resultado Netos del Día Se Guardan en Resultado
       --|-----------------------------------------------
       UPDATE  resultado 
       SET  neto_dia = acumulado_neto + @resultado_activo ,
        acumulado_neto  = acumulado_neto + @resultado_activo 
       WHERE tipo = 'C-' + CONVERT(CHAR(3),@cartera_activo) + '-ABI' AND
        fecha = @fecha_proceso
       UPDATE  resultado 
       SET  neto_dia = acumulado_neto + @resultado_pasivo ,
        acumulado_neto  = acumulado_neto + @resultado_pasivo 
       WHERE tipo = 'V-' + CONVERT(CHAR(3),@cartera_pasivo) + '-CAL' AND
        fecha = @fecha_proceso
      END
     ELSE
      BEGIN
       UPDATE  resultado_calce 
       SET  activo_saldo_usd   = activo_saldo_usd + @saldo_dolares_activo   ,
        activo_variacion_tc   = activo_variacion_tc + @reajuste_tc_activo   ,
        activo_variacion_uf   = activo_variacion_uf + @reajuste_uf_activo   ,
        activo_devengo    = activo_devengo + @devengo_activo    ,
        activo_devengo_dolares   = activo_devengo_dolares + @devengo_dolares_activo  ,
        activo_devengo_pesos   = activo_devengo_pesos + @devengo_pesos_activo   ,
        activo_devengo_uf   = activo_devengo_uf + @devengo_uf_activo   ,
        activo_acumulado_tc   = activo_acumulado_tc + @reajuste_tc_activo   ,
        activo_acumulado_uf   = activo_acumulado_uf + @reajuste_uf_activo   ,
        activo_acumulado_devengo  = activo_acumulado_devengo + @devengo_activo   ,
        activo_acumulado_devengo_dolares = activo_acumulado_devengo_dolares + @devengo_dolares_activo ,
        activo_acumulado_devengo_pesos  = activo_acumulado_devengo_pesos + @devengo_pesos_activo ,
        activo_acumulado_devengo_uf  = activo_acumulado_devengo_uf + @devengo_uf_activo  ,
        pasivo_saldo_usd   = pasivo_saldo_usd + @saldo_dolares_pasivo   ,
        pasivo_variacion_tc   = pasivo_variacion_tc + @reajuste_tc_pasivo   ,
        pasivo_variacion_uf   = pasivo_variacion_uf + @reajuste_uf_pasivo   ,
        pasivo_devengo    = pasivo_devengo + @devengo_pasivo    ,
        pasivo_devengo_dolares   = pasivo_devengo_dolares + @devengo_dolares_pasivo  ,
        pasivo_devengo_pesos   = pasivo_devengo_pesos + @devengo_pesos_pasivo   ,
        pasivo_devengo_uf   = pasivo_devengo_uf + @devengo_uf_pasivo   ,
        pasivo_acumulado_tc   = pasivo_acumulado_tc + @reajuste_tc_pasivo   ,
        pasivo_acumulado_uf   = pasivo_acumulado_uf + @reajuste_uf_pasivo   ,
        pasivo_acumulado_devengo  = pasivo_acumulado_devengo + @devengo_pasivo   ,
        pasivo_acumulado_devengo_dolares = pasivo_acumulado_devengo_dolares + @devengo_dolares_pasivo ,
        pasivo_acumulado_devengo_pesos  = pasivo_acumulado_devengo_pesos + @devengo_pesos_pasivo ,
        pasivo_acumulado_devengo_uf  = pasivo_acumulado_devengo_uf + @devengo_uf_pasivo  ,
        neto_dia     = activo_variacion_tc + activo_variacion_uf + activo_devengo + activo_devengo_dolares + activo_devengo_pesos + activo_devengo_uf + pasivo_variacion_tc + pasivo_variacion_uf + pasivo_devengo + pasivo_devengo_dolares + pasivo_devengo_pesos + pasivo_devengo_uf,
        neto_acumulado    = activo_acumulado_tc + activo_acumulado_uf + activo_acumulado_devengo + activo_acumulado_devengo_dolares + activo_acumulado_devengo_pesos + activo_acumulado_devengo_uf + pasivo_acumulado_tc + pasivo_acumulado_uf + pasivo_acumulado_devengo + pasivo_acumulado_devengo_dolares + pasivo_acumulado_devengo_pesos + pasivo_acumulado_devengo_uf 
       WHERE tipo = @llave_general AND
        fecha = @fecha_proceso
       --|-----------------------------------------------
       -- Resultado Netos del Día Se Guardan en Resultado
       --|-----------------------------------------------
       UPDATE  resultado 
       SET  neto_dia = acumulado_neto + @resultado_activo ,
        acumulado_neto  = acumulado_neto + @resultado_activo 
       WHERE tipo = 'C-' + CONVERT(CHAR(3),@cartera_activo) + '-CAL' AND
        fecha = @fecha_proceso
       UPDATE  resultado 
       SET  neto_dia = acumulado_neto + @resultado_pasivo ,
        acumulado_neto  = acumulado_neto + @resultado_pasivo 
       WHERE tipo = 'V-' + CONVERT(CHAR(3),@cartera_pasivo) + '-CAL' AND
        fecha = @fecha_proceso
      END
   END
   FETCH NEXT FROM Tmp_CurCALCE
   INTO @cartera_activo ,
    @numero_activo ,
    @cartera_pasivo ,
    @numero_pasivo ,
    @monto_calce ,
    @fecha_vcto ,
    @fecha_inicio
 END
  
CLOSE Tmp_CurCALCE
DEALLOCATE Tmp_CurCALCE
COMMIT TRANSACTION
SELECT 'OK'
END

GO
