USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AYUDA_DISCREPANCIAS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_AYUDA_DISCREPANCIAS]
   (   @iCodigo   NUMERIC(9) = 0  )
AS
BEGIN

   SELECT codigo , Descripcion 
   FROM   bacparamsuda..DISCREPANCIAS 
   WHERE (Codigo = @iCodigo or @iCodigo = 0)

END

GO
