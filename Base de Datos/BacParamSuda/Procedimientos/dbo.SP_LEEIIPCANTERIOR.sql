USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEIIPCANTERIOR]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEEIIPCANTERIOR] (@nMes INTEGER, @nAnn INTEGER)
AS
BEGIN
    SELECT vmvalor FROM valor_moneda WHERE vmcodigo = 502
                             AND   DATEPART(MONTH,vmfecha) = @nMes 
                             AND   DATEPART(YEAR, vmfecha) = @nAnn
    RETURN
END

GO
