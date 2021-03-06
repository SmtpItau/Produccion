USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MNT_FACTOR_VENCIMIENTI_RESIDUAL]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[MNT_FACTOR_VENCIMIENTI_RESIDUAL]
   (   @Tag       INTEGER
   ,   @Sistema   CHAR(3)         = ''
   ,   @Producto  CHAR(10)        = ''
   ,   @Desde     INTEGER         = 0
   ,   @Hasta     INTEGER         = 0
   ,   @Factor1   NUMERIC(21,4)   = 0.0
   ,   @Factor2   NUMERIC(21,4)   = 0.0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @Tag = 0
   BEGIN
      SELECT Nombre_Sistema , Id_Sistema 
      FROM   SISTEMA_CNT 
      WHERE  id_sistema     IN('BFW','PCS')
      AND    operativo      = 'S' 
      AND    gestion        = 'N'
      ORDER BY nombre_sistema
      RETURN
   END

   IF @Tag = 1
   BEGIN
      SELECT Descripcion , CASE WHEN id_sistema = 'PCS' AND Codigo_Producto = 'ST' THEN 1
                                WHEN id_sistema = 'PCS' AND Codigo_Producto = 'SM' THEN 2
                                WHEN id_sistema = 'PCS' AND Codigo_Producto = 'FR' THEN 3
                                WHEN id_sistema = 'PCS' AND Codigo_Producto = 'SP' THEN 4
                                ELSE Codigo_Producto
                           END
      FROM   PRODUCTO 
      WHERE  id_sistema = @Sistema ORDER BY Descripcion
   END

   IF @Tag = 2
   BEGIN
      SELECT Fvr_PlazoDesde ,  Fvr_PlazoHasta , Fvr_Factor1 , Fvr_Factor2 
      FROM   TBL_FACTOR_VENCIMIENTO_RESIDUAL WITH (NoLock)
      WHERE  Fvr_IdSistema = @Sistema AND Fvr_Producto = @Producto
      RETURN
   END

   IF @Tag = 3
   BEGIN
      DELETE TBL_FACTOR_VENCIMIENTO_RESIDUAL WITH (RowLock)
      WHERE  Fvr_IdSistema = @Sistema AND Fvr_Producto = @Producto
      RETURN
   END
   
   IF @Tag = 4
   BEGIN
      INSERT INTO TBL_FACTOR_VENCIMIENTO_RESIDUAL
      ( Fvr_IdSistema , Fvr_Producto , Fvr_PlazoDesde , Fvr_PlazoHasta , Fvr_Factor1 , Fvr_Factor2 )
      VALUES 
      ( @Sistema      , @Producto    , @Desde         ,  @Hasta        , @Factor1    , @Factor2    )

      RETURN
   END

END

GO
