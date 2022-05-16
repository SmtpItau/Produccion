USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_INT_BUS_OPE]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_INT_BUS_OPE] 
(
   @rut_cli	NUMERIC(9)	
)
AS 
BEGIN
	SELECT	OPRUTOPE	,
		OPNOMBRE
	FROM 	VIEW_CLIENTE_OPERADOR
	WHERE	OPRUTCLI = @RUT_CLI
END

GO
