USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Pais_Moneda]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Busca_Pais_Moneda]
      (         @moneda   VARCHAR(5)
      )
AS
BEGIN
   SET NOCOUNT ON
   SET DATEFORMAT dmy


      SELECT codigo_pais FROM MONEDA WHERE mnnemo = @moneda AND ESTADO<>'A'

   SET NOCOUNT OFF
END


GO
