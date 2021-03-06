USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_FLI]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DETALLE_FLI] (
  @usuario 		VARCHAR(15) = 'ADMINISTRA'
, @ventana 		NUMERIC(9,0)= 0
, @serie   		VARCHAR(20) = ''
, @CarteraNormativa  	VARCHAR(10) = ''
, @RutEmisor  		NUMERIC(10) = 0
)
AS
BEGIN
	SELECT   
		 ISNULL( Em.emgeneric , '' )
		,Det.Margen
		,Det.HairCut
		,Det.Documento
		,Det.Correlativo
		,Det.Nominal_Compra		-->NOMINAL DISPONIBLE
		,Det.Nominal_Venta 		-->NOMINAL SELECC.	
		,Det.Tasa_Venta              	-->TASA VALORIZACION	
		,Det.vPresente_Venta		-->VALOR TASA VAL. SELECC.		
		,Det.vInicial_Venta		-->VALOR INICIAL SELECC.
		,Det.BloqueoPacto
		,Det.Marca
		,Det.Tasa_Compra
	FROM BacTraderSuda..DETALLE_FLI Det WITH(NOLOCK)  
             LEFT JOIN BacParamSuda..Emisor Em ON Det.Rut_Emisor =  Em.emrut
                                                  AND Em.emtipo = 2 
                                                  AND NOT ( Em.emnombre like '%NULO%')
                                                  AND NOT ( Em.emnombre like '%MUTUO%') 
	WHERE 
	    Det.usuario 	= @usuario
	AND Det.ventana 	= @ventana
	AND Det.serie 		= @serie
        AND ( Det.CarteraSuper = @CarteraNormativa or @CarteraNormativa = '' )
        AND ( Det.Rut_Emisor = @RutEmisor or @RutEmisor = 0  )

END

GO
