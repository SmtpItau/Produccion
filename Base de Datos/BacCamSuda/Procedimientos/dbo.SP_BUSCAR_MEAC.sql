USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_MEAC]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_BUSCAR_MEAC]
AS
BEGIN
   SELECT acrut, acdv, accodigo, acnombre FROM meac
END



GO
