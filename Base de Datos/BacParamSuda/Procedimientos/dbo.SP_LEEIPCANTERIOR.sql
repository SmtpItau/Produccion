USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEIPCANTERIOR]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_LeeIPCAnterior    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_LeeIPCAnterior    fecha de la secuencia de comandos: 14/02/2001 09:58:28 ******/
CREATE PROCEDURE [dbo].[SP_LEEIPCANTERIOR] 
               (@cFecha CHAR(10))
AS
BEGIN
    IF DATEPART(MONTH,@cFecha) = 1
        SELECT vmvalor FROM VALOR_MONEDA WHERE vmfecha = '12/01/' + CONVERT(CHAR(4),DATEPART(YEAR,@cFecha) - 1) 
        AND    vmcodigo = 500
    Else
        SELECT vmvalor FROM VALOR_MONEDA WHERE vmfecha = @cFecha 
        AND    vmcodigo = 500
    RETURN
END 

GO
