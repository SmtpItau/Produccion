USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_CLIENTES1]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_CARGA_CLIENTES1]
 (
  @rut numeric(9),
  @cod numeric(9)
 )
as
begin
 select  clrut
         ,cldv
  ,clcodigo
  ,clnombre
  ,cldirecc
  ,b.tbglosa
  ,b.tbcodigo1
  ,c.tbglosa
  ,c.tbcodigo1
 from   VIEW_CLIENTE
  ,VIEW_TABLA_GENERAL_DETALLE b
  ,VIEW_TABLA_GENERAL_DETALLE c 
 where (b.tbcateg=3 or  c.tbcateg=180) 
 and clrut     = @rut 
 and clcodigo     = @cod
 and convert(varchar(10),clciudad)  = convert(varchar(10),b.tbcodigo1)
 and convert(varchar(10),clpais)    = convert(varchar(10),c.tbcodigo1)
end



GO
