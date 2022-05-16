USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIOFLAGACTIVOTRAN]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_CambioFlagActivoTran    fecha de la secuencia de comandos: 03/04/2001 15:17:59 ******/
CREATE PROCEDURE [dbo].[SP_CAMBIOFLAGACTIVOTRAN]
  ( @numerooperacion NUMERIC(10))
AS
BEGIN
 SET NOCOUNT ON
 SELECT  LINEA_TRANSACCION.numerooperacion
 FROM  LINEA_TRANSACCION
 WHERE  LINEA_TRANSACCION.numerooperacion = @numerooperacion 
Begin
       update  LINEA_TRANSACCION
 set   activo ='N'
 where  LINEA_TRANSACCION.numerooperacion = @numerooperacion 
 
 if @@error<>0
         begin
     select 'error'
 end else
     begin
           select ' modifica'
 end
   set nocount off 
END
end
GO
