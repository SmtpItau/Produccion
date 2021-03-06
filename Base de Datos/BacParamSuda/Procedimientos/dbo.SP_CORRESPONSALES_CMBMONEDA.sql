USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CORRESPONSALES_CMBMONEDA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CORRESPONSALES_CMBMONEDA]( @Opcion NUMERIC(1) =0 )
AS
BEGIN
  SET NOCOUNT ON
  IF @opcion = 0 BEGIN 
	SELECT	 mnnemo
		,mncodmon  
	FROM	moneda
	WHERE	(mnmx <> 'C') 
	ORDER BY mnnemo
   END ELSE BEGIN 
	SELECT   mnnemo
		,mncodmon
	FROM  moneda
	WHERE (mnmx = 'C') OR mnnemo = 'CLP'
	ORDER BY mnnemo
   END
   
   SET NOCOUNT OFF

END
GO
