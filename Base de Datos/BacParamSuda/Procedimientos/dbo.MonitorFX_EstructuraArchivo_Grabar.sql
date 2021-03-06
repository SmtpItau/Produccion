USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_EstructuraArchivo_Grabar]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MonitorFX_EstructuraArchivo_Grabar] (@idTipoArchivo int,
														 @idCodigoArchivo int,
														 @Estru_sCampo VARCHAR(30),
														 @Estru_sDescripcion VARCHAR(100),
														 @idPosicion INT,
														 @Estru_iLargo int,
														 @idTipoDato int,
														 @Estru_PosInicio int,
														 @Estru_PosFinal int,
														 @idCampo int,
														 @Estru_sClases VARCHAR(200),
														 @Estru_sRutaTAG VARCHAR(500))
	
	
AS
BEGIN
	
	/*
		dbo.MonitorFX_ConfArchivo_Grabar 4,'ARCHIVOS DE PLATAFORMA CITIBANK','CITIBANK',1,
		'C:\PROYECTOS\BACMONITOR\Files\Citibank\','prueba',1,0,1,'9:00','20:00','4',0,1
		
		select * from MonitorFX_TblEstructuraArchivos
	*/
	
	    IF EXISTS(
	           SELECT 1
	           FROM   MonitorFX_TblEstructuraArchivos
	           WHERE idArchivo = @idTipoArchivo
	           AND idPosicion = @idPosicion
	       )
	    BEGIN
	    	
	    	UPDATE MonitorFX_TblEstructuraArchivos
	    	SET Estru_sCampo		= @Estru_sCampo,
	    		Estru_sDescripcion	= @Estru_sDescripcion,
	    		Estru_iLargo		= @Estru_iLargo,
	    		idTipoDato			= @idTipoDato,
	    		Estru_PosInicio		= @Estru_PosInicio,
	    		Estru_PosFinal		= @Estru_PosFinal,
	    		idCampo				= @idCampo,
	    		Estru_sClases		= @Estru_sClases,
	    		Estru_sRutaTAG		= @Estru_sRutaTAG
	    	WHERE idArchivo			= @idTipoArchivo
	           AND idPosicion = @idPosicion
	
	    END
	    ELSE
	    BEGIN
	    	INSERT INTO MonitorFX_TblEstructuraArchivos
	    	(
	    		idArchivo,
	    		idPosicion,
	    		Estru_sCampo,
	    		Estru_sDescripcion,
	    		Estru_iLargo,
	    		idTipoDato,
	    		Estru_PosInicio,
	    		Estru_PosFinal,
	    		idCampo,
	    		Estru_sClases,
	    		Estru_sRutaTAG
	    	)
	    	VALUES
	    	(
	    	@idTipoArchivo	/*{ idArchivo }*/,
	    	@idPosicion	/*{ idPosicion }*/,
	    	@Estru_sCampo	/*{ Estru_sCampo }*/,
	    	@Estru_sDescripcion	/*{ Estru_sDescripcion }*/,
	    	@Estru_iLargo	/*{ Estru_iLargo }*/,
	    	@idTipoDato	/*{ idTipoDato }*/,
	    	@Estru_PosInicio	/*{ Estru_PosInicio }*/,
	    	@Estru_PosFinal	/*{ Estru_PosFinal }*/,
	    	@idCampo	/*{ idCampo }*/,
	    	@Estru_sClases	/*{ Estru_sClases }*/,
	    	@Estru_sRutaTAG	/*{ Estru_sRutaTAG }*/
	    	)
	    	
	    END
END
GO
