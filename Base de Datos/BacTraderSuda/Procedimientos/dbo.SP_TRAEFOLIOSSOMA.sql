USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEFOLIOSSOMA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_TRAEFOLIOSSOMA]
             (  @Fecha      Datetime
              , @TipOper    CHAR(3)
             )
AS BEGIN

 SET NOCOUNT ON

  if exists(SELECT 1
    FROM CARGASOMA  
    WHERE Fecha_Proceso  = @Fecha
    AND   FolioBCCH <> 0
    AND   CorrelaBCCH <> 0 )     

    SELECT  DISTINCT FolioBCCH, Numoper
    FROM CARGASOMA  
    WHERE Fecha_Proceso  = @Fecha
    AND   FolioBCCH <> 0
    AND   CorrelaBCCH <> 0
 else 
    SELECT  0, 0


 SET NOCOUNT OFF

END   /* fin procedimiento */

GO
