USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULAFPAGPEMX_DIARIOS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CALCULAFPAGPEMX_DIARIOS] ( @op_funcion     numeric(1)
                                             ,@xxfecha        datetime
                                             ,@aux_motipope   char(3) 
                                             ,@aux_moentre    numeric(2)
                                             ,@aux_morecib    numeric(2)
                                             ,@aux_tac_return numeric(2) out
                                             )
AS
BEGIN
SET NOCOUNT ON
set @aux_tac_return = isnull(@aux_tac_return,0)
/*=======================================================================*/
 if @OP_FUNCION = 1 Begin                 ---p11fpagmx1
   if DATEPART(dw,@xxfecha )=  5  BEGIN   --- VIERNES 
      if @aux_motipope = 'C' begin 
         set @aux_tac_return = @aux_moentre 
        end else begin 
         set @aux_tac_return = @aux_morecib 
      end
    if @aux_tac_return = 3 begin 
       set @aux_tac_return = 2 
    end
   end else begin 
    if @aux_motipope = 'C' begin 
       set @aux_tac_return = @aux_moentre
      end else begin
       set @aux_tac_return = @aux_morecib
    end
   end
  return 
 end else 
 if @OP_FUNCION = 2 begin                  ---p11fpagmx2
    if DATEPART(dw,@xxfecha )=  5  begin   --- VIERNES 
       if @aux_motipope = 'C' begin 
          set @aux_tac_return = @aux_morecib
         end else begin 
          set @aux_tac_return = @aux_moentre
       end
    if @aux_tac_return = 3 begin 
        set @aux_tac_return = 2
    end
  end else 
  if @aux_motipope = 'C' begin 
     set @aux_tac_return = @aux_morecib
    end else begin 
     set @aux_tac_return = @aux_moentre
  end
 
 end
IF @@ERROR <> 0 BEGIN
  ROLLBACK TRANSACTION
  SELECT -1, 'ERROR:  EN CALCULOS DIARIOS.'
  SET NOCOUNT OFF
  RETURN
END
End -- BEGIN




GO
