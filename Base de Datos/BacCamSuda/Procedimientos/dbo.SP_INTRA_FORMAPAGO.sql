USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTRA_FORMAPAGO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[SP_INTRA_FORMAPAGO]
as 
begin
   
      select  codigo
             ,glosa
             ,perfil
             ,glosa2
             ,diasvalor
       from 
             VIEW_FORMA_DE_PAGO  
       order by perfil
end 



GO
