USE [Bacfwdsuda]
GO
/****** Object:  UserDefinedFunction [dbo].[CalcularFechaValuta]    Script Date: 13-05-2022 9:09:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[CalcularFechaValuta]
	(	@formapago	INT
	,	@Fecha		as DATETIME	
	)
RETURNS DATETIME  
AS  
BEGIN  

    DECLARE @DiasValor INT  
    DECLARE @Date      DATETIME  
    DECLARE @Year      INT  
    DECLARE @Month     INT  
    DECLARE @Feriados  VARCHAR(100)  
    DECLARE @Day       VARCHAR(02)  
  
    SELECT @DiasValor = DiasValor  
      FROM BacParamSuda.dbo.FORMA_DE_PAGO  
     WHERE codigo = @formapago  
  
    set @Date = @Fecha  
  
    WHILE (@DiasValor > 0)  
    BEGIN  
        SET @DiasValor = @DiasValor - 1  
        SET @Date = dbo.CalcularDiaHabil(DATEADD( DAY, 1, @Date ))  
  
    END  
  
    SET @Date = dbo.CalcularDiaHabil(@Date)  
  
    RETURN @Date  

END

GO
