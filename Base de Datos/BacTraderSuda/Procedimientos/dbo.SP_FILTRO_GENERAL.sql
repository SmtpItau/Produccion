USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRO_GENERAL]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FILTRO_GENERAL]
  ( @fechainicio  datetime=' ',
   @fechavencimiento datetime=' ',
   @tipo   char(12)='',
   @serie   char(12)='',
   @numerooperacion numeric(10))
as   
begin
 set nocount on
 if @tipo<>'' and @serie<>'' and @numerooperacion<>0 begin
  select  MDDI.dinumdocu,MDDI.dinumdocuo,MDDI.dicorrela,
                MDDI.diinstser,MDDI.dinominal,MDCP.cpfeccomp,MDDI.ditircomp,
   MDDI.dipvpcomp,MDCP.cpvalcomp,MDDI.divptirc,MDDI.ditipoper
               
  from    MDDI,MDCP
  where   (MDCP.cpfeccomp >= @fechainicio)  
  and     (MDCP.cpfeccomp <= @fechavencimiento)
  and (MDDI.diserie=@tipo)
  and  (MDDI.diinstser=@serie)
  and (MDDI.dinumdocu=@numerooperacion)
  and (MDCP.cpnumdocu=MDDI.dinumdocu)
  and (MDCP.cpcorrela=MDDI.dicorrela)
  and (MDDI.codigo_carterasuper='T')
  and  (MDDI.ditipoper='CP')
  and  (MDDI.dinominal>0)
 
  order by MDDI.dinumdocu  
 end
 
 if @tipo<>'' and @serie<>''  begin
  select  MDDI.dinumdocu,MDDI.dinumdocuo,MDDI.dicorrela,
                MDDI.diinstser,MDDI.dinominal,MDCP.cpfeccomp,MDDI.ditircomp,
   MDDI.dipvpcomp,MDCP.cpvalcomp,MDDI.divptirc,MDDI.ditipoper
               
  from    MDDI,MDCP
  where   (MDCP.cpfeccomp >= @fechainicio)  
  and     (MDCP.cpfeccomp <= @fechavencimiento)
  and (MDDI.diserie=@tipo)
  and  (MDDI.diinstser= @serie)
  and (MDCP.cpnumdocu=MDDI.dinumdocu)
  and (MDCP.cpcorrela=MDDI.dicorrela)
  and (MDDI.codigo_carterasuper='T')
  and  (MDDI.ditipoper='CP')
  and  (MDDI.dinominal>0)
 
  order by MDDI.dinumdocu  
 end
 
 if @tipo<>'' and @numerooperacion<>0 begin
  select  MDDI.dinumdocu,MDDI.dinumdocuo,MDDI.dicorrela,
                MDDI.diinstser,MDDI.dinominal,MDCP.cpfeccomp,MDDI.ditircomp,
   MDDI.dipvpcomp,MDCP.cpvalcomp,MDDI.divptirc,MDDI.ditipoper
               
  from    MDDI,MDCP
  where   (MDCP.cpfeccomp >= @fechainicio)  
  and     (MDCP.cpfeccomp <= @fechavencimiento)
  and (MDDI.diserie=@tipo)
  and (MDDI.dinumdocu=@numerooperacion)
  and (MDCP.cpnumdocu=MDDI.dinumdocu)
  and (MDCP.cpcorrela=MDDI.dicorrela)
  and (MDDI.codigo_carterasuper='T')
  and  (MDDI.ditipoper='CP')
  and  (MDDI.dinominal>0)
 
  order by MDDI.dinumdocu  
 end
 if @serie<>'' and @numerooperacion<>0 begin
  select  MDDI.dinumdocu,MDDI.dinumdocuo,MDDI.dicorrela,
                MDDI.diinstser,MDDI.dinominal,MDCP.cpfeccomp,MDDI.ditircomp,
   MDDI.dipvpcomp,MDCP.cpvalcomp,MDDI.divptirc,MDDI.ditipoper
               
  from    MDDI,MDCP
  where   (MDCP.cpfeccomp >= @fechainicio)  
  and     (MDCP.cpfeccomp <= @fechavencimiento)
  and  (MDDI.diinstser= @serie)
  and (MDDI.dinumdocu=@numerooperacion)
  and (MDCP.cpnumdocu=MDDI.dinumdocu)
  and (MDCP.cpcorrela=MDDI.dicorrela)
  and (MDDI.codigo_carterasuper='T')
  and  (MDDI.ditipoper='CP')
  and  (MDDI.dinominal>0)
 
  order by MDDI.dinumdocu  
 end
 if @tipo<>''  begin
  select  MDDI.dinumdocu,MDDI.dinumdocuo,MDDI.dicorrela,
                MDDI.diinstser,MDDI.dinominal,MDCP.cpfeccomp,MDDI.ditircomp,
   MDDI.dipvpcomp,MDCP.cpvalcomp,MDDI.divptirc,MDDI.ditipoper
               
  from    MDDI,MDCP
  where   (MDCP.cpfeccomp >= @fechainicio)  
  and     (MDCP.cpfeccomp <= @fechavencimiento)
  and (MDDI.diserie=@tipo)
  and (MDCP.cpnumdocu=MDDI.dinumdocu)
  and (MDCP.cpcorrela=MDDI.dicorrela)
  and (MDDI.codigo_carterasuper='T')
  and  (MDDI.ditipoper='CP')
  and  (MDDI.dinominal>0)
 
  order by MDDI.dinumdocu  
 end
 if @serie<>'' begin
  select  MDDI.dinumdocu,MDDI.dinumdocuo,MDDI.dicorrela,
                MDDI.diinstser,MDDI.dinominal,MDCP.cpfeccomp,MDDI.ditircomp,
   MDDI.dipvpcomp,MDCP.cpvalcomp,MDDI.divptirc,MDDI.ditipoper
               
  from    MDDI,MDCP
  where   (MDCP.cpfeccomp >= @fechainicio)  
  and     (MDCP.cpfeccomp <= @fechavencimiento)
  and  (MDDI.diinstser=@serie)
  and (MDCP.cpnumdocu=MDDI.dinumdocu)
  and (MDCP.cpcorrela=MDDI.dicorrela)
  and (MDDI.codigo_carterasuper='T')
  and  (MDDI.ditipoper='CP')
  and  (MDDI.dinominal>0)
 
  order by MDDI.dinumdocu  
 end
 if @numerooperacion<>0 begin
  select  MDDI.dinumdocu,MDDI.dinumdocuo,MDDI.dicorrela,
                MDDI.diinstser,MDDI.dinominal,MDCP.cpfeccomp,MDDI.ditircomp,
   MDDI.dipvpcomp,MDCP.cpvalcomp,MDDI.divptirc,MDDI.ditipoper
               
  from    MDDI,MDCP
  where   (MDCP.cpfeccomp >= @fechainicio)  
  and     (MDCP.cpfeccomp <= @fechavencimiento)
  and (MDDI.dinumdocu=@numerooperacion)
  and (MDCP.cpnumdocu=MDDI.dinumdocu)
  and (MDCP.cpcorrela=MDDI.dicorrela)
  and (MDDI.codigo_carterasuper='T')
  and  (MDDI.ditipoper='CP')
  and  (MDDI.dinominal>0)
 
  order by MDDI.dinumdocu  
 end
 if @tipo='' and @serie='' and @numerooperacion=0 begin
  select  MDDI.dinumdocu,MDDI.dinumdocuo,MDDI.dicorrela,
                MDDI.diinstser,MDDI.dinominal,MDCP.cpfeccomp,MDDI.ditircomp,
   MDDI.dipvpcomp,MDCP.cpvalcomp,MDDI.divptirc,MDDI.ditipoper
               
  from    MDDI,MDCP
  where   (MDCP.cpfeccomp >= @fechainicio)  
  and     (MDCP.cpfeccomp <= @fechavencimiento)
  and (MDCP.cpnumdocu=MDDI.dinumdocu)
  and (MDCP.cpcorrela=MDDI.dicorrela)
  and (MDDI.codigo_carterasuper='T')
  and  (MDDI.ditipoper='CP')
  and  (MDDI.dinominal>0)
 
  order by MDDI.dinumdocu  
 end
 set nocount off
 
end 
GO
