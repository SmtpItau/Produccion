USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_VALORES_MERCADO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_VALORES_MERCADO]( @csistema    CHAR(3) ,
                                           @fechaproc   CHAR(8) )
AS
BEGIN
   SELECT  ISNULL( b.mnglosa ,'N/R') ,
           ISNULL( a.vmValor ,   0 ) ,
    ISNULL( b.mncodmon,   0)    
     FROM  VALOR_MONEDA a ,
    MONEDA b 
     WHERE a.vmfecha   = @fechaproc and
    b.mncodmon  = a.vmcodigo and
    b.mnrefmerc = '1'  
END
GO
