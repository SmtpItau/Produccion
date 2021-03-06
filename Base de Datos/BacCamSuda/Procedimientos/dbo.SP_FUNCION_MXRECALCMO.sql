USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNCION_MXRECALCMO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNCION_MXRECALCMO]( -- varaibles de Entrada Salida
                                          @xMercado Char(5) 
                                         ,@aux_xpreini    numeric(10,4) Out
      ,@aux_xtotco     numeric(15,2) Out
      ,@aux_xpmeco     numeric(10,4) Out
                                         ,@aux_xpmeve     numeric(10,4) Out
                                         ,@aux_xprecie    numeric(10,4) Out
                                         ,@aux_xpohedge   numeric(19,2) Out
                                         ,@aux_xtotcop    numeric(15,2) Out
      ,@aux_xtotve     numeric(15,2) Out
      ,@aux_xtotvep    numeric(15,2) Out
      ,@aux_xtotcore   numeric(19,4) Out
      ,@aux_xtotcopre  numeric(19,4) Out
      ,@aux_xpmecore   numeric(19,4) Out
      ,@aux_xposic     numeric(15,2) Out
             ,@aux_xpohefut   numeric(19,4) Out
      ,@aux_xpohespt   numeric(19,4) Out
      ,@aux_xtotvere   numeric(19,4) Out
      ,@aux_xtotvepre  numeric(19,4) Out
                                     ,@aux_xtotvepcp  numeric(19,2) Out 
      ,@aux_xtotcocp   numeric(19,4) Out
      ,@aux_xtotcopcp  numeric(19,2) Out
         ,@aux_xtotvecp   numeric(19,4) Out
      ,@aux_xpmecocpci numeric(15,4) Out
      ,@aux_xpmecocp   numeric(15,4) Out
      ,@aux_xpmevecpci numeric(15,4) Out
      ,@aux_xpmevecp   numeric(15,4) Out
                                         ,@aux_xuticoCP   numeric(15,2) Out
       ,@aux_xutiveCP   numeric(15,2) Out
                                         ,@aux_xposini    numeric(15,2) Out
       ,@aux_xPoHeFui   numeric(15,4) Out
       ,@aux_xPoHeSpi   numeric(19,4) Out
        ,@aux_xpmevere   numeric(19,4) Out
      ,@aux_xutili     numeric(15,2) Out
      ,@aux_xutilicp   numeric(9,2)  Out
                                         ,@valorRetorno   numeric(19,4) 
                                         ,@aux_prheini    numeric(15,4) out
     )
AS
BEGIN
SET NOCOUNT ON
Declare @aux_mouss30   numeric(19,4)  
       ,@aux_momonmo   numeric(19,4)    
       ,@aux_motipope  char(1)
       ,@aux_mocodcnv  char(3)  
       ,@aux_mototco   numeric(19,4)    
       ,@aux_moussme   numeric(19,4)
       ,@aux_monumfut  numeric(8)  
       ,@aux_motipmer  char(4)
       ,@aux_moticam   numeric(19,4)
       ,@aux_motctra   numeric(19,4)
       ,@aux_mocodmon  char(3)
       ,@aux_monumope  numeric(7)
       ,@aux_moparme   numeric(19,8)
       ,@aux_mopartr   numeric(19,8)
   
       ,@qUtrading     numeric(9,4)
       ,@Pfuturo       Char(1)     
       ,@Valorx        numeric(19,4) 
       ,@conta         numeric(5)
