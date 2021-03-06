USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PARAMETROS_INICIO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PARAMETROS_INICIO](@xEntidad   Char(5)
                                     ,@xpreini    Numeric(10,4) out --ACPREINI
                                     ,@xposinic   Numeric(15,2) out --ACPOSINI
                                     ,@xposic     Numeric(15,2) out --ACPOSIC
                                ,@xPrHeIni   Numeric(15,4) out --ACHEDGEPRECIOINICIAL
                                ,@xPoHeFui   Numeric(15,4) out --ACHEDGEINICIALFUTURO
         ,@xPoHeSpi   Numeric(19,4) out --ACHEDGEINICIALSPOT
         ,@xPoHeFut   Numeric(19,4) out --ACHEDGEACTUALFUTURO
         ,@xPoHeSpt   Numeric(19,4) out --ACHEDGEACTUALSPOT
                                     )
AS
BEGIN
set nocount on
    SELECT  @xpreini  = acpreini            
           ,@xposinic = acposini            
           ,@xposic   = acposic               
           ,@xPrHeIni = achedgeprecioinicial  
    ,@xPoHeFui = achedgeinicialfuturo  
    ,@xPoHeSpi = achedgeinicialspot    
    ,@xPoHeFut = achedgeactualfuturo   
    ,@xPoHeSpt = achedgeactualspot     
      FROM MEAC
     WHERE ACENTIDA = @xEntidad
END
 



GO
