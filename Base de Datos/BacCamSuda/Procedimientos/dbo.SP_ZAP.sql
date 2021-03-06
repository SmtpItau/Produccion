USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ZAP]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_ZAP]
              ( @fecha_ant   datetime ,
                @fecha_hoy   datetime ,
                @fecha_man   datetime )
as
begin
set nocount on
 update MEAC set 
  acfecpro = @fecha_hoy,
  acfecprx = @fecha_man,
  acfecant = @fecha_ant
 print 'limpiando tablas diarias' 
 truncate table MEMO        
 ---------------------------------------------------------------------
 select * into #TEMP from VIEW_POSICION_SPT 
 truncate table BACPARAMsuda..POSICION_SPT    
 insert into BACPARAMsuda..POSICION_SPT ( vmcodigo, vmfecha, vmparidad, vmparmes )
 select vmcodigo, vmfecha, vmparidad, vmparmes from #TEMP
 
 drop table #TEMP
 ---------------------------------------------------------------------
 truncate table BACPARAMsuda..PLANILLA_SPT
 truncate table TBDETALLEINTERESES
    print 'limpiando tablas historicas' 
 truncate table MEMOH        -- historica de movimientos, spot bancos, spot empresas
-- limpia posicion de dolares
update MEAC set
acposini =0.0,
acpmeco   =0.0,
acpmeve  =0.0,
acpreini  =0.0,
acpmecopo  =0.0,
acprecie    =0.0,
acpmevepo  =0.0,
acposic     = 
0.0,
acutilipo   =0.0,
acutili     =0.0,
acutiltot    =0.0,
actotco    =0.0,
actotve    =0.0,
actotcopo   =0.0,
actotvepo   =0.0,
acpmecofi   =0.0,
acpmevefi   =0.0,
acpreinifi  =0.0,
acpreciefi  =0.0,
actotalpe     =0.0,
actotalpef    =0.0,
 
acmmonori     =0.0,
aclogdig = '000000011'
set nocount off
end 

GO
