USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_ELIMINAR_CRITERIO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_ELIMINAR_CRITERIO]
	(	@Id_Criterio	INT	)
AS
BEGIN
	
	SET NOCOUNT ON

	DELETE FROM BacParamSuda.dbo.SADP_CRITERIOS
		  WHERE Id_Criterio = @Id_Criterio

END
GO
