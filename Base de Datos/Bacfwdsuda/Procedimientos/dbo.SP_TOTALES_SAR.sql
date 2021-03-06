USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TOTALES_SAR]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TOTALES_SAR]
AS 
BEGIN 
SET NOCOUNT ON
DECLARE @acfecha  CHAR(8)
DECLARE @totalreg  NUMERIC(10)
DECLARE @acumulado  NUMERIC(19)
declare @ccapi  NUMERIC(19) 
declare @acum  NUMERIC(19)
declare @numoper NUMERIC(19)
 
SELECT @ACFECHA = CONVERT(CHAR(8),acfecproc,112) FROM MFAC
SELECT @totalreg = COUNT(*)
 FROM mfca a ,view_cliente b, VIEW_MONEDA c
  WHERE  a.cacodigo = b.Clrut and  a.cafecha > @acfecha
         and a.cacodmon1 = c.mncodmon
        and a.cacodcli = b.Clcodigo
SELECT   'ctreg'  = 3
 ,'crut'  = space(9)
 ,'cref'  = space(20)
 ,'ccope' =  CASE  when a.cacodcart = 1 and a.cacodmon1 = 998 then  
              case a.catipoper when 'C' then 28118 else 68338 end 
          when a.cacodcart = 1 and a.cacodmon1 =  994 then --observado
            case catipoper when 'C' then 28795  else 68619 end 
          when a.cacodcart = 2 then 
            case a.catipoper when 'C' then 30486  else 68890 end 
          when a.cacodcart = 3 then 
     case catipoper when 'C' then 27540  else 68148 end  
       END 
 ,'ccsup' = space(4)
 ,'cctas' = space(3)
 ,'cscta' = space(2)
 ,'ccali' = space(1)
 ,'ctipc' = space(4)
 ,'ccpro' = space(3)
 ,'ctcar' = space(3)
 ,'ctcre' = space(2)
 ,'cfoto' = (select acfecproc FROM MFAC)
 ,'cvori' = space(15)
 ,'total_reg'  = @totalreg  
 ,'cvatc' = space(16)
 ,'cmon'  = space(2)
 ,'cmor'  = space(2)
 ,'cmone' = space(3)
 ,'ctasb' = space(3)
 ,'ctasa' = space(6)
 ,'cttas' = space(3)
 ,'ctcom' = space(6)
 ,'ctcof' = space(6)
 ,'cfext' = space(8)
 ,'cfven' = space(8)
 ,'ccapi' = a.caequmon1       --14
 ,'cpcrb' = space(3)
 ,'cpzop' = space(4)
 ,'cncua' = space(3)
 ,'cmcua' = space(16)
 ,'cmatr' = space(2)
 ,'cisis' = space(3)
 ,'cofio' = space(5)
 ,'cofco' = space(5)
 ,'cceje' = space(3)
 ,'cccos' = space(5)
 ,'cftas' = space(8)
 ,'cntoc' = space(1)
 ,'cncup' = space(1)
 ,'ccopi' = space(5)
 ,'cinte' = space(15)
 ,'ccopr' = space(5)
 ,'creaj' = space(15)
 ,'ccjud' = space(1)
 ,'cinfo' = space(1)
 ,'crell' = space(15)
 ,'numoper' = isnull(a.canumoper,0)
        into #tmp_sar
 FROM mfca a ,view_cliente b, VIEW_MONEDA c
  WHERE  a.cacodigo = b.Clrut and  a.cafecha > @acfecha
         and a.cacodmon1 = c.mncodmon
         and a.cacodcli = b.Clcodigo order by a.canumoper
  
  set @acum  = 0
  DECLARE cursor_sar  SCROLL  CURSOR
  FOR SELECT ccapi,numoper from #tmp_sar
  OPEN cursor_sar
  FETCH FIRST FROM cursor_sar
  INTO @ccapi,@numoper
   FETCH FIRST FROM cursor_sar
   WHILE (@@FETCH_STATUS = 0)
   BEGIN
       UPDATE #tmp_sar  SET ccapi = @ccapi + @acum
       WHERE numoper = @numoper
       SET @acum = @acum +  @ccapi
   
     FETCH NEXT FROM cursor_sar
     INTO @ccapi,@numoper
   END
   CLOSE cursor_sar
   DEALLOCATE cursor_sar
select * from #tmp_sar
end  
 
/* select * FROM mfcah a ,view_cliente b, VIEW_MONEDA c
  WHERE  a.cacodigo = b.Clrut and  a.cafecvcto > '20011024' --@acfecha
         and a.cacodmon1 = c.mncodmon
         and a.cacodcli = b.Clcodigo
*/
-- select * FROM mfcah a where  a.cafecvcto > '20011024'
/*
    cacodcart              cacodmon1
  If       Csc_TipCar = '100' .And. Csc_CodCnv='UF '
           nCuenta := If( Csc_TipOpe='COM', 28118 ,68338 )
           nCueCon := If( Csc_TipOpe='COM', 68452 ,27722 )
 ElseIF    Csc_TipCar='100' .And. Csc_CodCnv='$  '
           nCuenta := If( Csc_TipOpe='COM', 28795 ,68619 )
           nCueCon := If( Csc_TipOpe='COM', 68627 ,28829 )
 ElseIF    Csc_TipCar='200'
           nCuenta := If( Csc_TipOpe='COM', 30486 ,68890 )
           nCueCon := If( Csc_TipOpe='COM', 68890 ,30486 )
 ElseIF    Csc_TipCar='300'
           nCuenta := If( Csc_TipOpe='COM', 27540 ,68148 )
           nCueCon := If( Csc_TipOpe='COM', 68148 ,27540 )
 endIf
SELECT @acumulado = isnull(SUM( CASE WHEN a.camdausd = 999 THEN  a.camtomon1  --14
         ELSE ROUND(a.camtomon1*a.catipcam,0) END ),0)
 FROM mfcah a ,view_cliente b, VIEW_MONEDA c
  WHERE  a.cacodigo = b.Clrut and  a.cafecvcto > '20011024' --@acfecha
         and a.cacodmon1 = c.mncodmon
         and a.cacodcli = b.Clcodigo
*/

GO
