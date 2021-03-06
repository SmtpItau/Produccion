USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_Mantenedores_Grabar]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MonitorFX_Mantenedores_Grabar] (
    @idCampo         INT,
    @Descripcion     VARCHAR(100),
    @Campo           VARCHAR(30)
)
AS
BEGIN
	
	/*
	dbo.MonitorFX_Mantenedores_Grabar 1,3,'[Oper_dFecha] - Tipo: datetime','Oper_dFecha111'
	SELECT * FROM MonitorFX_TblCamposArchivo
	*/
	
	
	    IF EXISTS(
	           SELECT 1
	           FROM   MonitorFX_TblCamposArchivo
	           WHERE  idCampo = @idCampo
	       )
	    BEGIN
	        UPDATE MonitorFX_TblCamposArchivo
	        SET    sDescripcion     = @Descripcion,
	               sCampoFisico     = @Campo
	        WHERE  idCampo          = @idCampo
	    END
	    ELSE
	    BEGIN
	        INSERT INTO MonitorFX_TblCamposArchivo
	          (
	            idCampo,
	            sDescripcion,
	            sCampoFisico
	          )
	        VALUES
	          (
	            @idCampo /*{ idCampo }*/,
	            @Descripcion /*{ sDescripcion }*/,
	            @Campo /*{ sCampoFisico }*/
	          )
	    END
END
GO
