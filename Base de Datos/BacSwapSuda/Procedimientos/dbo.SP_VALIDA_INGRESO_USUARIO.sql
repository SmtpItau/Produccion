USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_INGRESO_USUARIO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_INGRESO_USUARIO]
               ( @Usuario CHAR(15) )
AS

BEGIN

 SET NOCOUNT ON

	SELECT	Clave, 
		Tipo_Usuario, 
		convert(char(10),Fecha_Expira,103), 
  Cambio_Clave,
  Dias_Expiracion,
  Largo_Clave,
  Tipo_Clave
 FROM  BacParamSuda.dbo.USUARIO with(nolock)
	WHERE 	Usuario = @Usuario

END
GO
