USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPRIME_SWIFT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPRIME_SWIFT](  @numero  NUMERIC(10) ,
     @Tipo_Mercado   CHAR   (1)
                               )
AS
BEGIN
   SET NOCOUNT ON
    IF @Tipo_Mercado = 'A'  --Arbitrajes
 BEGIN
               SELECT  * 
  FROM  tbTransferencia   a ,
   tbtransferencia_detalle  b 
  WHERE  @numero = a.numero_operacion AND 
   ( a.numero_operacion = b.numero_operacion )
 END
    ELSE
 BEGIN
       SELECT  * 
  FROM  tbTransferencia
  WHERE  @numero = numero_operacion
 END
   SET NOCOUNT OFF      
END

GO
