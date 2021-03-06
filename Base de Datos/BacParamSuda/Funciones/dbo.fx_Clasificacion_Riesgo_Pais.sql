USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_Clasificacion_Riesgo_Pais]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fx_Clasificacion_Riesgo_Pais]
	(	@nRutCliente	numeric(9)
	,	@nCodCliente	numeric(9)
	,	@cOrigen		char(3)
	)	returns			char(2)
as
begin

	declare @sRetorno	char(2)
		set	@sRetorno	= ''

	declare @bDerivado	int
		set @bDerivado	= case	when @cOrigen = 'bfw' then 1
								when @cOrigen = 'pcs' then 1
								when @cOrigen = 'bfw' then 1
								when @cOrigen = 'opt' then 1
								when @cOrigen = 'btr' then 2
								when @cOrigen = 'bex' then 3
							end 

	-->	Derivados
	if @bDerivado = 1
	begin
		set @sRetorno	=	(	select	Clasificacion	= case	-->		Clasificacion Directa, clientes cCorrectamente clasificados en BAC
																when	cltipcli	= 2		then	'R1'	--> Bancos Extranjeros
																when	cltipcli	= 12	then	'R2'	--> Empresas Extranjeras
																when	cltipcli	= 10	then	'R2'	-->	Soberanos

																-->		Deternminando clientes mal clasificados
																when (	clpais	> 0							-->	Campo Pais No Poblado	(0 = Sin Pais)
																and		clpais <> 6)		then			-->	Campo Pais Extranjero	(6 = Chile)
																
																case	when	(	cltipcli	= 3		--> Instituciones Financieras
																				or	cltipcli	= 4		-->	Corredoras de Bolsa
																				or	cltipcli	= 5		-->	Instituciones de Inversion
																				or	cltipcli	= 7		-->	Empresas
																				or	cltipcli	= 11	-->	Instituciones Fiscales
																				or  cltipcli	= 9		-->	Otras
																				) 			then	'R2'	-->	Empresas Extranjeras
																	end

																-->	 Exenta de Clasificacion
																else								''
															end
								from	BacParamSuda.dbo.cliente with(nolock)
								where	clrut			= @nRutCliente
								and		clcodigo		= @nCodCliente
							)

	end

	-->	Renta Fija Nacional
	if @bDerivado = 2
	begin
		set @sRetorno = ''
	end

	-->	Renta Fija Extranjera
	if @bDerivado = 3
	begin
		set @sRetorno	=	(	select	Clasificacion	= case	-->	 Exenta de Clasificacion
																when clie.Extranjero	= 0 then ''
																-->	Clasificacion de Emisores Federales y Soberanos
																when emis.emtipo		= 3 then 'P'	-->	SOBERANOS
																when emis.emtipo		= 4 then 'P'	-->	FEDERALES
																when emis.emtipo		= 5 then 'P'	-->	FEDERALES
																else isnull(clas.Letra, '')
															end
								from	BacParamSuda.dbo.Emisor emis with(nolock)
										inner join	(	select	Rut				= clrut
															,	Codigo			= clcodigo
															,	Dv				= cldv
															,	Extranjero		= case	when clpais > 0 and clpais <> 6 then 1 else 0 end
															,	Nombre			= clnombre
														from	BacParamSuda.dbo.cliente with(nolock)
													)	clie	On	clie.Rut	= emis.emrut
																and	clie.Codigo	= emis.emcodigo

										left join	(	select	Id				= tbcodigo1 
															,	Descrip			= tbglosa
														from	BacParamSuda.dbo.tabla_general_detalle with(nolock)
														where	tbcateg			= 210
													)	tipemi	On tipemi.Id	= emis.emtipo

										left join	(	select	Rut				= rut_emi
															,	Codigo			= codigo
															,	Clasf			= tipo_corto1
															,	Letra			= case	when tipo_corto1 like 'A%'					then 'E'
																						when tipo_corto1 IN('BBB', 'BBB+', 'BBB-')	then 'E'
																						when tipo_corto1 like 'B%'					then 'F'
																						else 'G'
																					end
														from	BacBonosExtSuda.dbo.text_emi_itl with(nolock)
													)	clas	On	clas.Rut	= emis.emrut
																and clas.Codigo	= emis.emcodigo
								where	emis.emrut		= @nRutCliente
								and		emis.emcodigo	= @nCodCliente
							)
	end

	return @sRetorno

end
GO
