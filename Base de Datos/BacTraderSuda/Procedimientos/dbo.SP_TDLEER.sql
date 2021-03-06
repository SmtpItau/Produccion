USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TDLEER]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_TDLEER]
            (@tdmascara1 CHAR(10))
AS
BEGIN
set nocount on
  
        SELECT   tdmascara, tdcupon, CONVERT(CHAR(10),tdfecven,103), 
                tdinteres, tdamort, tdflujo, tdsaldo 
       FROM     VIEW_TABLA_DESARROLLO  
       WHERE    tdmascara = @tdmascara1  
       ORDER BY tdcupon
RETURN
set nocount off
END

GO
