USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VENC_NETO]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VENC_NETO]
AS
BEGIN
SET NOCOUNT ON
select 'Neto1' = sum(case when catipoper = 'C' and cacodpos1 = 1 then camtomon1 else (case when catipoper = 'V' and cacodpos1 = 1 then camtomon1*-1 else 0 end) end),
       'Neto2' = sum(case when catipoper = 'C' and cacodpos1 = 2 then camtomon2 else (case when catipoper = 'V' and cacodpos1 = 2 then camtomon2*-1 else 0 end) end), 
       'Neto4' = sum(case when catipoper = 'C' and cacodpos1 = 4 then camtomon1 else (case when catipoper = 'V' and cacodpos1 = 4 then camtomon1*-1 else 0 end) end), 
       'Neto5' = sum(case when catipoper = 'O' and cacodpos1 = 5 then camtomon1 else (case when catipoper = 'A' and cacodpos1 = 5 then camtomon1*-1 else 0 end) end), 
       'Neto6' = sum(case when catipoper = 'C' and cacodpos1 = 6 then camtomon1 else (case when catipoper = 'V' and cacodpos1 = 6 then camtomon1*-1 else 0 end) end), 
       'Neto7' = sum(case when catipoper = 'C' and cacodpos1 = 7 then camtomon1 else (case when catipoper = 'V' and cacodpos1 = 7 then camtomon1*-1 else 0 end) end), 
       'Neto8' = sum(case when catipoper = 'C' and cacodpos1 = 8 then camtomon1 else (case when catipoper = 'V' and cacodpos1 = 8 then camtomon1*-1 else 0 end) end), 
       'Neto9' = sum(case when catipoper = 'C' and cacodpos1 = 9 then camtomon1 else (case when catipoper = 'V' and cacodpos1 = 9 then camtomon1*-1 else 0 end) end), 
       'FechaVencimiento' = cafecvcto ,
       'FechaDeProceso' = '           ',
       'Hora'			= '               ',
       'Nombre'			= '                          ',
       'entidad' ='                                       '
       INTO #TEMPO
FROM MFCA
GROUP BY cafecvcto
declare @fecha char(10)
declare @entidad char(40)
select @fecha = convert(char(10),acfecproc,103) ,@entidad = acnomprop
  from mfac 
update #tempo set fechadeproceso = @fecha,    
                  hora = convert(char(10),getdate(),108), 
                  nombre = acnomprop, 
                  entidad = @entidad
              from mfac 
select * from #tempo             
end

GO
