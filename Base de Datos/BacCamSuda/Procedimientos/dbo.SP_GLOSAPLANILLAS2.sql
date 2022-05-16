USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GLOSAPLANILLAS2]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GLOSAPLANILLAS2] ( @acomercio char(6),
                                          @aconcepto char(3) )
AS
BEGIN
 SELECT  codigo_relacion,concepto,glosa
   FROM  view_codigo_comercio
  WHERE  codigo_relacion  = @acomercio 

END

GO
