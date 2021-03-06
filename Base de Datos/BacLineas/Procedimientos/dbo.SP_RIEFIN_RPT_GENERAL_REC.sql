USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_RPT_GENERAL_REC]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_RPT_GENERAL_REC]
--	(	@Id_Sistema		VARCHAR(3)
--	,	@Rut			NUMERIC(9)=0
--	,	@Codigo			NUMERIC(9)=0
--	,	@Producto		VARCHAR(3)=''
--	)	
AS
BEGIN
	
	SET NOCOUNT ON  
    declare @fecha datetime
    select  @fecha = acfecproc /*acfecante*/ from bacTradersuda..mdac
       
	SELECT	Ge.Fecha                   
	,		Ge.Rut         
	,		Ge.Codigo      
	,		Ge.Codigo_Metodologia 
	,		Ge.Nombre                                                                 
	,		Ge.Linea                  
	,		Ge.Treshold               
	,		Ge.Valor_Mercado          
	,		Ge.Exposicion_Maxima      
	,		Ge.VaR90D                 
	,		Ge.AddOnAlVcto            
	,		Ge.Garantia_Ejecutada 
	,		Ge.Consumo_Linea          
	,		Ge.Holgura                
	,		Estado_Lineas = case when Ge.Estado_Linea = '' then 'Normal' else Ge.Estado_Linea end 
	,		Me.RecMtdNemo           
	,		Me.RecMtdDsc
	FROM	TBL_RIEFIN_General_REC Ge
	INNER JOIN Tbl_MetodologiaRec Me ON Ge.Codigo_Metodologia = Me.RecMtdCod
    where Ge.Fecha = @fecha
	ORDER BY Estado_Linea
	
	
		
	SET NOCOUNT OFF  	
END 
GO
