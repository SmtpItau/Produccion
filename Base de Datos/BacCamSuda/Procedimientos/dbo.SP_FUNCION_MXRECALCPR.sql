USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNCION_MXRECALCPR]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNCION_MXRECALCPR](  @aux_motipmer   char(4)       -- tipo operacion motipmer
            ,@aux_motipope   char(1)       -- tipo operacion c v motipope
     ,@aux_mototco    numeric(19,4) -- tipo cambio mototco
                                        ,@aux_moussme    numeric(19,4)
     ,@aux_xtotco     numeric(15,2) Out -- Variables de entrada salida
     ,@aux_xtotcop    numeric(15,2) Out
     ,@aux_xpmeco     numeric(10,4) Out
     ,@aux_xtotve     numeric(15,2) Out
     ,@aux_xtotvep    numeric(15,2) Out
     ,@aux_xpmeve     numeric(10,4) Out
     ,@aux_xtotcore   numeric(19,4) Out
     ,@aux_xtotcopre  numeric(19,4) Out
     ,@aux_xpmecore   numeric(19,4) Out
     ,@aux_xposic     numeric(15,2) Out
     ,@aux_xpohedge   numeric(19,2) Out
     ,@aux_xpohefut   numeric(19,4) Out
     ,@aux_xpohespt   numeric(19,4) Out
     ,@aux_xtotvere   numeric(19,4) Out
     ,@aux_xtotvepre  numeric(19,4) Out
                                        ,@aux_xpreini    numeric(10,4) Out
     ,@aux_xPosini    numeric(15,2) Out
     ,@aux_xprecie    numeric(10,4) Out
                                        ,@aux_xutili     numeric(15,2) out
                                       
                                    )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
declare @aux_futuro        char(4)  --  auxiliares para el cursor de tbafectoaposicion
declare @aux_rentabilidad  char(4)
declare @aux_trading       char(4)
declare @aux_posicion      char(4)
declare @aux_hedge         char(4)
declare @aux_nemo          char(4)
declare @qUtrading         numeric(10,4)
  /*=======================================================================*/
declare @xpFuturo   char(3)      -- F
select  @xpFuturo = 'F'
declare CalEfectosOpera_cursor cursor for
       Select futuro,rentabilidad,trading,posicion,hedge,nemo
       
         from   tbafectoaposicion
         where  nemo = @aux_motipmer
       open  CalEfectosOpera_cursor
       fetch CalEfectosOpera_cursor
               into  @aux_futuro
                    ,@aux_rentabilidad
                    ,@aux_trading
                    ,@aux_posicion
                    ,@aux_hedge
                    ,@aux_nemo
         while (@@fetch_status = 0)
            Begin
              -- Trading 
                                       
              if @aux_trading ='V' begin
 
                  if @aux_motipope='C' Begin
                     
                     set @aux_xtotco  = @aux_xtotco + @aux_moussme
                     set @aux_xtotcop = @aux_xtotcop + (@aux_moussme* @aux_mototco)
       set @aux_xpmeco  = Round((@aux_xtotcop/@aux_xtotco),4)
                   end else begin
                     
                     set @aux_xtotve  = @aux_xtotve + @aux_moussme
       set @aux_xtotvep = @aux_xtotvep + (@aux_moussme * @aux_mototco)
       set @aux_xpmeve  = Round((@aux_xtotvep/@aux_xtotve),4) 
                  end
           
                 if @aux_xtotco < @aux_xtotve begin  --  MxUtrading  
                    set @qUtrading = ( @aux_xPmeve - @aux_xPmeco)* @aux_xtotco
                   end else begin 
                    set @qUtrading = ( @aux_xPmeve - @aux_xPmeco)* @aux_xtotve
                end 
              End
         
              if @aux_rentabilidad='V' Begin
                  if @aux_motipope='C' Begin
                   
                     set @aux_xtotcore  = @aux_xtotcore + @aux_moussme                    --@aux_mouss30
       set @aux_xtotcopre = @aux_xtotcopre + ( @aux_moussme * @aux_mototco) -- =
       set @aux_xpmecore  = Round(( @aux_xtotcopre / @aux_xtotcore ),4)
                   end else begin
                   
                     set @aux_xtotvere  = @aux_xtotvere  + @aux_moussme                   --@aux_mouss30
       set @aux_xtotvepre = @aux_xtotvepre + ( @aux_moussme * @aux_mototco) -- =
       set @aux_xpmeve    = Round((@aux_xtotvepre/@aux_xtotvere),4)
                  end
               end 
               if @aux_posicion = 'V' Begin
                  if @aux_motipope = 'C' Begin
                    set @aux_xposic = @aux_xposic + @aux_moussme  --@aux_mouss30
                   end else begin
                    set @aux_xposic = @aux_xposic - @aux_moussme  --@aux_mouss30
                   end
               end 
               if @aux_hedge = 'V' Begin
                  if @aux_motipope = 'C' Begin
                     
                     if @xpFuturo <> 'V' begin   -- falso es cambio 
                        set @aux_xpohedge = @aux_xpohedge + @aux_moussme --@aux_mouss30
                        set @aux_xpohefut = 0
                        set @aux_xpohespt = @aux_xpohespt + @aux_moussme
                     end
                    end else begin 
                       if @xpFuturo <> 'F' begin   -- 
                          set @aux_xpohedge = @aux_xpohedge - @aux_moussme 
                          set @aux_xpohefut = 0
                          set @aux_xpohespt = @aux_xpohespt - @aux_moussme
                       end
                   end
                  
         end 
              
           execute sp_Funcion_MxUhedge  @aux_xtotco ,@aux_xtotve  ,@aux_xpmeco 
                                       ,@aux_xpmeve ,@aux_xpreini ,@aux_xPosini 
           ,@aux_xprecie,@aux_xutili  ,@aux_xpohedge OUT   
 
            fetch CalEfectosOpera_cursor
               into  @aux_futuro
                    ,@aux_rentabilidad
                    ,@aux_trading
                    ,@aux_posicion
                    ,@aux_hedge
                    ,@aux_nemo
                  
         End 
      Close CalEfectosOpera_cursor
      Deallocate CalEfectosOpera_cursor
end

GO
