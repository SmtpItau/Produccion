USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNT_LISTAINSTRUMENTOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_cnt_listainstrumentos    fecha de la secuencia de comandos: 05/04/2001 13:13:17 ******/
CREATE PROCEDURE [dbo].[SP_CNT_LISTAINSTRUMENTOS] ( 
    @paresid_sistemas char(03) 
    )
as
begin
set nocount on
 declare @varorginstrumentos  char(60)
 declare @vardatainstrumentos char(60)
 if  exists( select * from view_BAC_CNT_PRODUCTOS where id_sistema = @paresid_sistemas )
 begin
  select @varorginstrumentos     = origen_instrumentos , 
      @vardatainstrumentos =  datos_instrumentos
    from view_BAC_CNT_PRODUCTOS 
   where id_sistema = @paresid_sistemas
  execute ( 'select ' + @vardatainstrumentos + ' from ' + @varorginstrumentos  )
 end
 else
 begin
  select 'NO HAY DATOS' 
 end
set nocount off
end


GO
