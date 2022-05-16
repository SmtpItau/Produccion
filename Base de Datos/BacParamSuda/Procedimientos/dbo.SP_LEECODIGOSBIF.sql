USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEECODIGOSBIF]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEECODIGOSBIF]
                (  
                  @nemo     char(3)
                )
AS
BEGIN
   SET NOCOUNT ON
   SELECT mncodmon FROM MONEDA
    WHERE mnnemo = @nemo 
   
   SET NOCOUNT OFF
END

GO
