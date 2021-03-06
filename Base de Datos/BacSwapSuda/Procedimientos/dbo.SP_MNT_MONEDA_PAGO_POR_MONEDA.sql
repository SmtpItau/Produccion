USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_MONEDA_PAGO_POR_MONEDA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_MONEDA_PAGO_POR_MONEDA]
   (   @cTag               CHAR(1)
   ,   @id_sistema         CHAR(3)    = ''
   ,   @iMonedaOperacion   NUMERIC(9) = 0
   ,   @iMonedaPago        NUMERIC(9) = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @cTag = 'C' --> Consulta
   BEGIN
      SELECT DISTINCT id_Sistema , Moneda_Operacion , op.mnglosa as MonedaOp, Moneda_Pago , pa.mnglosa as MonedaPag
      FROM   bacswapsuda..MONEDA_PAGO 
                                 LEFT JOIN bacparamsuda..MONEDA op ON op.mncodmon = Moneda_Operacion
                                 LEFT JOIN bacparamsuda..MONEDA pa ON pa.mncodmon = Moneda_Pago
      WHERE  id_sistema       = @id_sistema 
      AND   (Moneda_Operacion = @iMonedaOperacion)

      RETURN
   END

   IF @cTag = 'E' --> Eliminar
   BEGIN
      DELETE bacswapsuda..MONEDA_PAGO
      WHERE  id_sistema       = @id_sistema
      AND    moneda_operacion = @iMonedaOperacion

      RETURN
   END

   IF @cTag = 'G' --> Grabar
   BEGIN
      INSERT INTO bacswapsuda..MONEDA_PAGO
      SELECT @id_sistema
      ,      @iMonedaOperacion
      ,      @iMonedaPago

      RETURN      
   END
   IF @cTag = 'M' --> Grabar
   BEGIN
      SELECT mncodmon    as CodigoMoneda
      ,      mnnemo      as NemoMoneda 
      ,      mnglosa     as GlosaMoneda
      ,      mntipmon    AS TipoMoneda
      FROM   bacparamsuda..MONEDA
      WHERE  mntipmon in(2,3)
      AND   (mncodmon = @iMonedaOperacion or @iMonedaOperacion = 0)
      ORDER BY mncodmon
   END
   IF @cTag = 'S' --> Grabar
   BEGIN
      SELECT id_sistema , nombre_sistema
      FROM   bacparamsuda..SISTEMA_CNT
      WHERE  operativo = 'S'
      AND    gestion   = 'N'
      ORDER BY nombre_sistema
   END


END

GO
