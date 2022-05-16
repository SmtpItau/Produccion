USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FRMMANTENEDORSERIES_TRAEDATOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FRMMANTENEDORSERIES_TRAEDATOS]
AS
BEGIN
      SET NOCOUNT ON
      SELECT       letra_serie
                  ,nemotecnico
      
      FROM  LETRA_HIPOTECARIA_SERIE 
      ORDER BY letra_serie
      SET NOCOUNT OFF
END

GO
