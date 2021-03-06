USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_INGRESO_USUARIO]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VALIDA_INGRESO_USUARIO]
               ( @USUARIO CHAR(15) )
AS
BEGIN

 SET NOCOUNT ON

 SELECT CLAVE, 
  TIPO_USUARIO, 
  CONVERT(CHAR(10),FECHA_EXPIRA,103), 
  Cambio_Clave,
  Dias_Expiracion,
  Largo_Clave,
  Tipo_Clave
 FROM  BacParamSuda.dbo.USUARIO with(nolock)
 WHERE  Usuario = @Usuario

END
GO
