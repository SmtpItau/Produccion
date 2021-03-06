USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNCION_MXUHEDGE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNCION_MXUHEDGE]
					(@aux_moussme     numeric(19,4)  -- Variables de entrada salida
					,@aux_xtotve     numeric(15,2) 
					,@aux_xpmeco     numeric(10,4) 
					,@aux_xpmeve     numeric(10,4)  
					,@aux_xpreini    numeric(10,4) 
					,@aux_xPosihini  numeric(19,4) 
					,@aux_xprecie    numeric(10,4)  
					,@aux_xtotco     numeric(15,2) 
					,@aux_xpohedge   numeric(19,4) out
                                     )
      
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
Declare   
        @aux_nUtiCom  numeric(19,4)     
       ,@aux_nUtiVen  numeric(19,4)     
       ,@aux_Utili    numeric(19,4)
       ,@aux_motipope char(1)
       ,@aux_moticam  numeric(9,4)
       ,@aux_qUhedge  numeric(19,4)
set @aux_nUtiCom = 0
set @aux_nUtiVen = 0
if @aux_xtotve <@aux_moussme Begin 
     Set @aux_qUhedge=Abs(@aux_xPosihini)*(@aux_xPreini-@aux_xPrecie)+(@aux_xtotco-@aux_xTotve)*(@aux_xPrecie-@aux_xPmeco)
    End Else Begin 
     Set @aux_qUhedge=Abs(@aux_xPosihini)*(@aux_xPreini-@aux_xPrecie)+(@aux_xtotco-@aux_xTotve)*(@aux_xPrecie-@aux_xPmeve)
End
 Declare MxUhedge_cursor cursor for
        Select motipope,moussme,moticam
              from memo where motipmer <> 'BREC'
  open MxUhedge_cursor
  fetch MxUhedge_cursor
  Into   @aux_motipope 
        ,@aux_moussme  
        ,@aux_moticam  
  While (@@fetch_status = 0)
   Begin
    if @aux_motipope = 'C' Begin 
       select @aux_nUtiCom = @aux_nUtiCom + (@aux_moussme*@aux_moticam)     
     End Else Begin
       select @aux_nUtiVen = @aux_nUtiVen + (@aux_moussme*@aux_moticam)     
    End
  
   Fetch MxUhedge_cursor
   Into  @aux_motipope 
        ,@aux_moussme  
        ,@aux_moticam  
  End                                                     -- while 
  Close MxUhedge_cursor
  Deallocate MxUhedge_cursor
  select @aux_Utili    = ( @aux_nUtiVen - @aux_nUtiCom )
  select @aux_xpohedge = ( @aux_xpohedge + @aux_Utili  )        -- Retorna
  End

GO
