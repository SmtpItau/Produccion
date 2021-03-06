USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_TASAS_MONEDA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_TASAS_MONEDA]
(   @iMiTag   INTEGER
,   @Moneda   NUMERIC(5) = 0
,   @Tasa     NUMERIC(5) = 0
)
AS
BEGIN

   SET NOCOUNT ON 

   IF @iMiTag = 0 --> Retorna Monedas para el Mantenedor
   BEGIN
      SELECT mncodmon    as CodigoMoneda
      ,      mnnemo      as NemoMoneda 
      ,      mnglosa     as GlosaMoneda
      ,      mntipmon    AS TipoMoneda
      FROM   bacparamsuda..MONEDA
      WHERE  mntipmon in(2,3)
      AND   (mncodmon = @Moneda or @Moneda = 0)
      ORDER BY mncodmon

      RETURN
   END

   IF @iMiTag = 1 --> Retorna Tasa para el Mantenedor
   BEGIN
      SELECT tbcodigo1                                  as CodigoTasa
      ,      convert(varchar(20),ltrim(rtrim(tbglosa))) as Glosatasa 
      ,      tbtasa                                     as PeriodoTasa 
      FROM   TABLA_GENERAL_DETALLE 
      WHERE  tbcateg   = 1042
      AND   (tbcodigo1 = @Tasa or @Tasa = 0)

      RETURN
   END

   IF @iMiTag = 2 --> Elimina Tasas por moneda
   BEGIN
      DELETE TASAS_MONEDA 
      WHERE (codigo_Moneda = @Moneda)
      AND   (codigo_Tasa   = @Tasa or @Tasa = 0)

      RETURN
   END

   IF @iMiTag = 3 --> Inserta Tasas por moneda
   BEGIN
      INSERT INTO TASAS_MONEDA  
      SELECT @Moneda , @Tasa

      RETURN
   END
   
   IF @iMiTag = 4 --> Consulta Tasas por moneda
   BEGIN
      SELECT Codigo_Moneda
      ,      mnglosa
      ,      Codigo_Tasa
      ,      tbglosa
      FROM   TASAS_MONEDA   RIGHT JOIN TABLA_GENERAL_DETALLE ON tbcateg  = 1042 and Codigo_Tasa = tbcodigo1
                            RIGHT JOIN MONEDA                ON mncodmon = Codigo_Moneda
      WHERE  Codigo_Moneda = @Moneda
      AND   (Codigo_Tasa   = @Tasa or @Tasa = 0)

      RETURN
   END

END



GO
