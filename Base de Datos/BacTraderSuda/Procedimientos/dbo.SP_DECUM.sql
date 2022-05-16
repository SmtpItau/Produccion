USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DECUM]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DECUM](  @ncodmon   integer        ,
                            @nredondeo integer output )
as
begin
       select @nredondeo = mnredondeo
              from VIEW_MONEDA 
              where mncodmon = @ncodmon
end

GO
