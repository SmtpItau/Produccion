USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_PLAZO_CONTRAPARTE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_PLAZO_CONTRAPARTE]( @xrutcliente  numeric(10)  ,
      @xtipooperacion  char(1)   )
as
begin
 select  rut   ,
  plazo_desde  ,
  plazo_hasta  ,
  monto   
  from MD_CONTRAPARTE
  where  rut = @xrutcliente and
   PRODUCTO=@xtipooperacion
   order by plazo_desde
end


GO
