USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_CONVENCION_AJUSTE_INTERES]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_CONVENCION_AJUSTE_INTERES]
   (   @cEvento          VARCHAR(3)
   ,   @iTipo_Tasa	 INTEGER        = 0
   ,   @cNombre_Tipo	 VARCHAR(20)    = ''
   ,   @iBase	         INTEGER        = 0
   ,   @nAjuste_Pasivo   NUMERIC(21,4)  = 0.0
   ,   @nAjuste_Activo   NUMERIC(21,4)  = 0.0
   ,   @cGlosa_Base	 VARCHAR(20)    = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @cEvento = 'CBC'
   BEGIN
      SELECT Codigo , Glosa FROM BacSwapSuda..BASE
      RETURN
   END

   IF @cEvento = 'CTT'
   BEGIN
      SELECT DISTINCT Tipo_Tasa , Nombre_Tipo FROM CONVENCION_AJUSTE_INTERES
      RETURN
   END

   IF @cEvento = 'CON'
   BEGIN
      SELECT c.Base
      ,      b.glosa
      ,      c.Ajuste_Pasivo
      ,      c.Ajuste_Activo
      FROM   CONVENCION_AJUSTE_INTERES c
             LEFT JOIN BASE b ON b.codigo = c.Base
      WHERE  Tipo_Tasa = @iTipo_Tasa
      RETURN
   END

   IF @cEvento = 'DEL'
   BEGIN
      DELETE CONVENCION_AJUSTE_INTERES WHERE Tipo_Tasa = @iTipo_Tasa
      RETURN
   END

   IF @cEvento = 'GRB'
   BEGIN
      IF EXISTS(SELECT 1 FROM CONVENCION_AJUSTE_INTERES WHERE Tipo_Tasa = @iTipo_Tasa AND Base = @iBase)
      BEGIN
         UPDATE CONVENCION_AJUSTE_INTERES 
         SET    Ajuste_Pasivo = @nAjuste_Pasivo
         ,      Ajuste_Activo = @nAjuste_Activo
         WHERE  Tipo_Tasa     = @iTipo_Tasa 
         AND    Base          = @iBase
      END ELSE
      BEGIN
         INSERT INTO CONVENCION_AJUSTE_INTERES
         SELECT @iTipo_Tasa
         ,      @cNombre_Tipo
         ,      @iBase
         ,      @nAjuste_Pasivo
         ,      @nAjuste_Activo
         ,      @cGlosa_Base
      END
      RETURN
   END

END

GO
