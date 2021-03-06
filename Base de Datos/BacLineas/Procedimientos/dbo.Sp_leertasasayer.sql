USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_leertasasayer]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_leertasasayer] ( @ncodigo NUMERIC ( 05, 00 ),
                                    @nplazo  NUMERIC ( 05, 00 )
                                  )
AS
BEGIN
   SET NOCOUNT ON
   SELECT tasa_compra ,
          tasa_venta  ,
          tasa_nominal
   FROM   tasa_fwd,
          view_mfac
   WHERE  codigo = @ncodigo  AND
          plazo  = @nplazo   AND
          fecha  = acfecante
   SET NOCOUNT OFF
END






GO
