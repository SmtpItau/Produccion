USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSGENERALES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DATOSGENERALES]
 as
 begin
        declare @valor_uf float 
        select @valor_uf = 0.0
        select @valor_uf = isnull(vmvalor,0.0)
 from   MDAC, VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA      
 where  VIEW_VALOR_MONEDA.vmcodigo = 998  and VIEW_VALOR_MONEDA.vmfecha = MDAC.acfecproc
 select 'fec_pro' = convert(char(10),MDAC.acfecproc,103),
        'nom_cli' = isnull(MDAC.acnomprop,''),
        'valor_uf'= @valor_uf
 from   MDAC
               
 end
/*
*/
--sp_datosgenerales

GO
