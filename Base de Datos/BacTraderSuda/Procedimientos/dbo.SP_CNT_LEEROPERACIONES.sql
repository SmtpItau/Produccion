USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNT_LEEROPERACIONES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CNT_LEEROPERACIONES]
                                    ( @pareid_sistema  char(03),
     @paretipo_movimiento char(03)  )
as
begin
set nocount on
  select 
   mov.tipo_operacion  ,
   mov.glosa_operacion  ,
   mov.control_instrumento  ,
   mov.control_moneda
  from
   VIEW_MOVIMIENTO_CNT  mov
  where  
   mov.id_sistema  = @pareid_sistema
  and mov.tipo_movimiento  = @paretipo_movimiento
 
end


GO
