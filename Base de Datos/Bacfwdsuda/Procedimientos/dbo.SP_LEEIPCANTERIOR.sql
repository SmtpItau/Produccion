USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEIPCANTERIOR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEEIPCANTERIOR] 
               (@cFecha CHAR(10))
AS
BEGIN
    IF DATEPART(MONTH,@cFecha) = 1
        SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = '12/01/' + CONVERT(CHAR(4),DATEPART(YEAR,@cFecha) - 1) 
        AND    vmcodigo = 500
    Else
        SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = @cFecha 
        AND    vmcodigo = 500
    RETURN
END

GO
