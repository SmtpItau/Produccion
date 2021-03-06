USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SIID_ACTUALIZAR]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SIID_ACTUALIZAR]( 
 @ADQUISICION_PORCESION CHAR(1), 
 @COMPRENSION_CARTERA CHAR(1), 
 @FECHA DATETIME, 
 @OPERACION NUMERIC, 
 @PLATAFORMA CHAR(3), 
 @RUT_CEDENTE  CHAR(10),		--NUMERIC, 
 @RUT_INTERMEDIARIO CHAR(10),	--NUMERIC, 
 @SISTEMA CHAR(3), 
 @TERMINO_ANTICIPADO CHAR(3), 
 @TERMINO_CESION CHAR(1), 
 @TIPO_MODIFICACION CHAR(1), 
 @USUARIO CHAR(15)) 
 AS 
 BEGIN
 --SI EXISTE EL REGISTRO, SE ACTUALIZA CON LOS PARÁMETROS 
IF EXISTS(SELECT Operacion FROM SIID WHERE  Sistema=@Sistema AND  Operacion=@Operacion)
BEGIN
	UPDATE SIID  
	SET 
		Adquisicion_PorCesion	=	@Adquisicion_PorCesion, 
		Tipo_Modificacion		=	@Tipo_Modificacion, 
		Termino_Cesion			=	@Termino_Cesion, 
		Rut_Cedente				=	@Rut_Cedente, 
		Rut_Intermediario		=	@Rut_Intermediario,
		FechaActualizacion		=	getdate()
	WHERE   Sistema=@Sistema AND  Operacion=@Operacion
 END
 ELSE
 BEGIN
	--SI NO EXISTE EL REGISTRO, SE CREA CON LOS PARÁMETROS
	 INSERT INTO SIID( Adquisicion_PorCesion,  Comprension_Cartera,  Fecha,  Operacion,  Plataforma,  Rut_Cedente,  Rut_Intermediario,  Sistema,  Termino_Anticipado,  Termino_Cesion,  Tipo_Modificacion,  Usuario,FechaActualizacion)
	 VALUES ( @Adquisicion_PorCesion,  @Comprension_Cartera,  @Fecha,  @Operacion,  @Plataforma,  @Rut_Cedente,  @Rut_Intermediario,  @Sistema,  @Termino_Anticipado,  @Termino_Cesion,  @Tipo_Modificacion,  @Usuario, getdate())
 END

 END

GO
