USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INVEXETERIOR_ELIMINA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_InvExeterior_Elimina    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
CREATE PROCEDURE [dbo].[SP_INVEXETERIOR_ELIMINA]
 (@Rut_Cliente NUMERIC(9))
AS BEGIN
 SET NOCOUNT ON
 DELETE INVERSION_EXTERIOR WHERE rut_cliente=@Rut_Cliente
 SET NOCOUNT OFF
END
--SP_HELP INVERSION_EXTERIOR 
--Sp_InvExeterior_Busca 1
--Sp_InvExeterior_Elimina 1
GO
