USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNT_LISTAMONEDAS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_cnt_listamonedas    fecha de la secuencia de comandos: 05/04/2001 13:13:17 ******/
CREATE PROCEDURE [dbo].[SP_CNT_LISTAMONEDAS] --'bcc'
         (@paresid_sistemas char(03))
as
begin
set nocount on
 declare @varorgmonedas  char(60)
 declare @vardatamonedas char(60)
        declare @cond_monedas char(60)
 if  exists( select * from VIEW_PRODUCTO_CNT where id_sistema = @paresid_sistemas )
 begin
            select @varorgmonedas   = origen_monedas , 
        @vardatamonedas  = datos_monedas  ,
                   @cond_monedas    = cond_monedas
              from VIEW_PRODUCTO_CNT 
             where id_sistema = @paresid_sistemas
           
                   
            if rtrim(@vardatamonedas) <> '' 
  execute ( 'select ' + @vardatamonedas + ' from ' + @varorgmonedas + ' where ' + @cond_monedas )
--               execute ( 'select ' + @vardatamonedas + ' from ' + '' + @varorgmonedas + ' where ' + @cond_monedas )
 end
 else
 begin
            select 'NO HAY DATOS' 
 end
                  print @varorgmonedas   
                   print @vardatamonedas  
                   print @cond_monedas  
   select 'OK'
   set nocount off
end


GO
