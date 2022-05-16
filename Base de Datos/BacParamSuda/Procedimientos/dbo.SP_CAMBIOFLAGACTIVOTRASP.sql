USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIOFLAGACTIVOTRASP]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_CambioFlagActivoTrasp    fecha de la secuencia de comandos: 03/04/2001 15:17:59 ******/
CREATE PROCEDURE [dbo].[SP_CAMBIOFLAGACTIVOTRASP]
  ( @numerooperacion NUMERIC(10))
AS
BEGIN
 SET NOCOUNT ON
 SELECT  LINEA_TRASPASO.numerooperacion
 FROM  LINEA_TRASPASO
 WHERE  LINEA_TRASPASO.numerooperacion = @numerooperacion 
Begin
       update  LINEA_TRASPASO
 set   activo ='N'
 where  LINEA_TRASPASO.numerooperacion = @numerooperacion 
 
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
