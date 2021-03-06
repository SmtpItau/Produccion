USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_XFIL]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_XFIL]  
AS
BEGIN 
SET NOCOUNT ON
-- Swap: Guardar Como
	DECLARE @ACFECHA CHAR(8)

	SELECT @ACFECHA = CONVERT(CHAR(8),fechaproc,112) FROM swapgeneral

	SELECT	 'CTREG' 	= 3						--1
		,'CRUT ' 	= STR(a.rut_cliente) + b.Cldv			--2
		,'CREF'		= a.numero_operacion				--3
		,'Ccope'	= '00000'					--4	
		,'CcSUP'	= space(4)					--5
		,'Cctas' 	= '000'						--6
		,'Cscta'	= '00'						--7
		,'Ccali'	= '0'						--8
		,'Ctipc'	= '0000'					--9
		,'Ccpro'	= '450'						--10
		,'Ctcar'	= space(3)					--11
		,'Ctcre'	= '00'						--12
		,'Cfoto'	= a.fecha_inicio				--13
		,'Cvori'	= a.Capital_Pesos_Actual			--14 
		,'Ccupo'	= '000000000000000'				--15
		,'Cvatc'	= ISNULL((SELECT ROUND(vmvalor,4) 
					 FROM 	view_valor_moneda 
					 WHERE 	vmcodigo = a.compra_moneda AND 
						vmfecha  = @acfecha),0)		--16
		,'Cmon'		=  CONVERT(CHAR(3),c.mncodbanco)		--17
		,'Cmor'		=  CONVERT(CHAR(3),c.mncodbanco)		--18
		,'Cmone'	=  c.mncodmon					--19
		,'Ctasb'	= CASE 	WHEN a.compra_codigo_tasa = 0
					THEN '1'
					ELSE '2'
				  END +
				  CASE 	WHEN a.compra_moneda IN(999,998)
					THEN '1'
					ELSE '3'
				  END + 
				  CASE 	WHEN DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) < 30 
					THEN '1'
					WHEN DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) >= 30 AND DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) < 90
					THEN '2'
					WHEN DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) >= 90 AND DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) < 180
					THEN '3'
					WHEN DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) >= 180 AND DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) < 365
					THEN '4'
					WHEN DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) >= 365 AND DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) < 1095
					THEN '5'
					ELSE '6'
				  END						--20
		,'Ctasa'	= '000000'					--21
		,'Cttas'	= space(3)					--22
		,'Ctcom'	= '000000'					--23
		,'Ctcof'	= '000000'					--24
		,'Cfext'	= a.fecha_termino				--25
		,'Cfven'	= a.fecha_vence_flujo				--26
		,'Ccapi'	= a.Capital_Pesos_Actual			--27 
		,'Cpcrb'	= '000'						--28
		,'cpzop'	= '0000'					--29
		,'cncua'	= '000'						--30
		,'cmcua'	= '0000000000000000'				--31
		,'cmatr'	= '00'						--32
		,'cisis'	= 'BSW'						--33
		,'cofio'	= '00001'					--34
		,'cofco'	= '00001'					--35
		,'cceje'	= space(3)					--36
		,'cccos'	= '00000'					--37
		,'cftas'	= CASE 	WHEN a.compra_codigo_tasa = 0 
					THEN a.fecha_inicio					
					ELSE a.fecha_inicio_flujo
				  END 						--38
		,'cntoc'	= ( SELECT MAX(d.numero_flujo) 
				    FROM   cartera d
				    WHERE  d.numero_operacion = a.numero_operacion
					   AND d.tipo_flujo = 1 )		--39
		,'cncup'	= a.numero_flujo				--40
		,'ccopi'	= '00000'					--41
		,'cinte'	= a.devengo_monto_peso				--42
		,'ccopr'	= '00000'					--43
		,'creaj'	= '000000000000000'				--44
		,'ccjud'	= space(1)					--45
		,'cinfo'	= 'S'						--46
		,'crell'	= '' 						--47
	FROM 	cartera		a 	,
		view_cliente 	b	, 
		view_moneda 	c
	WHERE  	a.rut_cliente 		= b.Clrut 	AND
		a.codigo_cliente  	= b.Clcodigo	AND
		a.fecha_vence_flujo	> @acfecha	AND 
		a.compra_moneda		= c.mncodmon	AND
		a.tipo_flujo		= 1             AND
                a.Estado                <> 'C'
	UNION
	SELECT	 'CTREG' 	= 3						--1
		,'CRUT ' 	= STR(a.rut_cliente) + b.Cldv			--2
		,'CREF'		= a.numero_operacion				--3
		,'Ccope'	= '00000'					--4	
		,'CcSUP'	= space(4)					--5
		,'Cctas' 	= '000'						--6
		,'Cscta'	= '00'						--7
		,'Ccali'	= '0'						--8
		,'Ctipc'	= '0000'					--9
		,'Ccpro'	= '450'						--10
		,'Ctcar'	= space(3)					--11
		,'Ctcre'	= '00'						--12
		,'Cfoto'	= a.fecha_inicio				--13
		,'Cvori'	= a.Capital_Pesos_Actual			--14 
		,'Ccupo'	= '000000000000000'				--15
		,'Cvatc'	= ISNULL((SELECT ROUND(vmvalor,4) 
					 FROM 	view_valor_moneda 
					 WHERE 	vmcodigo = venta_moneda AND 
						vmfecha  = @acfecha),0)		--16
		,'Cmon'		=  c.mncodbanco					--17
		,'Cmor'		=  c.mncodbanco					--18
		,'Cmone'	=  c.mncodmon					--19
		,'Ctasb'	= CASE 	WHEN a.venta_codigo_tasa = 0
					THEN '1'
					ELSE '2'
				  END +
				  CASE 	WHEN a.venta_moneda IN(999,998)
					THEN '1'
					ELSE '3'
				  END + 
				  CASE 	WHEN DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) < 30 
					THEN '1'
					WHEN DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) >= 30 AND DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) < 90
					THEN '2'
					WHEN DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) >= 90 AND DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) < 180
					THEN '3'
					WHEN DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) >= 180 AND DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) < 365
					THEN '4'
					WHEN DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) >= 365 AND DATEDIFF(dd,a.fecha_inicio_flujo,a.fecha_vence_flujo) < 1095
					THEN '5'
					ELSE '6'
				  END						--20
		,'Ctasa'	= '000000'					--21
		,'Cttas'	= space(3)					--22
		,'Ctcom'	= '000000'					--23
		,'Ctcof'	= '000000'					--24
		,'Cfext'	= a.fecha_termino				--25
		,'Cfven'	= a.fecha_vence_flujo				--26
		,'Ccapi'	= a.Capital_Pesos_Actual			--27 
		,'Cpcrb'	= '000'						--28
		,'cpzop'	= '0000'					--29
		,'cncua'	= '000'						--30
		,'cmcua'	= '0000000000000000'				--31
		,'cmatr'	= '00'						--32
		,'cisis'	= 'BSW'						--33
		,'cofio'	= '00001'					--34
		,'cofco'	= '00001'					--35
		,'cceje'	= space(3)					--36
		,'cccos'	= '00000'					--37
		,'cftas'	= CASE 	WHEN a.venta_codigo_tasa = 0 
					THEN a.fecha_inicio				
					ELSE a.fecha_inicio_flujo
				  END 						--38
		,'cntoc'	= ( SELECT MAX(d.numero_flujo) 
				    FROM   cartera d
				    WHERE  d.numero_operacion = a.numero_operacion
					   AND d.tipo_flujo = 2 )		--39
		,'cncup'	= a.numero_flujo				--40
		,'ccopi'	= '00000'					--41
		,'cinte'	= a.devengo_monto_peso				--42
		,'ccopr'	= '00000'					--43
		,'creaj'	= '000000000000000'				--44
		,'ccjud'	= space(1)					--45
		,'cinfo'	= 'S'						--46
		,'crell'	= '' 						--47
	FROM 	cartera		a 	,
		view_cliente 	b	, 
		view_moneda 	c
	WHERE  	a.rut_cliente 		= b.Clrut 	AND
		a.codigo_cliente  	= b.Clcodigo	AND
		a.fecha_vence_flujo	> @acfecha	AND 
		a.venta_moneda		= c.mncodmon	AND
		a.tipo_flujo		= 2             AND
                a.Estado                <> 'C'

END 
GO
