USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROCESO_SETTLEMENT]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PROCESO_SETTLEMENT]
AS
BEGIN
 DECLARE @Dia            INTEGER    ,
         @Sistema        CHAR(3)    ,
         @tipo_operacion CHAR(4)    ,
         @Operacion      NUMERIC(10),
         @Correlativo    NUMERIC(5) ,
         @Fecha_Hoy      DATETIME   ,
         @Fecha_Pago     DATETIME   ,
         @Regs           INTEGER    ,
         @Cont           INTEGER
 SELECT @Fecha_Hoy = ACFECPROC FROM MDAC
 SELECT @Regs = COUNT(*) FROM MD_PLAZO_SETTLEMENT WHERE dia > 0
 SELECT @Cont = 1
 
 WHILE @Cont <= @Regs
 BEGIN
  SET ROWCOUNT @Cont
  SELECT  
   @Dia            = dia,
   @Sistema        = sistema,
   @tipo_operacion = tipo_operacion,
   @Operacion      = operacion,
   @Correlativo    = correlativo
  FROM 
   MD_PLAZO_SETTLEMENT
  WHERE 
   Dia > 0
  SET ROWCOUNT 0
  EXECUTE SP_BUSCA_FECHA_HABIL @Fecha_Hoy, -1, @Fecha_Pago OUTPUT
  SELECT @Dia = (CASE WHEN DATEDIFF(day,@Fecha_Hoy,@Fecha_Pago) < 0 THEN 0 ELSE DATEDIFF(day, @Fecha_Hoy, @Fecha_Pago) END)
  UPDATE MD_PLAZO_SETTLEMENT
        SET Dia            = @Dia
      WHERE sistema        = @Sistema
        AND tipo_operacion = @tipo_operacion
        AND operacion      = @Operacion
        AND correlativo    = @Correlativo
  SELECT @Cont = @Cont + 1
 END
 RETURN 0 
END   /* FIN PROCEDIMIENTO */
-- SELECT * FROM MD_PLAZO_SETTLEMENT

GO
