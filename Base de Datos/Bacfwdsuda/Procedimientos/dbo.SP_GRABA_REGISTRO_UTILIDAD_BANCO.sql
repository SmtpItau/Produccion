USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_REGISTRO_UTILIDAD_BANCO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[SP_GRABA_REGISTRO_UTILIDAD_BANCO]  
   (   @Operacion NUMERIC(10,0)  
   ,   @TipoOp  NUMERIC(05,0)  
   ,   @Rut_Cl  NUMERIC(10,0)  
   ,   @Cod_Cl  NUMERIC(05,0)  
   ,   @Moneda  NUMERIC(05,0)  
   ,   @Utilidad NUMERIC(21,4)  
   ,   @ContraMon NUMERIC(05,0)  
   ,   @PlazoResidual NUMERIC(05,0)  
   ,   @MtoOp  FLOAT  
   ,   @MtoMonedaUSD FLOAT  
   ,   @Clase_OP CHAR(1)   
   )  
AS  
BEGIN  
  
   DECLARE @Correlativo     NUMERIC(20)  
   ,       @Fecha_Hoy       DATETIME  
   ,       @Porcentaje      NUMERIC(10,4)  
   ,       @TotalAsignado   NUMERIC(21,4)  
   ,       @TotalOcupado    NUMERIC(21,4)  
   ,       @TotalDisponible NUMERIC(21,4)  
   ,       @TotalProducto   NUMERIC(21,4)  
   ,       @Rut_Hijo     NUMERIC(10,0)  
   ,       @Cod_Hijo     NUMERIC(05,0)  
   ,       @Monto_OPMR     NUMERIC(21,4)  
   ,       @dFecvctoCompen  DATETIME  
   
   SELECT @Correlativo =  Isnull(Max(UB_CORRELA),0)   
   FROM   MFUTILIDADBCO  
   SELECT @Correlativo = @Correlativo + 1  
  
   SELECT @Fecha_Hoy   = acfecproc  
   FROM   MFAC  
  
   SELECT @Porcentaje = 0.0  
  
   IF @TipoOp <> 7  
   BEGIN  
      SELECT @Porcentaje     = ISNULL(porcentaje,0.0)  
      FROM   baclineas..MATRIZ_RIESGO  
      WHERE  codigo_producto = @TipoOp  
      AND    moneda          = @Moneda  
      AND    Contra_Moneda   = @ContraMon  
      AND    diasdesde      <= @PlazoResidual  
      AND    diashasta      >= @PlazoResidual  
   END ELSE  
   BEGIN  
      SELECT @dFecvctoCompen =(SELECT TOP 1 corfecvcto FROM bacfwdsuda..CORTES WHERE cornumoper = @Operacion AND corfecvcto > @Fecha_Hoy ORDER BY corfecvcto)  
      SELECT @PlazoResidual  = datediff(d,@Fecha_Hoy,@dFecvctoCompen)  --Nuevo  
      SELECT @Porcentaje     = IsNull(porcentaje,0.0)  
      FROM   baclineas..MATRIZ_RIESGO  
      WHERE  codigo_producto = @TipoOp         
      AND    moneda          = @Moneda  
      AND    Contra_Moneda   = @ContraMon  
      AND    diasdesde      <= (@PlazoResidual)  
      AND    diashasta      >= (@PlazoResidual)  
   END  
  
   IF @Porcentaje = 0.0   
      SELECT @Porcentaje = 1.0  
  
   SELECT @Monto_OPMR = (@MtoMonedaUSD * (@Porcentaje/100))  
   SELECT @Porcentaje = IsNull(@Porcentaje,0.0)  
  
   SELECT @Rut_Hijo = @RUT_CL  
   SELECT @Cod_Hijo = @COD_CL  
  
   /*IF EXISTS (SELECT 1 FROM BAClineas..CLIENTE_RELACIONADO WHERE clrut_hijo = @Rut_Hijo And clcodigo_hijo = @Cod_Hijo)
   BEGIN   
      SELECT @Rut_Hijo     = clrut_padre   
      ,      @Cod_Hijo     = clcodigo_padre  
      FROM   baclineas..CLIENTE_RELACIONADO  
      WHERE  clrut_hijo    = @Rut_Hijo  
      And    clcodigo_hijo = @Cod_Hijo  
   END*/
  
   --   Calculo de Valor Razonable a la Moneda de la Linea  
   DECLARE @DolarHoy   NUMERIC(21,4)  
   SELECT  @DolarHoy  = 0.0  
   SELECT  @DolarHoy  = vmvalor  
   FROM    BacParamSuda..VALOR_MONEDA  
   WHERE   vmfecha    = @Fecha_Hoy   
   AND     vmcodigo   = 994  
  
   SELECT @Utilidad = CASE WHEN moneda <> 999 and mnrrda = 'D' THEN @Utilidad / (CONVERT(NUMERIC(21,4),ISNULL(vmvalor,1.0)) / @DolarHoy)  
                           WHEN moneda <> 999 and mnrrda = 'M' THEN @Utilidad / (CONVERT(NUMERIC(21,4),ISNULL(vmvalor,1.0)) * @DolarHoy)  
                           WHEN moneda  = 999                  THEN @Utilidad   
                      END    
   FROM   BacLineas..LINEA_SISTEMA  
          LEFT JOIN BacParamSuda..MONEDA       ON mncodmon = moneda  
          LEFT JOIN BacParamSuda..VALOR_MONEDA ON vmfecha  = @Fecha_Hoy AND vmcodigo = moneda  
   WHERE  Rut_Cliente       = @Rut_Hijo  
   AND    Codigo_Cliente    = @Cod_Hijo  
   AND    Id_Sistema        = 'BFW'  
   --   Calculo de Valor Razonable a la Moneda de la Linea  
  
   SELECT @TotalProducto    = TotalAsignado    
   ,      @TotalOcupado     = (@Monto_OPMR + @Utilidad)  
   ,      @TotalDisponible  = CASE WHEN TotalDisponible = 0 THEN TotalExceso * -1 ELSE TotalDisponible END  
   FROM   baclineas..LINEA_SISTEMA  
   WHERE  Rut_Cliente       = @Rut_Hijo  
   AND    Codigo_Cliente    = @Cod_Hijo  
   AND    Id_Sistema        = 'BFW'   
  
   SELECT @PlazoResidual    = ISNULL(@PlazoResidual,0)  
   ,      @Porcentaje       = ISNULL(@Porcentaje,0)  
   ,      @TotalProducto    = ISNULL(@TotalProducto,0)  
   ,      @Utilidad         = ISNULL(@Utilidad,0)  
   ,      @TotalOcupado     = ISNULL(@TotalOcupado,0)  
   ,      @TotalDisponible  = ISNULL(@TotalDisponible,0)  
  
   INSERT INTO  MFUTILIDADBCO  
   (   /*01*/   UB_CORRELA  
   ,   /*02*/   UB_NOPERACION  
   ,   /*03*/   UB_TIPOOP  
   ,   /*04*/   UB_RUTCL  
   ,   /*05*/   UB_CODCL  
   ,   /*06*/   UB_MONEDA  
   ,   /*07*/   UB_CONTRAMONEDA  
   ,   /*08*/   UB_PLAZO_RESIDUAL  
   ,   /*09*/   UB_PORUSAMATRIZ  
   ,   /*10*/   UB_MONTOLPRODUCTO  
   ,   /*11*/   UB_UTILIDAD  
   ,   /*12*/   UB_MTOTOCUPADO  
   ,   /*13*/   UB_MTOTDISPO  
   ,   /*14*/   UB_FECHA  
   ,   /*15*/   UB_MONTOOP  
   ,   /*16*/   UB_MONTOOPDOLAR  
   ,   /*17*/   UB_CLASE_OP  
   ,   /*18*/   UB_MONTO_OPMR  
   )  
   VALUES  
   (   /*01*/   @Correlativo  
   ,   /*02*/   @Operacion  
   ,   /*03*/   @TipoOp  
   ,   /*04*/   @Rut_Cl  
   ,   /*05*/   @Cod_Cl  
   ,   /*06*/   @Moneda  
   ,   /*07*/   @ContraMon  
   ,   /*08*/   ISNULL(@PlazoResidual,0)  
   ,   /*09*/   ISNULL(@Porcentaje,0)  
   ,   /*10*/   ISNULL(@TotalProducto,0)  
   ,   /*11*/   ISNULL(@Utilidad,0)  
   ,   /*12*/   ISNULL(@TotalOcupado,0)  
   ,   /*13*/   ISNULL(@TotalDisponible,0)  
   ,   /*14*/   @Fecha_Hoy  
   ,   /*15*/   ISNULL(@MtoOp,0)  
   ,   /*16*/   ISNULL(@Mtomonedausd,0)  
   ,   /*17*/   @Clase_OP  
   ,   /*18*/   ISNULL(@Monto_OPMR,0)  
   )   
  
   IF @@ERROR <> 0  
   BEGIN  
      RETURN -1  
   END  
  
   RETURN 0  
END  
GO
