USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CO50]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CO50 '20211010'
CREATE PROCEDURE [dbo].[CO50] (@dFechaProceso	DateTime=Null)
AS
BEGIN	
 	SET NOCOUNT ON

--declare @dFechaProceso	DateTime
--set @dFechaProceso	='20220329'

	DECLARE @CANTIDAD INT
	
	CREATE TABLE #SALIDA_INT (REG_SALIDA varchar (121) )

	Declare @TipoSalida bit = 0

	if @dFechaProceso is null  
	begin   
	 set @dFechaProceso =  (SELECT fecha_proceso FROM MDPASIVO..View_Datos_Generales)
	end  

	CREATE TABLE #INT_CLI_OPE(
	/*01*/	ctry			CHAR(3),
	/*02*/	intf_dt			char(08),
	/*03*/	src_id			CHAR(14),
	/*04*/	cem				CHAR(3),
	/*05*/	con_no			CHAR(20),
	/*06*/	ident_cli		CHAR(12),
	/*07*/	rel_typ			CHAR(2),
	/*08*/	prod			CHAR(16),
	/*09*/	reln_pct		NUMERIC(6,3),
	/*10*/	val_lim_per		NUMERIC(14)		
	)		

	INSERT INTO #INT_CLI_OPE
	SELECT
	/*01*/	'ctry'			=	'CL ',
	/*02*/	'intf_dt'		=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))	,
	/*03*/	'src_id'		=	'COC3',
	/*04*/	'cem'			=	'001',
	/*05*/	'con_no'		=	LTRIM(RTRIM(STR(numero_operacion)))+LTRIM(RTRIM(STR(numero_correlativo))), 
	 
	/*06*/	'ident_cli'		=	right(replicate('0',12)+convert(varchar(10),Rut_Entidad)+Digito_Entidad,12) , 
	/*07*/	'rel_typ'		=	'00',
	/*08*/	'prod'			=	LTRIM(RTRIM((SELECT glosa FROM MDPASIVO..INSTRUMENTO_PASIVO I WHERE I.Codigo_Instrumento = P.Codigo_Instrumento)))+ SPACE(9),
	/*09*/	'reln_pct'		=	0,
	/*10*/	'val_lim_per'	=	0
	FROM	MDPASIVO..CARTERA_PASIVO P, MDPASIVO..VIEW_DATOS_GENERALES
	WHERE	P.estado_operacion = ''
	AND		fecha_vencimiento>=@dFechaProceso

--+ JPL
	INSERT INTO #INT_CLI_OPE
	SELECT
	/*01*/	'ctry'			=	'CL ',
	/*02*/	'intf_dt'		=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))	,
	/*03*/	'src_id'		=	'COC3',
	/*04*/	'cem'			=	'001',
	/*05*/	'con_no'		=	LTRIM(RTRIM(STR(numero_operacion)))+LTRIM(RTRIM(STR(numero_correlativo))), 
	/*06*/	'ident_cli'		=	convert(char(25),LTRIM(RTRIM(STR(Rut_Entidad))) + Digito_Entidad), 
	/*07*/	'rel_typ'		=	'00',
	/*08*/	'prod'			=	 LTRIM(RTRIM((SELECT glosa FROM MDPASIVO..INSTRUMENTO_PASIVO I WHERE I.Codigo_Instrumento = P.Codigo_Instrumento)))+ SPACE(9),
	/*09*/	'reln_pct'		=	0,
	/*10*/	'val_lim_per'	=	0
	FROM	MDPASIVO..MOVIMIENTO_PASIVO P, MDPASIVO..VIEW_DATOS_GENERALES
	WHERE	P.estado_operacion = ''
	AND		fecha_vencimiento>=@dFechaProceso
	AND     P.fecha_movimiento = @dFechaProceso
	AND     P.tipo_operacion = 'VEN'

	
if @TipoSalida != 0
	SELECT 
				  ctry																				--		1																							
				, intf_dt																			--		2																				
				, src_id																			--		3																				
				, cem																				--		4	
				, left(con_no+space(20), 20) as con_no												--		5	
				, Ident_cli																			--		6	
				, rel_typ																			--		7																			
				, 'MD01' + SPACE(12)	--prod																				--		8																																		
				, right(replicate(0,6)+convert(varchar(6),convert(numeric(6),abs(reln_pct*1000))),6) as reln_pct
				, right(replicate(0,14)+convert(varchar(14),convert(numeric(14),abs(val_lim_per))),14) as val_lim_per
	FROM #INT_CLI_OPE --order by cem, prod, con_no
else
	begin

	INSERT INTO #SALIDA_INT
		select 
				  ctry																				--		1																							
				+ intf_dt																			--		2																				
				+ src_id																			--		3																				
				+ cem																				--		4	
				+ left(con_no+space(20), 20)														--		5	
				+ Ident_cli																			--		6	
				+ rel_typ																			--		7																			
				+ 'MD01' + SPACE(12)	 --prod																				--		8																																		
				+ right(replicate(0,6)+convert(varchar(6),convert(numeric(6),abs(reln_pct*1000))),6)
				+ right(replicate(0,14)+convert(varchar(14),convert(numeric(14),abs(val_lim_per))),14)
	FROM #INT_CLI_OPE

	SET @CANTIDAD = (SELECT COUNT(*) FROM #SALIDA_INT)

--	INSERT INTO #SALIDA_INT
--	SELECT '99' + CONVERT(CHAR(08),@dFechaProceso,112)+ RTRIM(REPLICATE ('0', 10 - LEN(CONVERT(NUMERIC,@CANTIDAD))) + CONVERT(CHAR,CONVERT(NUMERIC,@CANTIDAD))) + SPACE(69)  
    
	SELECT * FROM #SALIDA_INT
	END


drop table #SALIDA_INT
drop table #INT_CLI_OPE


END

GO
