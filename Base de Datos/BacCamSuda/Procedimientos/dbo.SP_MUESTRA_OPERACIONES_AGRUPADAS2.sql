USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MUESTRA_OPERACIONES_AGRUPADAS2]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MUESTRA_OPERACIONES_AGRUPADAS2]
         (
             @MORUTCLI   NUMERIC(9)
            ,@MOTIPMER   CHAR(4)
            ,@MOTIPOPE   CHAR(1)
            ,@ESTADO     CHAR(1) 
         )
AS                            
BEGIN
   SET NOCOUNT ON
            SELECT 
                   'SUMA'    = ISNULL( SUM( momonmo ), 0)
                  ,'PROM'    = ISNULL( AVG( moticam ), 0)
            FROM MEMO
            WHERE morutcli   = @MORUTCLI
             AND  motipmer   = @MOTIPMER   
             AND  motipope   = @MOTIPOPE
             AND  moestatus  = @ESTADO
   SET NOCOUNT OFF
END

GO
