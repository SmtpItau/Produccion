USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEULTIMAUF]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEEULTIMAUF] 
AS
BEGIN
    DECLARE @nValorUF  FLOAT 
    DECLARE @cFechaUF  CHAR(10)
    DECLARE @nValorIPC FLOAT
    DECLARE @cFechaIPC CHAR(10)
    SET ROWCOUNT 1  
    SELECT @nValorUF = vmvalor, @cFechaUF   = CONVERT(CHAR(10),vmfecha,101) 
                                              FROM VIEW_VALOR_MONEDA 
                                              WHERE  vmcodigo = 998  
                                              ORDER BY vmfecha DESC
    SELECT @nValorIPC = vmvalor,@cFechaIPC = CONVERT(CHAR(10),vmfecha,101)
                                              FROM  VIEW_VALOR_MONEDA 
                                              WHERE vmcodigo = 500  
                                              ORDER BY vmfecha DESC
 
    IF RTRIM(@cFechaUF)  <> '' SELECT @cFechaUF  = SUBSTRING(@cFechaUF,4,2)  + '/' + SUBSTRING(@cFechaUF,1,2)  + '/' +  SUBSTRING(@cFechaUF,7,4)
    IF RTRIM(@cFechaIPC) <> '' SELECT @cFechaIPC = SUBSTRING(@cFechaIPC,4,2) + '/' + SUBSTRING(@cFechaIPC,1,2) + '/' +  SUBSTRING(@cFechaIPC,7,4)
    SELECT 'ValorUf'  = ISNULL(@nValorUF , 0.00), 
           'FechaUF'  = ISNULL(@cFechaUF ,   ''), 
           'ValorIPC' = ISNULL(@nValorIPC, 0.00), 
           'FechaIPC' = ISNULL(@cFechaIPC,   '')
    SET ROWCOUNT 0
 
    RETURN
END

GO