set @conta = 0
set @Pfuturo = 'V'
select 'mouss30' = mouss30
      ,'momonmo' = momonmo
      ,'motipope'= motipope
      ,'mocodcnv'= mocodcnv
      ,'mototco '= mototco
      ,'moussme '= moussme
      ,'monumfut'= monumfut
      ,'motipmer'= motipmer
      ,'moticam '= moticam
      ,'motctra '= motctra
      ,'mocodmon'= mocodmon
      ,'monumope'= monumope
      ,'moparme '= moparme
      ,'mopartr '= mopartr
      ,'monumfut'= monumfut     
   into #aux_memo  -- tabla temporal 
    FROM memo
 Declare MxRecal_cursor cursor for
       Select  mouss30,momonmo,motipope,mocodcnv,mototco,moussme,monumfut
              ,motipmer,moticam,motctra,mocodmon,monumope,moparme,mopartr,monumfut
              from #aux_memo
       open MxRecal_cursor
       fetch MxRecal_cursor
               into @aux_mouss30      
                   ,@aux_momonmo       
                   ,@aux_motipope     
                   ,@aux_mocodcnv   
                   ,@aux_mototco  
                   ,@aux_moussme  
     ,@aux_monumfut
                   ,@aux_motipmer
     ,@aux_moticam
            ,@aux_motctra
                   ,@aux_mocodmon
                   ,@aux_monumope
                   ,@aux_moparme
                   ,@aux_mopartr
                   ,@aux_monumfut
         while (@@fetch_status = 0)
           Begin  
           execute sp_funcion_MxMtoUsd30 @aux_mocodmon,@aux_momonmo,@valorRetorno out  -- Ok
           update memo set mouss30 = @valorRetorno Where monumope = @aux_monumope 
         
             if @aux_monumfut = 0 begin                      --@Pfuturo <> 'F'  begin        
                 if @aux_moussme = 0 begin              -- MxReCalcTx
                  select @aux_moussme = @aux_mouss30 
                 end
             -- ,@aux_mouss30  insertar 
                 execute sp_Func_MxRecalcPR  @aux_motipmer    ,@aux_motipope    ,@aux_mototco     ,@aux_moussme -- Variables del cursor
                                               ,@aux_xtotco   Out,@aux_xtotcop Out ,@aux_xpmeco Out  ,@aux_xtotve Out      
                                               ,@aux_xtotvep  Out,@aux_xpmeve  Out ,@aux_xtotcore Out,@aux_xtotcopre Out 
            ,@aux_xpmecore Out,@aux_xposic Out  ,@aux_xpohedge Out,@aux_xpohefut  Out
                          ,@aux_xpohespt Out,@aux_xtotvere Out,@aux_xtotvepre Out
                                               ,@aux_xpreini     ,@aux_xposini     ,@aux_xprecie     , @aux_xutili out
                                               ,@aux_prheini  out
                if @aux_mocodcnv = 'USD'  begin
                  if @aux_motipope = 'C' begin 
                      execute sp_Func_MxRecalcPR  @aux_motipmer    ,'V'              ,@aux_mototco  ,@aux_moussme     -- Variables del cursor
                                                    ,@aux_xtotco  Out ,@aux_xtotcop Out ,@aux_xpmeco Out  ,@aux_xtotve Out                 -- Acumulares de VB
                                                    ,@aux_xtotvep Out ,@aux_xpmeve  Out ,@aux_xtotcore Out,@aux_xtotcopre Out 
                 ,@aux_xpmecore Out,@aux_xposic Out  ,@aux_xpohedge Out,@aux_xpohefut  Out
                               ,@aux_xpohespt Out,@aux_xtotvere Out,@aux_xtotvepre Out
                                                    ,@aux_xpreini     ,@aux_xposini     ,@aux_xprecie     , @aux_xutili out
                                                    ,@aux_prheini  out
                   end else begin 
                     execute sp_Func_MxRecalcPR  @aux_motipmer     ,'V'              ,@aux_mototco ,@aux_moussme     -- Variables del cursor
                                                    ,@aux_xtotco  Out ,@aux_xtotcop Out ,@aux_xpmeco Out  ,@aux_xtotve Out                -- Acumulares de VB
                                                    ,@aux_xtotvep Out ,@aux_xpmeve  Out ,@aux_xtotcore Out,@aux_xtotcopre Out 
                 ,@aux_xpmecore Out,@aux_xposic Out  ,@aux_xpohedge Out,@aux_xpohefut  Out
                               ,@aux_xpohespt Out,@aux_xtotvere Out,@aux_xtotvepre Out
          ,@aux_xpreini     ,@aux_xposini     ,@aux_xprecie     , @aux_xutili out
                                                    ,@aux_prheini  out
                end
               end     -- end if USD
               If @aux_motipmer = 'EMPRE' BEGIN        --MxcalcVolCorp
                  If @aux_motipope = 'C' Begin 
                     select @aux_xtotcocp  = @aux_xtotcocp + @aux_moussme  
                     select @aux_xtotcopcp = @aux_xtotcopcp + Round(@aux_moussme*@aux_moticam,0)
       select @aux_xpmecocpci= Round((@aux_xtotcopcp/@aux_xtotcocp),4)
                     select @aux_xpmecocp    = Round((@aux_xtotcopcp/@aux_xtotcocp),4)
                    End Else Begin                 
                     select @aux_xtotvecp  = @aux_xtotcocp + @aux_moussme  
                     select @aux_xtotvepcp = @aux_xtotcopcp + Round(@aux_moussme*@aux_moticam,0)
       select @aux_xpmevecpci= Round((@aux_xtotvepcp/@aux_xtotvecp),4)
                     select @aux_xpmevecp  = Round((@aux_xtotvepcp/@aux_xtotvecp),4) 
                  End 
                 IF @aux_mocodmon <> 'USD' BEGIN 
                     If @aux_motipope = 'C' Begin  
                   select @aux_xtotvecp  = @aux_xtotcocp + @aux_moussme  
                        select @aux_xtotvepcp = @aux_xtotcopcp + Round(@aux_moussme*@aux_moticam,0)
           select @aux_xpmevecpci= Round((@aux_xtotvepcp/@aux_xtotvecp),4)
                        select @aux_xpmevecp  = Round((@aux_xtotvepcp/@aux_xtotvecp),4)   
                       End Else Begin 
                        select @aux_xtotcocp  = @aux_xtotcocp + @aux_moussme  
                        select @aux_xtotcopcp = @aux_xtotcopcp + Round(@aux_moussme*@aux_moticam,0)
                 select @aux_xpmecocpci= Round((@aux_xtotcopcp/@aux_xtotcocp),4)
                        select @aux_xpmecocp    = Round((@aux_xtotcopcp/@aux_xtotcocp),4)   
                     end 
                  If @aux_mocodcnv = 'CLP' Begin 
                     If @aux_motipope = 'C' Begin 
                        select @aux_xtotcocp  = @aux_xtotcocp + @aux_moussme  
                        select @aux_xtotcopcp = @aux_xtotcopcp + Round(@aux_moussme*@aux_moticam,0)
                 select @aux_xpmecocpci= Round((@aux_xtotcopcp/@aux_xtotcocp),4)
                        select @aux_xpmecocp  = Round((@aux_xtotcopcp/@aux_xtotcocp),4)
                       End Else Begin 
                        select @aux_xtotvecp  = @aux_xtotcocp + @aux_moussme  
                        select @aux_xtotvepcp = @aux_xtotcopcp + Round(@aux_moussme*@aux_moticam,0)
           select @aux_xpmevecpci= Round((@aux_xtotvepcp/@aux_xtotvecp),4)
                        select @aux_xpmevecp  = Round((@aux_xtotvepcp/@aux_xtotvecp),4)
                      End
                  End
                 End
              End
              --************************
              Execute sp_funcion_MxCalcRenCorp @aux_motipope,@aux_mocodmon,@aux_moticam,@aux_motctra
                                              ,@aux_moparme ,@aux_mopartr ,@aux_momonmo,@aux_moussme
                                              ,@aux_xUticoCP Out,@aux_xUtiveCP Out 
 
              If @aux_xtotco < @aux_xtotve Begin   -- MxUtrading
                  Select  @qUtrading = (@aux_xpmevecpci- @aux_xpmecocpci)* @aux_xtotco -- =acutili
                 End Else Begin 
                  Select  @qUtrading = (@aux_xpmevecpci- @aux_xpmecocpci)* @aux_xtotve
              End
            
               fetch MxRecal_cursor
               into @aux_mouss30      
                   ,@aux_momonmo       
                   ,@aux_motipope      
                   ,@aux_mocodcnv   
                   ,@aux_mototco  
                   ,@aux_moussme  
     ,@aux_monumfut
                   ,@aux_motipmer
                   ,@aux_moticam
     ,@aux_motctra
                   ,@aux_mocodmon
                   ,@aux_monumope
                   ,@aux_moparme
                   ,@aux_mopartr
            End 
       
     End  --
    Close MxRecal_cursor
    Deallocate MxRecal_cursor
   execute sp_funcion_MxRecPsMx     -- Recalcula posicion de una moneda
