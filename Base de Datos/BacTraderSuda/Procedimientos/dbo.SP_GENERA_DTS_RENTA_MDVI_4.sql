USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_DTS_RENTA_MDVI_4]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GENERA_DTS_RENTA_MDVI_4]  
AS 
  
BEGIN 

	SELECT   ISNULL(virutcart,0)			--01
			,ISNULL(vinumdocu,0)			--02
			,ISNULL(vicorrela,0)			--03
			,ISNULL(vinumoper,0)			--04
			,ISNULL(vitipoper,'')			--05
			,ISNULL(virutcli,0)				--06
			,ISNULL(vicodcli,0)				--07
			,ISNULL(viinstser,'')			--08
			,ISNULL(vinominal,0)			--09
			,ISNULL(vifecinip,'19000101')	--10
			,ISNULL(vifecvenp,'19000101')	--11
			,ISNULL(vivalinip,0)			--12
			,ISNULL(vivalvenp,0)			--13
			,ISNULL(vitaspact,0)			--14
			,ISNULL(vibaspact,0)			--15	
			,ISNULL(vimonpact,0)			--16
			,ISNULL(vivptirc,0)				--17
			,ISNULL(vivptirci,0)			--18
			,ISNULL(vivptirv,0)				--19
			,ISNULL(vivptirvi,0)			--20
			,ISNULL(vivalcomu,0)
			,ISNULL(vivalcomp,0)
			,ISNULL(vicapitalv,0)
			,ISNULL(viinteresv,0)
			,ISNULL(vireajustv,0)
			,ISNULL(viintermesv,0)
			,ISNULL(vireajumesv,0)
			,ISNULL(vicapitalvi,0)
			,ISNULL(viinteresvi,0)
			,ISNULL(vireajustvi,0)			--30
			,ISNULL(viintermesvi,0)
			,ISNULL(vireajumesvi,0)
			,ISNULL(vivalvent,0)
			,ISNULL(vivvum100,0)
			,ISNULL(vivalvemu,0)
			,ISNULL(vitirvent,0)
			,ISNULL(vitasest,0)
			,ISNULL(vipvpvent,0)
			,ISNULL(vivpvent,0)
			,ISNULL(vinumucupc,0)			--40
			,ISNULL(vinumucupv,0)
			,ISNULL(virutemi,0)
			,ISNULL(vimonemi,0)
			,ISNULL(vifecemi,'19000101')
			,ISNULL(vifecven,'19000101')
			,ISNULL(vifecucup,'19000101')
			,ISNULL(vicodigo,0)
			,ISNULL(vitircomp,0)
			,ISNULL(vifeccomp,'19000101')
			,ISNULL(viseriado,'')			--50
			,ISNULL(vimascara,'')
			,ISNULL(vivalinipci,0)
			,ISNULL(vivalvenpci,0)
			,ISNULL(vifecinipci,0)
			,ISNULL(vifecvenpci,0)
			,ISNULL(vitaspactci,0)
			,ISNULL(vibaspactci,0)
			,ISNULL(viinteresci,0)
			,ISNULL(vicorvent,0)
			,ISNULL(vinominalp,0)			--60
			,ISNULL(viforpagi,0)
			,ISNULL(viforpagv,0)
			,ISNULL(vicorrvent,0)
			,ISNULL(vifecpcup,'19000101')
			,ISNULL(vivcompori,0)
			,ISNULL(vivpcomp,0)
			,ISNULL(vidurat,0)
			,ISNULL(vidurmod,0)
			,ISNULL(viconvex,0)
			,ISNULL(viintacumcp,0)			--70
			,ISNULL(vireacumcp,0)
			,ISNULL(viintacumvi,0)
			,ISNULL(vireacumvi,0)
			,ISNULL(viintacumci,0)
			,ISNULL(vireacumci,0)
			,ISNULL(fecha_compra_original,'19000101')
			,ISNULL(valor_compra_original,0)
			,ISNULL(valor_compra_um_original,0)
			,ISNULL(tir_compra_original,0)
			,ISNULL(valor_par_compra_original,0)			--80
			,ISNULL(porcentaje_valor_par_compra_original,0)
			,ISNULL(codigo_carterasuper,'')
			--,ISNULL(Tipo_Cartera_Financiera,'')
			,ISNULL((SELECT CASE  WHEN tbcodigo1 = 'P' THEN 'A'
								  WHEN tbcodigo1 = 'T' THEN 'T'
								  WHEN tbcodigo1 = 'A' THEN 'V'
					ELSE '' END 
					FROM BacParamSuda..TABLA_GENERAL_DETALLE 
					WHERE tbcateg = 1111 AND tbcodigo1 = codigo_carterasuper), '')



			,ISNULL(Mercado,'')
			,ISNULL(Sucursal,'')
			,ISNULL(Id_Sistema,'')
			,ISNULL(Fecha_PagoMañana,'19000101')
			,ISNULL(Laminas,'')
			,ISNULL(Tipo_Inversion,'')
			,ISNULL(Cuenta_Corriente_Inicio,'')				--90
			,ISNULL(Cuenta_Corriente_Final,'')
			,ISNULL(Sucursal_Inicio,'')
			,ISNULL(Sucursal_Final,'')
			,ISNULL(Tasa_Contrato,0) 
			,ISNULL(Valor_Contable,0) 
			,ISNULL(Fecha_Contrato,'')
			,ISNULL(Numero_Contrato,0) 
			,ISNULL(Tipo_Rentabilidad,'')
			,ISNULL(Ejecutivo,0) 
			,ISNULL(Tipo_Custodia,0)						--100
			,ISNULL(vivptasemi,0)							--101
			,ISNULL(vimtoadif,0)							--102
			,ISNULL(Capital_Tasa_Emi,0)						--103
			,ISNULL(Intereses_Tasa_Emi,0)					--104
			,ISNULL(Reajustes_Tasa_Emi,0)					--105
		FROM mdvi (NOLOCK)


END

GO
