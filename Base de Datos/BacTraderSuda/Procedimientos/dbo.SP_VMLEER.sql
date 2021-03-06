USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VMLEER]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VMLEER]
                           (@vmcodigo1 NUMERIC (3,0), 
                            @vmmes     INTEGER      , 
                            @vmano     INTEGER      )
AS   
BEGIN
   set nocount on
    IF @vmmes = 0 
       BEGIN
           Select   vmcodigo,vmvalor,CONVERT(CHAR(10),vmfecha,103) 
           FROM     VIEW_VALOR_MONEDA
           WHERE    vmcodigo = @vmcodigo1 
           AND      DATEPART(YEAR,vmfecha)  = @vmano 
          ORDER BY vmcodigo,vmfecha
       END
    IF @vmmes > 0 
       BEGIN
           SELECT   vmcodigo,  
                    vmvalor,   
                    CONVERT(CHAR(10),vmfecha,103)
           FROM     VIEW_VALOR_MONEDA
           WHERE    vmcodigo = @vmcodigo1 
           AND      DATEPART(MONTH, vmfecha)  = @vmmes
           AND      DATEPART(YEAR, vmfecha)   = @vmano
           ORDER BY vmcodigo,vmfecha
        END
set nocount off
RETURN
END

GO
