USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJO_GAP]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FLUJO_GAP]
as
BEGIN 
SET NOCOUNT ON
DECLARE @ACFECHA CHAR(8)
SELECT @ACFECHA = CONVERT(CHAR(8),acfecproc,112) FROM MFAC
SELECT  'CTREG'  = 3      --1
 ,'CRUT '  = STR(a.cacodigo) + b.Cldv   --2
 ,'CREF'  = a.canumoper     --3
 ,'Ccope' = CASE  when a.cacodcart = 1 and a.cacodmon1 = 998 then   --4
              case a.catipoper when 'C' then 28118 else 68338 end 
          when a.cacodcart = 1 and a.cacodmon1 =  994 then --observado
            case catipoper when 'C' then 28795  else 68619 end 
          when a.cacodcart = 2 then 
            case a.catipoper when 'C' then 30486  else 68890 end 
          when a.cacodcart = 3 then 
     case catipoper when 'C' then 27540  else 68148 end  
        end      
 ,'CcSUP' =space(4)     --5
 ,'Cctas'  =space(3)     --6
 ,'Cscta' =space(2)     --7
 ,'Ccali' =space(1)     --8
 ,'Ctipc' =space(4)     --9
 ,'Ccpro' =space(3)     --10
 ,'Ctcar' =space(3)     --11
 ,'Ctcre' =space(2)     --12
 ,'Cfoto' =a.CAFECHA     --13
 ,'Cvori' =a.caequmon1     --14 equivalente pesos
 ,'Ccupo' =SPACE(15)     --15
 ,'Cvatc' =isnull((select round(VMVALOR,4) from view_valor_moneda --16
    where vmcodigo = 994 and vmfecha =@acfecha),0)
 ,'Cmon'  =c.mncodbanco     --17
 ,'Cmor'  =c.MNCODBANCO     --18
 ,'Cmone' =c.MNCODMON     --19
 ,'Ctasb' =space(3)     --20
 ,'Ctasa' =space(6)     --21
 ,'Cttas' =space(3)     --22
 ,'Ctcom' =space(6)     --23
 ,'Ctcof' =space(6)     --24
 ,'Cfext' =a.cafecvcto     --25
 ,'Cfven' =a.cafecvcto     --26
 ,'Ccapi' =a.caequmon1     --27 equivalente pesos
 ,'Cpcrb' =Space(3)     --28
 ,'cpzop' =space(4)     --29
 ,'cncua' =space(3)     --30
 ,'cmcua' =space(16)     --31
 ,'cmatr' =space(2)     --32
 ,'cisis' ='PCF'      --33
 ,'cofio' =1      --34
 ,'cofco' =1      --35
 ,'cceje' =space(3)     --36
 ,'cccos' =space(5)     --37
 ,'cftas' =a.cafecha     --38
 ,'cntoc' =1      --39
 ,'cncup' =1      --40
 ,'ccopi' =space(5)     --41
 ,'cinte' =space(15)     --42
 ,'ccopr' =space(5)     --43
 ,'creaj' =space(15)     --44
 ,'ccjud' =space(1)     --45
 ,'cinfo' ='S'      --46
 ,'crell' =space(15) --C-E    --47
      from mfca a ,view_cliente b, VIEW_MONEDA c
  where  a.cacodigo = b.Clrut 
         and  a.cafecha =  @acfecha --'20011116' 
         and a.cacodmon1 = c.mncodmon
         and a.cacodcli  = b.Clcodigo
END 
/*
select * from mfca ,view_cliente where  cacodigo = Clrut and cacodcli  = Clcodigo and cafecha =  '20020110'
select * from view_cliente where Clrut  = 97006000
select * from mfac
*/
GO
