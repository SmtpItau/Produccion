USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_LIMITES_TASAS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEE_LIMITES_TASAS]
AS
BEGIN
 set nocount on
 if not exists(SELECT  * FROM LIMITES_TASAS) begin
  select 'OK'
  return
 end
 SELECT  * FROM LIMITES_TASAS
 set nocount off
END

GO
