USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_OPTHRESHOLD_RESPALDO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_OPTHRESHOLD_RESPALDO]
   (   @FechaProc          CHAR(8)
   ,   @Sistema            CHAR(3)
   ,   @Producto	   VARCHAR(5)
   ,   @Numero_Operacion   NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON
   
   --- Variables para almacenar valores de respaldo en histórico	
   DECLARE @xSistema		CHAR(3)
   DECLARE @xProducto		VARCHAR(5)
   DECLARE @xRut_Cliente	NUMERIC(9)
   DECLARE @xCod_Cliente	INTEGER
   DECLARE @xNumero_Operacion   NUMERIC(9)
   DECLARE @xThrPropuesto	FLOAT
   DECLARE @xThrAplicado	FLOAT
   DECLARE @xRec		FLOAT

   IF EXISTS(SELECT 1 FROM BacParamsuda.dbo.TBL_THRESHOLD_OPERACION WHERE Sistema          = @Sistema 
                                                                      AND Producto         = @Producto
                                                                      AND Numero_Operacion = @Numero_Operacion)
   BEGIN
	--- Guardar variables para histórico
      SELECT @xSistema 		   = Sistema
         ,   @xProducto 	   = Producto
         ,   @xRut_Cliente	   = Rut_Cliente         ,   @xCod_Cliente	   = Cod_Cliente
         ,   @xNumero_Operacion	   = Numero_Operacion
         ,   @xThrPropuesto	   = Threshold_Propuesto
         ,   @xThrAplicado	   = Threshold_Aplicado
         ,   @xRec		   = Rec
      FROM   BacParamsuda.dbo.TBL_THRESHOLD_OPERACION 
      WHERE  Sistema               = @Sistema
      AND    Producto              = @Producto
      AND    Numero_Operacion      = @Numero_Operacion

      DELETE FROM BacParamsuda.dbo.TBL_THRESHOLD_OPERACION 
            WHERE Sistema          = @Sistema
              AND Producto         = @Producto
              AND Numero_Operacion = @Numero_Operacion

      IF @@Error <> 0
      BEGIN
         SELECT -1, 'Error al eliminar operación Threshold'
         RETURN
      END

      -- Guardar las variables en archivo histórico
      INSERT INTO TBL_THRESHOLD_OPERACION_HISTORICO
      (   Fecha
      ,   Sistema
      ,   Producto
      ,   Rut_Cliente
      ,   Cod_Cliente
      ,   Numero_Operacion
      ,   Threshold_Propuesto
      ,   Threshold_Aplicado
      ,   Rec
      )   
      VALUES
      (   @FechaProc
      ,   @xSistema
      ,   @xProducto
      ,   @xRut_Cliente
      ,   @xCod_Cliente
      ,   @xNumero_Operacion
      ,   @xThrPropuesto
      ,   @xThrAplicado
      ,   @xRec
      )

      SELECT 0, 'OK'
      RETURN

   END ELSE
   BEGIN
      SELECT 1,'No hay datos para eliminar'
      RETURN
   END

END
GO
