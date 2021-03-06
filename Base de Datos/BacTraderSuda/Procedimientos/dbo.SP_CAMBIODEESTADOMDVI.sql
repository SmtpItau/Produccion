USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIODEESTADOMDVI]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CAMBIODEESTADOMDVI]
  ( @numerodocumento numeric(10),
   @numerocorrela  numeric(3))
as
begin
 set nocount on
 select  MDVI.vinumdocu
 from  MDVI
 where  MDVI.vinumdocu = @numerodocumento
begin
       update  MDVI
 set   MDVI.codigo_carterasuper ='P'
 where  (MDVI.vinumdocu = @numerodocumento )
 and (MDVI.vicorrela=@numerocorrela)
 
 if @@error<>0
         begin
     select 'ERROR'
 end else
     begin
           select ' MODIFICA'
 end
   set nocount off 
end
end


GO
