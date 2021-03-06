USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_PERIODICIDAD_TASAS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_PERIODICIDAD_TASAS]
   (   @iEvento        CHAR(3)
   ,   @iTipoTasa      INTEGER        = -1
   ,   @cNombreTipo    VARCHAR(20)    = ''
   ,   @iDesde         INTEGER        = 0
   ,   @iHasta         INTEGER        = 0
   ,   @nAjustePasivo  NUMERIC(21,4)  = 0.0
   ,   @nAjusteActivo  NUMERIC(21,4)  = 0.0
   ,   @cGlosa         VARCHAR(100)   = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iEvento = 'CTT'
   BEGIN
      SELECT DISTINCT Tipo_Tasa , Nombre_Tipo FROM PERIODICIDAD_TASAS
      RETURN
   END

   IF @iEvento = 'CON'
   BEGIN
      SELECT Tipo_Tasa
      ,      Nombre_Tipo
      ,      Desde
      ,      Hasta
      ,      Ajuste_Pasivo
      ,      Ajuste_Activo
      ,      Glosa
      FROM   PERIODICIDAD_TASAS
      WHERE  (Tipo_Tasa = @iTipoTasa OR @iTipoTasa = -1)
      RETURN
   END

   IF @iEvento = 'DEL'
   BEGIN
      DELETE PERIODICIDAD_TASAS WHERE Tipo_Tasa = @iTipoTasa
   END

   IF @iEvento = 'GRB'
   BEGIN
      IF EXISTS(SELECT 1 FROM PERIODICIDAD_TASAS WHERE Tipo_Tasa = @iTipoTasa AND Desde = @iDesde AND Hasta = @iHasta)
      BEGIN
         UPDATE PERIODICIDAD_TASAS
         SET    Nombre_Tipo   = @cNombreTipo
         ,      Desde         = @nAjustePasivo
         ,      Hasta         = @nAjusteActivo
         ,      Glosa         = @cGlosa
         WHERE  Tipo_Tasa     = @iTipoTasa
         AND    Desde         = @iDesde
         AND    Hasta         = @iHasta
      END ELSE
      BEGIN
         INSERT INTO PERIODICIDAD_TASAS 
         SELECT @iTipoTasa
         ,      @cNombreTipo
         ,      @iDesde
         ,      @iHasta
         ,      @nAjustePasivo
         ,      @nAjusteActivo
         ,      @cGlosa
      END
   END

END

GO
