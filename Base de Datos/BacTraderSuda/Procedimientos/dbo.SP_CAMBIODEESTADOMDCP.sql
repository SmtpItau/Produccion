USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIODEESTADOMDCP]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CAMBIODEESTADOMDCP]
 ( @numerodocumento numeric(10),
  @numerocorrela  numeric(3))
as
begin
 set nocount on
 select  MDCP.cpnumdocu
 from  MDCP
 where  (MDCP.cpnumdocu = @numerodocumento)
 and  (MDCP.cpcorrela=@numerocorrela)
begin
       update  MDCP
 set   MDCP.codigo_carterasuper ='P'
 where  MDCP.cpnumdocu = @numerodocumento 
 
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
