USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDMFLEER]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDMFLEER](
    @ncodmon    NUMERIC(5,0)      -- Código Moneda
    )
AS
BEGIN
SET NOCOUNT ON
 IF @ncodmon=0 --Todas las formas de Pago
  BEGIN
   SELECT  codigo     ,
    glosa      ,
    '1' 
   FROM  VIEW_FORMA_DE_PAGO
  END
 ELSE  -- De Acuerdo a la Moneda
  BEGIN  
   SELECT  codigo     ,
    glosa      ,
    'estado' =  ISNULL( (  SELECT DISTINCT mfestado 
       FROM  VIEW_MONEDA_FORMA_DE_PAGO 
       WHERE   mfcodmon = @ncodmon  AND
        codigo   = mfcodfor   AND
        mfmonpag = @ncodmon  ), '0' )
   FROM  VIEW_FORMA_DE_PAGO
  END
SET NOCOUNT OFF
END

GO
