USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_PRECIOTASAS_FWD]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
    
CREATE PROCEDURE [dbo].[SP_CONTROL_PRECIOTASAS_FWD]    
 (    
   @codProducto VARCHAR(5)    
  ,@codMonFam VARCHAR(5)    
  ,@tipoOper CHAR(1)    
  ,@plazo  INTEGER    
  ,@precio NUMERIC(19,4)    
  ,@valor1 NUMERIC(19,4)    
  ,@diferencia NUMERIC(19,4) OUTPUT    
  ,@Leyenda VARCHAR(255) OUTPUT    
  ,@bandaInf NUMERIC(19,4) OUTPUT    
  ,@bandaSup NUMERIC(19,4) OUTPUT    
  ,@CFErr	CHAR(1) OUTPUT
 )    
AS    
BEGIN    
 SET NOCOUNT ON    
    
 DECLARE     
 @Volatilidad  NUMERIC(19,4),    
 @DatoFteExterna  NUMERIC(19,4),    
 @ValorIngresado NUMERIC(19,4),    
 @bandaInferior   NUMERIC(19,4),    
 @bandaSuperior  NUMERIC(19,4),    
 @factor   NUMERIC(19,4),    
 @tasaUF  NUMERIC(19,4),    
 @tasaUSD  NUMERIC(19,4),    
 @tasaCLP  NUMERIC(19,4),    
 @SpotContable  NUMERIC(19,4),    
 @PrecioFWD  NUMERIC(19,4),    
 @msgextra  VARCHAR(20),  
 @ValorSpotUF NUMERIC(19,4),  
 @fechaProc DATETIME,  
 @oCodProducto VARCHAR(5)    
     
 SELECT @ValorIngresado = @precio,    
 @diferencia = 0,    
 @Leyenda = '',    
 @msgextra = 'La tasa ',  
 @oCodProducto = @codProducto  
    
 IF @codProducto = '1' --- Seguro de Cambio (@ValorIngresado corresponde al Precio Futuro)    
 BEGIN    
  --- Traer el valor del SpotContable    
  EXECUTE dbo.SP_OBTENER_VALOR_MONEDACONTABLE '13', @DatoFteExterna OUTPUT    
  IF @DatoFteExterna IS NULL    
  BEGIN    
   SELECT @diferencia = -1,    
   @Leyenda = 'No se encontró Valor de Moneda Contable para el Dólar.',    
   @bandaInf = @bandaInferior,    
   @bandaSup = @bandaSuperior,
   @CFErr    = 'N'
   RETURN 0    
  END    
    
  SELECT @SpotContable = @DatoFteExterna      
  
  IF @codMonFam = '999'    
  BEGIN    
   --- Traer @tasaCLP y @tasaUSD    
   EXECUTE dbo.SP_OBTENER_DATOS_FUENTEEXTERNA 'BFW', @codProducto, @codMonFam, @plazo, @tipoOper, @DatoFteExterna OUTPUT    
   IF @DatoFteExterna IS NULL    
   BEGIN    
    SELECT @diferencia = -1,    
    @Leyenda = 'No se encontró curva para Forward (Seguro de Cambio) y moneda Peso.',    
    @bandaInf = @bandaInferior,    
    @bandaSup = @bandaSuperior,
    @CFErr    = 'N'				
    RETURN 0    
   END    
  
   SELECT @tasaCLP = @DatoFteExterna / 100.0, --- Agregado PRD-9287  
     @msgextra = 'El precio '    
    
   EXECUTE dbo.SP_OBTENER_DATOS_FUENTEEXTERNA 'BFW', @codProducto, '13', @plazo, @tipoOper, @DatoFteExterna OUTPUT    
   IF @DatoFteExterna IS NULL    
   BEGIN    
    SELECT @diferencia = -1,    
    @Leyenda = 'No se encontró curva para Forward (Seguro de Cambio) y moneda Dólar.',    
    @bandaInf = @bandaInferior,    
    @bandaSup = @bandaSuperior,
    @CFErr    = 'N'
    RETURN 0    
   END    
   SELECT @tasaUSD = @DatoFteExterna / 100.0 --- Agregado PRD-9287  
   SELECT @PrecioFWD = @SpotContable * ((1 + @tasaUSD * @plazo/360)/(1 + @tasaCLP * @plazo/360))    
  END  --- fin @codmonFam = '999'  
  
  IF @codMonFam = '998'    
  BEGIN    
   --- Traer @tasaUF y @tasaUSD    
   EXECUTE dbo.SP_OBTENER_DATOS_FUENTEEXTERNA 'BFW', @codProducto, @codMonFam, @plazo, @tipoOper, @DatoFteExterna OUTPUT    
   IF @DatoFteExterna IS NULL    
   BEGIN    
    SELECT @diferencia = -1,    
    @Leyenda = 'No se encontró curva para Forward (Seguro de Cambio) y moneda UF.',    
    @bandaInf = @bandaInferior,    
    @bandaSup = @bandaSuperior,
    @CFErr    = 'N'
    RETURN 0    
   END    
    
   SELECT @tasaUF = @DatoFteExterna / 100.0, --- Agregado PRD-9287  
      @msgextra = 'La tasa '    
    
   EXECUTE dbo.SP_OBTENER_DATOS_FUENTEEXTERNA 'BFW', @codProducto, '13', @plazo, @tipoOper, @DatoFteExterna OUTPUT    
   IF @DatoFteExterna IS NULL    
   BEGIN    
    SELECT @diferencia = -1,    
    @Leyenda = 'No se encontró curva para Forward (Seguro de Cambio) y moneda Dólar.',    
    @bandaInf = @bandaInferior,    
    @bandaSup = @bandaSuperior,
    @CFErr    = 'N'				
    RETURN 0    
   END    
    
   SELECT @tasaUSD = @DatoFteExterna / 100.0 --- Agregado PRD-9287  
   SELECT @PrecioFWD = @SpotContable * ((1 + @tasaUSD * @plazo/360)/(1 + @tasaUF * @plazo/360))    
   --- Aquí aplicar cambios solicitados por usuario certificador  
   --- Multiplicar el Valor Spot de la UF por el valor de la tasa recibida  
   SELECT @fechaProc = acfecproc FROM BacTraderSuda..MDAC  
   SELECT @ValorSpotUF = ISNULL(vmvalor, 1.00) FROM VALOR_MONEDA with(nolock)  
   WHERE vmcodigo = 998 AND vmfecha = @fechaProc  
    
   SELECT @ValorIngresado = @precio * @ValorSpotUF  
   --- fin cambios ...  
     
  END --- fin @codMonFam = '998'   
  
  SELECT @DatoFteExterna = @PrecioFWD    
    
 END --- Fin Seguro de Cambio    
    
 IF @codProducto = '2' --- ARBITRAJES A FUTURO (@ValorIngresado corresponde a Precio Futuro)    
 BEGIN    
  --- Paso 1, obtener datos de las paridades Bid Ask de tabla MFBIDASK     
  EXECUTE dbo.SP_RETPARBIDASK_T_1 @codMonFam, @tipoOper, @plazo, @DatoFteExterna OUTPUT    
  SELECT @msgextra = 'La paridad '    
 END --- Fin Arbitrajes    
    
 IF @codProducto = '3' --- Seguro de Inflación (@ValorIngresado corresponde a Precio Final)     
 BEGIN    
  --- Paso 1    
  SELECT @DatoFteExterna = @valor1    
  SELECT @msgextra = 'El precio '    
 END --- Fin Seguro de Inflación    
    
 IF @codProducto = '12' --- Arbitrajes MX-$    
 BEGIN    
  DECLARE  @parCierre_t_1  NUMERIC(19,4)  
    
  --- Paso 1, obtener el valor de la paridad de cierre del día anterior tabla MFBIDASK   
  EXECUTE dbo.SP_RETPARBIDASK_T_1 @codMonFam, @tipoOper, @plazo, @parCierre_t_1 OUTPUT  
  SELECT @msgextra = 'La paridad (Mx-$) '     
    
  SELECT @ValorIngresado = @Precio / @parCierre_t_1  
    
  ----AHORA PROCESAR COMO SEGURO DE CAMBIO CON MONEDA 999 (CLP)  
  SELECT @codProducto = '1',  
      @codMonFam = '999'   
    
    --- Traer el valor del SpotContable  
  EXECUTE dbo.SP_OBTENER_VALOR_MONEDACONTABLE '13', @SpotContable OUTPUT  
  IF @SpotContable IS NULL  
  BEGIN  
   SELECT @diferencia = -1,  
   @Leyenda = 'No se encontró Valor de Moneda Contable para el Dólar.',  
   @bandaInf = @bandaInferior,  
   @bandaSup = @bandaSuperior,
   @CFErr    = 'N'
   RETURN 0  
  END  
    
  --- Traer @tasaCLP y @tasaUSD  
  EXECUTE dbo.SP_OBTENER_DATOS_FUENTEEXTERNA 'BFW', @codProducto, '999', @plazo, @tipoOper, @DatoFteExterna OUTPUT  
  IF @DatoFteExterna IS NULL  
  BEGIN  
   SELECT @diferencia = -1,  
   @Leyenda = 'No se encontró curva para Forward (Seguro de Cambio) y moneda Peso.',  
   @bandaInf = @bandaInferior,  
   @bandaSup = @bandaSuperior,
   @CFErr    = 'N'
   RETURN 0  
  END  
  SELECT @tasaCLP = @DatoFteExterna / 100.0,  --- Agregado PRD-9287  
    @msgextra = 'El precio '  
  
  EXECUTE dbo.SP_OBTENER_DATOS_FUENTEEXTERNA 'BFW', @codProducto, '13', @plazo, @tipoOper, @DatoFteExterna OUTPUT  
  IF @DatoFteExterna IS NULL  
  BEGIN  
   SELECT @diferencia = -1,  
   @Leyenda = 'No se encontró curva para Forward (Seguro de Cambio) y moneda Dólar.',  
   @bandaInf = @bandaInferior,  
   @bandaSup = @bandaSuperior,
   @CFErr    = 'N'
   RETURN 0  
  END  
  
  SELECT @tasaUSD = @DatoFteExterna / 100.0  --- Agregado PRD-9287  
  SELECT @PrecioFWD = @SpotContable * ((1 + @tasaUSD * @plazo/360)/(1 + @tasaCLP * @plazo/360))  
    
  SELECT @DatoFteExterna = @PrecioFWD  
    
 END --- Fin Arbitrajes MX-$    
     
 --- Paso 2    
 SELECT @Volatilidad = Volatilidad    
 FROM Tbl_Mantenedores_TasasPrecios    
 WHERE codSistema = 'BFW'    
 AND codProducto = @codProducto    
 AND codMonFam = @codMonFam    
 AND @plazo BETWEEN PlazoDesde AND PlazoHasta    
    
 IF @Volatilidad IS NULL    
 BEGIN    
  SELECT @diferencia = -1    
  IF @codProducto <> '12'    
  BEGIN    
   SELECT @Leyenda = 'No se encontró valor para la Volatilidad en tabla de Mantenedores.',    
   @bandaInf = @bandaInferior,    
   @bandaSup = @bandaSuperior,
   @CFErr    = 'N'			
  END    
  ELSE    
  BEGIN    
   SELECT @Leyenda = 'No se encontró valor para la Volatilidad (Mx-$) en tabla de Mantenedores.',    
   @bandaInf = @bandaInferior,    
   @bandaSup = @bandaSuperior,
   @CFErr    = 'N'
  END    
  RETURN 0    
 END    
    
 --- Paso 3    
 SELECT @factor = (@Volatilidad * @DatoFteExterna )/100.0    
    
 --- Paso 4, construir las bandas    
 SELECT  @BandaSuperior = @DatoFteExterna + @factor,    
  @BandaInferior  = @DatoFteExterna - @factor    
    
 --- Paso 5, comparar valor con bandas    
 IF @ValorIngresado BETWEEN @bandaInferior AND @bandaSuperior    
 BEGIN    
  SELECT @diferencia = 0,    
  @Leyenda = 'OK',    
  @bandaInf = @bandaInferior,    
  @bandaSup = @bandaSuperior,
  @CFErr    = 'N'
  RETURN 0    
 END    
 IF @ValorIngresado > @bandaSuperior    
 BEGIN    
  SELECT @diferencia = @ValorIngresado - @bandaSuperior,    
  @Leyenda = @msgextra +'de conformidad de mercado se encuentra fuera de los márgenes establecidos, no puede ser superior a '+RTRIM(CONVERT(VARCHAR(20),@bandaSuperior))
  SELECT @Leyenda = @Leyenda + ' Valor: ' + RTRIM(CONVERT(VARCHAR(20),@ValorIngresado)) + '.', 
  @bandaInf = @bandaInferior,    
  @bandaSup = @bandaSuperior,
  @CFErr    = 'S'
  
  --- Aplicar cambios solicitados por usuario certificador, PRD-9287  
  IF @oCodProducto = '12' ---Arbitraje MX-$  
	  BEGIN	
   SELECT @Leyenda = 'La operación de cambio ingresada implica un tipo de cambio de dólar superior a la banda máxima de '+RTRIM(CONVERT(VARCHAR(20),@bandaSuperior))  
   SELECT @Leyenda = @Leyenda + ' Valor: ' + RTRIM(CONVERT(VARCHAR(20),@ValorIngresado)) + '.'		
	  END
  IF @oCodProducto = '1' AND @codMonFam = '998' ---Seguro de Cambio Dólar/UF  
	  BEGIN
   SELECT @Leyenda = 'La operación de cambio ingresada implica una paridad de cambio superior a la banda máxima de '+RTRIM(CONVERT(VARCHAR(20),@bandaSuperior))  
   SELECT @Leyenda = @Leyenda + ' Valor: ' + RTRIM(CONVERT(VARCHAR(20),@ValorIngresado)) + '.'  
	  END
  RETURN 0    
 END    
 IF @ValorIngresado < @bandaInferior    
 BEGIN    
  SELECT @diferencia = @bandaInferior - @ValorIngresado,    
  @Leyenda = @msgextra +'de conformidad de mercado se encuentra fuera de los márgenes establecidos, no puede ser inferior a '+RTRIM(CONVERT(VARCHAR(20),@bandaInferior))
  SELECT @Leyenda = @Leyenda + ' Valor: ' + RTRIM(CONVERT(VARCHAR(20),@ValorIngresado)) + '.',  
  @bandaInf = @bandaInferior,    
  @bandaSup = @bandaSuperior,
  @CFErr    = 'S'		
  
  --- Aplicar cambios solicitados por usuario certificador, PRD-9287  
  IF @oCodProducto = '12' ---Arbitraje MX-$  
	  BEGIN
   SELECT @Leyenda = 'La operación de cambio ingresada implica un tipo de cambio de dólar inferior a la banda mínima de ' + RTRIM(CONVERT(VARCHAR(20),@bandaInferior))  
   SELECT @Leyenda = @Leyenda + ' Valor: ' + RTRIM(CONVERT(VARCHAR(20),@ValorIngresado)) + '.'
	  END
  IF @oCodProducto = '1' AND @codMonFam = '998' ---Seguro de Cambio Dólar/UF  
	  BEGIN
   SELECT @Leyenda = 'La operación de cambio ingresada implica una paridad de cambio inferior a la banda mínima de '+RTRIM(CONVERT(VARCHAR(20),@bandaInferior))  
   SELECT @Leyenda = @Leyenda + ' Valor: ' + RTRIM(CONVERT(VARCHAR(20),@ValorIngresado)) + '.'
	  END
  RETURN 0    
 END    
END  

GO
