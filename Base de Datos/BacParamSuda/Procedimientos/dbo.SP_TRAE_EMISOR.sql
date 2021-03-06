USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_EMISOR]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TRAE_EMISOR    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_TRAE_EMISOR    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
CREATE PROCEDURE [dbo].[SP_TRAE_EMISOR](@xRut         NUMERIC(9))
AS
BEGIN
set nocount on
 SELECT emcodigo,
 emrut,
 emdv,
 emnombre,
 emgeneric,
 emdirecc,
 emcomuna,
 emtipo,
 emglosa,
 embonos
 FROM  EMISOR 
 WHERE emrut = @xRut
set nocount off
END
GO
