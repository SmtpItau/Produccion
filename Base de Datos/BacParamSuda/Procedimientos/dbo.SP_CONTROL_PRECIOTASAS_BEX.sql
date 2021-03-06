USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_PRECIOTASAS_BEX]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
  
CREATE PROCEDURE [dbo].[SP_CONTROL_PRECIOTASAS_BEX]  
 (  @codProducto VARCHAR(5)  
  ,@codMonFam VARCHAR(5)  
  ,@tipoMonFam CHAR(1)  
  ,@dias  INTEGER  
  ,@tasa  NUMERIC(19,4)  
  ,@diferencia NUMERIC(19,4) OUTPUT  
  ,@Leyenda VARCHAR(255) OUTPUT  
  ,@bandaInf NUMERIC(19,4) OUTPUT  
  ,@bandaSup NUMERIC(19,4) OUTPUT  
  ,@CFErr		CHAR(1) OUTPUT  
 )  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE   
 @codSistema CHAR(3),  
 @Max INT,  
 @Min INT,  
 @tOp VARCHAR(10),  
 @codCurva VARCHAR(20),  
 @valorVolatilidad NUMERIC(19,4),  
 @valInterpol NUMERIC(19,4),  
 @bandaInferior NUMERIC(19,4),  
 @bandaSuperior NUMERIC(19,4)  
   
 SELECT @tOp= '',  
 @codSistema = 'BEX'  
  
 IF @codProducto = 'CPX'  
 SELECT @tOp = 'Compra'  
  
 IF @codProducto = 'VPX'  
 SELECT @tOp = 'Venta'  
  
 SELECT  @Max = MAX(PlazoHasta),  
 @Min = MIN(PlazoDesde)  
 FROM BacParamsuda..Tbl_Mantenedores_TasasPrecios  
 WHERE codSistema = @codSistema  
 AND codProducto = @codProducto  
 AND codMonFam = @codMonFam  
 AND tipoMonFam = @tipoMonFam  
  
 IF @Max IS NULL OR @Min IS NULL  
 BEGIN  
  SELECT @Leyenda = 'No hay datos en tabla de parámetros para la operación buscada de Bonos Exterior.'  
  SELECT @diferencia = @dias,  
   @bandaInf = @bandaInferior,  
   @bandaSup = @bandaSuperior,
   @CFErr    = 'N'
  RETURN 0  
 END  
  
 IF @dias < @Min   
 BEGIN  
  SELECT @Leyenda = 'El plazo de la operación ('+RTRIM(CONVERT(VARCHAR(20),@dias))+' días) es menor al mínimo registrado ('+RTRIM(CONVERT(VARCHAR(20),@Min))+' días)'  
  SELECT @diferencia = @dias,  
   @bandaInf = @bandaInferior,  
   @bandaSup = @bandaSuperior,
   @CFErr    = 'N'			
  RETURN 0  
 END  
 IF @dias > @Max  
 BEGIN  
  SELECT @Leyenda = 'El plazo de la operación ('+RTRIM(CONVERT(VARCHAR(20),@dias))+' días) es mayor al máximo registrado ('+RTRIM(CONVERT(VARCHAR(20),@Max))+' días)'  
  SELECT @diferencia = @dias,  
   @bandaInf = @bandaInferior,  
   @bandaSup = @bandaSuperior,
   @CFErr    = 'N'			
  RETURN 0  
 END  
 /* Ahora sabemos que el plazo está dentro de los márgenes de la tabla */  
 SELECT @valorVolatilidad = Volatilidad,  
 @codCurva = codCurva  
 FROM BacParamsuda..Tbl_Mantenedores_TasasPrecios  
 WHERE codSistema = @codSistema  
 AND codProducto = @codProducto  
 AND codMonFam = @codMonFam  
 AND tipoMonFam = @tipoMonFam  
 AND @dias <= PlazoHasta  
 AND @dias >= PlazoDesde  
 /*  Llamar al sp_RetInterpolCurvas   */  
 IF @codProducto = 'CPX'  
  EXECUTE BacParamsuda..SP_RETINTERPOLCURVAS @codCurva, @dias, 'BID', @valInterpol OUTPUT  
  
 IF @codProducto = 'VPX'  
  EXECUTE BacParamsuda..SP_RETINTERPOLCURVAS @codCurva, @dias, 'ASK', @valInterpol OUTPUT  
  
 IF @valInterpol IS NULL  
 BEGIN  
  SELECT @Leyenda = 'No existe curva en el sistema para ' + @codCurva  
  SELECT @diferencia = @dias,  
   @bandaInf = @bandaInferior,  
   @bandaSup = @bandaSuperior,
   @CFErr    = 'N'			
  RETURN 0  
 END   
  
 SELECT  @bandaInferior = @valInterpol - @valorVolatilidad,  
  @bandaSuperior = @valInterpol + @valorVolatilidad  
   
 IF ( @tasa <= @bandaSuperior AND @tasa >= @bandaInferior )  
 BEGIN  
  SELECT  @diferencia=0  
  SELECT  @Leyenda = 'OK',  
    @bandaInf = @bandaInferior,  
    @bandaSup = @bandaSuperior,
    @CFErr    = 'N'				
  RETURN 0   
 END  
 IF @tasa > @bandaSuperior  
 BEGIN  
  SELECT @diferencia = @tasa - @bandaSuperior  
  SELECT @Leyenda = 'La tasa de conformidad de mercado de ' + @tOp + ' se encuentra fuera de los márgenes establecidos,'  
  SELECT @Leyenda = @Leyenda +' no puede ser superior a ' + RTRIM(CONVERT(VARCHAR(20),@bandaSuperior)) + ' Valor: ' + RTRIM(CONVERT(VARCHAR(20),@tasa)) + '.',  
   @bandaInf = @bandaInferior,  
   @bandaSup = @bandaSuperior,
   @CFErr    = 'S'			
  RETURN 0  
 END  
 IF @tasa < @bandaInferior  
 BEGIN  
  SELECT @diferencia = @bandaInferior - @tasa  
  SELECT @Leyenda = 'La tasa de conformidad de mercado de ' + @tOp + ' se encuentra fuera de los márgenes establecidos,'  
  SELECT @Leyenda = @Leyenda +' no puede ser inferior a ' + RTRIM(CONVERT(VARCHAR(20),@bandaInferior)) + ' Valor: ' + RTRIM(CONVERT(VARCHAR(20),@tasa)) + '.',  
   @bandaInf = @bandaInferior,  
   @bandaSup = @bandaSuperior,
   @CFErr    = 'S'
  RETURN 0  
 END  
END 
GO
