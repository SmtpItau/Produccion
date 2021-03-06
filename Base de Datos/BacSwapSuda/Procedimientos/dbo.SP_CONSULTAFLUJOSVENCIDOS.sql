USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTAFLUJOSVENCIDOS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CONSULTAFLUJOSVENCIDOS]
   (   @FechaVcto   DATETIME   )
AS
BEGIN
 -- SP_CONSULTAFLUJOSVENCIDOS '20150623'
   
  SET NOCOUNT ON
-- Swap: Guardar Como
   DECLARE @FechaSistema  DATETIME
   DECLARE @iFoundIcp     FLOAT
   DECLARE @Dias INT
   DECLARE @ContDias INT
   DECLARE @RescatarDias INT
   DECLARE @cDiasFeriados  VARCHAR(255)
   DECLARE @Cont int
   /*DECLARE @Num int
   DECLARE @DiaSig DATE
   DECLARE @Dia char(2)
   DECLARE @Retorno INT
   DECLARE @FecAux DATE
   DECLARE @ContAux INT
   DECLARE @FecFin DATE*/
   SELECT  @FechaSistema  = fechaproc 
   FROM    SWAPGENERAL

   SELECT  @iFoundIcp  = 0.0
   SELECT  @iFoundIcp  = ISNULL(vmvalor,0.0)
   FROM    BacParamSuda..VALOR_MONEDA
   WHERE   vmfecha     = @FechaSistema
   AND     vmcodigo    = 800 
   AND     vmvalor    <> 0


   DECLARE @SigDiaHabil	  DATETIME
   DECLARE @SDH			  DATETIME
   DECLARE @FecOriginal   DATETIME

  SET @FecOriginal=@FechaVcto
  exec BacParamSuda.dbo.SP_AGREGA_N_DIAS_HABILES @fechavcto OUTPUT,1,';6;',''
  --DROP TABLE #AUX
   IF  @FecOriginal=@FechaVcto 
	BEGIN
		SET @SDH=@FechaVcto
	END ELSE
	BEGIN
		SET @SDH=dateadd(day,-1,@fechavcto)
	END
--SELECT @FecOriginal,@SDH--,@AUX



