USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNCION_MXRECALCAR]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNCION_MXRECALCAR]( 
                                        @aux_xtotco     numeric(10) Out -- Variables de entrada salida
     ,@aux_xtotcop    numeric(10) Out
     ,@aux_xpmeco     numeric(10) Out
     ,@aux_xtotve     numeric(10) Out
     ,@aux_xtotvep    numeric(10) Out
     ,@aux_xpmeve     numeric(10) Out
     ,@aux_xtotcore   numeric(10) Out
     ,@aux_xtotcopre  numeric(10) Out
     ,@aux_xpmecore   numeric(10) Out
     ,@aux_xposic     numeric(10) Out
     ,@aux_xpohedge   numeric(10) Out
     ,@aux_xpohefut   numeric(10) Out
     ,@aux_xpohespt   numeric(10) Out
     ,@aux_xtotvere   numeric(10) Out
     ,@aux_xtotvepre  numeric(10) Out
      
           )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
Declare   
        @aux_arbcodcnv  char(3)
       ,@aux_arbtipope  char(1)
       ,@aux_arbmtomus  numeric(9,4)
       ,@aux_arbticamx  numeric(9,4)
       ,@Pfuturo        Char(1)  --F    
select @Pfuturo = 'V'
Declare MxReCalcAr_cursor cursor for
        Select arbcodcnv ,arbtipope,arbmtomus,arbticamx,arbcodmon 
              from mearb where arbcodcnv <> 'BREC'
           
open MxReCalcAr_cursor
fetch MxReCalcAr_cursor
Into  @aux_arbcodcnv
     ,@aux_arbtipope
     ,@aux_arbmtomus 
     ,@aux_arbticamx  
  While (@@fetch_status = 0)
  Begin
Execute sp_Funcion_MxRecalcPR @aux_arbcodcnv,@aux_arbtipope,@aux_arbmtomus ,@aux_arbticamx,'USD' 
       ,@aux_xtotco,@aux_xtotcop,@aux_xpmeco,@aux_xtotve,@aux_xtotvep,@aux_xpmeve,@aux_xtotcore,@aux_xtotcopre -- Acumulares de VB
       ,@aux_xpmecore,@aux_xposic,@aux_xpohedge,@aux_xpohefut,@aux_xpohespt,@aux_xtotvere,@aux_xtotvepre
  End -- while 
  Fetch MxReCalcAr_cursor
  Into  @aux_arbcodcnv
       ,@aux_arbtipope
       ,@aux_arbmtomus 
       ,@aux_arbticamx  
End

GO
