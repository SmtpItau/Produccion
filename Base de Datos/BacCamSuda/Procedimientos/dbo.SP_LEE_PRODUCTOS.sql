USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_PRODUCTOS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEE_PRODUCTOS]
AS
BEGIN
    SET NOCOUNT ON
 SELECT * FROM VIEW_PRODUCTO WHERE ID_SISTEMA  = 'BCC'
    SET NOCOUNT OFF
END
-- SELECT * FROM Rentabilidad_de_productos
--   SP_HELPTEXT sp_lee_Productos
-- SP_HELPtext sp_Grabar_Operaciones1446
-- SELECT * FROM VIEW_PRODUCTO WHERE ID_SISTEMA  = 'BCC'        

GO
