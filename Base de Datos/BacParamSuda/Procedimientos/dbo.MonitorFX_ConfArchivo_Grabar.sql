USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_ConfArchivo_Grabar]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MonitorFX_ConfArchivo_Grabar] (
    @idCampo			 INT,
    @Descripcion		 VARCHAR(150),
    @Arch_sCodigo_		 VARCHAR(15),
    @idTipoArchivo_		 INT,
    @Arch_sRutaFisica_	 Varchar(200),
    @Arch_sNombreFisico_ VARCHAR(50),
    @idSeparador_		 INT,
    @Arch_bHabilitado_	 BIT,
    @Arch_bGrabaLog_	 BIT,
    @Arch_dHoraInicio_	 DATETIME,
    @Arch_dHoraFinal_	 DATETIME,
    @Arch_sCodColor_	 VARCHAR(255),
    @idAmbiente_		 INT,
    @Arch_bDirectorio_	 BIT
)
AS
BEGIN
	SELECT * FROM MonitorFX_TblConfArchivos mftca
	/*
	dbo.MonitorFX_ConfArchivo_Grabar 
	SELECT * FROM MonitorFX_TblCamposArchivo
	*/
	
	    IF EXISTS(
	           SELECT 1
	           FROM   MonitorFX_TblConfArchivos
	           WHERE  idArchivo = @idCampo
	       )
	    BEGIN
	    	UPDATE MonitorFX_TblConfArchivos
	    	SET
	    		Arch_sCodigo = @Arch_sCodigo_,
	    		Arch_sDescripcion = @Descripcion,
	    		idTipoArchivo = @idTipoArchivo_,
	    		Arch_sRutaFisica = @Arch_sRutaFisica_,
	    		Arch_sNombreFisico = @Arch_sNombreFisico_,
	    		idSeparador = @idSeparador_,
	    		Arch_bHabilitado = @Arch_bHabilitado_,
	    		Arch_bGrabaLog = @Arch_bGrabaLog_,
	    		Arch_dHoraInicio = @Arch_dHoraInicio_,
	    		Arch_dHoraFinal = @Arch_dHoraFinal_,
	    		Arch_sCodColor = @Arch_sCodColor_,
	    		idAmbiente = @idAmbiente_,
	    		Arch_bDirectorio = @Arch_bDirectorio_
	    	WHERE idArchivo = @idCampo
	    END
	    ELSE
	    BEGIN
	    	INSERT INTO MonitorFX_TblConfArchivos
	    	(
	    		idArchivo,
	    		Arch_sCodigo,
	    		Arch_sDescripcion,
	    		idTipoArchivo,
	    		Arch_sRutaFisica,
	    		Arch_sNombreFisico,
	    		idSeparador,
	    		Arch_bHabilitado,
	    		Arch_bGrabaLog,
	    		Arch_dHoraInicio,
	    		Arch_dHoraFinal,
	    		Arch_sCodColor,
	    		idAmbiente,
	    		Arch_bDirectorio
	    	)
	    	VALUES
	    	(
	    	@idCampo	/*{ idArchivo }*/,
	    	@Arch_sCodigo_	/*{ Arch_sCodigo }*/,
	    	@Descripcion	/*{ Arch_sDescripcion }*/,
	    	@idTipoArchivo_	/*{ idTipoArchivo }*/,
	    	@Arch_sRutaFisica_	/*{ Arch_sRutaFisica }*/,
	    	@Arch_sNombreFisico_	/*{ Arch_sNombreFisico }*/,
	    	@idSeparador_	/*{ idSeparador }*/,
	    	@Arch_bHabilitado_	/*{ Arch_bHabilitado }*/,
	    	@Arch_bGrabaLog_	/*{ Arch_bGrabaLog }*/,
	    	@Arch_dHoraInicio_	/*{ Arch_dHoraInicio }*/,
	    	@Arch_dHoraFinal_	/*{ Arch_dHoraFinal }*/,
	    	@Arch_sCodColor_	/*{ Arch_sCodColor }*/,
	    	@idAmbiente_	/*{ idAmbiente }*/,
	    	@Arch_bDirectorio_	/*{ Arch_bDirectorio }*/
	    	)
	    	
	    END
END
GO
