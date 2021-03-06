USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VCTOS_ML_EX_RESUMEN_GLOBAL]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



Create Procedure [dbo].[SP_VCTOS_ML_EX_RESUMEN_GLOBAL]
						@FechaC CHAR(08)
AS
Begin
SET NOCOUNT ON
	CREATE TABLE #TMP_PLAZOS(
		Codigo	 Numeric(10)	,
		PlazoD	 Numeric(10)	,
		PlazoH	 Numeric(10)	,
		Producto Char   (30) Not Null Default ''	,
		Moneda	 Char	(30) Not Null Default ''	,
		CMoneda	 Char   (30) Not Null Default ''	)

	CREATE TABLE #TMP_RESUMEN(
		Producto Numeric(03)	,
		Moneda	 Numeric(03)	,
		CMoneda  Numeric(03)	,
		Plazo	 Numeric(10)	,

		TipoOpC  Char   (01)	,
		ModoCC   Char	(01)	,
		ModoCE   Char	(01)	,

		TipoOpV  Char   (01)	,
		ModoVC   Char	(01)	,
		ModoVE   Char	(01)	,

		Monto	 Float	)

	CREATE TABLE #TMP_FINAL(
		Producto Char   (30)	,
		Moneda	 Char   (30)	,
		CMoneda  Char   (30)	,
		Plazo	 Numeric(10)	,

		TipoOpC  Char   (01)	,
		ModoCC   Float		,
		ModoCE   Float		,

		TipoOpV  Char   (01)	,
		ModoVC   Float		,
		ModoVE   Float		)


	CREATE TABLE #TMP_FINAL_GRUPAL  (
		Producto Char   (30)	,
		Moneda	 Char   (30)	,
		CMoneda  Char   (30)	,
		PlazoDE	 Numeric(10)	,
		PlazoHA	 Numeric(10)	,
		ModoCC   Float		,
		ModoCE   Float		,
		ModoVC   Float		,
		ModoVE   Float		,
		NETO	Float		)
	
	Declare @Pais 	INT		,
		@banco	Char   (30)	,
		@Fecha  Datetime
	SELECT @PAIS  = ACPAIS		,
	       @FECHA = @FECHAC		,
	       @BANCO = ACNOMPROP
	FROM MFAC --CODIGO DEL PAíS 'CHILE'

		insert #TMP_RESUMEN
		SELECT 	CAcodpos1			,
			CAcodmon1			,
			CAcodmon2			,
			datediff(d,@Fecha,CAfecEfectiva),
			(CASE WHEN CAtipoper = 'C' THEN 'X' ELSE '' END),
			(CASE WHEN CAtipoper = 'C' THEN (CASE WHEN CAtipmoda = 'C' THEN 'X' ELSE '' END)ELSE '' END) ,
			(CASE WHEN CAtipoper = 'C' THEN (CASE WHEN CAtipmoda = 'E' THEN 'X' ELSE '' END)ELSE '' END) ,
			(CASE WHEN CAtipoper = 'V' THEN 'X' ELSE '' END),
			(CASE WHEN CAtipoper = 'V' THEN (CASE WHEN CAtipmoda = 'C' THEN 'X' ELSE '' END)ELSE '' END),
			(CASE WHEN CAtipoper = 'V' THEN (CASE WHEN CAtipmoda = 'E' THEN 'X' ELSE '' END)ELSE '' END),
 			convert(numeric,CAmtomon1)
--select *
		FROM  MFCA 
		Where CAfecEfectiva >= @Fecha
                and   cafecvcto > @Fecha
		And   CAcodpos1 In (1,2,3,7,10)

--select *,convert(numeric,Monto) from #TMP_RESUMEN

--Genera Grupo
	select 	 Producto ,
		 Moneda   ,
		 CMoneda  ,
		 Plazo	  , 
		 TipoOpC  ,
		 MODOCC = MAX(MODOCC),
		 ModoCE = MAX(ModoCE),
		 TipoOpV	     ,
 		 ModoVC = MAX(ModoVC),
		 ModoVE = MAX(ModoVE),
		 Monto  = convert(numeric,SUM(Monto))
	Into #Tmp_Grupal
	From #TMP_RESUMEN
	Group By Producto ,
		 Moneda   ,
		 CMoneda  ,
		 Plazo	  , 
		 TipoOpC  ,
		 MODOCC	  ,
		 ModoCE	  ,
		 TipoOpV  ,
 		 ModoVC   ,
		 ModoVE

	Insert #TMP_FINAL
	select 	 Productor = descripcion  ,
		 Moneda = Mon.mnglosa  ,
		 Contramoneda = con.mnglosa  ,
		 Plazo	      , 
		 TipoOpC      ,
		 MODOCC = (Case When TipoOpC = 'X' and MODOCC = 'X' Then Monto Else 0. End)  ,
		 ModoCE = (Case When TipoOpC = 'X' and ModoCE = 'X' Then Monto Else 0. End)  ,
		 TipoOpV      							    	     ,
		 ModoVC = (Case When TipoOpV = 'X' and ModoVC = 'X' Then Monto Else 0. End)  ,
		 ModoVE = (Case When TipoOpV = 'X' and ModoVE = 'X' Then Monto Else 0. End)  
	From #TMP_grupal
	Inner Join bacparamsuda..producto
 	   On id_sistema      = 'BFW'
	  And codigo_producto = Producto
	Inner Join bacparamsuda..moneda Mon
	   On Moneda = Mon.mncodmon
	Inner Join bacparamsuda..moneda Con
	   On CMoneda = Con.mncodmon

	select 	Producto 		    ,
		Moneda	 	    	    ,
		CMoneda  		    ,
		Plazo	 		    ,
		MODOCC = convert(numeric,Sum(MODOCC))	    ,
		ModoCE = convert(numeric,Sum(ModoCE))	    ,
		ModoVC = convert(numeric,Sum(ModoVC))	    ,
		ModoVE = convert(numeric,Sum(ModoVE))	    ,
		NETO   = (convert(numeric,SUM(MODOCC)) + convert(numeric,SUM(ModoCE))) - convert(numeric,(SUM(MODOVC)) + convert(numeric,SUM(ModoVE)))
