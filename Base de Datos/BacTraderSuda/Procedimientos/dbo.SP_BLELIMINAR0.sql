USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLELIMINAR0]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BLELIMINAR0] (@rutcart1 NUMERIC(09,0), 
                            @numdocu1 NUMERIC(10,0),
                            @correla1 NUMERIC(03,0))
AS
BEGIN 
 DELETE FROM MDBL
               WHERE blrutcart = @rutcart1 AND blnumdocu = @numdocu1 AND blcorrela = @correla1
END


GO
