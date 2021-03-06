USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_MEDIOSPAGO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_MEDIOSPAGO]
AS
BEGIN
	
	SET NOCOUNT ON
	
	SELECT	Codigo			= fp.codigo
		,	Glosa			= fp.glosa
	FROM	BacParamSuda.dbo.FPAGO_CANAL   cn
			INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO fp ON fp.codigo = cn.Codigo_FormaPago  
	WHERE	cn.Codigo_Canal	> 0
	
END 
GO
