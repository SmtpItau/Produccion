USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_MEDIOSPAGO_NEW]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_MEDIOSPAGO_NEW] ( @sistema VARCHAR(5)='' )
AS
BEGIN
	
	SET NOCOUNT ON
	IF @sistema ='' OR (@sistema <>'GPI' AND @sistema <>'FFMM' AND @sistema <>'CDB')     
		SELECT	Codigo			= fp.codigo
			,	Glosa			= fp.glosa
		FROM	BacParamSuda.dbo.FPAGO_CANAL   cn
				INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO fp ON fp.codigo = cn.Codigo_FormaPago  
		WHERE	cn.Codigo_Canal	> 0
		UNION SELECT 0, 'S/F.PAGO'
	ELSE 	
		SELECT fp.codigo, fp.glosa FROM 
		BacParamSuda.dbo.FORMA_DE_PAGO fp WHERE codigo in (SELECT DISTINCT ncodinterno FROM SADP_RELACION_FPAGO srf WHERE corigen=@sistema) 
		UNION SELECT 0, 'S/F.PAGO'
		
END
GO
