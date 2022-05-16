USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLAMA_A_LINEAS_ANULA]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LLAMA_A_LINEAS_ANULA]
	(	@dFecPro     DATETIME
	,	@cSistema    CHAR(03)
	,	@nNumoper    NUMERIC(10,0) 
	)

AS
BEGIN
	SET NOCOUNT ON
	
	EXECUTE LNKBAC.BacLineas.dbo.SP_LINEAS_ANULA  @dFecPro,@cSistema,@nNumoper
	
	
	
	  IF @@error <> 0 BEGIN
	  	
	  	SELECT 'NO','SE CAYO ANULACION'
	  END
	  
	  ELSE BEGIN
	  	
	  	SELECT 'SI', 'ANULACION LCR OK'
	       	
	  END
	
END
GO
