USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_OPERACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BORRAR_OPERACION]
   (   @NumOper   NUMERIC(10)   )
AS
BEGIN
   SET NOCOUNT ON

   DELETE FROM MovDiario 
         WHERE numero_operacion = @NumOper

   DELETE FROM CARTERA   
         WHERE numero_operacion = @NumOper

END
GO
