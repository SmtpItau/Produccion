USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDPEELIMINAR]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MDPEEliminar    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDPEEliminar    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
CREATE PROCEDURE [dbo].[SP_MDPEELIMINAR]
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   DELETE PERIODO_TASA_BIDASK
SET NOCOUNT OFF
SELECT 0
END

GO
