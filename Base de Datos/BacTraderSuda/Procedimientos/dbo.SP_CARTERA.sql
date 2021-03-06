USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARTERA]
as 
begin 
declare @xfecpro char(8)
select @xfecpro = convert(char(8),acfecproc) from mdac 
select 
  'Reg   '  = '2'
 ,'cRut  '  =  str(carutclic) + Cldv
        ,'cRef  '  = str(canumdocu) + str(canumoper) +str(cacorrela)
        ,'cCmon '  = '00'
        ,'nCInte'  = 0
        ,'nCReaj'  = 0
-- IF camonemis = 900 or camonemis = 142 or camonemis = 13
--           Bus_Cuenta()
--        ELse
--           'nCope'  = ' Carga cuenta capital'
--           'nCsup'  = 'Bus_Partida(ncope),4)'
--        End
 ,'cPtra'   = case when camonemis=900 then '70' else '00' end 
        ,'ctotr'   = case when camonemis=900 then '70' else '01' end 
 ,'nCtas'   = '000'
 ,'nScta'   = '00'
 ,'nCali'   = '0'
        ,'nTipc'   = '1735'
        ,'nCpro'   = '0'    --Strzero(xprod,3)
 ,'cTcar'   = case when catc_sbif = 1 then  'PER' else 'INV' end 
 ,'nTcre'   = '00'
 ,'dFoto'   = cafeccomp
 ,'nVori'   = case when catipoper = 'VI' or catipoper = 'VP' then cavalvenp
            when cacartera = '121' and catipoper = 'CP' then 
     case when camonemis =900 then  cavpresen * isnull((select vmvalor from view_valor_moneda where (vmcodigo = 994 and vmfecha = @xfecpro)),0)
      else  cavalcomp 
     end 
      when  catipoper = 'CP' then 
     case when camonemis = 900 or camonemis = 995 or camonemis = 13 or camonemis =142 then
      cavpresen * isnull((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = @xfecpro),0)
                  Else
                    cavpresen
                End
          when catipoper = 'CI' then cavalcomp
            end
        ,'nCupo'   = catasemis 
 ,'nVatc' = case when cacartera = '115' or cacartera = '112' then   isnull((select vmvalor from view_valor_moneda where  vmcodigo = camonpact and vmfecha = @xfecpro),0)
                when camonemis = 900   or camonemis = 995 or camonemis = 13 or camonemis =142 then  isnull((select vmvalor from view_valor_moneda where (vmcodigo = 994 and vmfecha = @xfecpro)),0)
             Else
                  isnull((select vmfecha from view_valor_moneda where vmcodigo = camonemis and vmfecha = @xfecpro),0)
           End
  
 ,'cCmor' =   case  when camonpact= 999 then  '00'
     when camonpact= 998 then '09'
     when camonpact= 997 then '09'
        when (camonpact = 900 or camonpact = 994 or camonpact = 995 or camonpact = 13 or camonpact = 14 or camonpact = 142 )then '11'
   else
   '00'
      end
 ,'nMone' =  isnull((select mncodbanco from view_moneda where mncodmon = camonemis),'000')
 
