USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CANJES_ELIMINA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CANJES_ELIMINA]
      (
          @numeroopera   NUMERIC(5)
         ,@tipomer       CHAR(4)
         ,@USUARIO       CHAR(15)          
      )
AS
BEGIN
   SET NOCOUNT ON
   
      UPDATE MEMO 
         SET moestatus       = 'A'  --anulado
            ,anula_usuario   = @USUARIO
            ,anula_fecha     = ( SELECT acfecpro FROM MEAC )
            ,anula_hora      = CONVERT ( CHAR(10) , GETDATE(), 108 )
            ,anula_motivo    = ''
            ,codigo_area     = ''
       WHERE monumope   =   @numeroopera
         AND motipmer   =   @tipomer
      SELECT 1
   SET NOCOUNT OFF
END 



GO
