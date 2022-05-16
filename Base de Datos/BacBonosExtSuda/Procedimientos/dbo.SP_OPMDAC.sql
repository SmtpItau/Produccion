USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPMDAC]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_OPMDAC]
 AS 
 BEGIN
 SET NOCOUNT ON
            
    DECLARE @acnumoper NUMERIC (10,0)
         
    SELECT @acnumoper=acnumoper FROM text_arc_ctl_dri

    UPDATE text_arc_ctl_dri
    SET acnumoper = acnumoper + 1

	--//**** PRD-21033 Para actualizar el Correlativo del N° Oper. de Bonex NY ****//
	UPDATE BacBonosExtNY..text_arc_ctl_dri
    SET acnumoper = acnumoper + 1
	--//***************//

    SELECT @acnumoper
 SET NOCOUNT OFF
 RETURN        
 END


GO
