USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_PERFIL_BUSCA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEER_PERFIL_BUSCA]
                  ( @varsistema char(03) , 
   @varmovimiento  char(03) ,
   @vartipoper     char(05) ,
   @varinstr char(06) ,
   @varmoneda char(03) )
as
begin
 select 
  folio_perfil 
 from  
  VIEW_PERFIL_CNT
 where
  id_sistema   = @varsistema
 and tipo_movimiento  = @varmovimiento 
 and tipo_operacion   = @vartipoper
 and codigo_instrumento  = @varinstr
 and moneda_instrumento  = @varmoneda
end


GO
