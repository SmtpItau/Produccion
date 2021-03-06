USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVUELVE_FERIADO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DEVUELVE_FERIADO]
            (
            @feano      NUMERIC(5)
            )      
AS
BEGIN
      SET NOCOUNT ON
      SELECT 
             feene
            ,fefeb
            ,femar
            ,feabr
            ,femay      
            ,fejun
            ,fejul
            ,feago
            ,fesep
            ,feoct
            ,fenov
            ,fedic
      
      FROM VIEW_FERIADO 
      WHERE feplaza = 1
      AND feano = @feano 
      SET NOCOUNT OFF
END

GO
