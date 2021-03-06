USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULO_RESULTADO_CALCE_ABIERTO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CALCULO_RESULTADO_CALCE_ABIERTO]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @cartera  NUMERIC(03) ,
  @numero   NUMERIC(10) ,
  @monto_calzado  NUMERIC(21) ,
  @monto_moneda1  NUMERIC(21) ,
  @monto_disponible NUMERIC(21) ,
  @fecha_vcto  DATETIME ,
  @fecha_inicio  DATETIME ,
  @fecha_proceso  DATETIME ,
  @fecha_anterior  DATETIME ,
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
  @resultado  NUMERIC(21,00) ,
  @saldo_dolares   NUMERIC(21,00) ,
  @llave   CHAR(9)  ,
  @tipo_operacion  CHAR(1)  ,
  @tipo   CHAR(2)
 SELECT  @fecha_proceso = acfecproc ,
  @fecha_anterior = acfecante
 FROM mfac
 BEGIN TRANSACTION
   DECLARE Tmp_CurABIERTA   SCROLL CURSOR
   FOR  SELECT cacodpos1 ,
    canumoper ,
    catipoper ,
    camtocalzado ,
    camtomon1 ,
    cafecha  ,
    cafecvcto ,
    cadiftipcam ,
    cadifuf  ,
    ( cautildevenga + caperddevenga )  ,
    pesos_devengo_usd ,
    ( CASE cacodmon2 WHEN 999 THEN pesos_devengo_cnv ELSE 0 END ) ,
    ( CASE cacodmon2 WHEN 998 THEN pesos_devengo_cnv ELSE 0 END ) ,
    ABS( devengo_acum_usd_hoy )  ,
    camtomon1ini    ,
    ( CASE WHEN cacodpos1 = 1 OR cacodpos1 = 3 OR cacodpos1 = 7 THEN cacodmon2 ELSE cacodmon1 END )
  FROM  mfca
