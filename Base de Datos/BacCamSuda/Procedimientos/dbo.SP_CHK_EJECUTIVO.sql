USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHK_EJECUTIVO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CHK_EJECUTIVO]
       (
        @nCodigo  NUMERIC(10)=0
       )
AS
BEGIN
   SELECT codigo, nombre, sucursal, Monto_Linea FROM view_ejecutivo WHERE codigo = @nCodigo OR @ncodigo = 0
END



GO
