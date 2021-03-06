USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOSISTEMA_ELIMINA_XSISTEMA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOSISTEMA_ELIMINA_XSISTEMA]
  
  (
  @rut_cliente  numeric(9),
  @codigo_cliente  numeric(9),
  @id_sistema  char(3)
  )  
AS
BEGIN
 SET NOCOUNT ON
  IF EXISTS( SELECT 1 FROM LINEA_SISTEMA WHERE rut_cliente= @rut_cliente AND
        codigo_cliente = @codigo_cliente AND
        id_sistema = @id_sistema)
  BEGIN
   DELETE FROM LINEA_SISTEMA WHERE rut_cliente= @rut_cliente AND
        codigo_cliente = @codigo_cliente AND
        id_sistema = @id_sistema
   SELECT 'ELIMINADO'
  END
  ELSE BEGIN
   SELECT 'NO EXISTE'   
  END
 SET NOCOUNT OFF
END

GO
