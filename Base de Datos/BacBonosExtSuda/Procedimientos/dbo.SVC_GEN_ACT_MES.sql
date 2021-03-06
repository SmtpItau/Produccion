USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_GEN_ACT_MES]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_GEN_ACT_MES] 
(
   @xValor CHAR(1)
)


AS
BEGIN

DECLARE @conta CHAR(1)
DECLARE @deven CHAR(1)

      SET NOCOUNT ON
	    SELECT @conta = (SELECT acsw_co FROM text_arc_ctl_dri)
            SELECT @deven = (SELECT acsw_dv FROM text_arc_ctl_dri)
            
	    IF (@conta ='1' or @deven ='1') and @xvalor='0' 
            BEGIN
               UPDATE text_arc_ctl_dri SET acsw_mesa = @xValor,acsw_dv = @xValor,acsw_co = @xValor
            END 
            ELSE 
            BEGIN
               UPDATE text_arc_ctl_dri SET acsw_mesa = @xValor             
            END

            IF @@ERROR <>0 
            BEGIN
            
                  SELECT 'ERROR'
            END 
            ELSE 
            BEGIN
                  SELECT 'OK'      
            END

      SET NOCOUNT OFF

END  


GO
