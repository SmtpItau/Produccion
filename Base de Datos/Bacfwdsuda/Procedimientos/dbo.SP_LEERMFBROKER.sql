USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERMFBROKER]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERMFBROKER]
AS
BEGIN
   SET NOCOUNT ON
   SELECT brokrut   ,
          brokdv    ,
   broknombre  
   FROM   MFBROKER
   SET NOCOUNT OFF
END

GO
