USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_EMISOR_INST_PLAZO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_GRABA_EMISOR_INST_PLAZO]( @rut          numeric(10) ,
                                        @instrumento  char(6)     ,
                                        @plazo_ini    integer     ,
                                        @plazo_fin    integer     ,
                                        @monto        float       ,
     @montoutil    float )
as
begin
insert MD_EMISOR_INST_PLAZO( rut,
                             instrumento,
                             plazo_ini,
                             plazo_fin,
                             monto_asignado,
                             monto_ocupado )
                     values( @rut,
                             @instrumento,
                             @plazo_ini,
                             @plazo_fin,
                             @monto,
                             @montoutil    )
if @@error <> 0 
   SELECT 'NO', 'NO GRABA INFORMACION'
else
   SELECT 'SI', ''
return 0
end   /* fin procedimiento */


GO
