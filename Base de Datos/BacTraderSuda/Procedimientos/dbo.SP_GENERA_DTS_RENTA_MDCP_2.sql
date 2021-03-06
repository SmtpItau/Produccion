USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_DTS_RENTA_MDCP_2]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_GENERA_DTS_RENTA_MDCP_2]  
AS
  
BEGIN 

	SELECT cprutcart
		,cptipcart
		,cpnumdocu
		,cpcorrela
		,cpnumdocuo
		,cpcorrelao
		,cprutcli
		,cpcodcli
		,cpinstser
		,cpmascara
		,cpnominal
		,cpfeccomp
		,cpvalcomp
		,cpvalcomu
		,cpvcum100
		,cptircomp
		,cptasest
		,cppvpcomp
		,cpvpcomp
		,cpnumucup
		,cpfecemi
		,cpfecven
		,cpseriado
		,cpcodigo
		,cpvptirc
		,cpcapitalc
		,cpinteresc
		,cpreajustc
		,cpcontador
		,cpfecucup
		,cpfecpcup
		,cpvcompori
		,cpdcv
		,cpdurat
		,cpdurmod
		,cpconvex
		,cpintermes
		,cpreajumes
		,fecha_compra_original
		,valor_compra_original
		,valor_compra_um_original
		,tir_compra_original
		,valor_par_compra_original
		,porcentaje_valor_par_compra_original
		,codigo_carterasuper
		,Tipo_Cartera_Financiera= ISNULL((SELECT CASE  WHEN tbcodigo1 = 'P' THEN 'A'
													   WHEN tbcodigo1 = 'T' THEN 'T'
													   WHEN tbcodigo1 = 'A' THEN 'V'
										   ELSE '' END 
									       FROM BacParamSuda..TABLA_GENERAL_DETALLE 
									       WHERE tbcateg = 1111 AND tbcodigo1 = codigo_carterasuper), '')
		,Mercado
		,Sucursal
		,Id_Sistema
		,Fecha_PagoMañana
		,Laminas
		,Tipo_Inversion
		,Estado_Operacion_Linea
		,cptipoletra
		,ISNULL(Tasa_Contrato,0) 
		,ISNULL(Valor_Contable,0) 
		,ISNULL(Fecha_Contrato,'') 
		,ISNULL(Numero_Contrato,0) 
		,ISNULL(Tipo_Rentabilidad,'') 
		,ISNULL(Ejecutivo,0) 
		,ISNULL(Tipo_Custodia,0) 
		,ISNULL(cpforpagi,0)
		,ISNULL(cpsenala,0) 
		,ISNULL(cpvptasemi,0) 
		,ISNULL(Valor_a_Diferir,0)
		,ISNULL(Capital_Tasa_Emi,0) 
		,ISNULL(Intereses_Tasa_Emi,0) 
		,ISNULL(Reajustes_Tasa_Emi,0) 
	FROM MDCP(NOLOCK)



END

GO