-- 	        Fecha = Convert(Char(10),@FECHA,103),
--	        Banco = @BANCO
	Into #TMP_Final_Neto
	from #TMP_FINAL
	Group By Producto ,
		 Moneda	  ,
		 CMoneda  ,
		 Plazo	 

--select * from #TMP_Final_Neto
--SELECT * FROM #TMP_PLAZOS --#TMP_Final_Neto


/*** CARGA DE LOS GRUPOS ***/
Insert #TMP_PLAZOS SELECT 1,0,0,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 2,1,1,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 3,2,2,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 4,3,3,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 5,4,4,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 6,5,5,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 7,6,6,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 8,7,15,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 9,16,30,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 10,31,60,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 11,61,90,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 12,91,180,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 13,181,360,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA
Insert #TMP_PLAZOS SELECT 14,361,9999999999,PRODUCTO,MONEDA,CMONEDA FROM #TMP_Final_Neto GROUP BY PRODUCTO, MONEDA,CMONEDA

Insert #TMP_FINAL_GRUPAL
select  NET.Producto 	   ,
        NET.Moneda	 	   ,
        NET.CMoneda  	   ,
        (PLA.PlazoD)	   ,
	(PLA.PlazoH)	   ,
        sum(MODOCC) 	,
	sum(ModoCE)	,
	sum(ModoVC)	,
	sum(ModoVE)	,
	sum(NETO)
FROM #TMP_FINAL_NETO NET, #TMP_PLAZOS PLA
WHERE NET.Plazo BETWEEN PLA.PlazoD AND PLA.PlazoH
  And NET.Producto = PLA.Producto
  And NET.Moneda   = PLA.Moneda
  And NET.CMoneda  = PLA.CMoneda
Group By NET.Producto 	   ,
         NET.Moneda	 	   ,
         NET.CMoneda  	   ,
	 PLA.PlazoD	   	   ,
	 PLA.PlazoH

INSERT #TMP_FINAL_GRUPAL 
SELECT PLA.PRODUCTO,PLA.MONEDA,PLA.CMONEDA,PLA.PLAZOD,PLA.PLAZOH,0.0,0.0,0.0,0.0,0.0 
FROM #TMP_FINAL_GRUPAL GRU, #TMP_PLAZOS PLA
WHERE  PLA.PRODUCTO = GRU.PRODUCTO
  AND  PLA.MONEDA   = GRU.MONEDA
  AND  PLA.CMONEDA  = GRU.CMONEDA
  AND  (PLA.PLAZOD  <> GRU.PLAZODE
  AND  PLA.PLAZOH   <> GRU.PLAZOHA)
GROUP BY PLA.PRODUCTO,PLA.MONEDA,PLA.CMONEDA,PLA.PLAZOD,PLA.PLAZOH

select 	Producto	, 
	Moneda		, 
	CMoneda		,
	Plazo   = right('   ' + str(PlazoDE),3) + 
				  (case when PlazoDE <> PlazoHA then  
					(case when PlazoDE = 361 then 
						' ó +    ' 
					 else   ' a'
					 end) + 
					(case when PlazoHA = 9999999999 then 
						' ' 
					else right('    ' + str(PlazoHA),4)
					end) 
				  else '' 
				  end),
	ModoCC  = Sum(ModoCC)		,
	ModoCE  = Sum(ModoCE)		,
	ModoVC  = Sum(ModoVC)		,
	ModoVE  = Sum(ModoVE)		,
	NETO    = Sum(NETO)		,
	'FECHA' = convert(Char(10),@FECHA,103),
	'BANCO' = @BANCO
from #TMP_FINAL_GRUPAL  
Group BY PRODUCTO,MONEDA,CMONEDA,PLAZODE,PLAZOHA

SET NOCOUNT OFF
End 


GO
