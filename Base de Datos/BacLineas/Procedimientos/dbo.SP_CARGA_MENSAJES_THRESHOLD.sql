USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_MENSAJES_THRESHOLD]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_MENSAJES_THRESHOLD]
   (   @Modulo     CHAR(3)
   ,   @Contrato   NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON

   
   IF EXISTS( SELECT 1 FROM BacparamSuda.dbo.TBL_MENSAJES_OPERACION_THRESHOLD with(nolock)
                          WHERE Id_Sistema   = @Modulo
                            AND Num_Contrato = @Contrato )
   BEGIN

      SELECT Id_Mensaje, Mensaje 
        FROM BacparamSuda.dbo.TBL_MENSAJES_OPERACION_THRESHOLD with(nolock)
       WHERE Id_Sistema   = @Modulo
         AND Num_Contrato = @Contrato
     ORDER BY Id_Mensaje

   END ELSE
   BEGIN
	IF @Modulo NOT IN ('BTR','BCC','BEX')
      SELECT -1 , 'Operacion no selecciono Threshold.'
   END
   
END
GO
