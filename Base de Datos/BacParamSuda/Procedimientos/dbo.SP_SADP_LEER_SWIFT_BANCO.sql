USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_SWIFT_BANCO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_SWIFT_BANCO]
	(	@nRutBanco		NUMERIC(10)
	,	@nCodBanco		INT
	)
AS
BEGIN
	
	SET NOCOUNT ON
	
	DECLARE @cSwift		VARCHAR(20)
		SET @cSwift		=''    

	 
	IF EXISTS( SELECT 1 FROM VIEW_SADP_BANCOS WHERE clrut = @nRutBanco AND clcodigo = @nCodBanco )
	BEGIN
		SET @cSwift		= ISNULL(( SELECT TOP 1 clswift FROM VIEW_SADP_BANCOS WHERE clrut = @nRutBanco AND clcodigo = @nCodBanco ),  '' )
										   
		SELECT  Swift 	= @cSwift
		RETURN
	END 

	-->	Busca Solamente por el Rut del Banco 
	IF EXISTS( SELECT 1 FROM VIEW_SADP_BANCOS WHERE clrut = @nRutBanco )
	BEGIN
		SET @cSwift		= ISNULL(( SELECT TOP 1 clswift FROM VIEW_SADP_BANCOS WHERE clrut = @nRutBanco ), '' )
		
		SELECT  Swift 	= @cSwift
		RETURN
	END

	SELECT  Swift  = @cSwift
	RETURN

END 
GO
