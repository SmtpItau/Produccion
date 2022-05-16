USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LEE_LIMITES_TASAS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_LEE_LIMITES_TASAS]
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
