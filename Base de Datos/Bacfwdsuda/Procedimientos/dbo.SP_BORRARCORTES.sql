USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRARCORTES]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BORRARCORTES] ( @nnumope NUMERIC ( 10, 0 ) )
AS
BEGIN
   DELETE cortes
   WHERE  cornumoper = @nnumope
END

GO
