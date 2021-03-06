USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_GRABA_PRIVILEGIOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_GRABA_PRIVILEGIOS]
	(	@Tipo			CHAR(1)
	,	@Nombre			VARCHAR(20)
	,	@Opcion			VARCHAR(20)
	,	@Habilitado		INT
	)
AS
BEGIN

	SET NOCOUNT ON 

	IF EXISTS( SELECT 1 FROM dbo.SADP_PRIVILEGIOS WHERE Tipo = @Tipo AND Nombre = @Nombre AND Opcion = @Opcion )
	BEGIN
		UPDATE dbo.SADP_PRIVILEGIOS
		   SET Habilitado = @Habilitado
		 WHERE Tipo		  = @Tipo
		   AND Nombre	  = @Nombre
		   AND Opcion	  = @Opcion
	END ELSE
	BEGIN
		INSERT INTO dbo.SADP_PRIVILEGIOS
		SELECT Tipo		  = @Tipo 
			,  Nombre	  = @Nombre
			,  Opcion	  = @Opcion 
			,  Habilitado = @Habilitado 
	END


	IF EXISTS( SELECT 1 FROM dbo.SADP_PRIVILEGIOS WHERE Tipo = @Tipo AND Nombre = @Nombre AND Opcion = 'MNU_SADP' )
	BEGIN
		UPDATE dbo.SADP_PRIVILEGIOS 
		   SET Habilitado = 1
		 WHERE Tipo		  = @Tipo 
		   AND Nombre	  = @Nombre 
		   AND Opcion	  = 'MNU_SADP'
	END ELSE
	BEGIN
		INSERT INTO dbo.SADP_PRIVILEGIOS SELECT @Tipo, @Nombre, 'MNU_SADP', 1
	END

	IF EXISTS( SELECT 1 FROM dbo.SADP_PRIVILEGIOS WHERE Tipo = @Tipo AND Nombre = @Nombre AND Opcion = 'MNU_00009' )
	BEGIN
		UPDATE dbo.SADP_PRIVILEGIOS 
		   SET Habilitado = 1
		 WHERE Tipo		  = @Tipo 
		   AND Nombre	  = @Nombre 
		   AND Opcion	  = 'MNU_00009'
	END ELSE
	BEGIN
		INSERT INTO dbo.SADP_PRIVILEGIOS SELECT @Tipo, @Nombre, 'MNU_00009', 1
	END

END
GO
