USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTEROPERHEDGE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SP_CARTEROPERHEDGE]
as
begin 
 set nocount on
 declare @nnomprop char (50)
 declare @nfecproc datetime
 
 select 
        @nnomprop = rcnombre     ,
        @nfecproc = acfecproc    
 from
  MFAC, view_entidad
 
 
 select  'Tipo Operacion' = a.catipoper    ,
  'Numero OPeracion' =a.canumoper    ,
  'Nombre Cliente' = b.clnombre    ,
  'Fecha Inicio' = convert (char(10),a.cafecha,103) ,
   'Fecha Termino' = convert (char(10),a.cafecvcto) ,
  'Plazo' = a.caplazo      ,
  'Plazo Residual' = datediff(dd,@nfecproc,a.cafecvcto ) ,
  'Monto USD Finales' = a.camtomon1fin   ,
  'Monto USD Iniciales' = a.camtomon1ini   ,
  'Tasa USD' = a.catasausd    ,
  'Tasa CNV' = a.catasacon    ,
  'Precio Spot' = a.capremon1    ,
  'Precio Futuro' = a.caprecal    ,
  'Moneda1' = c.mnnemo     ,
  'Moneda2'= d.mnnemo     ,
  'Monto a Diferir en Dolares' = a.camtodiferir  ,
  'Devengo Acumulado en Dolares' = a.cadevacum  ,
  'Valorizacion' = 0     ,
  'Nombre Empresa' = @nnomprop    ,
  'Fecha Proceso' = convert (char(10),@nfecproc,103) ,
  'Observado' =  (select vmvalor
    from view_valor_moneda   
    where vmcodigo = 994 and
          vmfecha = @nfecproc)  ,
  'Valor UF' = (select vmvalor
         from view_valor_moneda   
         where vmcodigo = 998 and
              vmfecha = @nfecproc)  ,  
  'Hora' = convert(char(5),getdate(),108)   
 from
  MFCA  a,
  view_cliente b,
  view_moneda c,
  view_moneda d
 where
  (b.clrut = a.cacodigo and
   a.cacodcli = b.clcodigo)and
   a.cacodmon1 = c.mncodmon and
   a.cacodmon2 = d.mncodmon and
   a.cacodpos1 = 6 and
   a.cafecvcto <> @nfecproc 
 set nocount off
end

GO
