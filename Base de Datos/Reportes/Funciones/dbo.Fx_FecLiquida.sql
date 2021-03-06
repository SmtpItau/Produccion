USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_FecLiquida]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_FecLiquida]( 
			 @iDias int
			,@iMoneda int	  
			,@dfecha datetime	 
			) RETURNS	datetime
AS
BEGIN

    DECLARE @dFechaVal datetime 
     
    DECLARE @plaza int
    ,@iContador int
    ,@mes int
    ,@ano int  
    ,@nrodia int

    DECLARE @feriado char(1)  
    ,@campo char(50)

    SET @iContador = 0
     
    IF @iMoneda =  13 SET @plaza = 225
    IF @iMoneda <> 13 SET @plaza = 6

    SET @nrodia = (CASE WHEN @iDias < 0 THEN -1 ELSE 1 END)
     
    SET @feriado   = 'S'

    SET @dFechaVal = @dfecha

    IF @iDias <> 0
	   BEGIN

		  SET @iContador   = 0

		  WHILE @feriado = 'S'
			 BEGIN

				SET @dFechaVal = DATEADD(DAY,@nrodia, @dFechaVal)

				SET @mes = DATEPART(MONTH,@dFechaVal)
				SET @ano = DATEPART(YEAR,@dFechaVal)

				if @mes = 01 select @campo = feene from bacparamsuda.dbo.feriado  where feano = @ano and feplaza = @plaza
				if @mes = 02 select @campo = fefeb from bacparamsuda.dbo.feriado  where feano = @ano and feplaza = @plaza
				if @mes = 03 select @campo = femar from bacparamsuda.dbo.feriado  where feano = @ano and feplaza = @plaza  
				if @mes = 04 select @campo = feabr from bacparamsuda.dbo.feriado  where feano = @ano and feplaza = @plaza  
				if @mes = 05 select @campo = femay from bacparamsuda.dbo.feriado  where feano = @ano and feplaza = @plaza  
				if @mes = 06 select @campo = fejun from bacparamsuda.dbo.feriado  where feano = @ano and feplaza = @plaza  
				if @mes = 07 select @campo = fejul from bacparamsuda.dbo.feriado  where feano = @ano and feplaza = @plaza  
				if @mes = 08 select @campo = feago from bacparamsuda.dbo.feriado  where feano = @ano and feplaza = @plaza
				if @mes = 09 select @campo = fesep from bacparamsuda.dbo.feriado  where feano = @ano and feplaza = @plaza  
				if @mes = 10 select @campo = feoct from bacparamsuda.dbo.feriado  where feano = @ano and feplaza = @plaza
				if @mes = 11 select @campo = fenov from bacparamsuda.dbo.feriado  where feano = @ano and feplaza = @plaza  
				if @mes = 12 select @campo = fedic from bacparamsuda.dbo.feriado  where feano = @ano and feplaza = @plaza

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