/******************************/
/******************************/
/******************************/
    --SET @ContDias=0
  -- SET @FecAux=@FechaVcto
   
  -- SET @FecFin=DATEADD(DAY,@Retorno-1,@FecAux)

   --IF @FechaVcto = (CONVERT(CHAR(10), @FechaSistema, 112)) 
  -- BEGIN
   
   

      SELECT Swap               = CASE WHEN Tipo_Swap = 1 THEN 'TASA   '
                                       WHEN Tipo_Swap = 2 THEN 'MONEDA '
                                       WHEN Tipo_Swap = 3 THEN 'FRA    '
                                       WHEN Tipo_Swap = 4 THEN 'PROM   '
                                  END
      ,      Numero_Operacion   = Numero_Operacion
      ,      Nombrecli          = ISNULL(clnombre,'*Conflicto con Nombre*')
      ,      Tipo_operacion     = Tipo_operacion
      ,      NombreOp           = CASE WHEN Tipo_operacion = 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END
      ,      FechaInicio        = CONVERT(CHAR(10), Fecha_inicio, 103)
      ,      NombreMoneda       = CASE WHEN Tipo_operacion = 'C' THEN ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = compra_moneda) ,' ')  
                                       ELSE                           ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = venta_moneda)  ,' ') 
                                  END
      ,      NombreMonedaConv   = CASE WHEN Tipo_operacion = 'C' THEN ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = venta_moneda)  ,' ')  
                                       ELSE                           ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = compra_moneda) ,' ') 
                                  END
      ,      Compra_amortiza    = Compra_amortiza
      ,      Compra_interes     = Compra_interes
      ,      Venta_amortiza     = Venta_amortiza
      ,      Venta_interes      = Venta_interes
      ,      Numero_Flujo       = Numero_Flujo
      ,      Fecha_Inicio_Flujo = Fecha_Inicio_Flujo
      ,      Dias               = DATEDIFF(dd, Fecha_Inicio_Flujo,Fecha_vence_flujo)
      ,      Modalidad          = ISNULL((CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' ')
      ,      Tipo_Swap          = Tipo_Swap
      ,      ValorIcp           = @iFoundIcp
	  ,		 fechaLiquidacion	= fechaLiquidacion
	  
      into #TMP2  
      FROM   CARTERA
             LEFT JOIN BacParamSuda..cliente ON clcodigo = codigo_cliente AND clrut = rut_cliente
      WHERE  fechaLiquidacion BETWEEN @FecOriginal and @SDH
     -- AND    tipo_swap         <> 3
      AND    Estado            <> 'C'
	order by numero_operacion	

      UPDATE #TMP2
      SET    NombreMoneda	 = ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = a.compra_moneda),' ')
      ,      NombreMonedaConv    = ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = a.compra_moneda),' ')
      ,      Compra_amortiza     = a.compra_amortiza
      ,      Compra_interes      = a.compra_interes
      FROM   CARTERA	         a
      ,      #TMP2	         b
      WHERE  a.fechaliquidacion BETWEEN @FecOriginal and @SDH
      AND    a.tipo_flujo        = 1
      AND    a.numero_operacion  = b.numero_operacion
		
      UPDATE #TMP2
      SET    NombreMoneda	 = ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = a.venta_moneda),' ')
      ,      NombreMonedaConv    = ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = a.venta_moneda),' ')
      ,      Venta_amortiza      = a.venta_amortiza
      ,      Venta_interes       = a.venta_interes
      FROM   CARTERA	         a
      ,      #TMP2	         b
      WHERE  a.fechaLiquidacion BETWEEN @FecOriginal and @SDH
      AND    a.tipo_flujo        = 2
      AND    a.numero_operacion  = b.numero_operacion

	-- UNION


     


	
	  /********************************************/
	  /********************************************/
	  /********************************************/
	INSERT INTO #TMP2


		   SELECT Swap               = CASE WHEN Tipo_Swap = 1 THEN 'TASA   '
                                       WHEN Tipo_Swap = 2 THEN 'MONEDA '
                                       WHEN Tipo_Swap = 3 THEN 'FRA    '
                                       WHEN Tipo_Swap = 4 THEN 'PROM   '
                                  END
      ,      Numero_Operacion	= Numero_Operacion
      ,      Nombrecli          = ISNULL(clnombre,'*Conflicto con Nombre*')
      ,      Tipo_operacion 	= Tipo_operacion
      ,      NombreOp		= CASE WHEN Tipo_operacion = 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END
      ,      FechaInicio	= CONVERT(CHAR(10), Fecha_inicio, 103)
      ,      NombreMoneda	= CASE WHEN Tipo_operacion = 'C' THEN ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = compra_moneda),' ')  
				       ELSE                           ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = venta_moneda) ,' ') 
                                  END
      ,      NombreMonedaConv	= CASE WHEN Tipo_operacion = 'C' THEN ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = venta_moneda) ,' ')  
				       ELSE                           ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = compra_moneda),' ')
                                  END
      ,      Compra_amortiza    = Compra_amortiza
      ,      Compra_interes     = Compra_interes
      ,      Venta_amortiza     = Venta_amortiza
      ,      Venta_interes      = Venta_interes
      ,      Numero_Flujo       = Numero_Flujo
      ,      Fecha_Inicio_Flujo = Fecha_Inicio_Flujo
      ,      Dias               = DATEDIFF(dd, Fecha_Inicio_Flujo,Fecha_vence_flujo)
      ,      Modalidad          = ISNULL((CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' ')
      ,      Tipo_Swap          = Tipo_Swap
      ,      ValorIcp           = @iFoundIcp
	  ,		 fechaLiquidacion	= fechaLiquidacion 
	  


	  FROM   CARTERAHIS
             LEFT JOIN BacParamSuda..CLIENTE ON clcodigo = codigo_cliente AND clrut = rut_cliente
      WHERE (fechaliquidacion BETWEEN @FecOriginal and @SDH) --or (fecha_vence_flujo BETWEEN @FecAux and @FecFin)
      --AND    tipo_swap         <> 3      
      AND    Estado            <> 'C'
	 -- order by numero_operacion

      UPDATE #TMP2
      SET    NombreMoneda         = ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = a.compra_moneda),' ')
      ,      NombreMonedaConv	  = ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = a.compra_moneda),' ')
      ,      Compra_amortiza      = a.compra_amortiza
      ,      Compra_interes       = a.compra_interes
      FROM   CARTERAHIS	          a
      ,      #TMP2	          b
      WHERE  a.fechaliquidacion BETWEEN @FecOriginal and @SDH 
      AND    a.tipo_flujo         = 1		  
      AND    a.numero_operacion   = b.numero_operacion
		
      UPDATE #TMP2
      SET   NombreMoneda	  = ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = a.venta_moneda),' ')
      ,      NombreMonedaConv	  = ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = a.venta_moneda),' ')
      ,      Venta_amortiza       = a.venta_amortiza
      ,      Venta_interes        = a.venta_interes
      FROM   CARTERAHIS	          a
      ,      #TMP2	          b
      WHERE  a.fechaLiquidacion  BETWEEN @FecOriginal and @SDH
      AND    a.tipo_flujo         = 2		  
      AND    a.numero_operacion   = b.numero_operacion

	 
	  declare @ProcLiquidacionEjecutado varchar(1)
	  select  @ProcLiquidacionEjecutado = 'N'  
	  select  @ProcLiquidacionEjecutado = 'S' 
	    from bacParamSuda.dbo.TBL_CAJA_DERIVADOS der where der.fechaLiquidacion = @FecOriginal 


	  declare @fecha_Corte datetime -- Fecha de corte de proceso de liquidacion
	  select  @fecha_Corte = ( select max(tbfecha) from BacParamSuda.dbo.TABLA_GENERAL_DETALLE where tbcateg = 31 )


	  update #TMP2
	     set Nombrecli = 'ERROR: No se ha ejecutado proceso Liquidacion' 
		   where @ProcLiquidacionEjecutado = 'N' and fechaliquidacion >= @fecha_Corte 
		
      



	  SELECT * FROM #TMP2 order by  Modalidad, numero_operacion ASC
	   
	   
	   --select @fecaux,@fecfin

  

END

-- select * from cartera where numero_operacion = 10758

GO
