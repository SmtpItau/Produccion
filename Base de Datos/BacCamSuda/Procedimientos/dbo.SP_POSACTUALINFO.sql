USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_POSACTUALINFO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_POSACTUALINFO]
AS
BEGIN
   DECLARE @totalpos    NUMERIC(12,2)
   DECLARE @Resul_Div   NUMERIC(12,2)
  SELECT      info_pmeco,
              info_pmeve,
              info_pmerc,
              info_totco,
              info_totve,
              info_posic,
              info_utili
         FROM meac
   SET NOCOUNT OFF
END



GO
