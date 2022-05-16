USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPMDAC_BONEXT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OPMDAC_BONEXT]
-- Autor: JBH, 19-10-2009
-- Objetivo: Generar nuevo correlativo de operación para operación intermesas
 AS 
 BEGIN
 SET NOCOUNT ON
            
    DECLARE @acnumticket NUMERIC (10,0)
         
    SELECT @acnumticket=acnumticket FROM text_arc_ctl_dri

    UPDATE text_arc_ctl_dri
    SET acnumticket = acnumticket + 1
    SELECT @acnumticket
 SET NOCOUNT OFF
 RETURN        
 END

GO
