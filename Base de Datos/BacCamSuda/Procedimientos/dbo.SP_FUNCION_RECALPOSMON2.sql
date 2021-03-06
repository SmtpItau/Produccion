USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNCION_RECALPOSMON2]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNCION_RECALPOSMON2]  (
                                          @aux_mncodmon char(8)
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
declare  @aux_qposic  numeric(19,4)
SET @aux_qposic = ISNULL(@aux_qposic,0)
--set @aux_qposic =(select sum(vmposini) from memo,VIEW_VALOR_MONEDA,meac where vmfecha = ACFECPRO and @aux_mncodmon = vmcodigo  and motipope = @aux_motipope )
 PRINT @aux_qposic
        
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
       IF @aux_mocodmon = Ltrim(Rtrim(@aux_mncodmon)) begin    -- caso operaciones normales
          if @aux_motipope = 'C' begin 
             set @aux_qposic  =  @aux_qposic + @aux_moussme
            end else begin 
             set @aux_qposic  =  @aux_qposic - @aux_moussme
          end 
          PRINT @aux_qposic 
       end
      
       if @aux_mocodcnv = @aux_mncodmon begin -- caso de operaciones M/X
          if @aux_motipope = 'C' begin 
             set @aux_qposic  =  @aux_qposic + @aux_moussme
            end else begin 
             set @aux_qposic  =  @aux_qposic - @aux_moussme
           end    
        end
       If @aux_mocodmon = 'USD' begin 
 
        /*  If @aux_motipmer = '1446' begin          --1446    ???????????????????????????????
             if @aux_motipope = 'C' begin 
               set @aux_qposic  =  @qposic + @aux_mouss30
            end else begin 
              set @aux_qposic  =  @qposic - @aux_mouss30
            end    
           end
        */
          
         If @aux_motipmer ='ARRI' begin           --ARRI
           if @aux_motipope = 'C' begin 
             set @aux_qposic  =  @aux_qposic + @aux_mouss30
            end else begin 
             set @aux_qposic  =  @aux_qposic - @aux_mouss30
             PRINT @aux_qposic
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
             
       End 
      Close RecalPosMon_cursor
      Deallocate RecalPosMon_cursor
End
GO
