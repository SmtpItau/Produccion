USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FRMMANTENEDORSUCURSAL_TRAEDATOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FRMMANTENEDORSUCURSAL_TRAEDATOS]
AS
BEGIN
      SET NOCOUNT ON
      SELECT       codigo_sucursal
                  ,nombre
      
      FROM  VIEW_SUCURSAL
      ORDER BY nombre
      SET NOCOUNT OFF
END


GO
