USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CLASIFICACION_CARTERA_DERIVADOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_CLASIFICACION_CARTERA_DERIVADOS]
   (   @IdSistema     CHAR(03)
   ,   @Contraparte   INTEGER --> Pais del Cliente.
   ,   @Cartera       CHAR(1) --> Cartera Normativa
   ,   @Subcartera    INTEGER --> Sub Cartera Normativa   
   ,   @Codigo        INTEGER   OUTPUT
   ,   @Matriz        integer  = 0
   )
AS 
BEGIN

   SET NOCOUNT ON 

   SET @Contraparte = CASE WHEN @Contraparte = 6 THEN 2 ELSE 1 END

   DECLARE @nCodigo_Cartera   INTEGER
       SET @nCodigo_Cartera    = ISNULL((SELECT TOP 1 CodigoCartera 
                                          FROM BacParamSuda..TBL_CLASIFICACION_CARTERA_INSTRUMENTO with(nolock)
                                         WHERE Id_sistema          = @IdSistema
                                           AND Contraparte         = @Contraparte
                                           AND CarteraNormativa    = @Cartera
                                           AND SubcarteraNormativa = @Subcartera
										   AND CasaMatriz = @Matriz 
										   ), 9999)


   SET @Codigo = @nCodigo_Cartera
END
GO
