USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROPIO_INTERFAZ_SAR]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PROPIO_INTERFAZ_SAR]
as
BEGIN 
SET NOCOUNT ON
DECLARE @ACFECHA CHAR(8)
SELECT @ACFECHA = '20020530'
SELECT  'CTREG'  = 3      --1
 ,'CRUT '  = STR(a.cacodigo) + b.Cldv   --2
 ,'CREF'  = a.canumoper     --3
 ,'Ccope' = CASE  when a.cacodcart = 1 and a.cacodmon1 = 998 then   --4
              case a.catipoper when 'C' then '28118' else '68338' end 
          when a.cacodcart = 1 and a.cacodmon1 =  994 then --observado
            case catipoper when 'C' then '28795'  else '68619' end 
          when a.cacodcart = 2 then 
            case a.catipoper when 'C' then '30486'  else '68890' end 
          when a.cacodcart = 3 then 
     case catipoper when 'C' then '27540'  else '68148' end  
                              else '00000'
        end      
 ,'CcSUP' =space(4)     --5
 ,'Cctas'  ='000'      --6
 ,'Cscta' ='00'      --7
 ,'Ccali' ='0'      --8
 ,'Ctipc' ='0000'      --9
 ,'Ccpro' ='000'      --10
 ,'Ctcar' =space(3)     --11
 ,'Ctcre' ='00'      --12
 ,'Cfoto' =a.CAFECHA     --13
 ,'Cvori' =a.caequmon1     --14 equivalente pesos
 ,'Ccupo' ='000000000000000'    --15
 ,'Cvatc' =isnull((select round(VMVALOR,4) from view_valor_moneda --16
    where vmcodigo = 994 and vmfecha =@acfecha),0)
 ,'Cmon'  =  C.mncodbanco     --17
 ,'Cmor'  =  C.MNCODBANCO     --18
 ,'Cmone' =  C.MNCODMON     --19
 ,'Ctasb' ='000'      --20
 ,'Ctasa' ='000000'     --21
 ,'Cttas' =space(3)     --22
 ,'Ctcom' ='000000'     --23
 ,'Ctcof' ='000000'     --24
 ,'Cfext' =a.cafecvcto     --25
 ,'Cfven' =a.cafecvcto     --26
 ,'Ccapi' =a.caequmon1     --27 equivalente pesos
 ,'Cpcrb' ='000'      --28
 ,'cpzop' ='0000'      --29
 ,'cncua' ='000'      --30
 ,'cmcua' ='0000000000000000'    --31
 ,'cmatr' ='00'      --32
 ,'cisis' ='PCF'      --33
 ,'cofio' ='00001'     --34
 ,'cofco' ='00001'     --35
 ,'cceje' =space(3)     --36
 ,'cccos' ='00000'     --37
 ,'cftas' =a.cafecha     --38
 ,'cntoc' =1      --39
 ,'cncup' =1      --40
 ,'ccopi' ='00000'     --41
 ,'cinte' ='000000000000000'    --42
 ,'ccopr' ='00000'     --43
 ,'creaj' ='000000000000000'    --44
 ,'ccjud' =space(1)     --45
 ,'cinfo' ='S'      --46
 ,'crell' =A.CATIPMODA     --47
        from mfca a ,view_cliente b, VIEW_MONEDA c
  where  a.cacodigo = b.Clrut and  a.cafecvcto >   @acfecha --
         and a.cacodmon1 = c.mncodmon
         and a.cacodcli  = b.Clcodigo
END 
/*
select * from view_cliente where  clrut = 97041000
select cacodigo,* from mfcah where cacodigo = 97041000
81148200,97041000
select * from VIEW_MONEDA
select * FROM mfca where cafecvcto > '20020110'
select * FROM voucher_CNT V  
select * FROM detalle_voucher_CNT 
select * from bacparamsuda..plan_de_cuenta
SELECT cafecvcto ,* FROM MFCAH WHERE cafecvcto > '20011116' ORDER BY cafecvcto
SELECT * FROM SYSOBJECTS WHERE TYPE = 'v'
select * from VIEW_MONEDA
select * from view_valor_moneda where vmcodigo = 994 and vmfecha = '20020110'
cafecha
cafecvcto
*/
GO
