USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProdxCamposLogicos_LeeCampos]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_ProdxCamposLogicos_LeeCampos] 
            (
                  @codigo_campo      NUMERIC(3) = 0
            ,     @codigo_condicion  VARCHAR(15) = ' '
            )
AS
BEGIN

	SET DATEFORMAT dmy
	SET NOCOUNT ON

            SELECT CODIGO
		,DESCRIPCION
            FROM   CAMPO_CNT_CABECERA
            WHERE  CODIGO IN(60)

            ORDER BY
                   CODIGO
            

      SET NOCOUNT OFF

END









GO
