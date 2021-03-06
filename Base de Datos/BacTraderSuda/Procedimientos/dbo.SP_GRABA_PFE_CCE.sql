USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PFE_CCE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_GRABA_PFE_CCE]( @drut           numeric(10)  ,
                              @dcodigo        numeric(5)   ,
                              @ctipo_limite   char(1)      ,
                              @cproducto char(10) ,
                              @fmonto         float        )
as
begin
 insert into
 MD_PFE_CCE( 
  rut,
  codigo   ,
                tipo_limite  ,
  plazo_ini  ,
  plazo_fin  ,
  productos  ,
  monto_asignado  ,
  monto_ocupado   )
 values( 
  @drut   ,
  @dcodigo  ,
  @ctipo_limite  ,
  0   ,
  0   ,
  @cproducto  ,
  @fmonto   ,
                0.0    )
 if @@error <> 0 
  SELECT 'NO', 'NO GRABA INFORMACION'
 else
  SELECT 'SI', ''
 return 0
end   
-- execute sp_graba_pfe_cce 97032000,1,'p','bonos',150000000'


GO
