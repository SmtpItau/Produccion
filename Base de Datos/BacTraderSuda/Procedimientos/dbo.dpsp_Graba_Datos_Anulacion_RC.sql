USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[dpsp_Graba_Datos_Anulacion_RC]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[dpsp_Graba_Datos_Anulacion_RC] (
					@dFechaope	DATETIME,
					@noper VARCHAR(50), 
					@ncertificado varchar(13),
					@CodCtaCliente varchar(20),	-- Ejemplo '00390001001700870916'
					@secImposicion varchar(5)) -- Ejemplo '00176'
AS  
/***********************************************************************  
NOMBRE         : dbo.dpsp_Graba_Datos_Anulacion_RC  
AUTOR          : Interno Banco Itau Corpbanca  
FECHA CREACION : 30/09/2016  
DESCRIPCION    : Almacena Codigo cuenta Cliente para DAP ALTAMIRA y nuemro secuencia ALTAMIRA del corte para posterior utilización 
				en la anulación del DAP   
HISTORICO DE CAMBIOS  
FECHA        AUTOR           DESCRIPCION     
----------------------------------------------------------------------  
  
  
**********************************************************************/  
  
begin   
  
BEGIN TRAN  

SET NOCOUNT ON
IF NOT EXISTS(SELECT 1 FROM Relacion_Anulacion WHERE fecha_operacion = @dFechaope AND
													numero_operacion = @noper AND
													numero_certificado_dcv = @ncertificado)
BEGIN

	
	INSERT INTO Relacion_Anulacion VALUES (@dFechaope,
						@noper, 
						@ncertificado,
						@CodCtaCliente,	-- Ejemplo '00390001001700870916'
						@secImposicion) -- Ejemplo '00176')
	IF @@ERROR<> 0 
	BEGIN
		SELECT 'NO' as 'Estatus', 'PROBLEMAS AL GRABAR TABLA RELACION ANULACIONES' as 'MSG'
		ROLLBACK TRAN
	END
	ELSE
	BEGIN
		SELECT 'SI' as 'Estatus', 'GRABACION/ACTUALIZACION TABLA RELACION ANULACIONES OK' as 'MSG'
		COMMIT TRAN
	END
END
ElSE
BEGIN
	UPDATE Relacion_Anulacion 
	SET CodigoCtaCliente = @CodCtaCliente,
		SecImposicion = @secImposicion
	WHERE fecha_operacion = @dFechaope AND numero_operacion = @noper AND numero_certificado_dcv = @ncertificado
	IF @@ERROR<> 0 
	BEGIN
		SELECT 'NO' as 'Estatus', 'PROBLEMAS AL ACTUALIZAR TABLA RELACION ANULACIONES' as 'MSG'
		ROLLBACK TRAN
	END
	ELSE
	BEGIN
		SELECT 'SI' as 'Estatus', 'GRABACION/ACTUALIZACION TABLA RELACION ANULACIONES OK' as 'MSG'
		COMMIT TRAN
	END

END	
SET NOCOUNT OFF 
end  
GO
