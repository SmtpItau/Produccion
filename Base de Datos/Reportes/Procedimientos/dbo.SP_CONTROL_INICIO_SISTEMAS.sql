USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_INICIO_SISTEMAS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_INICIO_SISTEMAS](
	@opcion int,
	@sistemas bit = 0
)
AS
BEGIN
 /*
	VALORES @SISTEMAS:
	0: Sistemas nacionales 
	1: Sistemas nueva york
	
	VALORES @OPCION:
   -1: Muestra los valores a procesar. (opcion para debug)
	0: Incio_Dia		-- Inicio de Dia
	1: Fin_Dia			-- Fin de dia
	2: Apertura_Mesa	-- Apertura de Mesa
	3: Cierre_Mesa		-- Cierre de Mesa
	4: Devengo			-- Devengo y Valorizacion, incluye Tasa de mercado para modulo Renta Fija
*/

set nocount on 

declare 
@fecha datetime,			-- fecha 
@switch int,				-- auxiliar de switch a evaluar
@registros int,				-- auxiliar de registros relacionados al switch a evaluar
@esferiado int,				-- indica si una fecha en particular es feriado o no | -1:true, 0: false
@estado varchar(5),			-- mensaje de status a devolver (True|False)
@mensaje varchar(5),		-- mensaje de proceso a devolver (OK | Err.)
@descripcion varchar(100)	-- descripcion del mensaje a devolver

/* TABLA CON LOS VALORES DE SWITCH A EVALUAR. */
declare @SISTEMA_NAC table (Posicion int,Sistema varchar(20),Modulo varchar(20),FechaAnterior Datetime,FechaProceso DateTime,FechaProxima DateTime
,ID int		-- INICIO DIA
,RC int		-- RE-COMPRA AUTOMATICA
,RV int		-- RE-VENTA AUTOMATICA
,CM int		-- CIERRE DE MESA
,CO int		-- CONTABILIDAD
,DV int		-- DEVENGO Y VALORIZACION
,TM int		-- TAZA MERCADO
,FD int		-- FIN DE DIA
)
/*
ID -- INICIO DIA
RC -- RE-COMPRA AUTOMATICA
RV -- RE-VENTA AUTOMATICA
CM -- CIERRE DE MESA
CO -- CONTABILIDAD
DV -- DEVENGO Y VALORIZACION
TM -- TAZA MERCADO
FD -- FIN DE DIA

VALORES: 
--  1: REALIZADO
--  0: NO REALIZADO
-- -1: NO APLICA
*/


