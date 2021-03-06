USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_LINEAS_RETENIDAS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_LINEAS_RETENIDAS]
   (   @miTag       INTEGER   
   ,   @miSistema   CHAR(3)    = ''
   ,   @miProdcuto  VARCHAR(5) = ''
   ,   @miMoneda    NUMERIC(3) = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @miTag = 1
   BEGIN
      SELECT nombre_sistema , id_sistema  FROM bacparamsuda..SISTEMA_CNT 
      WHERE operativo = 'S' AND gestion = 'N' ORDER BY nombre_sistema
   END
   IF @miTag = 2
   BEGIN
      SELECT descripcion , codigo_producto 
      FROM   bacparamsuda..PRODUCTO   
      WHERE (id_sistema = @miSistema or @miSistema = '') 
         UNION
      SELECT 'VENCIMIENTOS [Cupon/Instrumento]' , 'VC'
      ORDER BY descripcion
   END
   IF @miTag = 3
   BEGIN
      SELECT mncodmon    as CodigoMoneda
      ,      mnnemo      as NemoMoneda 
      ,      mnglosa     as GlosaMoneda
      ,      mntipmon    as TipoMoneda
      FROM   bacparamsuda..MONEDA
      WHERE  mntipmon in(2,3)
      ORDER BY mncodmon
   END
   IF @miTag = 4
   BEGIN
      /*
      SELECT codigo      as CodigoFormaPago 
      ,      glosa       as FormadePago
      FROM   bacparamsuda..MONEDA_FORMA_DE_PAGO
                         INNER JOIN bacparamsuda..FORMA_DE_PAGO ON mfcodfor = codigo
      WHERE (mfcodmon  = @miMoneda OR @miMoneda = 0)
      */
      SELECT codigo      as CodigoFormaPago 
      ,      glosa       as FormadePago
      FROM   bacparamsuda..FORMA_DE_PAGO 
      ORDER BY glosa
   END
      
END

GO
