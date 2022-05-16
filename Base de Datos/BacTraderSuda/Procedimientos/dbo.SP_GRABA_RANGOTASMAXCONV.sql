USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_RANGOTASMAXCONV]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_RANGOTASMAXCONV]( @xmoneda numeric(5) ,
      @xrango  numeric(5) ,
      @xplazo  numeric(5) ,
      @xtasmax numeric(9,4) )
as
begin
 insert into  BAC_LIMITES_TASAMAXCONV values ( @xmoneda ,
       @xrango  ,
       @xplazo  ,
       @xtasmax )
end
--select * from bac_limites_tasamaxconv

GO
