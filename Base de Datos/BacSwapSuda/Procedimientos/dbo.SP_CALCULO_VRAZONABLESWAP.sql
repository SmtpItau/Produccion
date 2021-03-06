USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULO_VRAZONABLESWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CALCULO_VRAZONABLESWAP]
   (   @Fecha_Proc   DATETIME
   ,   @Numero_Oper  NUMERIC(9)
   )
AS    
BEGIN

   SET NOCOUNT ON

   -- MAP se llama al proceso que calcula el AVR:
   -- para calcular el AVR al grabar operaciones
   -- de Renta Fija
   EXECUTE SP_CALCULO_ACTPAS_C08 @Fecha_Proc, @Numero_Oper   
END
GO
