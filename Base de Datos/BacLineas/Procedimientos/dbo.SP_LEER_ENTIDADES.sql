USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_ENTIDADES]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create Procedure [dbo].[SP_LEER_ENTIDADES]
as
begin
   Select rcnombre,rcrut 
     from ENTIDAD 
 order by rcnombre
end
GO
