USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDPELEER]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MDPELeer    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDPELeer    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
CREATE PROCEDURE [dbo].[SP_MDPELEER]
AS
BEGIN
SET NOCOUNT ON
   SELECT pecodigo, peperiodo, penumero, petipo, peglosa FROM PERIODO_TASA_BIDASK
SET NOCOUNT OFF
END

GO
