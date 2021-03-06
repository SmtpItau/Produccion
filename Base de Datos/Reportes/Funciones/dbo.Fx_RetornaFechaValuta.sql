USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_RetornaFechaValuta]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[Fx_RetornaFechaValuta](@iDias  SMALLINT
                                             ,@iMoneda SMALLINT
											 ,@dfecha  DATETIME)



  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns DATETIME



 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : FECHA DE VALUTA                                             */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
    DECLARE @dFechaVal  DATETIME
       
       DECLARE @plaza             SMALLINT
       ,      @iContador   SMALLINT
       ,      @mes         SMALLINT
       ,      @ano         SMALLINT     
       ,      @nrodia             SMALLINT
       ,      @ano2        SMALLINT

    DECLARE @feriado     CHAR(1)  
       ,      @campo       CHAR(50)

       SET @iContador = 0

       IF @iDias = 0
       BEGIN
             SET @dFechaVal = @dfecha
             RETURN @dFechaVal
       END

       SET @ano2 = DATEPART(YEAR, @dfecha)

       IF @iMoneda = 999
             SELECT @plaza = mncodpais FROM BacParamsuda.dbo.MONEDA WITH(NOLOCK) WHERE mncodmon = @iMoneda
       ELSE
       BEGIN
             SELECT @plaza = ISNULL((SELECT mncodpais FROM BacParamsuda.dbo.MONEDA  WITH(NOLOCK) WHERE mncodmon = @iMoneda),-1)
             IF @plaza = -1
             BEGIN
                    SET @plaza = 225    ---> USA
             END
       END
       ---> Finalmente, validar que la plaza correspondiente exista en la tabla de feriados
       IF NOT EXISTS(SELECT 1 FROM BacParamsuda.dbo.FERIADO f WITH(NOLOCK) WHERE f.feplaza = @plaza AND f.feano = @ano2)
       BEGIN
             IF @iMoneda = 999
             BEGIN
                    --> No existe la plaza para CLP, devolver la fecha original y salir!
                    SET @dFechaVal = @dfecha
                    RETURN @dFechaVal
             END
             ---> Si no existe feriado para la plaza, asumirla como USA
             SELECT @plaza = 225
       END
       ---> Validar de nuevo porque se pudo haber cambiado la plaza
       IF NOT EXISTS(SELECT 1 FROM BacParamsuda.dbo.FERIADO f WITH(NOLOCK) WHERE f.feplaza = @plaza AND f.feano = @ano2)
       BEGIN
             --> No hay feriado para la plaza, devolver la fecha original y salir!
             SET @dFechaVal = @dfecha
             RETURN @dFechaVal
       END
             
       SET @nrodia    = (CASE WHEN @iDias < 0 THEN -1 ELSE 1 END)
       
       SET @feriado   = 'S'

       SET @dFechaVal = @dfecha

       IF @iDias <> 0
       BEGIN

             SET @iContador   = 0

             WHILE @feriado = 'S'
             BEGIN

                    SET @dFechaVal = DATEADD(DAY, @nrodia, @dFechaVal)

                    SET @mes = DATEPART(MONTH, @dFechaVal)
                    SET @ano = DATEPART(YEAR , @dFechaVal)

                    if @mes = 01 SELECT @campo = feene FROM bacparamsuda.dbo.feriado WITH(NOLOCK) WHERE feano = @ano AND feplaza = @plaza
                    if @mes = 02 SELECT @campo = fefeb FROM bacparamsuda.dbo.feriado WITH(NOLOCK) WHERE feano = @ano AND feplaza = @plaza
                    if @mes = 03 SELECT @campo = femar FROM bacparamsuda.dbo.feriado WITH(NOLOCK) WHERE feano = @ano AND feplaza = @plaza  
                    if @mes = 04 SELECT @campo = feabr FROM bacparamsuda.dbo.feriado WITH(NOLOCK) WHERE feano = @ano AND feplaza = @plaza  
                    if @mes = 05 SELECT @campo = femay FROM bacparamsuda.dbo.feriado WITH(NOLOCK) WHERE feano = @ano AND feplaza = @plaza  
                    if @mes = 06 SELECT @campo = fejun FROM bacparamsuda.dbo.feriado WITH(NOLOCK) WHERE feano = @ano AND feplaza = @plaza  
                    if @mes = 07 SELECT @campo = fejul FROM bacparamsuda.dbo.feriado WITH(NOLOCK) WHERE feano = @ano AND feplaza = @plaza  
                    if @mes = 08 SELECT @campo = feago FROM bacparamsuda.dbo.feriado WITH(NOLOCK) WHERE feano = @ano AND feplaza = @plaza
                    if @mes = 09 SELECT @campo = fesep FROM bacparamsuda.dbo.feriado WITH(NOLOCK) WHERE feano = @ano AND feplaza = @plaza  
                    if @mes = 10 SELECT @campo = feoct FROM bacparamsuda.dbo.feriado WITH(NOLOCK) WHERE feano = @ano AND feplaza = @plaza
                    if @mes = 11 SELECT @campo = fenov FROM bacparamsuda.dbo.feriado WITH(NOLOCK) WHERE feano = @ano AND feplaza = @plaza  
                    if @mes = 12 SELECT @campo = fedic FROM bacparamsuda.dbo.feriado WITH(NOLOCK) WHERE feano = @ano AND feplaza = @plaza

                    IF CHARINDEX(SUBSTRING(CONVERT(CHAR(10),@dFechaVal,103),1,2),@campo) = 0
                    BEGIN    
                           SELECT @iContador = @iContador + 1
                           IF  @iContador = ABS(@iDias)
                           BEGIN
                                  SELECT @feriado = 'N'
                           END   
                    END 
             END
       END

       RETURN @dFechaVal


 END


GO
