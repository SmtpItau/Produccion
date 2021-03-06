USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIBERA_LINEAS_RETENIDAS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_LIBERA_LINEAS_RETENIDAS]
   (   @id_Sistema        CHAR(3)
   ,   @codigo_Producto   VARCHAR(5)
   ,   @numero_Operacion  NUMERIC(9)
   ,   @iiMonto           NUMERIC(21,4)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFecha   DATETIME
   SELECT  @dFecha = acfecproc
   FROM    bactradersuda..MDAC

   declare @iFound   INTEGER

   select  @iFound           = -1
   select  @iFound           = 0
   from    lineas_retenidas
   where   id_sistema        = @id_Sistema
   and     numero_operacion  = @numero_Operacion
-- and     fecha_pago        = @dFecha
   and     estado_liberacion = 'N'

   if @iFound = 0
   begin
      EXECUTE Sp_Lineas_Anula @dFecha , @id_Sistema , @numero_Operacion

      update  lineas_retenidas 
      set     estado_liberacion = 'S'
      where   id_sistema        = @id_Sistema
      and     numero_operacion  = @numero_Operacion
--    and     fecha_pago        = @dFecha
      and     estado_liberacion = 'N'
   end

   RETURN
END
GO
