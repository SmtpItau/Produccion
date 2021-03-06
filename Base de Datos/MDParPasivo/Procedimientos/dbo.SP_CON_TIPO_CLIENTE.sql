USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TIPO_CLIENTE]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_TIPO_CLIENTE]
       (
         @nCodigo      NUMERIC(05)
       )
AS
BEGIN

   	SET DATEFORMAT DMY
	SET NOCOUNT ON
 
  SELECT          Codigo_Tipo_Cliente,
	           Descripcion
          FROM     TIPO_CLIENTE
          WHERE    Codigo_Tipo_Cliente = @nCodigo      OR
                   @nCodigo            = 0
          ORDER BY Codigo_Tipo_Cliente

END
GO
