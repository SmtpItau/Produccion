USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_RNT_RF_VALUES]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create function [dbo].[Fx_RNT_RF_VALUES](
	@mascara		varchar(15)				-- mascara del instrumento.
,	@cod_subprodu	varchar(3)				-- codigo de subproducto (indicador de tabla).
,	@nominal		numeric(20,4)			-- nominal para calculo. 
,	@num_ult_cp		numeric(10)				-- numero ultimo cupon.
,	@num_doc		numeric(10)				-- numero documento.
,	@fec_comp		date					-- fecha de compra
,	@fec_venc		date					-- fecha de vencimiento
,	@fec_ucup		date					-- fecha de ultimo cupon
,	@fec_pcup		date					-- fecha de proximo cupon
,	@opcion			int				= null	-- opcion de despliegue de informacion adicional		
)
returns @RF_Values table
(
	concept varchar(50),
	value	numeric(20,4),
	other	varchar(50)		null
)
as 
begin

/*
-- nota: se estructuro, esta funcion pensando en mas adelante, para poder rastrear los noseriados, procedencia, etc.


declare 
	@mascara		varchar(15)				-- mascara del instrumento.
,	@cod_subprodu	varchar(3)				-- codigo de subproducto (indicador de tabla).
,	@nominal		numeric(20,4)			-- nominal para calculo. 
,	@num_ult_cp		numeric(10)				-- numero ultimo cupon.
,	@num_doc		numeric(10)				-- numero documento.
,	@fec_comp		date					-- fecha de compra
,	@fec_venc		date					-- fecha de vencimiento
,	@fec_ucup		date					-- fecha de ultimo cupon
,	@fec_pcup		date					-- fecha de proximo cupon


set @mascara		='BTP0450321'
set @cod_subprodu	='CP'
set @nominal		= 1000000000.0000
set @num_ult_cp		= 2
set	@fec_comp		= '2017-04-20' 
set	@fec_venc		= '2021-03-01' 
set	@fec_ucup		= '2017-03-01' 
set	@fec_pcup		= '2017-09-01' 
*/


/****************************************************************************************/
/*				DECLARACION VARIABLES													*/
/****************************************************************************************/
declare 
	@last_cupon		numeric(10)			-- numero ultimo cupon
,	@first_cupon	numeric(10)			-- numero primer cupon
,	@fec_ant	    date				-- fecha flujo anterior
,   @fec_vig		date				-- fecha cupon vigente (o a consultar)
,	@fec_sup		date				-- fecha flujo siguiente
,	@num_cp_ant		numeric(10)			-- numero cupon anterior
,	@num_cp_sup		numeric(10)			-- numero cupon siguiente

/*******************************************************************************/
/* Almacenamiento temporal de las series a trabajar							   */
/*******************************************************************************/
declare @TMP_TABLA_DESARROLLO table
(
tdmascara	char(12)
,tdcupon	numeric(5)
,tdfecven	date	
,tdinteres	numeric(19,4)
,tdamort	numeric(19,4)
,tdflujo	numeric(19,4)
,tdsaldo	numeric(19,4)
)

insert into @TMP_TABLA_DESARROLLO
select * from BacParamSuda.dbo.TABLA_DESARROLLO
where ltrim(rtrim(tdmascara)) = ltrim(rtrim(@mascara))



/****************************************************************************************/
/*				VERIFICACION EN CASO DEL NUMERO DE CUPON VENIR EN 0 O NULL				*/
/****************************************************************************************/
if @num_ult_cp = 0 or isnull(@num_ult_cp,-1)=-1 begin
	if not exists(select 1 from @TMP_TABLA_DESARROLLO
				where tdfecven = @fec_ucup and tdmascara = @mascara) begin
		set @num_ult_cp = 1
	end else begin
		set @num_ult_cp = (select top 1 tdcupon from @TMP_TABLA_DESARROLLO
				where tdfecven = @fec_ucup and tdmascara = @mascara)
	end
end

