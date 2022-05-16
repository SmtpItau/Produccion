USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CODIGO_DEVENGAMIENTO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CODIGO_DEVENGAMIENTO]
       (
        @ncodigo    numeric(03),
        @dfecha     datetime
       )
as
begin
   select       vmvalor
          from  VIEW_VALOR_MONEDA
          where vmcodigo = @ncodigo    and
                vmfecha  = @dfecha
end


GO
