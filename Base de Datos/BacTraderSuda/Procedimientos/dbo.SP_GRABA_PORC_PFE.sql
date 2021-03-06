USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PORC_PFE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_GRABA_PORC_PFE]( @borrar     char(1)    ,
                               @plazo_ini  numeric(5) ,
                               @plazo_fin  numeric(5) ,
                               @porcentaje float      )
as
begin
if @borrar = 's'
begin
   delete MD_PORC_PFE
   if @@error <> 0 
      return -1
end
insert MD_PORC_PFE( plazo_ini,
                    plazo_fin,
                    porcentaje )
            values( @plazo_ini,
                    @plazo_fin,
                    @porcentaje )
if @@error <> 0 
   return -1
return 0
end   /* fin procedimiento */

GO
