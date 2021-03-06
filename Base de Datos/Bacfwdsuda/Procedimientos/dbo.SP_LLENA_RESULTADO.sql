USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_RESULTADO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LLENA_RESULTADO]( @cartera  NUMERIC(03) ,
     @fecha_proceso  DATETIME ,
     @fecha_anterior  DATETIME ,
     @moneda1  NUMERIC(03) ,
     @moneda2  NUMERIC(03) ,
     @reatcdia  NUMERIC(21,04) ,
     @reaufdia  NUMERIC(21,04) ,
     @devengo_hoy  NUMERIC(21,00) , 
     @tipo_operacion  CHAR(1)  ,
     @fecha_vencimiento DATETIME ,
     @monto_1  NUMERIC(21,04) ,
     @monto_2  NUMERIC(21,04) ,
     @devengo_moneda1 NUMERIC(21,00) ,
     @devengo_moneda2 NUMERIC(21,00) ,
     @monto_acum_mon1 NUMERIC(21,04) ,
     @monto_acum_mon2 NUMERIC(21,04) ,
     @numero_operacion NUMERIC(10,00) ,
     @monto_compensa  NUMERIC(21,00) ,
     @valorizacion_hoy NUMERIC(21,00) ,
     @valorizacion_ayer NUMERIC(21,00) 
    )
