USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_ALGO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_BUSCA_ALGO]
as 
begin
 select * from VIEW_PAIS
end



GO
