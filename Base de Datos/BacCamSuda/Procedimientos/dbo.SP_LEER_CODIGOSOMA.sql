USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CODIGOSOMA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEER_CODIGOSOMA]
       (
        @CodigoOMA     INTEGER = 0,
        @TipoDocumento INTEGER = 0
       )
AS
BEGIN
     SET NOCOUNT ON
     SELECT 'CodigoOMA'     = codigo_numerico,
            'Glosa'         = glosa,
            'TipoDocumento' = codigo_caracter
       FROM view_tbcodigooma
      WHERE (codigo_numerico = @CodigoOMA  OR @CodigoOMA     = 0)
        AND (CONVERT(INTEGER,SUBSTRING(codigo_caracter,1,1))= @TipoDocumento OR @TipoDocumento = 0)
END



GO
