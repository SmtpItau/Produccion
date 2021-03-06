USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_GRABA_MAILS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_GRABA_MAILS]( 
			@NombreDestinatario 	varchar(100) 
		,	@TipoDestinatario  	int 
		,	@DireccionEmail  	varchar(50)  
		,	@TextoMail		varchar(255)
		,	@Asunto			VARCHAR(255)
		)
AS
BEGIN

	IF EXISTS( SELECT * FROM dbo.tbl_Gar_DireccionEmail WHERE DireccionEmail=@DireccionEmail )
		UPDATE dbo.tbl_Gar_DireccionEmail 
		   SET NombreDestinatario	= @NombreDestinatario	
		,      TipoDestinatario  	= @TipoDestinatario 
		 WHERE DireccionEmail=@DireccionEmail
	ELSE
		INSERT INTO 
		dbo.tbl_Gar_DireccionEmail ( 
			NombreDestinatario 
		,	TipoDestinatario  	
		,	DireccionEmail    )	

		VALUES (
			@NombreDestinatario 
		,	@TipoDestinatario  	
		,	@DireccionEmail   )
	

	IF  (SELECT COUNT(*) FROM dbo.tbl_Parametros_Gral_Garantias )= 0
		INSERT INTO 
		dbo.tbl_Parametros_Gral_Garantias(
			SubjectEmail
		,	ACNumGarantias
		,	ACNumGarantiasOtorgadas
		,	MensajeEmail )
		VALUES(
			@Asunto
		,	0	
		,	0			
		,	@TextoMail)
	ELSE
		UPDATE dbo.tbl_Parametros_Gral_Garantias
		   SET 	SubjectEmail = @Asunto
		,	MensajeEmail = @TextoMail
		
END 
GO
