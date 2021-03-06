USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CLIENTE_DERIVADOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_CLIENTE_DERIVADOS]
					(   @iRutCliente   NUMERIC(10)  = 0   
					,   @iCodCliente   INT			= 0
					)
AS
BEGIN

   SET NOCOUNT ON

	--+++jcamposd 20170421 implementación control IDD (no debe controlar lineas BAC)
		RETURN
	-----jcamposd 20170421 implementación control IDD


-- SP_CON_CLIENTE_DERIVADOS

   select distinct Id_Hijo = ltrim( rtrim( clrut_hijo ) ) + ltrim( rtrim(clcodigo_hijo)) 
   into #HIJO
    from BacLineas.dbo.CLIENTE_RELACIONADO



	SELECT	Clrut
	,		Clcodigo		 
	,		Clnombre
	,		'MetodologiaLCR'=ISNULL(BacLineas.dbo.FN_RIEFIN_METODO_LCR( Clrut, Clcodigo, Clrut, Clcodigo ),1) 
	,       'Mto_Lin_Threshold' =ISNULL((SELECT Monto_Linea_Threshold 
	                                     FROM	BacLineas..LINEA_GENERAL 
	                                     WHERE	Rut_Cliente = Clrut  and Codigo_Cliente = Clcodigo),0)
	,		Cldv	
	INTO	#CLIENTE_DERIVADOS 
	FROM	bacparamsuda..cliente

	SELECT	Clrut
	,		Clcodigo		 
	,		Clnombre 
	,		MetodologiaLCR
	,		Mto_Lin_Threshold
	,		Cldv
	FROM	#CLIENTE_DERIVADOS 
	WHERE	MetodologiaLCR <> 1 AND MetodologiaLCR <> 4
	AND		(Clrut = @iRutCliente OR @iRutCliente = 0) 	
	AND		(Clcodigo = @iCodCliente OR @iCodCliente =0)
    AND      ltrim( rtrim( Clrut) ) + ltrim( rtrim(clcodigo))  not in ( select id_hijo from #HIJO )
	ORDER BY CLRUT,Clcodigo

END 

GO
