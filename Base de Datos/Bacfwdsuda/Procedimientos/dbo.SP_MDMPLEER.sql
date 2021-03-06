USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDMPLEER]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDMPLEER]
   (   @ncodprod    NUMERIC(5,0)   )
AS
BEGIN

   SET NOCOUNT OFF

   SELECT mncodmon             as CodigoMoneda
   ,      mnglosa              as GlosaMoneda
   ,      ISNULL(mpestado,'0') as Estado
   FROM   VIEW_MONEDA          LEFT JOIN VIEW_PRODUCTO_MONEDA on mpSistema = 'BFW' AND mpproducto = @ncodprod AND mncodmon =  mpcodigo
   WHERE  mnrefmerc            <> '1'

END

GO
