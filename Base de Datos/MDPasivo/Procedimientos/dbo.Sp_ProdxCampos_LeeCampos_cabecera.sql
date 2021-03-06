USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProdxCampos_LeeCampos_cabecera]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ProdxCampos_LeeCampos_cabecera](
                  @codigo_campo      NUMERIC(3) = 0
            )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

SELECT 
           codigo
    ,      descripcion
    FROM   CAMPO_CNT_CABECERA

    WHERE  (codigo = 0 OR 0 = 0)


    ORDER BY
           codigo            

      SET NOCOUNT OFF

END


GO