/*
-- @xMercado @aux_xposinic @aux_xuhedge
   
   print @aux_xpreini 
   print @aux_xposic
   print @aux_xpmeco
   print @aux_xpmeve
   print @aux_xtotco
   print @aux_xtotve
   print @aux_xtotcop
   print @aux_xtotvep
   print @aux_xpmecore
   print @aux_xpmevere
   print @aux_xtotcore
   print @aux_xtotvere
   print @aux_xtotcopre
   print @aux_xtotvepre
   print @aux_xutili
   print @aux_xprecie
   print @aux_xPoHeFui
   print @aux_xPoHeSpi
   print @aux_xPoHeFut
   print @aux_xPoHeSpt
   print @aux_xtotcocp
   print @aux_xtotvecp    
   print @aux_xtotcopcp
   print @aux_xtotvepcp
   print @aux_xutilicp
   print @aux_xpmecocp
   print @aux_xpmevecp
   print @aux_xpmecocpci  
   print @aux_xpmevecpci
   print @aux_xuticocp
   print @aux_xutivecp 
   print @aux_xpohedge 
*/
   execute sp_Funcion_GrabaParametros xMercado,@aux_xpreini,@aux_xposini,@aux_xposic,@aux_xpmeco,@aux_xpmeve,@aux_xtotco
                                     ,@aux_xtotve,@aux_xtotcop,@aux_xtotvep,@aux_xpmecore,@aux_xpmevere,@aux_xtotcore
                                     ,@aux_xtotvere,@aux_xtotcopre,@aux_xtotvepre,@aux_xutili,@aux_xprecie,@aux_xPoHeFui
                                     ,@aux_xPoHeSpi,@aux_xPoHeFut,@aux_xPoHeSpt,@aux_xpohedge ,@aux_xtotcocp,@aux_xtotvecp    
                                     ,@aux_xtotcopcp,@aux_xtotvepcp,@aux_xutilicp,@aux_xpmecocp,@aux_xpmevecp,@aux_xpmecocpci  
                                     ,@aux_xpmevecpci,@aux_xuticocp,@aux_xutivecp
End

GO
