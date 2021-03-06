USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_leer_cuentas_sbif_ima]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fx_leer_cuentas_sbif_ima]
	(	@id_sistema			varchar(5)		-->	;	set @id_sistema			= 'pcs'
	,	@id_Movimiento		varchar(5)		-->	;	set @id_Movimiento		= 'dev'
	,	@id_Operacion		varchar(5)		-->	;	set @id_Operacion		= 'd1'
	,	@Id_Instrumento		varchar(10)		-->	;	set @Id_Instrumento		= ''
	,	@Id_Moneda			varchar(5)		-->	;	set @Id_Moneda			= 13

	,	@id_Pata			int				-->	;	set @id_Pata			= 1
	,	@id_signo			char(1)			-->	;	set @id_signo			= '+'
	,	@Id_Pais			int				-->	;	set	@Id_Pais			= 1 
	,	@Id_Normativa		char(1)			-->	;	set @Id_Normativa		= 'T'
	,	@Id_Subcartera		int				-->	;	set @Id_Subcartera		= 4

	,	@Id_Visualizar		int				--> ;	@Id_Visualizar = 1 = Cta | @Id_Visualizar = 2 = Perfil | @Id_Visualizar = 3 = Cond Variable
	)	returns				varchar(20)
as
begin


	-->		variable de Trabajo
	declare @ix_Folio			numeric(9);		set @ix_Folio			= null;
	declare @ix_Fila			numeric(9);		set @ix_Fila			= null;
	declare @ix_Tipo			char(1);		set @ix_Tipo			= null;
	declare @ix_Fijo			char(1);		set @ix_Fijo			= null;
	declare @ix_CampoFijo		varchar(10);	set @ix_CampoFijo		= null;
	declare @ix_CampoVariable	varchar(10);	set @ix_CampoVariable	= null;
	declare @ix_ValorDatoCampo	varchar(50);	set @ix_ValorDatoCampo	= null;
	declare @ix_CtaSbif			varchar(20);	set @ix_CtaSbif			= null;

	-->		variable de Retorno	
	declare @ix_Returns			varchar(20);	set @ix_Returns			= null;

	-->		Extrayendo el Folio del Perfil
		set @ix_Folio			=	isnull((select	folio_perfil
		           		   					from	BacParamSuda.dbo.perfil_cnt with(nolock) 
		           		   					where	id_sistema			= @id_sistema
		           		   					and		tipo_movimiento		= @id_Movimiento
		           		   					and		tipo_operacion		= @id_Operacion
		           		   					and		codigo_instrumento	= @Id_Instrumento
		           		   					and		moneda_instrumento	= @Id_Moneda
		           		   					), 0)

	if (@Id_Visualizar = 2)
	begin
		set		@ix_Returns	= ltrim(rtrim( @ix_Folio )) ;
		return	@ix_Returns
	end


	-->		Si no hay perfil, se debe abortar la cta
	if ((@ix_Folio = 0) or (@ix_Folio = null))
	begin
		set		@ix_Returns	= 'ERR. SIN PERFIL';
		return	@ix_Returns
	end else
	begin

		if ( @id_sistema = 'PCS' )
		begin
			-->		si hay perfil, hay que determinar la cta contable
			select  @ix_Folio			= det.folio_perfil
				,	@ix_Fila			= det.correlativo_perfil
				,	@ix_Tipo			= det.tipo_movimiento_cuenta
				,	@ix_Fijo			= case when det.perfil_fijo = 'S' then 'F' else 'V' end
				,	@ix_CampoFijo		= det.codigo_campo
				,	@ix_CampoVariable	= det.codigo_campo_variable
				,	@ix_CtaSbif			= case when det.perfil_fijo = 'S' then det.codigo_cuenta else '' end
			from	bacparamsuda.dbo.perfil_detalle_cnt det with(nolock)
			where	det.folio_perfil = @ix_Folio
			and	(	det.codigo_campo = 204 and det.tipo_movimiento_cuenta = 'D'
				or	det.codigo_campo = 205 and det.tipo_movimiento_cuenta = 'H'
				)
			and		det.tipo_movimiento_cuenta = case when @id_signo = '+' then 'D' else 'H' end
		end

		if ( @id_sistema = 'BFW' )
		begin
			-->		si hay perfil, hay que determinar la cta contable
			select  @ix_Folio			= det.folio_perfil
				,	@ix_Fila			= det.correlativo_perfil
				,	@ix_Tipo			= det.tipo_movimiento_cuenta
				,	@ix_Fijo			= case when det.perfil_fijo = 'S' then 'F' else 'V' end
				,	@ix_CampoFijo		= det.codigo_campo
				,	@ix_CampoVariable	= det.codigo_campo_variable
				,	@ix_CtaSbif			= case when det.perfil_fijo = 'S' then det.codigo_cuenta else '' end
			from	bacparamsuda.dbo.perfil_detalle_cnt det with(nolock)
			where	det.folio_perfil = @ix_Folio
			and	(	det.codigo_campo = 304 and det.tipo_movimiento_cuenta = 'D'
				or	det.codigo_campo = 305 and det.tipo_movimiento_cuenta = 'H'
				)
			and		det.tipo_movimiento_cuenta = case when @id_signo = '+' then 'D' else 'H' end
		end
		

		-->		Si la Cta esta en blanco y el perfil es Fijo, se deduce que el perfil esta incompleto y fuera de uso
		if ( (@ix_CtaSbif = '') and (@ix_Fijo = 'F') )
		begin
			set		@ix_Returns	= 'ERR. CTA BLANCO';
			return	@ix_Returns
		end

		-->		Si la Cta esta en Blanco y es Perfil Variable, debemos urguetear la variabilidad		
		if ( (@ix_CtaSbif = '') and (@ix_Fijo = 'V') )
		begin
			--	NOTA :
			--	La condicion de Cartera Normativa, es la opcion de apertura que hasta hoy existe, y debido a la gran cantidad de opcioens que 
			--	que presenta el proceso, si llega a incorporarce otra, debera ser programada

			-->		Condicion de : CLIENTE + CARTERA NORMATIVA (Swap)
			if	(@ix_CampoVariable = 917)
			begin
				set @ix_ValorDatoCampo	=	isnull((	select	CodigoCartera = ltrim(rtrim( CodigoCartera )) 
														from	BacParamSuda.dbo.TBL_CLASIFICACION_CARTERA_INSTRUMENTO  with(nolock) 
														where	id_sistema			= @id_sistema
														and		contraparte			= @Id_Pais
														and		carteranormativa	= @Id_Normativa
														and		subcarteranormativa = @Id_Subcartera
													), 9999);
				if (@Id_Visualizar = 3)
				begin
					set		@ix_Returns	= ltrim(rtrim( @ix_ValorDatoCampo )) ;
					return	@ix_Returns
				end

			end else
			begin
				set		@ix_Returns = 'ERR. COND. VAR.'
				return	@ix_Returns
			end
			
			-->		Se encuentra la cuenta, al ingresar por esta variablidad
			if not ( (@ix_ValorDatoCampo = null) and (@ix_ValorDatoCampo = ''))
			begin
				set	@ix_CtaSbif		=	isnull((	select	codigo_cuenta 
													from	BacParamSuda.dbo.perfil_variable_cnt with(nolock)
													where	folio_perfil		= @ix_Folio
													and		correlativo_perfil	= @ix_Fila
													and		valor_dato_campo	= @ix_ValorDatoCampo
												), '');
			end

		end	else	--> [ IF ((@ix_CtaSbif = '') and (@ix_Fijo = 'V')) ]
		begin
			set		@ix_Returns = @ix_CtaSbif
			return	@ix_Returns
		end

	end	-->	[ IF ((@ix_Folio = 0) or (@ix_Folio = null)) ]

	-->		Retorna la Cta Sbif
	set		@ix_Returns = @ix_CtaSbif
	return	@ix_Returns

end
GO
