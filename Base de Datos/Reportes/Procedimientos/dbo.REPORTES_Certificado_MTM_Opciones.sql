USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[REPORTES_Certificado_MTM_Opciones]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---REPORTES_Certificado_MTM_Opciones 96962540, 1, '20131230', 'PMOYA'

CREATE PROCEDURE [dbo].[REPORTES_Certificado_MTM_Opciones]
(
		@nRut AS NUMERIC(11)
	,	@nCod AS INT
	,	@dFecha varchar(10)
	,	@Usuario varchar(40)

	)
AS  BEGIN

SET NOCOUNT ON

--		declare @dFecha		datetime
--			set @dFecha		= '20131230'
----			set @dFecha		= '2014-04-04'
											
--		declare @nRut		numeric(11)
--			set	@nRut		= 96962540

--		declare @nCod		int
--			set @nCod		= 1


	    DECLARE @dia			VARCHAR(02)   
		DECLARE @mes			VARCHAR(20)
        DECLARE @año			VARCHAR(04)
        DECLARE @fecha_Consulta VARCHAR(20)

						DECLARE @Conta NUMERIC(10)
		SET @Conta = (SELECT charindex('-', (SELECT nombre FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario)))

		 /*Format fecha*************************************************************/
   SELECT @dia  = SUBSTRING(@dFecha,7,2)
   select @mes  = SUBSTRING(@dFecha,5,2)
   SELECT @año	= SUBSTRING(@dFecha,1,4) 

   SELECT @fecha_Consulta = @dia + '-' + @mes + '-' + @año 

		select	'Folio Contrato'	= Opc.CaNumContrato
			,	'Fecha Inicio'		= convert(char(10), Opc.CaFechaContrato, 103)
			,	'Tipo Opcion'		= Opc.cacallput
			,	'Tipo Contrato'		= case when Opc.cacvopc = 'C' then 'Compra' else 'Venta' end
			,	'Indiv estructura'  = ''
			,	'Modalidad'			= case when Opc.camodalidad = 'C' then 'Compensado' else 'Fisicio' end
			,	'Monedas'			= ltrim(rtrim( mac.mnnemo )) + '-' + ltrim(rtrim( mps.mnnemo ))
			,	'Monto Nocional'	= Opc.camontomon1
			,	'Fecha Vcto'		= convert(char(10), Opc.cafechavcto, 103)
			,	'Strike'			= Opc.castrike
			,	'Valor MTM Neto'	= Opc.CaVr
			,	'Observacion'       = case when Opc.CaVr >= 0 then 'A Favor Corpbanca' else 'A Favor Cliente' end
			, 'Cliente'			= (select Clnombre from BacParamSuda..cliente where clrut = @nRut and clcodigo = @nCod)	
			 , 'Fecha_Consulta'		= @fecha_Consulta
			 , 'FirmaBanco'			= (select firma from bacparamsuda..reportes_firma where nombre_usuario = @Usuario)  

			 , 'Usuario_Banco'		= 
										CASE WHEN @Conta = 0 THEN
										( SELECT substring(nombre, 1, 80) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario) 
											
										ELSE
												( SELECT substring(nombre, 1, charindex('-', nombre)-1) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario) 
												--(select substring(@Usuario, 1, 80))
										END
		from	(	
					select	enc.canumcontrato, enc.cafechacontrato,	enc.CaVr
						,	det.cacallput, det.camodalidad, det.cacodmon1, det.cacodmon2, det.camontomon1, det.cafechavcto, det.castrike, det.cacvopc
					from	CbMdbOpc.dbo.CaResEncContrato	enc with(nolock)
							inner join 	(	select	canumcontrato, cacallput, camodalidad, cacodmon1, cacodmon2, camontomon1, cafechavcto, castrike, cacvopc
											from	CbMdbOpc.dbo.CaResDetContrato with(nolock)
											where	cadetfecharespaldo	= @dFecha
										)	det  On det.CaNumContrato	= enc.CaNumContrato

					where	enc.CaEncFechaRespaldo = @dFecha
					and	(	enc.CaRutCliente = @nRut and enc.CaCodigo = @nCod)	
						union
					select	enc.canumcontrato, enc.cafechacontrato,	enc.CaVr
						,	det.cacallput, det.camodalidad, det.cacodmon1, det.cacodmon2, det.camontomon1, det.cafechavcto, det.castrike, det.cacvopc
					from	CbMdbOpc.dbo.CaEncContrato	enc with(nolock)
							inner join 	(	select	canumcontrato, cacallput, camodalidad, cacodmon1, cacodmon2, camontomon1, cafechavcto, castrike, cacvopc
											from	CbMdbOpc.dbo.CaDetContrato with(nolock)
										)	det  On det.CaNumContrato	= enc.CaNumContrato
					where	@dFecha		= (select fechaproc from CbMdbOpc.dbo.opcionesgeneral)
					and	(	enc.CaRutCliente = @nRut and enc.CaCodigo = @nCod)
					
				)	Opc
				left join BacparamSuda.dbo.Moneda mac On mac.mncodmon = Opc.cacodmon1
				left join BacparamSuda.dbo.Moneda mps On mps.mncodmon = Opc.cacodmon2

END

GO
