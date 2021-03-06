USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_PASIVOS_34A_1]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_PASIVOS_34A_1]    
                      @dFecha DATETIME

AS    
BEGIN    


    
	SET NOCOUNT ON   

	 
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : PASIVOS                                                     */
   /* AUTOR         : ALEJANDRO CONTRERAS                                         */
   /* FECHA CRACION : 19/02/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
CREATE TABLE #TEMP
	(
			FechaEmisionINT		CHAR(10)		--1--
		,	NombrePapel			CHAR(30)		--2--
		,	CodigoPapel			CHAR(15)		--3--
		,	CodigoEmpresa_Sinc	NUMERIC(3,0)	--4--
		,	NombreEmpresa		CHAR(50)		--5--
		,	Indexador			NUMERIC(5,0)	--6--
		,	PorcentajeIndexador INT				--7--
		,	Tasa				NUMERIC(9,4)	--8--
		,	NombreContraparte	VARCHAR(50)		--9--
		,	CNPJ				VARCHAR(50)		--10--
		,	TipoPersona			VARCHAR(50)		--11--
		,	CodCetip			CHAR(1)			--12--
		,	Principal			NUMERIC(19,4)	--13--
		,	Controle			CHAR(1)			--14--
		,	Interes				NUMERIC(19,2)	--15--
		,	Reajuste			NUMERIC(19,0)	--16--
		,	ValorContable		NUMERIC(19,2)	--17--
		,	FechaEmision		DATETIME		--18--
		,	FechaVencimiento	DATETIME		--19--
		,	FechaProxCupon		DATETIME		--20--
		,	InteresReal			NUMERIC(1,1)	--21--
		,	PagoIntereses		NUMERIC(1,0)	--22--
		,	PlazoIntereses		NUMERIC(1,0)	--23--
		,	DiasXVencer			NUMERIC(1,0)	--24--
		,	plazoII				INT				--25--
		,	Plazo				CHAR(20)		--26--
		,	Cosif				VARCHAR(20)		--27--
		,	CosifGer			CHAR(1)			--28--
		,	CosifIntereses		CHAR(1)			--29--
		,	CosifReajustes		CHAR(1)			--30--
		,	MoNedaOrigemCont	CHAR(3)			--31--
		,	CXVencimientos		CHAR(1)			--32--
		,	BACEN				CHAR(2)			--33--
		,	Nota				CHAR(1)			--34--
		,	ApoioNota			CHAR(1)			--35--
		,	ApoioCDB			CHAR(1)			--36--
	)
	
	INSERT INTO #TEMP
	SELECT	CONVERT(CHAR(10),@dFecha,105)																	--1--
		,	INS.nombre_instrumento																			--2--
		,	CAR.nombre_serie																				--3--
		,	469																								--4--
		,	(SELECT LTRIM(RTRIM(Nombre_Entidad)) FROM MdParPasivo.dbo.DATOS_GENERALES WITH(NOLOCK))			--5--
		,	car.moneda_emision																				--6--
		,	0																								--7--
		,	car.tasa_colocacion																				--8--
		,	MdPasivo.dbo.Fn_datos_cliente (car.rut_cliente, car.codigo_cliente, 1)							--9--
		,	MdPasivo.dbo.Fn_datos_cliente (car.rut_cliente, car.codigo_cliente, 3)							--10--
		,	MdPasivo.dbo.Fn_datos_cliente (car.rut_cliente, car.codigo_cliente, 4)							--11--
		,	''																								--12--
		,	ISNULL(Res.nominal,0)																			--13--
		,	''																								--14--
		,	ISNULL(Res.interes_acum_colocacion, 0)															--15--
		,	ISNULL(Res.reajuste_acum_colocacion, 0)															--16--
		,	ISNULL(Res.valor_proximacolocacion, 0)															--17--
		,	CAR.fecha_emision_papel																			--18--
		,	CAR.fecha_vencimiento																			--19--
		,	CAR.fecha_proximo_cupon																			--20--
		,	0.0																								--21--
		,	0																								--22--
		,	0																								--23--
		,	0																								--24--
		,	DATEDIFF(YY,CAR.fecha_colocacion,CAR.fecha_vencimiento)											--25--
		,	CASE WHEN DATEDIFF(YY,CAR.fecha_colocacion,CAR.fecha_vencimiento) < 1 THEN 'Inferior 1 ano'		--26--
				 WHEN DATEDIFF(YY,CAR.fecha_colocacion,CAR.fecha_vencimiento) < 2 THEN 'Inferior 2 ano'		
				 WHEN DATEDIFF(YY,CAR.fecha_colocacion,CAR.fecha_vencimiento) < 3 THEN 'Inferior 3 ano'		
				 WHEN DATEDIFF(YY,CAR.fecha_colocacion,CAR.fecha_vencimiento) < 4 THEN 'Inferior 4 ano'		
				 WHEN DATEDIFF(YY,CAR.fecha_colocacion,CAR.fecha_vencimiento) < 5 THEN 'Inferior 5 ano'		
				 WHEN DATEDIFF(YY,CAR.fecha_colocacion,CAR.fecha_vencimiento) >= 5 THEN 'Superior a 5 anos'	
			END																								
		,	(SELECT CUENTA_CONTABLE 
		 	 FROM REPORTES.DBO.ContabilidadBonosPasivo(CAR.numero_operacion, CAR.numero_correlativo) 
		 	 WHERE CORRELATIVO =1)																			--27--
		,	''																								--28--
		,	''																								--29--	
		,	''																								--30--
		,	'CLP'																							--31--
		,	''																								--32--
		,	'NO'																							--33--
		,	''																								--34--
		,	''																								--35--	
		,	''																								--36--

	FROM MdPasivo.dbo.CARTERA_PASIVO CAR LEFT JOIN MdPasivo.dbo.RESULTADO_PASIVO RES
											ON RES.fecha_calculo		= @dFecha
											AND RES.codigo_instrumento	= 15
											AND RES.tipo_operacion		= 'DEV'
											AND RES.numero_operacion	= CAR.numero_operacion
											AND RES.numero_correlativo	= CAR.numero_correlativo
	
											INNER JOIN MdPasivo.dbo.SERIE_PASIVO SER
											ON SER.codigo_instrumento = 15
											AND SER.bono_subordinado = 'S'
											AND SER.codigo_instrumento = CAR.codigo_instrumento
											AND SER.nombre_serie =CAR.nombre_serie
											
											LEFT JOIN MdPasivo.dbo.INSTRUMENTO_PASIVO INS
											ON INS.codigo_instrumento = CAR.codigo_instrumento
											



	SELECT
		t.FechaEmisionINT,
		t.NombrePapel,
		t.CodigoPapel,
		t.CodigoEmpresa_Sinc,
		t.NombreEmpresa,
		t.Indexador,
		t.PorcentajeIndexador,
		t.Tasa,
		t.NombreContraparte,
		t.CNPJ,
		t.TipoPersona,
		t.CodCetip,
		t.Principal,
		t.Controle,
		t.Interes,
		t.Reajuste,
		t.ValorContable,
		t.FechaEmision,
		t.FechaVencimiento,
		t.FechaProxCupon,
		t.InteresReal,
		t.PagoIntereses,
		t.PlazoIntereses,
		t.DiasXVencer,
		t.plazoII,
		t.Plazo,
		t.Cosif,
		t.CosifGer,
		t.CosifIntereses,
		t.CosifReajustes,
		t.MoNedaOrigemCont,
		t.CXVencimientos,
		t.BACEN,
		t.Nota,
		t.ApoioNota,
		t.ApoioCDB
	FROM
		#TEMP t


END
GO
