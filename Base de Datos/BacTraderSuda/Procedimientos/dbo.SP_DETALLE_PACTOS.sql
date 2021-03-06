USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_PACTOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DETALLE_PACTOS] (
  @usuario 		VARCHAR(15) = 'ADMINISTRA'
, @ventana 		NUMERIC(9,0)= 0
, @serie   		VARCHAR(20) = ''
, @CarteraNormativa  	VARCHAR(10) = ''
, @RutEmisor  		NUMERIC(10) = 0
)
AS
BEGIN
	SELECT   
		 ISNULL( Em.emgeneric , '' )	-->--1--
		,Det.Margen			-->--2--
		,Det.HairCut			-->--3--	
		,Det.Documento			-->--4--	
		,Det.Correlativo		-->--5--	
		,Det.Nominal_Compra		-->NOMINAL DISPONIBLE 		-->--6--
		,Det.Nominal_Venta 		-->NOMINAL SELECC.		-->--7--	
		,Det.Tasa_Compra              	-->TASA COMPRA			-->--8--
		,Det.Tasa_Venta              	-->TASA VALORIZACION		-->--9--	
		,Det.vPresente_Venta		-->VALOR TASA VAL. SELECC.	-->--10--		
		,Det.vInicial_Venta		-->VALOR INICIAL SELECC.	-->--11--	
		,Det.BloqueoPacto		-->--12--			
		,Det.Marca			-->--13--	
		,CASE WHEN Det.cCustodia = 'D' THEN 'DCV'			-->DCV-PROPIA-CLIENTE -->--14--	
		      WHEN Det.cCustodia = 'C' THEN 'CLIENTE' ELSE 'PROPIA' END
		,Det.cClave			-->CLAVE CUSTODIA		-->--15--	
	FROM BacTraderSuda..DETALLE_VTAS_CON_PCTO Det WITH(NOLOCK)  		-->--16--	
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
