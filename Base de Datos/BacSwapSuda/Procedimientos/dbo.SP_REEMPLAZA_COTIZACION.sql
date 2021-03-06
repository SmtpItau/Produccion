USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REEMPLAZA_COTIZACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_REEMPLAZA_COTIZACION]
   (   @Numero_Cotizacion   NUMERIC(9)
   ,   @Numero_Operacion    NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON

   IF NOT EXISTS( SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE Numero_Operacion = @Numero_Cotizacion and Estado = 'C' )
   BEGIN
      SELECT -1, 'Operación no existe como cotización.... favor verificar.'
      RETURN
   END

   DECLARE @dFecha_Cierre   DATETIME
       SET @dFecha_Cierre   = (SELECT DISTINCT fecha_cierre FROM BacSwapSuda.dbo.CARTERA WHERE Numero_Operacion = @Numero_Operacion )

   DELETE FROM BacSwapSuda.dbo.CARTERA
         WHERE Numero_Operacion = @Numero_Operacion

   UPDATE BacSwapSuda.dbo.CARTERA
      SET Numero_Operacion   = @Numero_Operacion
      ,   Estado             = ''
      ,   Estado_oper_lineas = ''
      ,   Fecha_Cierre       = @dFecha_Cierre
    WHERE Numero_Operacion   = @Numero_Cotizacion

END
GO
