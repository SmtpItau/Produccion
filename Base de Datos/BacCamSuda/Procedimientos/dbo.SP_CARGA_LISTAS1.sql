USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_LISTAS1]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_CARGA_LISTAS1]
  ( @cod numeric(2) )
as 
begin
 select
   codigo_tabla
  ,codigo_numerico
  ,codigo_caracter
  ,glosa
   from    
  VIEW_AYUDA_PLANILLA 
  where 
  codigo_tabla = @cod
end



GO
