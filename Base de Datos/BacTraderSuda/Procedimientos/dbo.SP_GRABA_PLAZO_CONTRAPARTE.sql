USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PLAZO_CONTRAPARTE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_PLAZO_CONTRAPARTE]( @xrutcliente  numeric(09) ,
      @xcodigocliente  numeric(09) ,
      @xtipooperacion  char(1)  ,
      @xplazodesde  numeric(19) ,
      @xplazohasta  numeric(19) ,
      @xmonto   numeric(19,4) )
as
begin
 insert into MD_CONTRAPARTE values( @xrutcliente  ,
      @xcodigocliente  ,
      @xtipooperacion  ,
      @xplazodesde  ,
      @xplazohasta  ,
      @xmonto   )
end
--select * from md_contraparte


GO
