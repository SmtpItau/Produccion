USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRANSFERENCIA_CARGA_APODERADO]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[SP_TRANSFERENCIA_CARGA_APODERADO]
as 
begin
   set nocount on
   select 
      apnombre
      ,aprutapo
   from 
       MEAC                     ,
       VIEW_CLIENTE_APODERADO       
   where 
       aprutcli  = acrut
   set nocount off 
end 



GO
