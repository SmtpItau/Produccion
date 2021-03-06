USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJOS_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FLUJOS_SWAP]  
      (
       @modalidad        CHAR(01)
      )
AS
BEGIN

    SET NOCOUNT ON

    DECLARE @MODA     CHAR(01)
    DECLARE @FECHA    DATETIME
    DECLARE @FECHA2   DATETIME

    SET @MODA = CASE WHEN @modalidad in ( 'C', 'A' ) THEN 'C'
                     WHEN @modalidad in ( 'E', 'B' ) THEN 'E'
                                                     ELSE '*'
                END

    SELECT @FECHA  = fechaant,
           @FECHA2 = fechaproc
      FROM dbo.SwapGeneral
                     
    SELECT C.fecha_vence_flujo
         , 'Fixing'            = CASE WHEN @modalidad = 'B' THEN C.fecha_vence_flujo
                                                            ELSE DATEADD( DAY, CASE WHEN P.cltipcli = 2 AND P.clrut = 413045828 THEN -2 ELSE -1 END, C.fecha_vence_flujo )
                                 END
         , 'NewFixing'         = GETDATE()
         , 'Delta'             = 0
         , 'TipoCliente'       = case P.cltipcli when 1 then 1 when 2 then 2 else 0 end, P.clrut
         , 'Nocional'          = case when C.tipo_flujo = 1 then C.compra_amortiza    else -C.venta_amortiza     end * case when IntercPrinc = 1 then 1.0 else 0.0 end
         , 'Interes'           = case when C.tipo_flujo = 1 then C.compra_interes     else -C.venta_interes      end
      INTO #tmpCartera
      FROM dbo.Cartera C WITH(NOLOCK)
           LEFT JOIN BacParamSuda.dbo.Cliente P on C.rut_cliente = P.clrut AND C.codigo_cliente = P.clcodigo
     WHERE Estado              <> 'C'
       AND (case when C.tipo_flujo = 1 then C.compra_moneda      else C.venta_moneda       end)  = 13
       AND @MODA                  in ( '*', modalidad_pago )
     ORDER BY C.fecha_vence_flujo

    IF (@modalidad in ( 'A' ))
    BEGIN
        UPDATE #tmpCartera
           SET NewFixing = DATEADD( DAY, 1, Fixing )

        UPDATE #tmpCartera
           SET NewFixing = DATEADD( DAY, CASE DATEPART( weekday, NewFixing ) WHEN 1 THEN 1 WHEN 7 THEN 2 ELSE 0 END, NewFixing )
             , Delta     = CASE DATEPART( weekday, Fixing ) WHEN 1 THEN 1 WHEN 7 THEN 2 ELSE 0 END

    END ELSE IF (@modalidad in ( 'B' ))
    BEGIN
        UPDATE #tmpCartera
           SET NewFixing = DATEADD( DAY, CASE DATEPART( weekday, NewFixing ) WHEN 1 THEN 1 WHEN 7 THEN 2 ELSE 0 END, Fixing )
             , Delta     = CASE DATEPART( weekday, Fixing ) WHEN 1 THEN 1 WHEN 7 THEN 2 ELSE 0 END

    END ELSE
    BEGIN
        UPDATE #tmpCartera
           SET NewFixing = DATEADD( DAY, CASE DATEPART( weekday, Fixing ) WHEN 1 THEN -2 WHEN 7 THEN -1 ELSE 0 END, Fixing )
             , Delta     = CASE DATEPART( weekday, Fixing ) WHEN 1 THEN -2 WHEN 7 THEN -1 ELSE 0 END

    END

    SELECT 'Fixing'             = NewFixing
         , 'Nacionales'         = SUM(CASE TipoCliente WHEN 1 THEN Nocional ELSE 0 END)
         , 'Extranjeros'        = SUM(CASE TipoCliente WHEN 2 THEN Nocional ELSE 0 END)
         , 'Clientes'           = SUM(CASE TipoCliente WHEN 0 THEN Nocional ELSE 0 END)
         , 'Total'              = SUM(Nocional)
         , 'InteresNacionales'  = SUM(CASE TipoCliente WHEN 1 THEN Interes ELSE 0 END)
         , 'InteresExtranjeros' = SUM(CASE TipoCliente WHEN 2 THEN Interes ELSE 0 END)
         , 'InteresClientes'    = SUM(CASE TipoCliente WHEN 0 THEN Interes ELSE 0 END)
         , 'InteresTotal'       = SUM(Interes)
      FROM #tmpCartera
     where NewFixing > @FECHA
     GROUP BY NewFixing
     ORDER BY NewFixing

    DROP TABLE #tmpCartera

    SET NOCOUNT OFF

END
GO
