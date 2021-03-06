USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIODEESTADOMDDI]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CAMBIODEESTADOMDDI]
  ( @numerodocumento numeric(10),
   @numerocorrela  numeric(3))
as
begin
 set nocount on
 select  MDDI.dinumdocu
 from  MDDI
 where  (MDDI.dinumdocu = @numerodocumento)
 and (MDDI.dicorrela=@numerocorrela)
begin
       update  MDDI
 set   MDDI.codigo_carterasuper ='P'
 where  MDDI.dinumdocu = @numerodocumento 
 
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
