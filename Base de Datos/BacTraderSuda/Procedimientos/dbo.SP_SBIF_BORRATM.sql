USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_BORRATM]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SBIF_BORRATM]
    (
    @cSistema CHAR (03) ,
    @dFecha  DATETIME
    )
AS
BEGIN
 SET NOCOUNT OFF
 DECLARE @nRutcart NUMERIC (09)
 SELECT @nRutcart = acrutprop
 FROM MDAC
 DELETE TASA_MERCADO WHERE id_sistema=@cSistema AND fecha_proceso=@dFecha AND  tmrutcart=@nRutcart
 SET NOCOUNT ON
END


GO
