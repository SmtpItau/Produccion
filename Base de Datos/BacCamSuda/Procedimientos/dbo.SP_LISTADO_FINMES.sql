USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADO_FINMES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTADO_FINMES]( -- varaibles de Entrada 
                                    @xmes numeric(2) 
                                   ,@xaño numeric(4) 
                                  )
AS
BEGIN
Declare   @aux_mofecha   datetime 
         ,@aux_motipmer  char(4)
         ,@aux_motipope  char(1)
         ,@aux_moussme   numeric(19,4)
         ,@aux_mocodmon  char(3)
         ,@aux_momonmo   numeric(19,4)    
         ,@aux_motctra   numeric(19,4)
         ,@aux_mocostofo numeric(19,4)
         ,@aux_mouss30   numeric(19,4)    
         ,@aux_mocodcnv  char(3)  
         ,@nVolcom       numeric(19,4)
         ,@nVolvta       numeric(19,4)           
         ,@nVoltot       numeric(19,4)    
         ,@nUtimon       numeric(19,4)    
         ,@nUtiHoy       numeric(19,4)    
declare @aux_acfecpro datetime
       ,@aux_cputico  numeric(15,2)
       ,@aux_cputive  numeric(15,2)
       ,@nUtiope      numeric(15,2)
Create Table #Temporal
            (fecha     datetime 
             ,Volcom    numeric(19,4)    
             ,Volta     numeric(19,4)    
             ,Voltot    numeric(19,4)    
             ,VolAcu    numeric(19,4)    
             ,UtiOp     numeric(19,4)    
             ,UtiHoy    numeric(19,4)    
             ,UtiMon    numeric(19,4)    
             ,Utitot    numeric(19,4)    
             ,utiacu    numeric(19,4)    ) 
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
select 'acfecpro ' = acfecpro
      ,'nUtiope  ' = sum(cp_utico + cp_utive)
   into #aux_meach  -- tabla temporal 
    from meach where  month(acfecpro)= @xmes and  year(acfecpro) = @xaño group by acfecpro
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
select 'mofech   ' = mofech
      ,'motipmer ' = motipmer
      ,'motipope ' = motipope
      ,'moussme  ' = moussme
      ,'mocodmon ' = mocodmon
      ,'momonmo  ' = momonmo
      ,'motctra  ' = motctra
      ,'mocostofo' = mocostofo
      ,'mouss30  ' = mouss30
      ,'mocodcnv ' = mocodcnv
      
   into #aux_memoh  -- tabla temporal 
    from memo where motipmer <> 'PTAS' and month(mofech)= @xmes and  year(mofech) = @xaño  
   declare Listado_cursor cursor for
   Select  mofech
          ,motipmer
          ,motipope
          ,moussme
          ,mocodmon
          ,momonmo
          ,motctra
          ,mocostofo
          ,mouss30
          ,mocodcnv
       from   #aux_memoh
       open Listado_cursor
       fetch Listado_cursor
       into @aux_mofecha
           ,@aux_motipmer 
           ,@aux_motipope 
           ,@aux_moussme  
           ,@aux_mocodmon 
           ,@aux_momonmo  
           ,@aux_motctra  
           ,@aux_mouss30  
           ,@aux_mocodcnv 
         while (@@fetch_status = 0)
          Begin
            
           if @aux_motipope = 'C' begin 
               set @nvolcom = @nvolcom + @aux_moussme
               set @nvoltot = @nvoltot + @aux_moussme
              if @aux_mocodmon = 'USD' begin 
                 set @nutihoy = @nutihoy + (@aux_momonmo * (@aux_motctra - @aux_mocostofo))
                end else begin 
                 set @nvolvta = @nvolvta + @aux_mouss30
                 set @nvoltot  = @nvoltot + @aux_mouss30
                 if @aux_mocodcnv = 'CLP' begin 
                   set @nvolcom = @nvolcom + @aux_moussme
                   set @nvoltot = @nvoltot + @aux_moussme
                 end
              end
            end else begin  -- venta
             set @nvolvta = @nvolvta + @aux_moussme
             set @nvoltot = @nvoltot + @aux_moussme
             if @aux_mocodmon = 'USD' begin 
                set @nutihoy = @nutihoy + (@aux_momonmo * (@aux_motctra - @aux_mocostofo))
               end else begin 
                set @nvolvta  = @nvolvta  + @aux_mouss30
                set @nvoltot  = @nvoltot  + @aux_mouss30
 	     if @aux_mocodcnv = 'CLP' begin 
                   set @nvolcom = @nvolcom + @aux_moussme
                   set @nvoltot = @nvoltot + @aux_moussme
                end
             end
             
       
           end 
           
          fetch Listado_cursor
          into @aux_mofecha
              ,@aux_motipmer 
              ,@aux_motipope 
              ,@aux_moussme  
              ,@aux_mocodmon 
              ,@aux_momonmo  
              ,@aux_motctra  
              ,@aux_mouss30  
              ,@aux_mocodcnv 
                  
          End 
        Close Listado_cursor
        Deallocate Listado_cursor
End
GO