AS 
BEGIN
 SET NOCOUNT ON
 -- Cartera de Opciones y Swaps BCCH no se consideran
 IF @cartera = 8 OR @cartera = 9
  RETURN
 DECLARE @llave   CHAR(9)  ,
  @llave2   CHAR(9)  ,
  @monto_moneda1  NUMERIC(21,04) ,
  @monto_moneda2  NUMERIC(21,04) ,
  @valor_arbitraje NUMERIC(21,00) ,
  @monto_diario  NUMERIC(21,00) ,
  @acumulado_neto  NUMERIC(21,00)
 SELECT @monto_moneda1 = 0
 SELECT @monto_moneda2 = 0
 SELECT @valor_arbitraje = 0
 SELECT @monto_diario = 0
 SELECT @acumulado_neto = 0
 IF @cartera = 1 OR @cartera = 3 OR @cartera = 7
  SELECT @llave = @tipo_operacion + '-' + CONVERT(CHAR(3),@moneda1) + '-' + CONVERT(CHAR(3),@moneda2)
 IF @cartera = 2
  SELECT @llave = @tipo_operacion + '-M/X-' + CONVERT(CHAR(3),@moneda2)
 IF @cartera = 4 OR @cartera = 5 OR @cartera = 6
  SELECT @llave = @tipo_operacion + '-CAR-' + CONVERT(CHAR(3),@cartera)
 SELECT @reatcdia = @reatcdia * ( CASE WHEN @tipo_operacion = 'C' OR @tipo_operacion = 'O' THEN 1 ELSE -1 END )
 SELECT @reaufdia = @reaufdia * ( CASE WHEN @tipo_operacion = 'C' OR @tipo_operacion = 'O' THEN -1 ELSE 1 END ) 
 IF @cartera = 1 OR @cartera = 7
  BEGIN
   SELECT @monto_moneda1 = @monto_1
   SELECT @monto_moneda2 = @monto_2
  END
 ELSE
  IF @cartera = 2 --Sólo Arbitrajes
   BEGIN
    SELECT  @monto_moneda1 = @monto_2
    SELECT  @valor_arbitraje = @valorizacion_hoy + @monto_compensa - @valorizacion_ayer 
    SELECT  @reatcdia = 0
    SELECT  @reaufdia = 0
   END
 ELSE
  IF @cartera = 3 --Sólo Seguros de Inflación
   BEGIN
    SELECT @monto_moneda1 = caequusd1 --Obtiene el Valor Inicial en USD
    FROM mfca
    WHERE @numero_operacion = canumoper
    SELECT @monto_moneda2 = @monto_1
    SELECT @reaufdia = ( @reaufdia * -1 )
    SELECT  @reatcdia = 0
   END
 ELSE
  IF @cartera = 4 OR @cartera = 5 OR @cartera = 6
   BEGIN
    SELECT @monto_moneda1 = @monto_acum_mon1
    SELECT @monto_moneda2 = @monto_acum_mon2
   END
 IF @moneda2 <> 998  -- Sólo si es UF se informa el Saldo de la Moneda
  SELECT @monto_moneda2 = 0
 IF CONVERT(CHAR(8),@fecha_vencimiento,112) <= CONVERT(CHAR(8),@fecha_proceso,112)
  BEGIN
   SELECT @monto_moneda1 = 0
   SELECT @monto_moneda2 = 0
  END
 -- |------------------------------------------------------------------------------------------
 -- |Graba los Resultados Diarios 
 -- |------------------------------------------------------------------------------------------
 UPDATE resultado SET  saldo_usd   = saldo_usd + @monto_moneda1        ,
     saldo_uf    = saldo_uf + @monto_moneda2        , 
     variacion_tc   = variacion_tc + @reatcdia + @valor_arbitraje      ,
     variacion_uf   = variacion_uf + @reaufdia        ,
     devengo        = devengo + @devengo_hoy + @devengo_moneda1      ,
     devengo_pesos   = devengo_pesos + ( CASE @moneda2 WHEN 999 THEN @devengo_moneda2 ELSE 0 END )  ,
     devengo_uf      = devengo_uf + ( CASE @moneda2 WHEN 998 THEN @devengo_moneda2 ELSE 0 END )  ,
     neto_dia        = neto_dia + @reatcdia + @valor_arbitraje + @reaufdia + @devengo_hoy + @devengo_moneda1 + @devengo_moneda2 ,
     acumulado_tc     = acumulado_tc + @reatcdia + @valor_arbitraje      ,
     acumulado_uf     = acumulado_uf + @reaufdia        ,
     acumulado_devengo   = acumulado_devengo + @devengo_hoy + @devengo_moneda1     ,
     acumulado_devengo_pesos  = acumulado_devengo_pesos + ( CASE @moneda2 WHEN 999 THEN @devengo_moneda2 ELSE 0 END ) ,
     acumulado_devengo_uf     = acumulado_devengo_uf + ( CASE @moneda2 WHEN 998 THEN @devengo_moneda2 ELSE 0 END ) ,
     acumulado_neto           = acumulado_neto + @reatcdia + @valor_arbitraje + @reaufdia + @devengo_hoy + @devengo_moneda1 + @devengo_moneda2
 WHERE  CONVERT(CHAR(8),@fecha_proceso,112) = CONVERT(CHAR(08),fecha,112) AND 
  @llave  = tipo
 -- |----------------------------------------------------------------------------------
 -- |Calculo de los Resultados Netos Contables
 -- |----------------------------------------------------------------------------------
 SELECT @monto_diario = 0
 IF @cartera = 1 
  BEGIN
   SELECT @llave2 = @tipo_operacion + '-NET-' + CONVERT(CHAR(3),@cartera)
   SELECT @monto_diario = @devengo_hoy + @reatcdia + @reaufdia
  END
 ELSE IF @cartera = 7
  BEGIN
   SELECT @llave2 = @tipo_operacion + '-NET-' + CONVERT(CHAR(3),1)
   SELECT @monto_diario = @devengo_hoy + @reatcdia + @reaufdia
  END
 ELSE IF @cartera = 2
   BEGIN
    SELECT @llave2 = 'NETO-' + CONVERT(CHAR(3),@cartera)
    SELECT @monto_diario = @valor_arbitraje
   END
 ELSE IF @cartera = 3
   BEGIN
    SELECT @llave2 = 'NETO-' + CONVERT(CHAR(3),@cartera)
    SELECT @monto_diario = @devengo_hoy + @reaufdia
   END
 ELSE  
  BEGIN
   SELECT @llave2 = 'NETO-' + CONVERT(CHAR(3),@cartera)
   SELECT @monto_diario = @reatcdia + @reaufdia + @devengo_moneda1 + @devengo_moneda2
  END
 -- |------------------------------------------------------------------------------------------
 -- |Graba los Resultados Acumulados del Día 
 -- |------------------------------------------------------------------------------------------
 UPDATE resultado SET acumulado_neto = acumulado_neto + @monto_diario
 WHERE  CONVERT(CHAR(8),@fecha_proceso,112) = CONVERT(CHAR(08),fecha,112) AND 
  tipo = @llave2
     
 SET NOCOUNT OFF
END

GO
