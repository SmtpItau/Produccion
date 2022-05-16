USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACON]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Bacon    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Bacon    fecha de la secuencia de comandos: 14/02/2001 09:58:22 ******/
CREATE PROCEDURE [dbo].[SP_BACON] 
AS
set nocount on
BEGIN
 SELECT  codigo,
  glosa,
  producto 
 
 FROM MEPP ORDER BY codigo 
END         
GO
