USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_FMU_AYD_VAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_FMU_AYD_VAR]
(
         @orden	FLOAT 	
)
AS
BEGIN

	SELECT variable, orden, Tipo_Variable
	FROM text_var_frm
	WHERE orden = @orden
END

GO
