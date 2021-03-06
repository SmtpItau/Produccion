USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERTASASAYER]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERTASASAYER] ( @ncodigo NUMERIC ( 05, 00 ),
                                    @nplazo  NUMERIC ( 05, 00 )
                                  )
AS
BEGIN
   SET NOCOUNT ON
   SELECT tasa_compra ,
          tasa_venta  ,
          tasa_nominal
   FROM   view_tasa_fwd,
          mfac
   WHERE  codigo = @ncodigo  AND
          plazo  = @nplazo   AND
          fecha  = acfecante
   SET NOCOUNT OFF
END

GO
