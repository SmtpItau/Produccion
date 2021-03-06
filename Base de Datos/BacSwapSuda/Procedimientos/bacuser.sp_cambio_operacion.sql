USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [bacuser].[sp_cambio_operacion]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [bacuser].[sp_cambio_operacion]
   (   @Operacion   NUMERIC(9)
   ,   @Cotizacion  NUMERIC(9)
   )
as 
begin

--=================================================
--- CARTERA
--=================================================


--   BEGIN TRANSACTION

--   DECLARE @Operacion     NUMERIC(9)
--   DECLARE @Cotizacion    NUMERIC(9)
--       SET @Operacion     = 1181
--       SET @Cotizacion    = 1235

   DECLARE @dFechaCierre  DATETIME
       SET @dFechaCierre  = (SELECT TOP 1 fecha_cierre FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @Operacion)

   DELETE FROM BacSwapSuda.dbo.CARTERA 
         WHERE numero_operacion = @Operacion

   UPDATE BacSwapSuda.dbo.CARTERA 
      SET numero_operacion   = @Operacion
      ,   fecha_cierre       = @dFechaCierre
      ,   estado             = ''
      ,   Estado_oper_lineas = ''
    WHERE numero_operacion   = @Cotizacion

   SELECT * FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @Operacion
   SELECT * FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @Cotizacion

--   ROLLBACK TRANSACTION

--   COMMIT TRANSACTION


--=================================================
--- MOVIMIENTO 
--=================================================

--   BEGIN TRANSACTION

--   DECLARE @Operacion     NUMERIC(9)
--   DECLARE @Cotizacion    NUMERIC(9)
--       SET @Operacion     = 1181
--       SET @Cotizacion    = 1235
--   DECLARE @dFechaCierre  DATETIME
/*
       SET @dFechaCierre  = (SELECT TOP 1 fecha_cierre FROM BacSwapSuda.dbo.MOVHISTORICO WHERE numero_operacion = @Operacion)

   DELETE FROM BacSwapSuda.dbo.MOVHISTORICO 
         WHERE numero_operacion = @Operacion
   UPDATE BacSwapSuda.dbo.MOVDIARIO
      SET numero_operacion   = @Operacion
      ,   fecha_cierre       = @dFechaCierre
      ,   estado             = ''
      ,   Estado_oper_lineas = ''
    WHERE numero_operacion   = @Cotizacion

--   ROLLBACK TRANSACTION

-- INSERTA OP EN MOVIMIENTOHISTORICO
INSERT INTO MOVHISTORICO SELECT * FROM MOVDIARIO WHERE numero_operacion = 1181 

-- ELIMINA OP DEL MOVIMIENTO DIARIO
DELETE MOVDIARIO WHERE numero_operacion = @Operacion     
*/
SELECT * FROM MOVDIARIO WHERE numero_operacion = @Operacion     
SELECT * FROM MOVHISTORICO WHERE numero_operacion = @Operacion     

end



GO
