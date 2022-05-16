USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_INT_OFI_OPE]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_INT_OFI_OPE] 
(
    @cod_ofi	float	
)
AS
BEGIN
	
	SELECT	Isnull ( ofi_NOM , ' ' )
	FROM 	TTAB_ofi 
	WHERE 	@COD_OFI = ofi_COD
END

GO
