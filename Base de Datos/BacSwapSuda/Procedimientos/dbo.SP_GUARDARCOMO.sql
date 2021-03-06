USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GUARDARCOMO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GUARDARCOMO]  
   (   @Numero_operacion NUMERIC(10) -- NUmero de Operacion  
   ,   @Como             CHAR(1)     -- Estado = 'C' Cotizacion, Estado = ' ' cartera  
   ,   @LCR              NUMERIC(15) -- Monto LCR  
   ,   @MetodoLCR		 NUMERIC(5)
   ,   @Garantia         FLOAT  
   -- agregar parametros metodologia,garantias
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @cProducto               CHAR(05)  
   DECLARE @Capital_A               FLOAT  
   DECLARE @Capital_P               FLOAT  
   DECLARE @Plazo_A                 NUMERIC(18,6)         
   DECLARE @Plazo_P                 NUMERIC(18,6)         
   DECLARE @Moneda_A                NUMERIC(5)      
   DECLARE @Moneda_P                NUMERIC(5)      
   DECLARE @Duration_A              FLOAT           
   DECLARE @Duration_P              FLOAT           
   DECLARE @dFecPro                 DATETIME  
   DECLARE @SubTotal                FLOAT  
   DECLARE @TotalGeneral            FLOAT  
   DECLARE @LargoObservacion_Lineas INT
   DECLARE @Observacion_Lineas      CHAR(255)  
   DECLARE @Observacion_Grabacion   CHAR(200)  
  

   set @TotalGeneral = case when @MetodoLCR in ( 1, 4 ) then 0.0 else @LCR end

    SELECT @dFecPro = fechaproc FROM SWAPGENERAL  
    -- Swap: Guardar Como  
   IF @MetodoLCR = 1 or @MetodoLCR = 4
   BEGIN 
  
   SELECT @cProducto       = rtrim(ltrim( convert(char(05), tipo_Swap ) ) )   
      ,   @Capital_A       = compra_capital   
      ,   @Plazo_A         = (CASE WHEN Compra_codigo_tasa = 0 THEN DATEDIFF(d,@dFecPro,fecha_Termino)  
                                   ELSE                             DATEDIFF(d,@dFecPro,fecha_vence_Flujo)  
                             END)  
      ,   @Moneda_A        = compra_moneda  
      ,   @Duration_A      = vDurMacaulActivo  
   FROM   BACSWAPSUDA..CARTERA  
   WHERE  numero_operacion = @Numero_operacion  
   AND    tipo_flujo       = 1  
   AND    estado_flujo     = 1  
  
   SELECT @Capital_P       = venta_capital  
      ,   @Plazo_P         = (CASE WHEN Venta_codigo_tasa = 0 THEN DATEDIFF(d,@dFecPro,fecha_termino)  
                                   ELSE  DATEDIFF(d,@dFecPro,fecha_vence_flujo)  
                             END)  
      ,   @Moneda_P        = venta_moneda  
      ,   @Duration_P      = vDurMacaulPasivo  
   FROM   BACSWAPSUDA..CARTERA  
   WHERE  numero_operacion = @Numero_operacion  
   AND    tipo_flujo       = 2  
   AND    estado_flujo     = 1  
  
    /*  
    EXEC BacLineas..SP_IMPUTACION_LCR_DERIVADOS @Numero_operacion,   
                                                 'PCS',  
                                                 @cProducto,  
                                                 'C',  
                                                 @Capital_A,    
                                                 @Capital_P,  
                                                 @Plazo_A,  
                                                 @Plazo_P,  
                                                 @Moneda_A,  
                                                 @Moneda_P,  
                                                 @Duration_A,  
                                                 @Duration_P,  
                                                 @dFecPro,   
                                                 @SubTotal output  
   */  
  
   
   DECLARE @Prc FLOAT  
  
   EXECUTE BacLineas..SP_RIESGO_POTENCIAL_FUTURO @Numero_operacion    
                                             ,   'PCS'  
                                             ,   @cProducto  
                                             ,   'C'  
                                             ,   @Capital_A  
                                             ,   @Capital_P  
                                             ,   @Plazo_A  
                                             ,   @Plazo_P  
                                             ,   @Moneda_A  
                                             ,   @Moneda_P  
                                             ,   @Duration_A  
                                             ,   @Duration_P  
                                             ,   @dFecPro  
                                             ,   @SubTotal    OUTPUT  
                                             ,   @Prc         OUTPUT   
  
   EXECUTE BacLineas..SP_LCR_VRAZONABLE_NEGATIVO @dFecPro, 'PCS', @Numero_operacion, @SubTotal, 0, @TotalGeneral OUTPUT  
   END /* @MetodoLCR = 1 or @MetodoLCR = 4 */
   
   
  
   DECLARE @NoCalculo CHAR(20)  
       SET @NoCalculo = ''  
  
   IF @TotalGeneral IS NULL  
      SET @NoCalculo = ' Falló Cálculo LCR '   
  
   SET @TotalGeneral = isnull( @TotalGeneral, 0 )  
  
   -- MAP 20080604 Corrige caida de producción  
   SET @Observacion_Grabacion = 'Monto LCR: '   
                              + CONVERT(CHAR(15), CONVERT(NUMERIC(15), ROUND( @TotalGeneral, 0)))   
                              + @NoCalculo  
   SET @Observacion_Grabacion = LTRIM(RTRIM( @Observacion_Grabacion ))   
   SET @Observacion_Lineas    = ''  
  
   SELECT @Observacion_Lineas = Observacion_Lineas  
     FROM CARTERA  
    WHERE numero_operacion    = @Numero_operacion  
  
   SELECT @Observacion_Lineas = SUBSTRING(@Observacion_Grabacion, 1, LEN(@Observacion_Grabacion)) + ' ' + @Observacion_Lineas  
  
  
  IF @MetodoLCR = 1 or @MetodoLCR = 4
  BEGIN 
 
  UPDATE CARTERA  
     SET Estado        = @Como  
       , Monto_LCR_Matriz     = ISNULL( @Prc, 0)         --> ISNULL( @SubTotal,     0)  
		   , Monto_LCR_Ajuste_AVR	= ISNULL( @TotalGeneral-@Garantia, 0)
       , Observacion_Lineas   = @Observacion_Lineas  
   WHERE numero_operacion     = @Numero_operacion  
  END
  ELSE
  BEGIN
  
		UPDATE CARTERA
			 SET Estado 				= @Como
			   , Monto_LCR_Matriz		= ISNULL( 0, 0)         --> ISNULL( @SubTotal,     0)
			   , Monto_LCR_Ajuste_AVR	= ISNULL( @LCR-@Garantia, 0)
			   , Observacion_Lineas		= @Observacion_Lineas
		WHERE numero_operacion			= @Numero_operacion
  END 
  
  
   UPDATE  MovDiario     
   SET    Estado     = @Como  
   ,       Observaciones    = CASE WHEN @Como = 'C' THEN 'COTIZACION' ELSE '' END + ltrim( rtrim(Observaciones)  )   
   WHERE   numero_operacion = @Numero_operacion  
  
   UPDATE  MovHistorico  
   SET    Estado      = @Como  
   WHERE   numero_operacion  = @Numero_operacion  
  
END  
GO
