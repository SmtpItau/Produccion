USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MFBROKERELIMINA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MFBROKERELIMINA]
       ( 
        @nrut NUMERIC ( 9, 0 )
       )
AS
BEGIN   
SET NOCOUNT ON 
   DELETE FROM MFBROKER WHERE brokrut = @nrut
SET NOCOUNT OFF
SELECT 0
END

GO
