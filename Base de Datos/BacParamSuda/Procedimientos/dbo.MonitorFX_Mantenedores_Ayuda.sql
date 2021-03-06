USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_Mantenedores_Ayuda]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MonitorFX_Mantenedores_Ayuda] (@opt INT,
												   @idCampo INT = 0,
												   @CodigoTA INT = 0)
AS
BEGIN
	/*
	exec MonitorFX_Mantenedores_Ayuda 4,1
	dbo.MonitorFX_Mantenedores_Ayuda 4,1
	dbo.MonitorFX_Mantenedores_Ayuda 5,1
	
	dbo.MonitorFX_Mantenedores_Ayuda 6,1
	dbo.MonitorFX_Mantenedores_Ayuda 6,0,1
	dbo.MonitorFX_Mantenedores_Ayuda 6,2,1
	dbo.MonitorFX_Mantenedores_Ayuda 6,0,0
	*/

	IF @opt = 1
	BEGIN
	
		SELECT idCampo,
			   sDescripcion AS Descripcion 
		FROM MonitorFX_TblCamposArchivo
		
	END
	
	IF @opt = 2
	BEGIN
	
		SELECT idPosicion AS idCampo,
			   Estru_sDescripcion AS Descripcion
		FROM  MonitorFX_TblEstructuraArchivos
		WHERE idArchivo = @CodigoTA
		
	END
	
	IF @opt = 3
	BEGIN
	
		SELECT idArchivo AS idCampo,
			   Arch_sDescripcion AS Descripcion
		FROM MonitorFX_TblConfArchivos
		
	END
	
	IF @opt = 4
	BEGIN
		SELECT idCampo,
			   sDescripcion AS Descripcion,
			   sCampoFisico AS CampoFisico
		FROM MonitorFX_TblCamposArchivo
		WHERE idCampo = @idCampo
		
	END
	
	IF @opt = 5
	BEGIN
		SELECT idArchivo as idCampo, 
			   Arch_sDescripcion AS Descripcion,
			   Arch_sCodigo,
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
		FROM MonitorFX_TblConfArchivos
		WHERE idArchivo = @idCampo
		
	END
	
	IF @opt = 6
	BEGIN
		IF @idCampo = 0
		BEGIN
			SELECT idArchivo
				 , idPosicion
				 , Estru_sCampo
				 , Estru_sDescripcion
				 , Estru_iLargo
				 , MonitorFX_TblEstructuraArchivos.idTipoDato
				 , Estru_PosInicio
				 , Estru_PosFinal
				 , MonitorFX_TblEstructuraArchivos.idCampo
				 , Estru_sClases
				 , case when isnull(Estru_sRutaTAG,'') = '' then '-' else Estru_sRutaTAG END AS Estru_sRutaTAG
				 , TD.sDescripcion AS DESCRICCIONTD
				 , CA.sDescripcion AS DESCRIPCIONCA
			FROM MonitorFX_TblEstructuraArchivos
			INNER JOIN MonitorFX_TblTipoDatos TD ON TD.idTipoDato = MonitorFX_TblEstructuraArchivos.idTipoDato
			INNER JOIN MonitorFX_TblCamposArchivo CA ON CA.idCampo = MonitorFX_TblEstructuraArchivos.idCampo
			WHERE idArchivo = @CodigoTA
		END 
		ELSE
			BEGIN
				SELECT idArchivo
					 , idPosicion
					 , Estru_sCampo
					 , Estru_sDescripcion
					 , Estru_iLargo
					 , MonitorFX_TblEstructuraArchivos.idTipoDato
					 , Estru_PosInicio
					 , Estru_PosFinal
					 , MonitorFX_TblEstructuraArchivos.idCampo
					 , Estru_sClases
					 , case when isnull(Estru_sRutaTAG,'') = '' then '-' else Estru_sRutaTAG END AS Estru_sRutaTAG
					 , TD.sDescripcion AS DESCRICCIONTD
					 , CA.sDescripcion AS DESCRIPCIONCA
				FROM MonitorFX_TblEstructuraArchivos
				INNER JOIN MonitorFX_TblTipoDatos TD ON TD.idTipoDato = MonitorFX_TblEstructuraArchivos.idTipoDato
				INNER JOIN MonitorFX_TblCamposArchivo CA ON CA.idCampo = MonitorFX_TblEstructuraArchivos.idCampo
				WHERE idArchivo = @CodigoTA 
				  AND idPosicion = @idCampo
			END		
		
		
	END
END	

GO
