USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_LISTADO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_LISTADO]( 
                                   @xfecha1 char(8)
                                 )
AS
BEGIN
create table #Temporal
             (fecha     datetime 
             ,Volcom    numeric(19,4)    
             ,Volvta    numeric(19,4)    
             ,Voltot    numeric(19,4)    
             ,VolAcu    numeric(19,4)    
             ,UtiOp     numeric(19,4)    
             ,UtiHoy    numeric(19,4)    
             ,UtiMon    numeric(19,4)    
             ,Utitot    numeric(19,4)    
             ,utiacu    numeric(19,4) 
             ) 
declare @aux_acfecpro datetime
       ,@aux_cputico  numeric(15,2)
       ,@aux_cputive  numeric(15,2)
       ,@nUtiope      numeric(15,2)
Declare @aux_mofecha   datetime 
       ,@aux_motipmer  char(4)
       ,@aux_motipope  char(1)
       ,@aux_moussme   numeric(19,4)
       ,@aux_mocodmon  char(3)
       ,@aux_momonmo   numeric(19,4)    
       ,@aux_motctra   numeric(19,4) 
       ,@aux_mocostofo numeric(19,4)  
       ,@aux_mouss30   numeric(19,4)    
       ,@aux_mocodcnv  char(3)  
       ,@aux_moutilpe  numeric(19,4)
       ,@nVolcom       numeric(19,4)
       ,@nVolvta       numeric(19,4)           
       ,@nVoltot       numeric(19,4)    
       ,@nUtimon       numeric(19,4)    
       ,@nUtiHoy       numeric(19,4)    
       ,@nVolAcu       numeric(19,4)   
       ,@nutiacu       numeric(19,4)
       ,@xfecha        datetime  
set @xfecha  = CONVERT( CHAR(10), @xfecha1, 103 )
set @nUtiOpe = isnull(@nUtiOpe ,0)
set @nutiacu = isnull(@nutiacu ,0)
set @nVolAcu = isnull(@nVolAcu ,0)
set @nVolCom = isnull(@nVolCom ,0)
set @nVolvta = isnull(@nVolvta ,0)
set @nVoltot = isnull(@nVoltot ,0)
set @nUtiMon = isnull(@nUtiMon ,0)
set @nUtiHoy = isnull(@nUtiHoy ,0)
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   declare Recorre_Meach_cursor cursor for   
   Select acfecpro,cp_utico,cp_utive
   from meach where month(acfecpro)= month(@xFecha) and  year(acfecpro) = year(@xFecha) 
     order by acfecpro     
       open Recorre_Meach_cursor
       fetch Recorre_Meach_cursor
               into @aux_acfecpro
            ,@aux_cputico
                   ,@aux_cputive
         while (@@fetch_status = 0)
         Begin
         set @nUtiOpe = (@aux_cputico + @aux_cputive )
         set @nVolCom = 0
         set @nVolvta = 0
         set @nVoltot = 0
         set @nUtiMon = 0
         set @nUtiHoy = 0
       
         declare CargaListadoMemo_cursor cursor for             
         Select  mofech  ,motipmer,motipope  ,moussme ,mocodmon
                ,momonmo ,motctra ,mocostofo ,mouss30 ,mocodcnv,moutilpe
            from memoh where  motipmer <> 'PTAS' and mofech = @aux_acfecpro and (MOESTATUS = ' ' OR MOESTATUS = 'M')
                 order by mofech
           open CargaListadoMemo_cursor
           fetch CargaListadoMemo_cursor
           into @aux_mofecha
               ,@aux_motipmer 
               ,@aux_motipope 
               ,@aux_moussme  
               ,@aux_mocodmon 
               ,@aux_momonmo  
               ,@aux_motctra  
               ,@aux_mocostofo
               ,@aux_mouss30  
               ,@aux_mocodcnv  
               ,@aux_moutilpe
          while (@@fetch_status = 0)
           Begin
           if @aux_motipope = 'C' begin                    -- COMPRA 
               set @nvolcom = @nvolcom + @aux_moussme
               set @nvoltot = @nvoltot + @aux_moussme
              if @aux_mocodmon = 'USD' begin 
                 set @nUtiHoy = @nUtiHoy + (@aux_momonmo * (@aux_motctra - @aux_mocostofo))
                end else begin 
                 set @nVolVta  = @nVolVta + @aux_mouss30
                 set @nVolTot  = @nVolTot + @aux_mouss30
                 if @aux_mocodcnv = 'CLP' begin 
                   set @nVolCom = @nVolCom + @aux_moussme
        set @nVolTot = @nVolTot + @aux_moussme
      end
              end
            end else begin                                -- VENTA
             set @nVolVta = @nVolVta + @aux_moussme
             set @nVolTot = @nVolTot + @aux_moussme
             if @aux_mocodmon = 'USD' begin 
                set @nUtiHoy = @nUtiHoy + (@aux_momonmo * (@aux_motctra - @aux_mocostofo))
               end else begin 
                set @nVolcom = @nvolcom + @aux_mouss30
                set @nVolTot = @nvoltot + @aux_mouss30
                if @aux_mocodcnv = 'CLP' begin 
                   set @nVolvta = @nvolvta + @aux_moussme
                   set @nVoltot = @nvoltot + @aux_moussme
                end
             end                                         --if
      end 
      fetch CargaListadoMemo_cursor
      into @aux_mofecha
          ,@aux_motipmer 
          ,@aux_motipope 
          ,@aux_moussme  
          ,@aux_mocodmon 
          ,@aux_momonmo  
          ,@aux_motctra 
          ,@aux_mocostofo 
          ,@aux_mouss30  
          ,@aux_mocodcnv 
          ,@aux_moutilpe
           
        End  -- CARGALISTADOMEMO_CURSOR
        Close CargaListadoMemo_cursor
        Deallocate CargaListadoMemo_cursor
         set @nVolAcu = @nVolAcu + @nVoltot
         set @nUtiOpe = @nUtiOpe - @nUtiHoy
         set @nUtiAcu =(@nUtiAcu + @nUtiOpe + @nUtimon + @nUtihoy)
         set @nUtimon = @nUtimon + isnull((select sum(moutilpe) from memo where mofech = @aux_acfecpro),0)
        insert into #Temporal ( Fecha  ,VolCom,Volvta ,VolTot ,VolAcu 
                                ,UtiOp ,UtiHoy,UtiMon ,UtiTot ,UtiAcu)
              Values (@aux_acfecpro  
                    ,(@nVolCom / 1000)
                    ,(@nVolVta / 1000) 
                    ,(@nVolTot / 1000) 
                    ,(@nVolAcu / 1000)
                    ,(@nUtiOpe / 1000)
                    ,(@nUtiHoy / 1000) 
                    ,(@nUtiMon / 1000)
                   ,((@nUtiOpe + @nUtiMon + @nUtiHoy)/ 1000)
                    ,(@nUtiAcu / 1000) ) 
 
          fetch Recorre_Meach_cursor
          into @aux_acfecpro
       ,@aux_cputico
              ,@aux_cputive
                  
         End 
        Close Recorre_Meach_cursor
        Deallocate Recorre_Meach_cursor
End -- BEGIN PRINCIPAL
 
select *,'Hora'=CONVERT(CHAR(08),GETDATE(),108),'FecPro'=CONVERT(CHAR(10),acfecpro,103)  from #Temporal,meac



GO
