USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_CARGA_COMBOS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_CARGA_COMBOS]
		 @opcion INTEGER
		,@icodorigen INTEGER = 0
AS BEGIN
   SET NOCOUNT ON
   
   IF @Opcion = 0
   BEGIN
	SELECT   tbcodigo1
		,tbglosa
        FROM BacParamSuda.dbo.tabla_general_detalle WITH(NOLOCK)
	WHERE tbcateg=8601      
   END 

   IF @Opcion = 1
   BEGIN
	SELECT   codigo,descripción
        FROM TBL_HEDGE_PRODUCTO WITH(NOLOCK)
	WHERE codigo_origen = @icodorigen 
   END 

  IF @Opcion = 3
   BEGIN
	SELECT mncodmon,mnnemo 
	FROM bacparamsuda.dbo.moneda WITH(NOLOCK)
	WHERE mnmx='C' OR mncodmon='999' 
	ORDER BY mnnemo
   END 

   SET NOCOUNT OFF
END
GO
