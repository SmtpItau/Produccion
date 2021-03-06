USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CLIENTE_LCR]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_CLIENTE_LCR]
					(   @iRutCliente   NUMERIC(10)   
					,   @iCodCliente   INT		
					)
AS
BEGIN

   SET NOCOUNT ON

-- SP_CON_CLIENTE_DERIVADOS

--   select distinct Id_Hijo = ltrim( rtrim( clrut_hijo ) ) + ltrim( rtrim(clcodigo_hijo)) 
--   into #HIJO
--    from BacLineas.dbo.CLIENTE_RELACIONADO


	SELECT	Clrut
	,		Clcodigo		 
	,		Clnombre
	,		'MetodologiaLCR'=ISNULL(dbo.FN_RIEFIN_METODO_LCR( @iRutCliente, @iCodCliente, @iRutCliente, @iCodCliente ),1) 
	,       'Mto_Lin_Threshold' =ISNULL((SELECT Monto_Linea_Threshold 
	                                     FROM	lnkBac.BacLineas.dbo.LINEA_GENERAL 
	                                     WHERE	Rut_Cliente = Clrut  and Codigo_Cliente = Clcodigo),0)
	,		Cldv	
	,		Clpais
	FROM	lnkBac.bacparamsuda.dbo.cliente
	WHERE	Clrut = @iRutCliente	
    AND		Clcodigo = @iCodCliente 

END 
GO
