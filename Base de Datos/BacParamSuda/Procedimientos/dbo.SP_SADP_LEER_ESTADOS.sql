USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_ESTADOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_ESTADOS]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT CONVERT(CHAR(30),sDescripcion) + SPACE(100)+sEstado FROM SADP_EstadoAlertas sea

END 
GO
