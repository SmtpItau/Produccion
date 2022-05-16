USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPD_BLOQUEO_CLI]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_UPD_BLOQUEO_CLI 22253778,1,'N'
--SELECT CLNOMBRE,clvigente,* FROM BACPARAMSUDA..CLIENTE WHERE CLRUT=22253778
CREATE PROCEDURE [dbo].[SP_UPD_BLOQUEO_CLI]  
(
	@RUT_CLI	NUMERIC(9)
,	@COD_CLI	NUMERIC(3)
,	@FLAG		VARCHAR(1)='S'
)
AS
BEGIN   
--SE MODIFICA EL USO DEL CODIGO DE CLIENTE POR MODIFICACION DE ARCHIVO DE BLOQUEO, QUE SOLO VIENE RUT

SET NOCOUNT ON   
DECLARE @ClVigente	char(1)

	IF  EXISTS (SELECT * FROM BACPARAMSUDA..CLIENTE WHERE CLRUT=@RUT_CLI AND CLCODIGO=@COD_CLI )
	BEGIN
		SELECT @ClVigente=ClVigente FROM BACPARAMSUDA..CLIENTE WHERE CLRUT=@RUT_CLI AND CLCODIGO=@COD_CLI
		IF @FLAG='S'
		begin
			if @ClVigente='S'
			begin
				UPDATE BACPARAMSUDA..CLIENTE
				SET clvigente = 'N'
				,	Clnombre = LEFT('(NO USAR)'+ RTRIM(CONVERT(VARCHAR(70),CLNOMBRE)),70)
				WHERE CLRUT		=	@RUT_CLI
--				AND   CLCODIGO	=	@COD_CLI
			end
		end
		ELSE
	    begin
			if @ClVigente='N'
			begin
				UPDATE BACPARAMSUDA..CLIENTE
				SET clvigente = 'S'
				,	Clnombre = SUBSTRING(CLNOMBRE,10,80)
				WHERE CLRUT		=	@RUT_CLI
--				AND   CLCODIGO	=	@COD_CLI
			end

		end
	END
	
	
END
GO
