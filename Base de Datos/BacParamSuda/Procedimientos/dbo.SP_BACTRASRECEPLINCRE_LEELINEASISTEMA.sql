USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACTRASRECEPLINCRE_LEELINEASISTEMA]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_BacTrasRecepLinCre_LeeLineaSistema    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
CREATE PROCEDURE [dbo].[SP_BACTRASRECEPLINCRE_LEELINEASISTEMA]
 (@rut_cliente NUMERIC(9))
AS BEGIN
 SET NOCOUNT ON
 IF EXISTS(SELECT rut_cliente, id_sistema FROM LINEA_SISTEMA WHERE @rut_cliente = rut_cliente)
    BEGIN
  SELECT rut_cliente, id_sistema FROM LINEA_SISTEMA WHERE @rut_cliente = rut_cliente
    RETURN
 END
 SELECT 'NO HAY'
 SET NOCOUNT OFF
END
--SELECT * FROM LINEA_SISTEMA
GO