-- 'cTTas'   := IIF( MdIn->(dbSeek( MdCa->cainst)), Iif( MdIn->intiptas='S','FLO','FIJ'),'XXX')
--         * Especial Bono Bcaps-A1
--        if Mdca->cainstser = 'BCAPS-A1  '
--             cTTas := 'VAR'
--        End
 
  ,'nTCom'   = '000000'
 ,'nTcof'   = '000000'
 ,'dFExt'   = case when cacartera = 112 or cacartera = 115 then cafecvtop else cafecvcto end 
 ,'dFVen'   = case when cacartera = 112 or cacartera = 115 then cafecvtop else cafecpcup end 
 ,'nPcRb'   = '000'
 ,'nPzop'   = '0000'
 ,'nNCua'   = '000'
 ,'nMCua'   = '0000000000000000'
        ,'nMatr'   = '000'
        ,'nIsis'   = 'PCT'
        ,'nOfio'   = '00047'
        ,'nOfco'   = '00047'
 ,'nCeje'   =  SPACE(3)
 ,'nCCos'   = '00000'
 ,'nbase'   = case when catipoper = 'CP' then case 
      when datediff(d,cafecvcto,@xfecpro) < 30 then '101'
   when datediff(d,cafecvcto,@xfecpro) >= 30 and datediff(d,cafecvcto,@xfecpro) < 89  then '102'
   when datediff(d,cafecvcto,@xfecpro) >= 90 and datediff(d,cafecvcto,@xfecpro) < 179  then '103'
   when datediff(d,cafecvcto,@xfecpro) >= 180 and datediff(d,cafecvcto,@xfecpro) < 364  then '104'
   when datediff(y,cafecvcto,@xfecpro) >= 1 and datediff(y,cafecvcto,@xfecpro)  < 3  then '105'
   when datediff(y,cafecvcto,@xfecpro) >= 3  then '106'
   end 
     Else
   case 
      when datediff(d,cafecvtop,@xfecpro) < 30 then '101'
   when datediff(d,cafecvtop,@xfecpro) >= 30 and datediff(d,cafecvtop,@xfecpro)  <  89  then '102'
   when datediff(d,cafecvtop,@xfecpro) >= 90 and datediff(d,cafecvtop,@xfecpro)  < 179  then '103'
   when datediff(d,cafecvtop,@xfecpro) >= 180 and datediff(d,cafecvtop,@xfecpro) < 364  then '104'
   when datediff(y,cafecvtop,@xfecpro) >= 1 and datediff(y,cafecvtop,@xfecpro)   <   3  then '105'
   when datediff(y,cafecvtop,@xfecpro) >= 3  then '106'
   end 
      End
 ,'ntasa1' = catircomp
 ,'nCapi'  = case when catipoper = 'VI' or catipoper = 'VP' then cavalvenp
           when catipoper = 'CP' then 
                case when camonemis = 900 or camonemis = 995 or camonemis =13 or camonemis =142 then 
                                 cavpresen * isnull((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = @xfecpro),0)
                 Else
                       case when cacartera= 121 then  cavalcomp
                     Else
     cavpresen
                       End
    End
           when catipoper = 'CI' then cavalcomp
       end
-- 'dFtas' =  IIF( cTTas ='TIP',DTos( MdCa->Cafecpcup ),'00000000')
--     case when cacartera = 112 or cacartera = 115 then 
--    set Difere  = '001'        
--    set nNcup   = (nCupon,3)
--          else
--    Difere  := StrZero(Difcu,3)
--    nNcup   := StrZero(nCupon,3)
--     end
 ,'ncopi'  = '00000'
 ,'nInte1' = '000000000000000'
 ,'nCopr' = '00000'
 ,'nReaj' = '000000000000000'
 ,'cCjud' = 'S'
 ,'cInfo' = 'S'
 ,'cRell' =  space(5)
 ,'cCmon' = '00000000000' --+ cPtra + '0' + ctotr + space(14)
 from mdca, view_cliente
 where carutclic = clrut 
end
--cTTas 
-- select * from mddi
--select * from  VIEW_CLIENTE 
-- select * from  sysobjects where type ='u'
--select * from sysobjects where type ='v'
/*
 case when cacartera = '111' and catipoper = 'CP' then
          case camonemis = 900 or camonemis = 995 or camonemis = 142 then 994
                    case cainst = 'BR    ' or cainst = 'CBR   ' then 999
                         Else camonemis
                       End
               End
          when (cacartera = 111 or cacartera = 112 or cacartera = 113) and catipoper = 'CI'
                     then camonpact
           when cacartera = 114 and catipoper = 'VI' then 
                 case cainst ='BR    ' or cainst ='CBR   ' then 995
              Else camonemis
             End
      when cacartera = 115 and catipoper = 'VI' then camonpact
   when cacartera = 121 and catipoper = 'CP' then 
             case camonemis = 900 or camonemis = 995 then 994
              Else camonemis
              End
      End
*/
-- select * from mdca


GO
