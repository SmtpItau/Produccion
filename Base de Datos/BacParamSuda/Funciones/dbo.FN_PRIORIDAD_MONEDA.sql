USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_PRIORIDAD_MONEDA]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FN_PRIORIDAD_MONEDA]
       (
         @CodMoneda    NUMERIC(5)         
       )
RETURNS   INT
AS
BEGIN

  
    DECLARE @Prioridad   INT
    
    set @Prioridad = (case when @CodMoneda = 999 then 0    
                          when @CodMoneda = 998 then 1    
                          when (@CodMoneda = 13 or @CodMoneda = 994) then 2    
                     else 3 end)    
    

    RETURN @Prioridad


END
GO
