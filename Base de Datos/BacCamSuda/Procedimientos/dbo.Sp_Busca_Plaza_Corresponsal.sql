USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Plaza_Corresponsal]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
create procedure [dbo].[Sp_Busca_Plaza_Corresponsal]  
 ( @nCorresponsal int )  
as  
begin  
  
 declare @nPlaza  varchar(5)  
  set @nPlaza  = 225  
  
 if exists(  select 1 from BacParamSuda.dbo.Feriado where FeAno  = ( select year(acfecproc) from BacTraderSuda.dbo.Mdac with(nolock) )  
               and   FePlaza = @nCorresponsal  
     )  
 begin  
  set @nPlaza  = @nCorresponsal  
 end  
  
 select Plaza = @nPlaza   
  
end  
GO
