USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_TBL_PREPARA_OPERACIONES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_MNT_TBL_PREPARA_OPERACIONES]
   (
			@iTab			integer   
	   ,    @Sistema		char(3)		 	
	   ,    @CodOperacion   CHAR(1) = ''
	   ,	@NroOperacion	numeric(7,0)
	   ,	@Estado			CHAR(1) = ''
	   ,    @UserPrepara	varchar(15) = ''
	   ,    @FechaPrepara	datetime
	   ,	@UserEjecuta	varchar(15) = ''
	   ,	@FechaEjecuta	datetime	= NULL
	   ,	@Observacion	varchar(100) = ''
   )

AS
BEGIN

   /*RETORNO LOS REGISTROS DE TABLA PREPARA_OPERACIONES*/
   IF @iTab = 0
   BEGIN
		SELECT ID_SISTEMA,COD_OPERACION,NRO_OPERACION,ESTADO,USUARIO_PREPARA,FECHA_PREPARA,USUARIO_EJECUTA,FECHA_EJECUTA,OBSERVACION
		FROM   TBL_PREPARA_OPERACIONES
		WHERE	   ID_SISTEMA     = @Sistema
			AND	   NRO_OPERACION = @NroOperacion
	END

	/*ELIMINACION DE REGISTROS TABLA PREPARA_OPERACIONES*/
	IF @iTab = 2
	BEGIN
		DELETE FROM TBL_PREPARA_OPERACIONES
			WHERE ID_SISTEMA   = @Sistema
				AND NRO_OPERACION =  @NroOperacion
	END

	/*ACTUALIZACION DE REGISTROS TABLA PREPARA_OPERACIONES*/
	IF @iTab = 3
	BEGIN
		UPDATE TBL_PREPARA_OPERACIONES SET COD_OPERACION = @CodOperacion , ESTADO=@Estado
				,USUARIO_PREPARA=@UserPrepara, FECHA_PREPARA = @FechaPrepara,OBSERVACION = @Observacion
			WHERE ID_SISTEMA   = @Sistema
				AND NRO_OPERACION =  @NroOperacion
	END
	/*REGISTRO DE UNA NUEVA PREPARACION DE OPERACIONES */
	IF @iTab = 4
	BEGIN
		INSERT INTO TBL_PREPARA_OPERACIONES(ID_SISTEMA,COD_OPERACION,NRO_OPERACION,ESTADO,USUARIO_PREPARA,FECHA_PREPARA,USUARIO_EJECUTA,FECHA_EJECUTA,OBSERVACION)
				VALUES( @Sistema,@CodOperacion,@NroOperacion,@Estado,@UserPrepara,@FechaPrepara,@UserEjecuta,@FechaEjecuta,@Observacion)
	END
END

GO
