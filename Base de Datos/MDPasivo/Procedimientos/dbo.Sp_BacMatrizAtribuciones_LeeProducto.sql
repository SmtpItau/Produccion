USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMatrizAtribuciones_LeeProducto]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_BacMatrizAtribuciones_LeeProducto] (@Control CHAR(10))

AS BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

   CREATE TABLE #TEMPORAL 
	(CODIGO_PRODUCTO 	CHAR (05)
	,DESCRIPCION		CHAR (50)
	,ID_SISTEMA		CHAR (03)
	)

   IF @Control = "N" 
   BEGIN
	INSERT INTO #TEMPORAL
      	SELECT 	DISTINCT
		P.codigo_producto, 
		P.descripcion, 
		P.id_sistema 

	FROM PRODUCTO P
        WHERE P.contabiliza = 'S'
         AND  P.gestion = 'N'
         AND  NOT EXISTS(SELECT 1 FROM MATRIZ_ATRIBUCION M WHERE M.codigo_producto = P.codigo_producto AND P.id_sistema <> 'BTR')

        ORDER BY P.descripcion

   END ELSE BEGIN

	INSERT INTO #TEMPORAL
      	SELECT 	DISTINCT
		P.codigo_producto, 
		P.descripcion, 
		P.id_sistema 
	FROM PRODUCTO P
        WHERE P.contabiliza = 'S'
         AND  P.gestion = 'N'
         AND  NOT EXISTS(SELECT 1 FROM MATRIZ_ATRIBUCION M WHERE M.codigo_producto = P.codigo_producto AND P.id_sistema <> 'BTR')

	INSERT INTO #TEMPORAL
      	SELECT 	DISTINCT
		M.codigo_producto, 
		P.descripcion ,
		P.id_sistema 
	
	FROM MATRIZ_ATRIBUCION M
	,	PRODUCTO P
        WHERE P.CODIGO_PRODUCTO = M.CODIGO_PRODUCTO
	AND	M.CODIGO_CONTROL = @Control
	AND  P.ID_SISTEMA <> 'BTR'	


   END

   SET NOCOUNT OFF

SELECT * FROM #TEMPORAL
ORDER BY descripcion



END

-- DROP TABLE #TEMPORAL
-- SELECT * FROM MATRIZ_ATRIBUCION
-- SP_BacMatrizAtribuciones_LeeProducto 'N'

GO
