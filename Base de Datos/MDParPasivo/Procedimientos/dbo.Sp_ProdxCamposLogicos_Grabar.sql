USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProdxCamposLogicos_Grabar]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_ProdxCamposLogicos_Grabar]
      (      @codigo_campo      NUMERIC(3)
      ,      @codigo_condicion  VARCHAR(15)
      ,      @productos         CHAR(200)
      )

AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

      UPDATE   CAMPO_LOGICO
      SET      productos = @productos
      WHERE    codigo_campo       = @codigo_campo
      AND      codigo_condicion   = @codigo_condicion

      SET NOCOUNT OFF

END








GO
