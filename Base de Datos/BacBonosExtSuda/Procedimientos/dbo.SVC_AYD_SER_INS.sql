USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_AYD_SER_INS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVC_AYD_SER_INS]
   (   
       @COD_NEMO	CHAR(20),
       @FECHA_VCTO	DATETIME
   )
AS
BEGIN

   IF EXISTS(SELECT 1 FROM TEXT_SER WHERE cod_nemo = @cod_nemo AND fecha_vcto = @fecha_vcto)
   BEGIN
      SELECT /*01*/ 'cod_familia'			= cod_familia
      ,      /*02*/ 'cod_nemo'				= cod_nemo
      ,      /*03*/ 'nom_nemo'				= nom_nemo
      ,      /*04*/ 'rut_emis'				= rut_emis
      ,      /*05*/ 'tipo_tasa'				= tipo_tasa
      ,      /*06*/ 'indice_basilea'		= indice_basilea
      ,      /*07*/ 'per_cupones'			= per_cupones
      ,      /*08*/ 'num_cupones'			= num_cupones
      ,      /*09*/ 'fecha_emis'			= fecha_emis
      ,      /*10*/ 'fecha_vcto'			= fecha_vcto
      ,      /*11*/ 'afecto_encaje'			= afecto_encaje
      ,      /*12*/ 'tasa_emis'				= tasa_emis
      ,      /*13*/ 'base_tasa_emi'			= base_tasa_emi
      ,      /*14*/ 'tasa_vigente'			= tasa_vigente
      ,      /*15*/ 'fecha_primer_pago'		= fecha_primer_pago
      ,      /*16*/ 'dias_reales'			= dias_reales
      ,      /*17*/ 'base_flujo'			= base_flujo
      ,      /*18*/ 'tasa_fija'				= tasa_fija
      ,      /*19*/ 'monto_emision'			= monto_emision
      ,      /*20*/ 'nombrecli'				= isnull(nom_emi,'')
      ,      /*21*/ 'monemi'				= monemi
      ,      /*22*/ 'monpag'				= monpag
      ,      /*23*/ 'tasas_bases'			= tasas_bases
      ,      /*24*/ 'per_capital'			= per_capital
      ,      /*25*/ 'cod_emis'				= cod_emis
      ,      /*26*/ 'dias_habiles_valor'	= dias_habiles_valor
      ,      /*27*/ 'valor_spread'			= valor_spread
      ,      /*28*/ 'periodo_tasa'			= periodo_tasa
      ,      /*29*/ 'tipo_cartera'			= 1
      ,      /*30*/ 'IdCurva'				= IdCurva
	  ,		 /*31*/	'Agencia'				= isnull(ClasInst.Agencia,			0)
	  ,		 /*32*/	'Clasificacion'			= isnull(ClasInst.Clasificacion,	'')
	  --+++COLTES, jcamposd 20171207 se agrega salida de marca subgenero--> si es 0 no es coltes
	  ,		 /*33*/	'tipoBono'				= isnull(coltes,0) 
	  -----COLTES, jcamposd 20171207 se agrega salida de marca subgenero	  
      FROM   TEXT_SER (NOLOCK)
             LEFT JOIN TEXT_EMI_ITL ON rut_emi = rut_emis AND codigo = cod_emis
			 left join (	select	Nemo, Agencia, Clasificacion
							from	Tbl_Clasificacion_Instrumento
						)	ClasInst	On	ClasInst.Nemo	= cod_nemo
      WHERE  cod_nemo                    = @cod_nemo
      AND    fecha_vcto                  = @fecha_vcto
   END ELSE 
   BEGIN
      SELECT 0
   END

END
GO
