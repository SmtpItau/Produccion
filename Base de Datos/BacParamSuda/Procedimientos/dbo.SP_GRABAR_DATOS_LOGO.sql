USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_DATOS_LOGO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_DATOS_LOGO] (	@RUT_ENTIDAD				INT,
											@DIGITO_VERIFICADOR			VARCHAR(1),
											@CODIGO_ENTIDAD				INT,	
											@RAZON_SOCIAL				VARCHAR(200),
											@NOMBRE_FANTASIA			VARCHAR(200),
											@DIRECCION					VARCHAR(200),
											@TELEFONO					VARCHAR(200),
											@COMUNA						VARCHAR(200),
											@CIUDAD						VARCHAR(200)
										  )
 AS	
 BEGIN

	SET NOCOUNT ON  
   
	IF EXISTS (SELECT * FROM Contratos_ParametrosGenerales WHERE RUTENTIDAD=@RUT_ENTIDAD)
		BEGIN
			
			UPDATE Contratos_ParametrosGenerales
				SET RutEntidad = @RUT_ENTIDAD,
					DigitoVerificador=@DIGITO_VERIFICADOR,
					CodigoEntidad = @CODIGO_ENTIDAD,
					RazonSocial = @RAZON_SOCIAL,
					NombreFantasia = @NOMBRE_FANTASIA,
					DireccionLegal = @DIRECCION,
					TelefonoLegal = @TELEFONO,
					Comuna = @COMUNA,
					Ciudad = @CIUDAD
			WHERE RutEntidad=@RUT_ENTIDAD
		END
	ELSE
		BEGIN				
			INSERT INTO Contratos_ParametrosGenerales (
					RutEntidad,
					DigitoVerificador,
					CodigoEntidad,
					RazonSocial,
					NombreFantasia,
					DireccionLegal,
					TelefonoLegal,
					Comuna,
					Ciudad
					)
			VALUES (
					@RUT_ENTIDAD,
					@DIGITO_VERIFICADOR,
					@CODIGO_ENTIDAD,
					@RAZON_SOCIAL,
					@NOMBRE_FANTASIA,
					@DIRECCION,
					@TELEFONO,
					@COMUNA,
					@CIUDAD
				)
   
		END   
   SET NOCOUNT OFF  

 END
 

GO
