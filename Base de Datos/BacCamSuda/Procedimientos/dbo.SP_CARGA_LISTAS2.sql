USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_LISTAS2]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_CARGA_LISTAS2]
as
begin
 select   0
  ,codigo
  ,glosa2
  ,glosa 
 from  VIEW_FORMA_DE_PAGO
 order by glosa
end



GO
