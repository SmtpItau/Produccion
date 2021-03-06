USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_INGRESO_USUARIO]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SP_VALIDA_INGRESO_USUARIO]
               ( @Usuario CHAR(15) )
AS

BEGIN

 SET NOCOUNT ON

	SELECT	Clave,
                Tipo_Usuario, 
                convert(char(10), Fecha_Expira,103),
  Cambio_Clave,
  Dias_Expiracion,
  Largo_Clave,
  Tipo_Clave
 FROM  BacParamSuda.dbo.USUARIO with(nolock)
	WHERE 	Usuario = @Usuario

END

GO
