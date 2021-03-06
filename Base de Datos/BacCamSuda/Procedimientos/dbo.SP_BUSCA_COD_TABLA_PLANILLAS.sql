USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_COD_TABLA_PLANILLAS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_BUSCA_COD_TABLA_PLANILLAS]( @Tabla NUMERIC(10) )
AS
BEGIN
 SET NOCOUNT ON
 SELECT   codigo_tabla 
  ,codigo_numerico 
  ,codigo_caracter 
  ,glosa                                              
 FROM  VIEW_AYUDA_PLANILLA 
 WHERE  codigo_tabla = @Tabla
          AND   codigo_numerico <>  0
          AND   codigo_caracter <> '0'
END



GO
