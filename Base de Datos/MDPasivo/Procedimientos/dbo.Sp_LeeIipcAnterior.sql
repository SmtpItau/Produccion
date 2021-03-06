USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeeIipcAnterior]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_LeeIipcAnterior]
                  (@nMes INTEGER, @nAnn INTEGER)
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
    SELECT vmvalor 
      FROM VALOR_MONEDA 
     WHERE vmcodigo = 502
           AND   DATEPART(MONTH,vmfecha) = @nMes 
           AND   DATEPART(YEAR, vmfecha) = @nAnn

    RETURN
SET NOCOUNT OFF
END

GO
