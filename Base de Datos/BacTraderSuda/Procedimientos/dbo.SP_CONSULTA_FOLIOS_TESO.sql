USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_FOLIOS_TESO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONSULTA_FOLIOS_TESO]( @xformapago  numeric(02)  ,
      @xnumerodecomprobantes numeric(19)  )
as
begin
 if (select folio_actual + @xnumerodecomprobantes from BAC_TESORERIA_FOLIOS
      where tipo_documento = @xformapago and
            estado      = 'A'  ) <=
  (select folio_termino from BAC_TESORERIA_FOLIOS
      where tipo_documento = @xformapago and
            estado      = 'A'  )
   begin
  select 'SI'
  return  
 end else begin
  
  if exists(select * from BAC_TESORERIA_FOLIOS where tipo_documento = @xformapago and
            estado         = '') begin
   select 'SI'
   return
  end
 end
select 'NO'
end


GO
