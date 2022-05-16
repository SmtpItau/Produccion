USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_TDE_ELI_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


create procedure [dbo].[SVA_TDE_ELI_DAT] 
( 
      @cod_nemo	CHAR	(20),	
      @fecha_vcto DATETIME      
)
AS
BEGIN
		DELETE TEXT_DSA WHERE cod_nemo = @cod_nemo and fecha_vcto = @fecha_vcto
END


GO
