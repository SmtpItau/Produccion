USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_DTS_RENTA_MDCI_3]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_GENERA_DTS_RENTA_MDCI_3]  
AS  
  
BEGIN 

	SELECT cirutcart
		,citipcart
		,cinumdocu
		,cicorrela
		,cinumdocuo
		,cicorrelao
		,cirutcli
		,cicodcli
		,ciinstser
		,cimascara
		,cinominal
		,cifeccomp
		,civalcomp
		,civalcomu
		,civcum100
		,citircomp
		,citasest
		,cipvpcomp
		,civpcomp
		,cifecemi
		,cifecven
		,ciseriado
		,cicodigo
		,cifecinip
		,cifecvenp
		,civalinip
		,civalvenp
		,citaspact
		,cibaspact
		,cimonpact
		,civptirc
		,cicapitalc
		,ciinteresc
		,cireajustc
		,ciintermes
		,cireajumes
		,cicapitalci
		,ciinteresci
		,cireajustci
		,civptirci
		,cinumucup
		,cirutemi
		,cimonemi
		,cicontador
		,cifecucup
		,cinominalp
		,ciforpagi
		,ciforpagv
		,cifecpcup
		,cidcv
		,cidurat
		,cidurmod
		,ciconvex
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
		,Cuenta_Corriente_Inicio
		,Cuenta_Corriente_Final
		,Sucursal_Inicio
		,Sucursal_Final
		,Estado_Operacion_Linea
		,ISNULL(Tasa_Contrato,0)
		,ISNULL(Valor_Contable,0) 
		,ISNULL(Fecha_Contrato,'')
		,ISNULL(Numero_Contrato,0) 
		,ISNULL(Tipo_Rentabilidad,'')
		,ISNULL(Ejecutivo,0) 
		,ISNULL(Tipo_Custodia,0)
		,ISNULL(cigarantia,'')  
		,ISNULL(ciind1446,'') 
	FROM MDCI(NOLOCK)




END

GO
