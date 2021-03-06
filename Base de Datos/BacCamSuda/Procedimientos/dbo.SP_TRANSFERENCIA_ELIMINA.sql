USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRANSFERENCIA_ELIMINA]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[SP_TRANSFERENCIA_ELIMINA] 
         ( 
             @numeroopera  NUMERIC (10) 
            ,@USUARIO      CHAR(15)
         )
AS 
BEGIN
   UPDATE MEMO SET 
         moestatus   =   'A'
        ,anula_usuario   = @USUARIO
        ,anula_fecha     = ( SELECT acfecpro FROM MEAC )
        ,anula_hora      = CONVERT ( CHAR(10) , GETDATE(), 108 )
        ,anula_motivo    = ''
        ,codigo_area     = ''
   WHERE monumope    =   @numeroopera 
     AND motipope    =   'C'
END 



GO