--/* SISTEMAS CHILE */
INSERT INTO @SISTEMA_NAC
SELECT ROW_NUMBER() OVER (ORDER BY LEN(Modulo),Sistema) AS Posicion, * FROM (
SELECT 
'RentaFija' as Sistema
,'BTR' AS Modulo
, acfecante as FechaAnterior
, acfecproc as FechaProceso
, acfecprox as FechaProxima
, ID = (CASE WHEN acsw_pd = 1 THEN 1 ELSE 0 END)
, RC = (CASE WHEN acsw_rc = 1 THEN 1 ELSE 0 END)
, RV = (CASE WHEN acsw_rv = 1 THEN 1 ELSE 0 END)
, CM = (CASE WHEN acsw_mesa = 1 THEN 1 ELSE 0 END)
, CO = (CASE WHEN acsw_co = 1 THEN 1 ELSE 0 END)
, DV = (CASE WHEN acsw_dvprop = 1 THEN 1 ELSE 0 END)
, TM = (CASE WHEN NOT Tm.Fecha IS NULL THEN 1 ELSE 0 END)
, FD = (CASE WHEN acsw_fd = 1 THEN 1 ELSE 0 END )
FROM  BacTraderSuda.dbo.MDAC with(nolock)
LEFT JOIN ( select top 1 Fecha = fecha_valorizacion
from BacTraderSuda.dbo.VALORIZACION_MERCADO with(nolock)
where fecha_valorizacion = (select acfecproc from BacTraderSuda.dbo.MDAC with(nolock) )
) Tm On Tm.Fecha = acfecproc
UNION
SELECT 
'Bonex' as Sistema
,'BEX' as Modulo
, acfecante as FechaAnterior
, acfecproc as FechaProceso
, acfecprox as FechaProxima
, ID = (CASE WHEN acsw_pd = 1 THEN 1 ELSE 0 END)
, RC = -1
, RV = -1
, CM = (CASE WHEN acsw_mesa = 1 THEN 1 ELSE 0 END)
, CO = (CASE WHEN acsw_co = 1 THEN 1 ELSE 0 END)
, DV = (CASE WHEN acsw_dv = 1 THEN 1 ELSE 0 END)
, TM = (CASE WHEN NOT Tm.Fecha IS NULL THEN 1 ELSE 0 END)
, FD = (CASE WHEN acsw_fd = 1 THEN 1 ELSE 0 END)
FROM  BacBonosExtSuda.dbo.TEXT_ARC_CTL_DRI with(nolock)
LEFT JOIN (select top 1 Fecha = mofecpro
from  BacBonosExtSuda.dbo.TEXT_MVT_DRI_TAS_MERC with(nolock)
where mofecpro = (select acfecproc from BacBonosExtSuda.dbo.TEXT_ARC_CTL_DRI with(nolock) )
) Tm On Tm.Fecha = acfecproc 
UNION  
SELECT 
'Spot' as Sistema
,'BCC' as Modulo
, acfecant as FechaAnterior
, acfecpro as FechaProceso
, acfecprx as FechaProxima
, ID = (CASE WHEN substring(aclogdig,1,1) = 1 THEN 1 ELSE 0 END)
, RC = -1													   
, RV = -1													   
, CM = (CASE WHEN substring(aclogdig,6,1) = 1 THEN 1 ELSE 0 END)
, CO = (CASE WHEN substring(aclogdig,8,1) = 1 THEN 1 ELSE 0 END)
, DV = -1													   
, TM = -1													   
, FD = (CASE WHEN substring(aclogdig,9,1) = 1 THEN 1 ELSE 0 END)
FROM BaccamSuda.dbo.MEAC with(nolock)
UNION
SELECT 
'Forward' as Sistema
,'BFW' as Modulo
, acfecante as FechaAnterior
, acfecproc as FechaProceso
, acfecprox as FechaProxima
, ID = (CASE WHEN acsw_pd = 1 THEN 1 ELSE 0 END)
, RC = -1
, RV = -1
, CM = (CASE WHEN acsw_ciemefwd = 1 THEN 1 ELSE 0 END)
, CO = (CASE WHEN acsw_contafwd = 1 THEN 1 ELSE 0 END)
, DV = (CASE WHEN acsw_devenfwd = 1 THEN 1 ELSE 0 END)
, TM = -1
, FD = (CASE WHEN acsw_fd = 1 THEN 1 ELSE 0 END)
FROM BacFwdSuda.dbo.MFAC with(nolock)
UNION  
SELECT 
'Swap' as Sistema
,'PCS' as Modulo
, fechaant	 as FechaAnterior
, fechaproc	 as FechaProceso
, fechaprox	 as FechaProxima
, ID = (CASE WHEN iniciodia = 1 THEN 1 ELSE 0 END)
, RC = -1
, RV = -1
, CM = (CASE WHEN cierreMesa = 1 THEN 1 ELSE 0 END)
, CO = (CASE WHEN contabilidad = 1 THEN 1 ELSE 0 END)
, DV = (CASE WHEN devengo = 1 THEN 1 ELSE 0 END)
, TM = -1
, FD = (CASE WHEN findia = 1 THEN 1 ELSE 0 END)
FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock)
UNION    
SELECT 
'Opciones' as Sistema
,'OPC' as Modulo
, fechaant	 as FechaAnterior
, fechaproc	 as FechaProceso
, fechaprox	 as FechaProxima
, ID = (CASE WHEN iniciodia = 1 THEN 1 ELSE 0 END)
, RC = -1
, RV = -1
, CM = (CASE WHEN cierreMesa = 1 THEN 1 ELSE 0 END)
, CO = (CASE WHEN contabilidad = 1 THEN 1 ELSE 0 END)
, DV = (CASE WHEN devengo = 1 THEN 1 ELSE 0 END)
, TM = -1
, FD = (CASE WHEN findia = 1 THEN 1 ELSE 0 END)
FROM CbMdbOpc.dbo.OPCIONESGENERAL with(nolock)
) AS T1


/* VALIDACION DE ALINEACION DE FECHAS: >1 : indica que los sistemas estan alineados*/
if((select count(distinct FechaProxima) from @SISTEMA_NAC)>1) begin
	
	set @estado		 = 'False'
	set @mensaje	 = 'Err.'
	set @descripcion = 'Error en sincronización de modulos, fecha de sistemas desalineados'
	set @switch		 = -1 
	set @registros	 = -1
	set @opcion		 = -1

	select Estado = @estado,Mensaje=@mensaje,Descripcion = @descripcion
	select status_switch = @switch,registros = @registros
	return
