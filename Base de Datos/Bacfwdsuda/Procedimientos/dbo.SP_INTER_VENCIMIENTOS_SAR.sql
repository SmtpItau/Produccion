USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTER_VENCIMIENTOS_SAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SP_INTER_VENCIMIENTOS_SAR]
AS 
BEGIN 
SET NOCOUNT ON
declare @ACFECHA  char(8)
SELECT @ACFECHA = CONVERT(CHAR(8),acfecproc,112) FROM MFAC
select   'ctreg' = 2
 ,'crut'  = STR(a.cacodigo) + b.Cldv
 ,'cref'  = a.canumoper 
 ,'ccope' = CASE  when a.cacodpos1 = 1 and a.cacodmon2 = 998 then   --4
              case a.catipoper when 'C' then '28118' else '68338' end 
           when a.cacodpos1 = 1 and a.cacodmon2 =  999 then  
            case catipoper when 'C' then '28795'  else '68619' end 
           when a.cacodpos1 = 2 and b.clpais = d.acpais then 
            case a.catipoper when 'C' then '30486'  else '68890' end 
           when a.cacodpos1 = 2 and b.clpais <> d.acpais then 
     case catipoper when 'C' then '27540'  else '68148' end  
    else '00000'
        END 
 ,'ccorr' =  '00'
 ,'cncua' =  '001'
 ,'cntoc' =  '001'
 ,'csepa' =  'M'
 ,'cncep' =  '001'
 ,'cfven' =  a.cafecvcto
 ,'cvamo' =  a.caequmon1                  -- equivalente en pesos
 ,'cinte' =  '000000000000000'
 ,'ccomi' =  '000000000000000'
 ,'cvcuo' =  a.caequmon1   -- equivalente en pesos
 ,'csvca' =  '000000000000000'
 ,'ctasa' =  '0000000'
 ,'crell' =   space(8)
     FROM mfca a ,view_cliente b, VIEW_MONEDA c, mfac d
 WHERE   a.cacodigo  = b.Clrut 
  and  a.cafecvcto = @acfecha
         and a.cacodmon1 = c.mncodmon  
         and a.cacodcli  = b.Clcodigo order by a.canumoper 
 
END
 
--select cafecvcto,* from mfca,mfac where cafecvcto > acfecproc

GO
