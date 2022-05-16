USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_GRABA_MENU]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_GRABA_MENU]
	(	@Modulo			VARCHAR(5)
	,	@Correlativo	INT
	,	@Posicion		INT
	,	@Opcion			VARCHAR(20)
	,	@Nombre			VARCHAR(100)
	)
AS
BEGIN
	
	SET NOCOUNT ON

	INSERT INTO dbo.SADP_MENU
		SELECT  @Modulo, @Correlativo, @Posicion, @Opcion, @Nombre
	
END 
GO
