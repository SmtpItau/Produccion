USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHEQUEA_TRASPASOS]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CHEQUEA_TRASPASOS]
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


      IF NOT EXISTS(SELECT NumeroTraspaso FROM LINEA_TRASPASO) BEGIN
            SELECT 'NO'
            RETURN
      END

      IF EXISTS(SELECT NumeroTraspaso FROM LINEA_TRASPASO WHERE NumeroOperacion = 0 /*OR NumeroDocumento = 0 OR NumeroCorrelativo = 0*/)
            SELECT 'NO'
      ELSE
            SELECT 'SI'



END
GO
