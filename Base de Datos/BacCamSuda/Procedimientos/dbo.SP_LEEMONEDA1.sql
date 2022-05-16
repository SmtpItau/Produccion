USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEMONEDA1]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_LEEMONEDA1]( @codigo VARCHAR(255)
                                   ,@digito FLOAT
                                   ,@sw NUMERIC(1)
                                  )
AS
BEGIN
   DECLARE @aux VARCHAR(255)
   SELECT @aux = 'SELECT fecha,codigo_relacion,concepto,glosa,tipo_documento,codigo_oma,* FROM view_codigo_comercio WHERE  codigo_oma =' +  @codigo
   IF @sw = 1  BEGIN
      IF @digito = 2 SET @digito = 1
      SELECT @aux = @aux + ' and tipo_documento =' + CONVERT(VARCHAR(10),@digito) 
   END
   EXECUTE (@aux)
END




GO
