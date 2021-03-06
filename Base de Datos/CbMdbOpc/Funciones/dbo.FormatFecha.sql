USE [CbMdbOpc]
GO
/****** Object:  UserDefinedFunction [dbo].[FormatFecha]    Script Date: 16-05-2022 10:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[FormatFecha](@Fecha DATETIME)  
RETURNS varchar(30)  
AS  
BEGIN  
  
    DECLARE @Result VARCHAR(30)  
  
    SET @Result = CONVERT( VARCHAR(2), DAY( @Fecha ) )  
  
    IF MONTH( @Fecha ) = 1  
    BEGIN  
        SET @Result = @Result + ' de Enero '  
  
    END ELSE IF MONTH( @Fecha ) = 2  
    BEGIN  
        SET @Result = @Result + ' de Febrero '  
  
    END ELSE IF MONTH( @Fecha ) = 3  
    BEGIN  
        SET @Result = @Result + ' de Marzo '  
  
    END ELSE IF MONTH( @Fecha ) = 4  
    BEGIN  
        SET @Result = @Result + ' de Abril '  
  
    END ELSE IF MONTH( @Fecha ) = 5  
    BEGIN  
        SET @Result = @Result + ' de Mayo '  
  
    END ELSE IF MONTH( @Fecha ) = 6  
    BEGIN  
        SET @Result = @Result + ' de Junio '  
  
    END ELSE IF MONTH( @Fecha ) = 7  
    BEGIN  
        SET @Result = @Result + ' de Julio '  
  
    END ELSE IF MONTH( @Fecha ) = 8  
    BEGIN  
        SET @Result = @Result + ' de Agosto '  
  
    END ELSE IF MONTH( @Fecha ) = 9  
    BEGIN  
        SET @Result = @Result + ' de Septiembre '  
  
    END ELSE IF MONTH( @Fecha ) = 10  
    BEGIN  
        SET @Result = @Result + ' de Octubre '  
  
    END ELSE IF MONTH( @Fecha ) = 11  
    BEGIN  
        SET @Result = @Result + ' de Noviembre '  
  
    END ELSE IF MONTH( @Fecha ) = 12  
    BEGIN  
        SET @Result = @Result + ' de Diciembre '  
  
    END  
  
    SET @Result = @Result + 'del año ' + CONVERT( VARCHAR(4), YEAR( @Fecha ) )  
  
    RETURN @Result  
  
END  
  
  
  
GO