end 



if(@sistemas='true') begin
	--set @fecha = '2016-04-03' -- (select distinct FechaProxima from @SISTEMA_NAC)
	set @fecha = (select distinct FechaProxima from @SISTEMA_NAC)
	exec BacParamSuda.dbo.sp_feriado @dFecha=@fecha,@cPlaza=225,@lFlag = @esferiado OUTPUT
	if (@esferiado = 0) begin
		--/* NEW YORK */
																																																																							INSERT INTO @SISTEMA_NAC
	SELECT ROW_NUMBER() OVER (ORDER BY SISTEMA ASC) AS Posicion, * FROM (
	SELECT 
	'Bonex (NY)' as Sistema
	,'BEXNY' as Modulo
	, acfecante  as FechaAnterior
	, acfecproc as FechaProceso
	, acfecprox as FechaProxima
	, ID = (CASE WHEN acsw_pd = 1 THEN 1 ELSE 0 END)
	, RC = -1
	, RV = -1
	, CM = (CASE WHEN acsw_mesa = 1 THEN 1 ELSE 0 END)
	, CO = (CASE WHEN acsw_co = 1 THEN 1 ELSE 0 END)
	, DV = (CASE WHEN acsw_dv = 1 THEN 1 ELSE 0 END)
	, TM = (CASE WHEN NOT Tm.Fecha IS NULL THEN 1 ELSE 0 END)
	, FD = (CASE WHEN acsw_fd = 1 THEN 1 ELSE 0 END) 
	FROM BacBonosExtNY.dbo.TEXT_ARC_CTL_DRI with(nolock) 
	LEFT JOIN (select  top 1 Fecha = mofecpro from  BacBonosExtNy.dbo.TEXT_MVT_DRI_TAS_MERC with(nolock) 
	where mofecpro = (select acfecproc from BacBonosExtNY.dbo.TEXT_ARC_CTL_DRI with(nolock))) Tm  On Tm.Fecha = acfecproc 
	UNION
	SELECT 
	'Swap (NY)' as Sistema
	,'PCSNY' as Modulo 
	, fechaant	 as FechaAnterior
	, fechaproc	 as FechaProceso
	, fechaprox	 as FechaProxima
	, ID = CASE WHEN iniciodia = 1 THEN 1 ELSE 0 END
	, RC = -1
	, RV = -1
	, CM = CASE WHEN cierreMesa = 1 THEN 1 ELSE 0 END
	, CO = CASE WHEN contabilidad = 1 THEN 1 ELSE 0 END
	, DV = CASE WHEN devengo = 1 THEN 1 ELSE 0 END
	, TM = -1 
	, FD = CASE WHEN findia = 1 THEN 1 ELSE 0 END
	FROM BacSwapNy.dbo.SWAPGENERAL with(nolock) 
	/*
	UNION
	SELECT 
	'Forward (NY)' as Sistema
	,'BFWNY' as Modulo 
	, acfecante	 as FechaAnterior
	, acfecproc	 as FechaProceso
	, acfecprox	 as FechaProxima
	, ID = (CASE WHEN acsw_pd = 1 THEN 1 ELSE 0 END)
	, RC = -1
	, RV = -1
	, CM = (CASE WHEN acsw_ciemefwd = 1 THEN 1 ELSE 0 END)
	, CO = (CASE WHEN acsw_contafwd = 1 THEN 1 ELSE 0 END)
	, DV = (CASE WHEN acsw_devenfwd = 1 THEN 1 ELSE 0 END)
	, TM = -1
	, FD = (CASE WHEN acsw_fd = 1 THEN 1 ELSE 0 END)
	FROM BacFwdNy.dbo.MFAC with(nolock)
	UNION
	SELECT 
	'Opciones (NY)' as Sistema
	,'OPCNY' as Modulo
	, fechaant as FechaAnterior
	, fechaproc as FechaProceso
	, fechaprox as FechaProxima
	, ID = (CASE WHEN iniciodia = 1 THEN 1 ELSE 0 END)
	, RC = -1
	, RV = -1
	, CM = (CASE WHEN cierreMesa = 1 THEN 1 ELSE 0 END)
	, CO = (CASE WHEN contabilidad = 1 THEN 1 ELSE 0 END)
	, DV = (CASE WHEN devengo = 1 THEN 1 ELSE 0 END)
	, TM = -1
	, FD = (CASE WHEN findia = 1 THEN 1 ELSE 0 END)
	FROM CbMdbOpcNy.dbo.OPCIONESGENERAL with(nolock) 
	*/
	) as T2
	end
