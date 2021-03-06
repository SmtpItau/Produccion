USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERTASAMCDO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERTASAMCDO]
                                ( @ncodigo  integer        ,
                                  @nmesesvto integer        ,
      @nemisor  numeric(9,0)   ,
                                  @ftasmcdo float  OUTPUT  )
as
begin
      set nocount on
 declare @cfamilia char(10)
 
 select @cfamilia = inserie from VIEW_INSTRUMENTO where incodigo = @ncodigo
               -- trfecha  trserie  trvaldes  trvalhas  trtasas tremisor       
 select 
  @ftasmcdo = trtasas     
 from 
  MDTR
 where 
  trserie    = @cfamilia
 and  tremisor   = @nemisor 
 and @nmesesvto>= trvaldes 
 and @nmesesvto <= trvalhas 
       -- para la dblib.-
       set nocount off
       select @ftasmcdo
       return
end

GO
