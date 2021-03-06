USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_PRECIOTASAS_BCC]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_PRECIOTASAS_BCC]      
 (  @codProducto VARCHAR(5)      
  ,@codMonFam VARCHAR(5)      
  ,@tipoMonFam CHAR(1)      
  ,@tipoOper CHAR(1) --- C/V      
  ,@dias  INTEGER      
  ,@tasa  NUMERIC(19,4)      
  ,@diferencia NUMERIC(19,4) OUTPUT      
  ,@Leyenda VARCHAR(255) OUTPUT      
  ,@bandaInf NUMERIC(19,4) OUTPUT      
  ,@bandaSup NUMERIC(19,4) OUTPUT      
  ,@CFErr  CHAR(1) OUTPUT  
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
 @ValorContableDolar NUMERIC(19,4),      
 @indicador   CHAR(1),  
 @Paridad  NUMERIC(19,4),      
 @factor   FLOAT      
       
 SELECT @ValorIngresado = @tasa,      
 @diferencia = 0,      
 @Leyenda = ''      
      
 SELECT @Volatilidad = Volatilidad      
 FROM Tbl_Mantenedores_TasasPrecios with (nolock)      
 WHERE codSistema = 'BCC'      
 AND codProducto = @codProducto      
 AND codMonFam = @codMonFam      
 AND tipoMonFam = 'M'      
      
 IF @Volatilidad IS NULL      
 BEGIN      
  SELECT @diferencia = -1,      
  @Leyenda = 'No se encontró valor para la Volatilidad en tabla de Mantenedores.',      
  @bandaInf = @bandaInferior,      
  @bandaSup = @bandaSuperior,  
  @CFErr   = 'N'  
  RETURN 0      
 END      
      
 -- Traer el indicador de la moneda  
 SELECT @indicador = mnrrda FROM Bacparamsuda..MONEDA  
 WHERE mncodmon = @codMonFam  
 --- Las invierto porque no estoy calculando la paridad  
 IF @indicador = 'M'  
  SELECT @indicador = 'D'  
 ELSE  
  SELECT @indicador = 'M'  
      
 IF @codProducto = 'PTAS'      
 BEGIN      
  EXECUTE dbo.SP_OBTENER_DATOS_DATATEC @tipoOper, @codMonFam, @DatoFteExterna OUTPUT      
  IF @DatoFteExterna IS NULL      
  BEGIN      
   --- Como no encontró valores en Datatec, buscará en Valores Contables      
   EXECUTE dbo.SP_OBTENER_VALOR_MONEDACONTABLE @codMonFam, @DatoFteExterna OUTPUT      
   IF @DatoFteExterna IS NULL      
   BEGIN      
    SELECT @diferencia = -1,      
    @Leyenda = 'No se pudo obtener el valor online de Datatec ni de Valores Monedas Contables para el tipo de cambio',      
    @bandaInf = @bandaInferior,      
    @bandaSup = @bandaSuperior,  
    @CFErr   = 'N'  
    RETURN 0      
   END      
  END      
  SELECT @factor = ( @DatoFteExterna * @Volatilidad ) / 100.0      
  SELECT @bandaInferior = @DatoFteExterna - @factor      
  SELECT @bandaSuperior = @DatoFteExterna + @factor      
 END      
 IF @codProducto = 'ARBI'        
 BEGIN      
  --- Primero, Si la moneda no es dolar, traer el valor contable del dolar      
  EXECUTE dbo.SP_OBTENER_VALOR_MONEDACONTABLE '13', @ValorContableDolar OUTPUT      
      
  --- Segundo, traer valor contable de la moneda buscada      
  EXECUTE dbo.SP_OBTENER_VALOR_MONEDACONTABLE @codMonFam, @DatoFteExterna OUTPUT      
  IF @DatoFteExterna IS NULL      
  BEGIN      
   SELECT @diferencia = -1,      
   @Leyenda = 'No se pudo obtener el valor de Valores Monedas Contables para el tipo de cambio',      
   @bandaInf = @bandaInferior,      
   @bandaSup = @bandaSuperior,  
   @CFErr   = 'N'  
   RETURN 0      
  END      
  IF @indicador = 'D'  
   SELECT @Paridad = @DatoFteExterna / @ValorContableDolar  
  ELSE  
   SELECT @Paridad = @DatoFteExterna * @ValorContableDolar  
    
  SELECT @factor = ( @Paridad * @Volatilidad ) / 100.0      
  SELECT @bandaInferior = @Paridad - @factor      
  SELECT @bandasuperior = @Paridad + @factor      
 END      
 IF (@codProducto = 'EMPR' OR @codProducto = 'CCBB')   
 BEGIN      
  IF @codMonFam = '13'      
  BEGIN      
   EXECUTE dbo.SP_OBTENER_DATOS_DATATEC @tipoOper, @codMonFam, @DatoFteExterna OUTPUT      
   IF @DatoFteExterna IS NULL      
   BEGIN      
    --- Como no encontró valores en Datatec, buscará en Valores Contables      
    EXECUTE dbo.SP_OBTENER_VALOR_MONEDACONTABLE @codMonFam, @DatoFteExterna OUTPUT      
    IF @DatoFteExterna IS NULL      
    BEGIN      
     SELECT @diferencia = -1,      
     @Leyenda = 'No se pudo obtener el valor online de Datatec ni de Valores Monedas Contables para el tipo de cambio',      
     @bandaInf = @bandaInferior,      
     @bandaSup = @bandaSuperior,  
     @CFErr   = 'N'  
     RETURN 0      
    END      
   END      
   /* Empresa y Moneda = USD, el valor del Tipo de Cambio es el de la fuente Externa */      
   SELECT @factor = ( @DatoFteExterna * @Volatilidad ) / 100.0      
   SELECT @bandaInferior = @DatoFteExterna - @factor      
   SELECT @bandaSuperior = @DatoFteExterna + @factor         
  END      
  ELSE      
  BEGIN      
   /* Empresa y Moneda distinta a USD */      
      
   /* Traer el valor contable del dolar */         
   EXECUTE dbo.SP_OBTENER_VALOR_MONEDACONTABLE '13', @ValorContableDolar OUTPUT      
      
   /* Traer valor contable de la moneda buscada */      
   EXECUTE dbo.SP_OBTENER_VALOR_MONEDACONTABLE @codMonFam, @DatoFteExterna OUTPUT      
   IF @DatoFteExterna IS NULL      
   BEGIN      
    SELECT @diferencia = -1,      
    @Leyenda = 'No se pudo obtener el valor de Valores Monedas Contables para el tipo de cambio',      
    @bandaInf = @bandaInferior,      
    @bandaSup = @bandaSuperior,  
    @CFErr   = 'N'  
    RETURN 0      
   END      
      
    IF @indicador = 'D'  
     SELECT @Paridad = @DatoFteExterna / @ValorContableDolar  
    ELSE  
     SELECT @Paridad = @DatoFteExterna * @ValorContableDolar  
      
   SELECT @factor = ( @Paridad * @Volatilidad ) / 100.0      
   SELECT @bandaInferior = @Paridad - @factor      
   SELECT @bandaSuperior = @Paridad + @factor      
  END      
 END      
      
 IF @ValorIngresado BETWEEN @bandaInferior AND @bandaSuperior      
 BEGIN      
  SELECT @diferencia = 0,      
  @Leyenda = 'OK',      
  @bandaInf = @bandaInferior,      
  @bandaSup = @bandaSuperior,  
  @CFErr   = 'N'  
  RETURN 0      
 END      
 IF @ValorIngresado > @bandaSuperior      
 BEGIN      
  SELECT @diferencia = @ValorIngresado - @bandaSuperior      
  IF @codProducto = 'PTAS'      
  BEGIN      
   SELECT @Leyenda = 'El Tipo de Cambio de conformidad de mercado se encuentra fuera de los márgenes establecidos, no puede ser superior a '+RTRIM(CONVERT(VARCHAR(20),@bandaSuperior))   
   SELECT @Leyenda = @Leyenda + ' Valor:' + RTRIM(CONVERT(VARCHAR(20),@ValorIngresado)) + '.',   
   @bandaInf = @bandaInferior,      
   @bandaSup = @bandaSuperior,  
   @CFErr   = 'S'  
  END      
  ELSE      
  BEGIN      
   SELECT @Leyenda = 'La Paridad de conformidad de mercado se encuentra fuera de los márgenes establecidos, no puede ser superior a '+RTRIM(CONVERT(VARCHAR(20),@bandaSuperior))      
   SELECT @Leyenda = @Leyenda + ' Valor:' + RTRIM(CONVERT(VARCHAR(20),@ValorIngresado)) + '.',   
   @bandaInf = @bandaInferior,      
   @bandaSup = @bandaSuperior,  
   @CFErr   = 'S'  
  END      
  RETURN 0      
 END      
 IF @ValorIngresado < @bandaInferior      
 BEGIN      
  SELECT @diferencia = @bandaInferior - @ValorIngresado      
  IF @codProducto = 'PTAS'      
  BEGIN      
   SELECT @Leyenda = 'El Tipo de Cambio de conformidad de mercado se encuentra fuera de los márgenes establecidos, no puede ser inferior a '+RTRIM(CONVERT(VARCHAR(20),@bandaInferior))      
   SELECT @Leyenda = @Leyenda + ' Valor:' + RTRIM(CONVERT(VARCHAR(20),@ValorIngresado)) + '.',   
   @bandaInf = @bandaInferior,      
   @bandaSup = @bandaSuperior,  
   @CFErr   = 'S'  
  END      
  ELSE      
  BEGIN      
   SELECT @Leyenda = 'La Paridad de conformidad de mercado se encuentra fuera de los márgenes establecidos, no puede ser inferior a '+RTRIM(CONVERT(VARCHAR(20),@bandaInferior))      
   SELECT @Leyenda = @Leyenda + ' Valor:' + RTRIM(CONVERT(VARCHAR(20),@ValorIngresado)) + '.',  
   @bandaInf = @bandaInferior,      
   @bandaSup = @bandaSuperior,  
   @CFErr   = 'S'  
  END      
  RETURN 0      
 END      
END      
GO
