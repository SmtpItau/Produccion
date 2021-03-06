USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeeIPCAnterior]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_LeeIPCAnterior] 
               (@cFecha CHAR(10))
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
    IF DATEPART(MONTH,@cFecha) = 1
        SELECT vmvalor FROM VALOR_MONEDA WHERE vmfecha = '12/01/' + CONVERT(CHAR(4),DATEPART(YEAR,@cFecha) - 1) 
        AND    vmcodigo = 500
    Else
        SELECT vmvalor FROM VALOR_MONEDA WHERE vmfecha = @cFecha 
        AND    vmcodigo = 500

    RETURN
SET NOCOUNT OFF
END

GO
