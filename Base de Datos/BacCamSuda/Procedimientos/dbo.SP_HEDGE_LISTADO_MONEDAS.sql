USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_LISTADO_MONEDAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_LISTADO_MONEDAS]
AS BEGIN
   SET NOCOUNT ON
      SELECT mncodmon,mnnemo FROM bacparamsuda.dbo.moneda WITH(NOLOCK) where mnmx='C' or mncodmon='999' order by mnnemo
   SET NOCOUNT OFF
END

GO
