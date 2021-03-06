USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_AVAL_CONT_DERIVADOS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACT_AVAL_CONT_DERIVADOS](	@Tipo_Accion		char(1)
						,	@Rut_Cliente		numeric(9, 0)
						,	@Cod_Cliente		int
						,	@Rut_Aval		numeric(9, 0)
						,	@DV_Aval		char(1)
						,	@Nombre_Aval		char(70)
						,	@Razon_Social_Aval	char(50)
						,	@Profesion_Aval		char(30)
						,	@Direccion_Aval		char(40)
						,	@Comuna_Aval		char(20)
						,	@Ciudad_Aval		char(30)
						,	@Rut_Apod_Aval_1	numeric(9, 0)
						,	@Dv_RAA_1		char(1)
						,	@Nom_Apod_Aval_1	char(70)
						,	@Rut_Apod_Aval_2	numeric(9, 0)
						,	@Dv_RAA_2		char(1)
						,	@Nom_Apod_Aval_2	char(70)
						,	@Regimen_Conyuga_Aval	char(50)
						,	@Rut_Conyuge_Aval	numeric(9, 0)
						,	@Dv_RCA			char(1)
						,	@Nom_Conyuge_Aval	char(70) 
						,	@Profesion_Conyuge_Aval	char(50))
AS
BEGIN
	SET NOCOUNT ON
	IF @Tipo_Accion ='I'
	BEGIN
		DELETE	TBL_AVAL_CLIENTE_DERIVADO
		WHERE	Rut_Cliente	= @Rut_Cliente
		AND	Cod_Cliente	= @Cod_Cliente
		AND	Rut_Aval	= @Rut_Aval
		AND	DV_Aval		= @DV_Aval
	

		INSERT INTO TBL_AVAL_CLIENTE_DERIVADO(		Rut_Cliente
							,	Cod_Cliente
							,	Rut_Aval
							,	DV_Aval
							,	Nombre_Aval
							,	Razon_Social_Aval
							,	Profesion_Aval
							,	Direccion_Aval
							,	Comuna_Aval
							,	Ciudad_Aval
							,	Rut_Apod_Aval_1
							,	Dv_RAA_1
							,	Nom_Apod_Aval_1
							,	Rut_Apod_Aval_2
							,	Dv_RAA_2
							,	Nom_Apod_Aval_2
							,	Regimen_Conyuga_Aval
							,	Rut_Conyuge_Aval
							,	Dv_RCA
							,	Nom_Conyuge_Aval
							,	Profesion_Conyuge_Aval)
						VALUES(		@Rut_Cliente
							,	@Cod_Cliente
							,	@Rut_Aval
							,	@DV_Aval
							,	@Nombre_Aval
							,	@Razon_Social_Aval
							,	@Profesion_Aval
							,	@Direccion_Aval
							,	@Comuna_Aval
							,	@Ciudad_Aval
							,	@Rut_Apod_Aval_1
							,	@Dv_RAA_1
							,	@Nom_Apod_Aval_1
							,	@Rut_Apod_Aval_2
							,	@Dv_RAA_2
							,	@Nom_Apod_Aval_2
							,	@Regimen_Conyuga_Aval
							,	@Rut_Conyuge_Aval
							,	@Dv_RCA
							,	@Nom_Conyuge_Aval
							,	@Profesion_Conyuge_Aval)
		SELECT 'OK'
		IF @@ERROR <> 0
		BEGIN
			SELECT -1, 'Error: al Ingresar Aval'
			RETURN 
		END

	END
	IF @Tipo_Accion ='D'
	BEGIN
		DELETE	TBL_AVAL_CLIENTE_DERIVADO
		WHERE	Rut_Cliente	= @Rut_Cliente
		AND	Cod_Cliente	= @Cod_Cliente
		AND	Rut_Aval	= @Rut_Aval
		AND	DV_Aval		= @DV_Aval

		SELECT 'OK'
		IF @@ERROR <> 0
		BEGIN
			SELECT -2, 'Error: al Eliminar Aval'
			RETURN 
		END
	END	
END
GO
