USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GEN_LOG_INTERFAZ]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GEN_LOG_INTERFAZ]  
	(	@cIdSistema			VARCHAR(3)  
	,	@cNombre_Interfaz	VARCHAR(4)  
	,	@nNumOperacion		NUMERIC(20)  
	,	@nNumDocumento		NUMERIC(20)  
	,	@nNumCorrelativo	NUMERIC(20)  
	,	@cError				VARCHAR(200)  
	,	@cUsuario			VARCHAR(30)  
	,	@dFecha				DATETIME  
	,	@dHora				DATETIME  
	)  
AS
BEGIN

    SET NOCOUNT ON

    INSERT INTO BacParamSuda.dbo.LOG_INTERFACES  
    (    Nombre_interfaz  
    ,    Fecha  
    ,    Hora  
    ,    Numero_operacion  
    ,    Numero_documento  
    ,    Numero_correlativo  
    ,    Error_detectado  
    ,    Usuario  
    ,    Sistema  
    )  
    VALUES
    (    @cNombre_Interfaz
    ,    @dFecha
    ,    CONVERT(CHAR(10), @dHora, 108) 
    ,    @nNumOperacion
    ,    @nNumDocumento
    ,    @nNumCorrelativo
    ,    @cError
    ,    @cUsuario
    ,    @cIdSistema
    )

END 
GO
