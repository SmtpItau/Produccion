USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNT_LEERMOVIMIENTOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CNT_LEERMOVIMIENTOS] 
            (@pareid_sistema char(03) )
as
begin
  select 
   distinct mov.tipo_movimiento  ,
   mov.tipo_operacion
  from
                        VIEW_MOVIMIENTO_CNT  mov
  where  
   mov.id_sistema = @pareid_sistema
end
/*
 execute sp_cnt_leermovimientos 'bcc' ,2
        sp_cnt_leermovimientos 'bcc'
*/
select * from                         VIEW_MOVIMIENTO_CNT  


GO
