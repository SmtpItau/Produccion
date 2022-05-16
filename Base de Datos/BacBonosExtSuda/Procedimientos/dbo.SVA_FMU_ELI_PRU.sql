USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_FMU_ELI_PRU]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_FMU_ELI_PRU]  
( 
        @cod_familia	NUMERIC		(4)  ,
	@Cod_nemo		CHAR		(20) ,
	@fecha_vcto	DATETIME	     
)	
			     	  
AS
BEGIN
SET NOCOUNT ON
	DELETE FROM text_val_frm where 	cod_familia = @cod_familia 	AND
					cod_nemo    = @cod_nemo	   	AND
					fecha_vcto  = @fecha_vcto  	
END


GO
