USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VMELIMINAR]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VMELIMINAR]
                               (@vmcodigo1 NUMERIC (3,0) ,
                                @vmmes     INTEGER       ,
                                @vmano     INTEGER       )
AS   
BEGIN
    IF @vmmes = 0 
       BEGIN
           DELETE VIEW_VALOR_MONEDA WHERE vmcodigo = @vmcodigo1 
                         AND DATEPART(YEAR, vmfecha)  = @vmano 
       END
    IF @vmmes > 0 
       BEGIN
           DELETE VIEW_VALOR_MONEDA WHERE vmcodigo = @vmcodigo1 
                       AND   DATEPART(MONTH, vmfecha)  = @vmmes
                       AND   DATEPART(YEAR,  vmfecha)  = @vmano
        END
    RETURN
END

GO
