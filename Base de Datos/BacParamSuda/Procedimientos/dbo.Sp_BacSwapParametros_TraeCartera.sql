USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacSwapParametros_TraeCartera]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_BacSwapParametros_TraeCartera]
AS
BEGIN
   SET NOCOUNT ON
   
   SELECT TOP 1
          rcrut       
        , rcdv 
        , rcnombre                                           
     FROM ENTIDAD with (nolock)

END
GO
