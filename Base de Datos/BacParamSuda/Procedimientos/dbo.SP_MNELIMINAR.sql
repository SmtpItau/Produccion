USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNELIMINAR]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MNEliminar    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MNEliminar    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
CREATE PROCEDURE [dbo].[SP_MNELIMINAR] (@mncodmon1 NUMERIC(5,0))
AS
BEGIN
        DELETE FROM MONEDA WHERE  mncodmon = @mncodmon1
        RETURN
END

GO
