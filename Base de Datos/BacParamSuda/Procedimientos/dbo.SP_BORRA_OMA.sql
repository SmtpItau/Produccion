USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_OMA]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Borra_OMA    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Borra_OMA    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BORRA_OMA]( @codigo   NUMERIC (03))
AS
BEGIN
--iF NOT EXISTS (SELECT codigo_numerico FROM Ayuda_Planilla WHERE codigo_tabla = 14 AND codigo_numerico = @codigo)
   DELETE AYUDA_PLANILLA 
    WHERE codigo_tabla    = 14
      AND codigo_numerico = @codigo
END             
GO
