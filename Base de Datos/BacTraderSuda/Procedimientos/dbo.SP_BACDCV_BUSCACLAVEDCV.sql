USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACDCV_BUSCACLAVEDCV]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BACDCV_BUSCACLAVEDCV]
AS
BEGIN
      SET NOCOUNT ON
      SELECT monumdocu,mocorrela,moclave_dcv FROM MDMO 
      SET NOCOUNT OFF
END


GO
