USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Campo_cnt_logico_X_Producto]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Campo_cnt_logico_X_Producto] 
   (   @producto            VARCHAR(5)
   ,   @codigo_condicion    VARCHAR(15) = ''
   )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


    SELECT  
             codigo_condicion 
            ,descripcion
            ,codigo_campo
            ,productos  
            ,CHARINDEX(@producto, productos )
           
    FROM CAMPO_LOGICO

    WHERE   CHARINDEX(@producto, productos ) > 0
      AND   (codigo_condicion = @codigo_condicion OR @codigo_condicion= '' )
   

    SET NOCOUNT OFF

END     







GO