/****************************************************************************************/
/*				SETEO DE VARIABLES														*/
/****************************************************************************************/
set @last_cupon =(select max(tdcupon) from @TMP_TABLA_DESARROLLO
					where 
					ltrim(rtrim(tdmascara)) = @mascara
					)
set @first_cupon =(select min(tdcupon) from @TMP_TABLA_DESARROLLO
					where 
					ltrim(rtrim(tdmascara)) = @mascara
					)
select 
@fec_ant = (case 
				when @num_ult_cp = @first_cupon then @fec_pcup
				else tdfecven
			end)
,@num_cp_ant = (case when @num_ult_cp = @first_cupon then @first_cupon else @num_ult_cp - 1 end)

,@fec_vig	 = (select tdfecven from @TMP_TABLA_DESARROLLO where ltrim(rtrim(tdmascara)) = @mascara
				and tdcupon = @num_ult_cp)

,@num_cp_sup = (case when @num_ult_cp = @last_cupon
					then @num_ult_cp 
				else @num_ult_cp + 1
				end
				)
,@fec_sup	= (select tdfecven from @TMP_TABLA_DESARROLLO where ltrim(rtrim(tdmascara)) = @mascara
							and tdcupon = @num_ult_cp +1 )
				
from @TMP_TABLA_DESARROLLO 
where 
	ltrim(rtrim(tdmascara)) = @mascara
	and tdcupon = (case when @num_ult_cp = 1 then 1 else @num_ult_cp - 1 end) 

/****************************************************************************************/
/*									PROCESO												*/
/****************************************************************************************/

declare 
	@p_saldo	numeric(19,4)
,	@p_flujo	numeric(19,4)
,	@p_interes	numeric(19,4)
,	@p_amortiza numeric(19,4)


-- calculo imp_cuo_ini_mo (cuota_inicial)
select @p_interes = tdinteres, @p_flujo = tdflujo, @p_amortiza = tdamort, @p_saldo=tdsaldo
from @TMP_TABLA_DESARROLLO
where 
	tdcupon = @num_cp_ant
	and tdmascara = @mascara


insert into @RF_Values
select 'imp_cuo_ini_mo',convert(numeric(20,4),(@nominal * @p_saldo)/100),null



-- calculo imp_cuo_mo (proxima cuota)
select @p_interes = tdinteres, @p_flujo = tdflujo, @p_amortiza = tdamort, @p_saldo=tdsaldo
from @TMP_TABLA_DESARROLLO
where 
	tdcupon = @num_cp_sup
	and tdmascara = @mascara
insert into @RF_Values
select 'imp_cuo_mo' ,convert(numeric(20,4),(@nominal * @p_saldo)/100),null



if isnull(@opcion,-1)<>-1 begin
	-- informacion para depuracion.
	insert into @RF_Values
	values
	 ('@p_amortiza'	,convert(numeric(19,4),@p_amortiza),null)
	,('@p_interes'	,convert(numeric(19,4),@p_interes	),null )
	,('@p_flujo	'	,convert(numeric(19,4),@p_flujo	),null )
	,('@p_saldo	'	,convert(numeric(19,4),@p_saldo	),null )
	,('@mascara	'	,null,convert(varchar(max),@mascara	))
		
	
	insert into @RF_Values
	values
	 ('fecha_cupon_anterior' ,null, convert(varchar(max),@fec_ant		))
	,('fecha_cupon_siguiente' ,null, convert(varchar(max),@fec_sup		))
	,('fecha_cupon_vigente' ,null, convert(varchar(max),@fec_vig		))
	,('cupon_anterior' , convert(numeric(20,4),@num_cp_ant	),null)
	,('cupon_vigente' , convert(numeric(20,4),@num_ult_cp	),null)
	,('cupon_siguiente' , convert(numeric(20,4),@num_cp_sup	),null)
	,('primer_cupon' , convert(numeric(20,4),@first_cupon	),null)
	,('ultimo_cupon' , convert(numeric(20,4),@last_cupon	),null)
end
return 
end
GO
