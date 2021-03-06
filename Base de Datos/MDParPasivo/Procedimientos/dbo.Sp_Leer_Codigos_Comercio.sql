USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Codigos_Comercio]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Leer_Codigos_Comercio]
       (
            @Comercio CHAR(6)
      )
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

    SELECT  
            comercio
    ,       glosa
    ,       tipo_documento
    ,       codigo_oma
    ,       tipo_registro
    ,       codigo_validacion
    ,      'FECHA'   =   SPACE(10)
    FROM    CODIGO_COMERCIO
    WHERE   ( @Comercio = ' ' OR @Comercio = comercio )

    ORDER BY comercio

SET NOCOUNT OFF
END

GO
