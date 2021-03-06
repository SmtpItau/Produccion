USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MONEDA_DOC_PAGO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MONEDA_DOC_PAGO]
   (   @iSistema      CHAR(3)
   ,   @iMoneda       INTEGER = 0
   ,   @iMonPago      INTEGER = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iMonPago = 0
   BEGIN
      SELECT mon.mncodmon    as Codigo_Moneda         --> mfcodmon (1)
      ,      mnPag.mncodmon  as Codigo_MonedaPago     
      ,      mnPag.mnglosa   as Glosa_MonedaPago      --> mfmonpag (2)
      ,      fpag.codigo     as Codigo_FPago          --> mfcodfor (4)
      ,      fpag.glosa      as Glosa_FPago           --> glosa    (5)
      ,      mon.mnglosa     as Glosa_Moneda          --> mnglosa  (3)
      ,      mon.mnnemo      as Nemo_Moneda           
      ,      mnPag.mnnemo    as Nemo_MonedaPago
      ,      fpag.glosa2     as Perfil_FPago
      FROM   bacparamsuda..MONEDA_FORMA_DE_PAGO mfpag 
                                                      RIGHT JOIN bacparamsuda..FORMA_DE_PAGO fpag  ON mfpag.mfcodfor = fpag.codigo
                                                      RIGHT JOIN bacparamsuda..MONEDA        mon   ON mfpag.mfcodmon = mon.mncodmon
                                                      RIGHT JOIN bacparamsuda..MONEDA        mnPag ON mfpag.mfmonpag = mnPag.mncodmon
      WHERE mfpag.mfsistema = @iSistema
      AND   mfpag.mfestado  = 1
      AND  (mfpag.mfcodmon  = @iMoneda  OR @iMoneda  = 0)
      ORDER BY fpag.glosa , mfpag.mfcodmon , mfpag.mfmonpag , mfpag.mfcodfor
   END 

   IF @iMonPago = 1
   BEGIN
      SELECT DISTINCT mnPag.mncodmon  as Codigo_MonedaPago     
      ,               mnPag.mnglosa   as Glosa_MonedaPago      --> mfmonpag (2)
      ,               mnPag.mnnemo    as Nemo_MonedaPago
      FROM   bacparamsuda..MONEDA_FORMA_DE_PAGO mfpag 
                                                      RIGHT JOIN bacparamsuda..FORMA_DE_PAGO fpag  ON mfpag.mfcodfor = fpag.codigo
                                                      RIGHT JOIN bacparamsuda..MONEDA        mon   ON mfpag.mfcodmon = mon.mncodmon
                                                      RIGHT JOIN bacparamsuda..MONEDA        mnPag ON mfpag.mfmonpag = mnPag.mncodmon
      WHERE mfpag.mfsistema = @iSistema
      AND   mfpag.mfestado  = 1
      AND  (mfpag.mfcodmon  = @iMoneda  OR @iMoneda  = 0)
      ORDER BY mnPag.mnglosa
   END
   IF @iMonPago = 2
   BEGIN
      SELECT DISTINCT fpag.codigo     as Codigo_FPago          --> mfcodfor (4)
      ,               fpag.glosa      as Glosa_FPago           --> glosa    (5)
      ,               fpag.glosa2     as Perfil_FPago
      FROM   bacparamsuda..MONEDA_FORMA_DE_PAGO mfpag 
                                                      RIGHT JOIN bacparamsuda..FORMA_DE_PAGO fpag  ON mfpag.mfcodfor = fpag.codigo
                                                      RIGHT JOIN bacparamsuda..MONEDA        mon   ON mfpag.mfcodmon = mon.mncodmon
                                                      RIGHT JOIN bacparamsuda..MONEDA        mnPag ON mfpag.mfmonpag = mnPag.mncodmon
      WHERE mfpag.mfsistema = @iSistema
      AND   mfpag.mfestado  = 1
      AND  (mfpag.mfcodmon  = @iMoneda  OR @iMoneda  = 0)
      ORDER BY fpag.glosa
   END

END
GO
