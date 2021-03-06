USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Calculos_Lineas]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Calculos_Lineas]
      (
             @ASIGNADO     FLOAT
         ,   @OCUPADO      FLOAT
         ,   @DISPONIBLE   FLOAT
         ,   @EXESO        FLOAT   
         ,   @CAP_BAS      FLOAT
      )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


    DECLARE @AUX_ASIGNADO      FLOAT
    ,       @AUX_OCUPADO       FLOAT
    ,       @AUX_DISPONIBLE    FLOAT
    ,       @AUX_EXESO         FLOAT
    ,       @AUX_CAP_BAS       FLOAT

   SELECT   @AUX_ASIGNADO   = ROUND((@CAP_BAS *@ASIGNADO)/100,0)
   ,        @AUX_OCUPADO    = @OCUPADO 
   ,        @AUX_DISPONIBLE = CASE WHEN @AUX_ASIGNADO >= @AUX_OCUPADO  THEN ( @AUX_ASIGNADO - @AUX_OCUPADO  ) END
   ,        @AUX_EXESO      = CASE WHEN @AUX_OCUPADO  >  @AUX_ASIGNADO THEN ( @AUX_OCUPADO  - @AUX_ASIGNADO ) END

   
   SELECT ISNULL( @AUX_ASIGNADO   , 0 )
    ,     ISNULL( @AUX_OCUPADO    , 0 )
    ,     ISNULL( @AUX_DISPONIBLE , 0 )
    ,     ISNULL( @AUX_EXESO      , 0 )


END



GO
