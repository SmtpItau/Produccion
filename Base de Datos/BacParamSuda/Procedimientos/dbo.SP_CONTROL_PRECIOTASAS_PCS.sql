USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_PRECIOTASAS_PCS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
  
CREATE PROCEDURE [dbo].[SP_CONTROL_PRECIOTASAS_PCS]  
 (  @codProducto VARCHAR(5)  
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
 @VAC  NUMERIC(19,4),  
 @rangoMinimo  NUMERIC(19,4),  
 @rangoMaximo  NUMERIC(19,4)  
   
 SELECT  @VAC = @tasa  
  
 SELECT  @rangoMinimo = RangoDesde,  
 @rangoMaximo = RangoHasta  
 FROM Tbl_Mantenedores_TasasPrecios  
 WHERE codSistema = 'PCS'  
 AND codProducto = @codProducto  
 AND @dias BETWEEN PlazoDesde AND PlazoHasta  
  
 IF @rangoMinimo IS NULL OR @rangoMaximo IS NULL  
 BEGIN  
  SELECT @diferencia = -1,  
  @Leyenda = 'Error, no se encontró el plazo en la tabla de parámetros.',  
  @bandaInf = @rangoMinimo,  
  @bandaSup = @rangoMaximo    
  RETURN 0  
 END  
 IF @VAC BETWEEN @rangoMinimo AND @rangoMaximo  
 BEGIN  
  SELECT @diferencia = 0,  
  @Leyenda = 'OK',  
  @bandaInf = @rangoMinimo,  
  @bandaSup = @rangoMaximo,
  @CFErr    = 'N'
  RETURN 0  
 END  
 IF @VAC > @rangoMaximo  
 BEGIN  
  SELECT @diferencia = @VAC - @rangoMaximo,  
  @Leyenda = 'La razón de Valor Razonable/Capital está fuera de los rangos establecidos para el plazo del contrato, el valor no puede ser superior a '+RTRIM(CONVERT(VARCHAR(20),@rangoMaximo))
  SELECT @Leyenda = @Leyenda + ' Valor: ' +  RTRIM(CONVERT(VARCHAR(20),@VAC)) + '.',
  @bandaInf = @rangoMinimo,  
  @bandaSup = @rangoMaximo,
  @CFErr    = 'S'		
  RETURN 0  
 END  
 IF @VAC < @rangoMinimo  
 BEGIN  
  SELECT @diferencia = @rangoMinimo - @VAC,  
  @Leyenda = 'La razón de Valor Razonable/Capital está fuera de los rangos establecidos para el plazo del contrato, el valor no puede ser inferior a '+RTRIM(CONVERT(VARCHAR(20),@rangoMinimo))  
  SELECT @Leyenda = @Leyenda + ' Valor: ' +  RTRIM(CONVERT(VARCHAR(20),@VAC)) + '.',
  @bandaInf = @rangoMinimo,  
  @bandaSup = @rangoMaximo,
  @CFErr    = 'S'		
  RETURN 0  
 END  
END  
GO
