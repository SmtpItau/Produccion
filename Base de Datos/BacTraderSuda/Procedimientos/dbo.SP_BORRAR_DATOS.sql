USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_DATOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BORRAR_DATOS]
  (@numope numeric(10),
   @documentomonto numeric(9))
as 
begin
 
 delete VALE_VISTA_EMITIDO
 where  numero_operacion=@numope
 and documento_monto=@documentomonto
end


GO