end


/* obtencion de datos */

if (@opcion = -1) begin
    -- para debug
	select * from @SISTEMA_NAC
	select @esferiado as 'Es Feriado'	
end else if (@opcion = 0) begin
	-- inicio dia
	select 
		@switch = min(tbl_control.ID),
		@registros = sum(tbl_control.Registros)
	from (	
		select 
			tbl_data.ID,
			tbl_data.FechaProxima,
			Registros = count(1)
		from (		
				select ID,FechaProxima
				from @SISTEMA_NAC 				
				group by FechaProxima,ID						
		) as tbl_data
		group by tbl_data.ID,tbl_data.FechaProxima
	) as tbl_control	
	set @descripcion = 'Error en sincronización de modulos, Inicio de día aún no realizado'
end else if (@opcion = 1) begin
	-- Fin dia
	select 
		@switch = min(tbl_control.FD),
		@registros = sum(tbl_control.Registros)
	from (	
		select 
			tbl_data.FD,
			tbl_data.FechaProxima,
			Registros = count(1)
		from (		
				select FD,FechaProxima
				from @SISTEMA_NAC 
				group by FechaProxima,FD					
		) as tbl_data
		group by tbl_data.FD,tbl_data.FechaProxima
	) as tbl_control
	set @descripcion = 'Error en sincronización de modulos, Fin de día aún no realizado'	
end else if(@opcion = 2) begin
	-- APERTURA DE MESA			
	select 
		@switch = min(tbl_control.CM),
		@registros = sum(tbl_control.Registros)
	from (	
		select 
			tbl_data.CM,
			tbl_data.FechaProceso,
			Registros = count(1)
		from (		
				select CM,FechaProceso
				from @SISTEMA_NAC 
				group by CM,FechaProceso
		) as tbl_data
		group by tbl_data.CM,tbl_data.FechaProceso
	) as tbl_control
		
	set @descripcion = ' Error en sincronización de mesas, faltan por abrir.'	
end else if(@opcion = 3) begin
	-- CIERRE MESA
	select 
		@switch = min(tbl_control.CM),
		@registros = sum(tbl_control.Registros)
	from (	
		select 
			tbl_data.CM,
			tbl_data.FechaProxima,
			Registros = count(1)
		from (		
				select CM,FechaProxima
				from @SISTEMA_NAC 
				-- where Posicion not in (1,4) for debug
				group by FechaProxima,CM
		) as tbl_data
		group by tbl_data.CM,tbl_data.FechaProxima
	) as tbl_control

	set @descripcion = ' Error en sincronización de mesas, faltan por cerrar.'	
end else if(@opcion = 4) begin
	-- DEVENGO Y VALORIZACION
	select 
		@switch = min(tbl_control.DV),
		@registros = sum(tbl_control.Registros)
	from (	
		select 
			tbl_data.DV,
			tbl_data.FechaProxima,
			Registros = count(1)
		from (		
				select DV,FechaProxima from @SISTEMA_NAC where Modulo not like ('BCC%') 
				group by FechaProxima,DV 
				union  
				select TM,FechaProxima from @SISTEMA_NAC where Modulo like ('BTR%') or Modulo like ('BEX%') 
				group by FechaProxima,TM				
		) as tbl_data
		group by tbl_data.DV,tbl_data.FechaProxima
	) as tbl_control
	
	set @descripcion = ' Error de sincronización (Devengo y Valorizacion)'
end


/*
SOLO PARA PRUEBAS DE SERVICIO WINDOWS: WindowsServiceFMD
, volver a comentar antes de pasar a produccion.
*/
--set @switch    = 1
--set @registros = 1



if(@switch = 1 and @registros = 1) begin
	set @estado='True'
	set @mensaje='Ok'
	set @descripcion = 'Modulos Sincronizados'
end else begin
	set @estado = 'False'
	set @mensaje = 'Err.'	
end


select Estado = @estado,Mensaje=@mensaje,Descripcion = @descripcion
select status_switch = @switch,registros = @registros

/*
tm,co,dv ->BTR
dv-co ->

fwd,opc,bcc,pcs -> no aplica tasa mercado (TM)
renta fija,bonex -> aplica tasa mercado (TM)
dvengo para todos  menos spot
*/
END


GO
