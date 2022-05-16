USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_ENTIDADES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEER_ENTIDADES]
AS
BEGIN
   SET NOCOUNT ON 
   SELECT rcnombre,
          rccodcar,
          clrut
   FROM   VIEW_ENTIDAD,
          VIEW_CLIENTE 
   WHERE  rcrut = clrut 
   ORDER BY rcnombre
   SET NOCOUNT OFF
END



GO
