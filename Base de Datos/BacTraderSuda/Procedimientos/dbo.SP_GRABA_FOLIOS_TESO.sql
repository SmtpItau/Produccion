USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_FOLIOS_TESO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_FOLIOS_TESO]( @xtipooperacion  numeric(02)  ,
     @xcorrelativo  numeric(19)  ,
     @xfolioinicio  numeric(19)  ,
     @xfolioactual  numeric(19)  ,
     @xfoliotermino  numeric(19)  )
as
begin
 if exists(select * from BAC_TESORERIA_FOLIOS where tipo_documento = @xtipooperacion and
          correla_interno= @xcorrelativo    ) begin
  
  update BAC_TESORERIA_FOLIOS set folio_inicio = @xfolioinicio  ,
      folio_actual = @xfolioactual  ,
      folio_termino =  @xfoliotermino 
    where tipo_documento = @xtipooperacion and
                     correla_interno= @xcorrelativo
 end else begin
  insert into BAC_TESORERIA_FOLIOS values( @xtipooperacion   ,
        @xcorrelativo   ,
        @xfolioinicio   ,
        @xfolioactual   ,
        @xfoliotermino   ,
        ''    )
 end
end

GO
