USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNCION_RECALPOSMON]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNCION_RECALPOSMON]  (@aux_mncodmon  numeric(5)
                                         ,@aux_codmon char(3)
                                         )
AS
BEGIN
declare @aux_mocodmon char(3)
declare @aux_motipope char(1)
declare @aux_motipmer char(4)
declare @aux_momonmo  numeric(19,4)
declare @aux_moussme  numeric(19,4)
declare @aux_mouss30  numeric(19,4)
declare @aux_mocodcnv char(3)
declare @fechaPro     datetime
declare @aux_qposic   numeric(19,4)
set @fechaPro   = isnull(@fechaPro,(select acfecpro from  meac))
set @aux_qposic = ISNULL(@aux_qposic,(select vmposini from VIEW_VALOR_MONEDA,meac where  vmfecha = ACFECPRO and vmcodigo = @aux_mncodmon  ))
declare RecalPosMon_cursor cursor for
      Select mocodmon,motipope,momonmo,moussme,mouss30,mocodcnv,motipmer
      from   memo
      open  RecalPosMon_cursor
      fetch RecalPosMon_cursor
      into  @aux_mocodmon
    ,@aux_motipope
           ,@aux_momonmo 
           ,@aux_moussme
           ,@aux_mouss30 
           ,@aux_mocodcnv
           ,@aux_motipmer
      while (@@fetch_status = 0)
      Begin
       
      
       IF @aux_mocodmon = @aux_codmon begin    -- caso operaciones normales
          if @aux_motipope = 'C' begin 
             set @aux_qposic  =  @aux_qposic + @aux_moussme
            end else begin 
             set @aux_qposic  =  @aux_qposic - @aux_moussme
          end 
          
       end  
      
       if @aux_mocodcnv = @aux_codmon begin -- caso de operaciones M/X
          if @aux_motipope = 'C' begin 
             set @aux_qposic  =  @aux_qposic + @aux_moussme
            end else begin 
             set @aux_qposic  =  @aux_qposic - @aux_moussme
           end    
       end
       If @aux_mocodmon = 'USD' begin 
            
          If @aux_motipmer = 'VB2' begin          
             if @aux_motipope = 'C' begin 
               set @aux_qposic  = @aux_qposic + @aux_moussME
            end else begin 
              set @aux_qposic   = @aux_qposic - @aux_moussME
            end    
          end
         If @aux_motipmer ='ARRI' begin           --ARRI
           if @aux_motipope = 'C' begin 
             set @aux_qposic  =  @aux_qposic + @aux_moussME
            end else begin 
             set @aux_qposic  =  @aux_qposic - @aux_moussME
           end    
         end
        end  --usd
      fetch RecalPosMon_cursor
      into  @aux_mocodmon
    ,@aux_motipope
           ,@aux_momonmo 
           ,@aux_moussme
           ,@aux_mouss30 
           ,@aux_mocodcnv
           ,@aux_motipmer
             
       End --while
      Close RecalPosMon_cursor
      Deallocate RecalPosMon_cursor
End  --principal
UPDATE VIEW_VALOR_MONEDA SET vmposini = @aux_qposic where vmfecha = @fechaPro and vmcodigo = @aux_mncodmon  
/*
IF @@ERROR = 0 BEGIN 
    PRINT 'SIN ERRORES'
 END ELSE BEGIN 
     PRINT 'CON ERRORES'
END
*/

GO
