USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_STDCHARTERED_SET_CODOPMEMO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_STDCHARTERED_SET_CODOPMEMO](@SourceReference VARCHAR(20),@CodOpeMemo AS NUMERIC(15))
AS BEGIN

    UPDATE tbl_StdChartered_Spot_Fwd
    SET NumOpeMemo =  @CodOpeMemo
    WHERE SourceReference = @SourceReference
END




GO
