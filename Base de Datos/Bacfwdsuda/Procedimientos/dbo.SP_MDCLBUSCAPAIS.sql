USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLBUSCAPAIS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDCLBUSCAPAIS] ( @npais  NUMERIC ( 05 ) )
AS
BEGIN
   SET NOCOUNT ON
   SELECT 'retorno' = CASE WHEN RTRIM ( nombre ) LIKE '%CHILE%' THEN
                         '1'
                      ELSE
                        '0'
                      END
   FROM   view_pais
   WHERE  codigo_pais = @npais
   SET NOCOUNT OFF 
END

GO
