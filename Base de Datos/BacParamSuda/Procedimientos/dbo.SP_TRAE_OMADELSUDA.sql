USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_OMADELSUDA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_TRAE_OMADELSUDA]( @codigo   NUMERIC(2) )
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @comercio CHAR(06)

	SELECT @comercio = comercio FROM tbomadelsuda WHERE codi_opera = @codigo

	IF @comercio = ' ' BEGIN
		SELECT   conc_opera 
			,op_concep 
			,codi_oma 
			,comercio
			,''
		FROM     tbomadelsuda 
		WHERE   codi_opera = @codigo  
	END
	ELSE BEGIN
		SELECT   a.conc_opera 
			,a.op_concep 
			,a.codi_oma 
			,a.comercio
			,b.glosa
		FROM     tbomadelsuda a
			,codigo_comercio b
		WHERE   a.codi_opera = @codigo           AND   
			a.comercio   = b.codigo_relacion 

	     END

	SET NOCOUNT OFF
END


-- sp_trae_omadelsuda 1

GO
