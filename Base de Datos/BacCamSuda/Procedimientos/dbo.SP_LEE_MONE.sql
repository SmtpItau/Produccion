USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_MONE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_LEE_MONE]
as 
begin
set nocount on
 select dolar, pesos from MEAC
end



GO
