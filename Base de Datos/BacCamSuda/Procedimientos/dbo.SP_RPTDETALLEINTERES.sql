USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RPTDETALLEINTERES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RPTDETALLEINTERES]
AS
BEGIN
  select * from RPTDETALLEINTERESES
end 



GO
