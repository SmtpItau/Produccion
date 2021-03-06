USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_TASA_MAXIMA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LIMITES_TASA_MAXIMA]
                                       ( @fecha_inicio    datetime    ,
                                         @fecha_vcto      datetime    ,
                                         @tasa            float       )
as
begin
declare @plazo   numeric(5) 
declare @tasamax float
select @plazo = datediff(day, @fecha_inicio, @fecha_vcto )
select @tasamax = tasmax 
  from BAC_LIMITES_TASAMAXCONV
 where @plazo >= rango
   and @plazo <= plazo
if @tasa > @tasamax
   select 9
else
   select 0
end   /* fin procedimiento */

GO
