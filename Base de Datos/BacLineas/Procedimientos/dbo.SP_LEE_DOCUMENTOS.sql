USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_DOCUMENTOS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_DOCUMENTOS]
	( 
		@sistema CHAR(3) 
	)
AS
BEGIN
	
	SET NOCOUNT ON

	SELECT 	a.Sistema		
	,	a.Numero_Operacion	
	,	a.Folio			
	,	'Nombre_Beneficiario' = ISNULL(a.nombre_beneficiario,'')
	,	a.Codigo_Cliente --Tomador			
	,	'fecha_proceso' = (CONVERT(CHAR(8),a.Fecha_Proceso,112))
	,	a.Estado		
	,	a.Monto			
	,	a.Tipo_Operacion	
	,	a.Tipo_Documento	
	,	a.Tipo_Emision		
	,	a.Usuario		
	,	b.glosa			
	,	'nombre_cliente'	=	ISNULL(c.clnombre,'')
	,	a.Rut_Cliente  --Tomador
	,	a.valor_inicial
	,	a.valor_nominal
	,	a.tir
	,	a.agrupa
	,	a.envia
	,	'monto_agrupa'		=	(SELECT CONVERT(NUMERIC(21),0))
	,	'valor_inicial_agrupa'	=	(SELECT CONVERT(NUMERIC(21),0))
	,	'valor_nominal_agrupa'	=	(SELECT CONVERT(NUMERIC(21),0))

	INTO #TEMP	
	FROM	forma_de_pago	b,
		documento	a LEFT OUTER JOIN cliente c
		ON a.Rut_Cliente = c.clrut
		--cliente		c
	WHERE	a.Sistema 		= @Sistema		
	AND	b.codigo  		= a.Tipo_Documento	
	---AND	a.Rut_Cliente		*= c.clrut		
	ORDER BY a.folio,a.numero_operacion


	SELECT 	'monto1' = SUM(monto)		,
		'monto2' = SUM(valor_inicial)	,
		'monto3' = SUM(valor_nominal)   ,
		'folio1' = folio			
	INTO	#TEMP1
	FROM 	#TEMP
	WHERE 	agrupa 	= 'S'
	GROUP BY folio

	UPDATE	#TEMP
	SET	monto_agrupa		=	monto1	,
		valor_inicial_agrupa	=	monto2	,
		valor_nominal_agrupa	=	monto3
	FROM	#TEMP1
	WHERE	folio = folio1

/*
	INSERT INTO #TEMP
	(
	 monto_agrupa
	,valor_inicial_agrupa
	,valor_nominal_agrupa
	)
	
	SELECT	
		
		SUM(monto) 
	 ,	SUM(monto) 
	 ,	SUM(monto) 
		
	
	FROM #TEMP	
	WHERE 	folio 	= folio 
	AND	agrupa 	= 'S'  
	
*/
	
	/*UPDATE #TEMP
	SET 	monto_agrupa		=	(SELECT SUM(monto) 
						WHERE 	folio 	= folio 
						AND	agrupa 	= 'S'  )


	UPDATE #TEMP
	SET 	valor_inicial_agrupa	=	(SELECT SUM(A.valor_inicial) 
						FROM 	#TEMP		A
						,	DOCUMENTO	B
						WHERE 	A.folio 	= B.folio 
						AND	B.agrupa 	= 'S' )  


	UPDATE #TEMP
	SET 	valor_nominal_agrupa	=	(SELECT SUM(A.valor_nominal) 
						FROM 	#TEMP		A
						,	DOCUMENTO	B
						WHERE 	A.folio 	= B.folio 
						AND	B.agrupa 	= 'S' ) */

	SELECT * FROM #TEMP 		

	SET NOCOUNT OFF
	
END

-- select * from forma_de_pago 
-- select * from sysobjects where type='u' order by name
-- sp_lee_documentos 'BTR'
--select * from documento where sistema = 'BTR'
--delete  documento where sistema = 'BTR'
--select * from entidad
GO
