USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERENTIDAD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERENTIDAD]
AS
BEGIN
   SET NOCOUNT ON
   SELECT rcnombre, rccodcar FROM VIEW_ENTIDAD ORDER BY rcnombre
   SET NOCOUNT OFF
END

GO