--  WHERE  cafecvcto > @fecha_proceso
  
  OPEN Tmp_CurABIERTA
  FETCH FIRST FROM Tmp_CurABIERTA
   INTO @cartera  ,
    @numero   ,
    @tipo_operacion  ,
    @monto_calzado  ,
    @monto_moneda1  ,
    @fecha_inicio  ,
    @fecha_vcto  ,
    @reajuste_tc  ,
    @reajuste_uf  ,
    @devengo  ,
    @devengo_dolares ,
    @devengo_pesos  ,
    @devengo_uf  ,
    @interes_dolares ,
    @inicio_moneda1  ,
    @moneda   
    
  WHILE ( @@FETCH_STATUS = 0 ) 
   BEGIN
   SELECT @monto_disponible = @monto_moneda1 - @monto_calzado
   IF @fecha_vcto >= @fecha_proceso AND @monto_disponible > 0 AND ( @cartera <> 2  AND @cartera <> 8 AND @cartera <> 9 )
    BEGIN
     IF @cartera = 7 
      SELECT @cartera = 1 -- Esto Porque se Tratan como un Seguro de Cambio
     SELECT @saldo_dolares = @monto_disponible
    
     EXECUTE sp_div @monto_disponible , @monto_moneda1 , @factor OUTPUT
     IF @cartera = 4 OR @cartera = 5 OR @cartera = 6
      SELECT @saldo_dolares = ( @inicio_moneda1 + @interes_dolares ) * @factor
     IF @fecha_vcto <= @fecha_proceso
      SELECT @saldo_dolares = 0
     SELECT  @reajuste_tc  = @reajuste_tc * ( CASE WHEN @tipo_operacion = 'C' OR @tipo_operacion = 'O' THEN 1 ELSE -1 END )
     SELECT  @reajuste_uf  = @reajuste_uf * ( CASE WHEN @tipo_operacion = 'C' OR @tipo_operacion = 'O' THEN -1 ELSE 1 END )     
     SELECT  @reajuste_tc  = @reajuste_tc * @factor
     SELECT  @reajuste_uf  = @reajuste_uf * @factor
     SELECT  @devengo  = @devengo * @factor
     SELECT  @devengo_dolares = @devengo_dolares * @factor
     SELECT @devengo_pesos  = @devengo_pesos * @factor
     SELECT  @devengo_uf  = @devengo_uf * @factor
     SELECT  @resultado  = @reajuste_tc + @reajuste_uf + @devengo + @devengo_dolares + @devengo_pesos +  @devengo_uf 
     SELECT  @tipo   = ( CASE WHEN @tipo_operacion = 'C' OR @tipo_operacion = 'O' THEN 'C-' ELSE 'V-' END ) 
     SELECT  @llave    = @tipo + CONVERT(CHAR(3),@cartera) + '-' + CONVERT(CHAR(3),@moneda)
     --|-----------------------------------------------------
     --| Grabación de los Calces
     --|-----------------------------------------------------
     IF @tipo_operacion = 'C' OR @tipo_operacion = 'O'
      BEGIN
       UPDATE  resultado_calce 
       SET  activo_saldo_usd   = activo_saldo_usd + @saldo_dolares   ,
        activo_variacion_tc   = activo_variacion_tc + @reajuste_tc   ,
        activo_variacion_uf   = activo_variacion_uf + @reajuste_uf   ,
        activo_devengo    = activo_devengo + @devengo    ,
        activo_devengo_dolares   = activo_devengo_dolares + @devengo_dolares  ,
        activo_devengo_pesos   = activo_devengo_pesos + @devengo_pesos   ,
        activo_devengo_uf   = activo_devengo_uf + @devengo_uf   ,
        activo_acumulado_tc   = activo_acumulado_tc + @reajuste_tc   ,
        activo_acumulado_uf   = activo_acumulado_uf + @reajuste_uf   ,
        activo_acumulado_devengo  = activo_acumulado_devengo + @devengo   ,
        activo_acumulado_devengo_dolares = activo_acumulado_devengo_dolares + @devengo_dolares ,
        activo_acumulado_devengo_pesos  = activo_acumulado_devengo_pesos + @devengo_pesos ,
        activo_acumulado_devengo_uf  = activo_acumulado_devengo_uf + @devengo_uf  
       WHERE tipo = @llave  AND
        fecha = @fecha_proceso
       --|-----------------------------------------------
       -- Resultado Netos del Día Se Guardan en Resultado
       --|-----------------------------------------------
       UPDATE  resultado 
       SET  neto_dia = acumulado_neto + @resultado ,
        acumulado_neto  = acumulado_neto + @resultado 
       WHERE tipo = 'C-' + CONVERT(CHAR(3),@cartera) + '-ABI' AND
        fecha = @fecha_proceso
      END
     ELSE
      BEGIN
       UPDATE  resultado_calce 
       SET  pasivo_saldo_usd   = pasivo_saldo_usd + @saldo_dolares   ,
        pasivo_variacion_tc   = pasivo_variacion_tc + @reajuste_tc   ,
        pasivo_variacion_uf   = pasivo_variacion_uf + @reajuste_uf   ,
        pasivo_devengo    = pasivo_devengo + @devengo    ,
        pasivo_devengo_dolares   = pasivo_devengo_dolares + @devengo_dolares  ,
        pasivo_devengo_pesos   = pasivo_devengo_pesos + @devengo_pesos   ,
        pasivo_devengo_uf   = pasivo_devengo_uf + @devengo_uf   ,
        pasivo_acumulado_tc   = pasivo_acumulado_tc + @reajuste_tc   ,
        pasivo_acumulado_uf   = pasivo_acumulado_uf + @reajuste_uf   ,
        pasivo_acumulado_devengo  = pasivo_acumulado_devengo + @devengo   ,
        pasivo_acumulado_devengo_dolares = pasivo_acumulado_devengo_dolares + @devengo_dolares ,
        pasivo_acumulado_devengo_pesos  = pasivo_acumulado_devengo_pesos + @devengo_pesos ,
        pasivo_acumulado_devengo_uf  = pasivo_acumulado_devengo_uf + @devengo_uf  
       WHERE tipo = @llave  AND
        fecha = @fecha_proceso
       --|-----------------------------------------------
       -- Resultado Netos del Día Se Guardan en Resultado
       --|-----------------------------------------------
       UPDATE  resultado 
       SET  neto_dia = acumulado_neto + @resultado ,
        acumulado_neto  = acumulado_neto + @resultado 
       WHERE tipo = 'V-' + CONVERT(CHAR(3),@cartera) + '-ABI' AND
        fecha = @fecha_proceso
      END
   END
   FETCH NEXT FROM Tmp_CurABIERTA
   INTO @cartera  ,
    @numero   ,
    @tipo_operacion  ,
    @monto_calzado  ,
    @monto_moneda1  ,
    @fecha_inicio  ,
    @fecha_vcto  ,
    @reajuste_tc  ,
    @reajuste_uf  ,
    @devengo  ,
    @devengo_dolares ,
    @devengo_pesos  ,
    @devengo_uf  ,
    @interes_dolares ,
    @inicio_moneda1  ,
    @moneda   
 END
UPDATE  resultado_calce 
SET  neto_dia  = activo_variacion_tc + activo_variacion_uf + activo_devengo + activo_devengo_dolares + activo_devengo_pesos + activo_devengo_uf + pasivo_variacion_tc + pasivo_variacion_uf + pasivo_devengo + pasivo_devengo_dolares + pasivo_devengo_pesos + pasivo_devengo_uf,
 neto_acumulado = activo_acumulado_tc + activo_acumulado_uf + activo_acumulado_devengo + activo_acumulado_devengo_dolares + activo_acumulado_devengo_pesos + activo_acumulado_devengo_uf + pasivo_acumulado_tc + pasivo_acumulado_uf + pasivo_acumulado_devengo + pasivo_acumulado_devengo_dolares + pasivo_acumulado_devengo_pesos + pasivo_acumulado_devengo_uf 
WHERE fecha = @fecha_proceso
CLOSE Tmp_CurABIERTA
DEALLOCATE Tmp_CurABIERTA
COMMIT TRANSACTION
SELECT 'OK'
END

GO
