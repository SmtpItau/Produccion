USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHKOPER_TESORERIA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CHKOPER_TESORERIA]
               (@sistema  char(03) ,
  @entidad  numeric(09,00) ,
  @numoper  numeric(09,00) )
as
begin
 declare @estado char(01)
 select 
  @estado = cerrada 
 from  
  GEN_OPERACIONES
 where
  id_sistema  = @sistema
 and entidad  = @entidad
 and operacion = @numoper
 select @estado    /* n significa que se puede anular */
end


GO
