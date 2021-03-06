USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_TASAS_FORWARD]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_TASAS_FORWARD]( @plazo_ini  numeric(10) ,
      @plazo_fin  numeric(10) ,
      @uf   float  ,
      @clp   float  ,
      @libor   float  ,
      @spread   float  )
as
begin
insert into VIEW_TASA_FWD( plazo_ini   ,
    plazo_fin   ,
    uf    ,
    clp    ,
    libor    ,
    spread    )
  values     ( @plazo_ini   ,
    @plazo_fin   ,
    @uf    ,
    @clp    ,
    @libor    ,
    @spread    )
if @@error <> 0 
 select -1,'problemas al grabar informacion'
end

GO
