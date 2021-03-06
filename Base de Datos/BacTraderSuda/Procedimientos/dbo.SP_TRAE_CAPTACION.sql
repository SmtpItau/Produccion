USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_CAPTACION]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_CAPTACION]
                  (
   @nNumeroOperacion NUMERIC(10)
    )
AS
BEGIN
set nocount on
 DECLARE @Fecha_Proceso  DATETIME
 SELECT @Fecha_Proceso = acfecproc FROM MDAC
 IF NOT EXISTS(SELECT * FROM GEN_CAPTACION WHERE numero_operacion = @nNumeroOperacion) BEGIN
  SELECT 'N','OPERACION NO EXISTE'
                SET NOCOUNT OFF
  RETURN
 END
 IF (SELECT MAX(fecha_operacion) FROM GEN_CAPTACION WHERE numero_operacion = @nNumeroOperacion) = @Fecha_Proceso BEGIN
  SELECT 'N','LA OPERACION FUE HECHA HOY, DEBE ANULAR'
                SET NOCOUNT OFF
  RETURN
 END
 
/* IF EXISTS(SELECT * FROM gen_captacion WHERE Numero_Operacion = @nNumeroOperacion AND Estado = 'V') BEGIN
  SELECT 'N','Operacion esta vencida'
  RETURN
 END*/
 IF EXISTS(SELECT * FROM GEN_CAPTACION WHERE numero_operacion = @nNumeroOperacion AND Estado = 'R') BEGIN
  SELECT 'N','OPERACION ESTA RENOVADA'
                SET NOCOUNT OFF
  RETURN
 END
 IF EXISTS(SELECT * FROM GEN_CAPTACION WHERE numero_operacion = @nNumeroOperacion AND Estado = 'A') BEGIN
  SELECT 'N','OPERACION ESTA ANULADA'
                SET NOCOUNT OFF
  RETURN
 END
 SELECT 
        'S'              ,--1
  Rut_Cliente             ,--2
  Codigo_Rut             ,--3
  clnombre             ,--4
        'Valor_Actual'   = (SELECT SUM(Valor_Presente) FROM GEN_CAPTACION WHERE numero_operacion = @nNumeroOperacion) ,--5
        'Valor_Anticipo' = (SELECT SUM(Valor_Presente) FROM GEN_CAPTACION WHERE numero_operacion = @nNumeroOperacion) ,--6
  tasa              ,--7
  correla_corte             ,--8
  monto_inicio             ,--9
  monto_inicio_pesos            ,--10
  monto_final             ,--11
  rut_cliente             ,--12
  codigo_rut             ,--13
  entidad              ,--14
  forma_pago             ,--15
  retiro              ,--16
  moneda              ,--17
        'Fecha_Vencimiento' = CONVERT(CHAR(10),Fecha_Vencimiento , 103 )       ,--18
        'Fecha_inicio'      = CONVERT(CHAR(10),Fecha_operacion   , 103 )       ,--19
        'CapitalUM' = (SELECT SUM(monto_inicio)     FROM GEN_CAPTACION WHERE Numero_Operacion = @nNumeroOperacion) ,--20
        'CapitalCLP'= (SELECT SUM(monto_inicio_pesos)     FROM GEN_CAPTACION WHERE Numero_Operacion = @nNumeroOperacion) ,--21
        'Intereses' = (SELECT SUM(interes_acumulado)  FROM GEN_CAPTACION WHERE Numero_Operacion = @nNumeroOperacion) ,--22
        'Reajustes' = (SELECT SUM(reajuste_acumulado) FROM GEN_CAPTACION WHERE Numero_Operacion = @nNumeroOperacion) ,--23
        'ValorFinalUM' = (SELECT SUM(monto_final)     FROM GEN_CAPTACION WHERE Numero_Operacion = @nNumeroOperacion) ,--24
        'Base'      = MNBASE              ,--25
        'codmoneda ' = mnnemo            ,--26
  valor_presente             ,--27
  correla_operacion             ,--28 
  valormoneda  =  CASE  WHEN moneda =999 or moneda = 13 THEN 1 ELSE  (SELECT isnull(vmvalor,1) FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA WHERE vmfecha  = @fecha_proceso AND vmcodigo = moneda) END ,
  valor_presente ,
  'valor_pres_UM' = (gen_captacion.valor_presente /  CASE  WHEN moneda =999 or moneda = 13 THEN 1 ELSE  (SELECT isnull(vmvalor,1) FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA WHERE vmfecha  = @fecha_proceso AND vmcodigo = moneda) END)
 FROM
  GEN_CAPTACION ,
  VIEW_CLIENTE  ,
  VIEW_MONEDA
 WHERE  
  rut_cliente  = clrut   
 AND numero_operacion = @nNumeroOperacion 
 AND  mncodmon  = moneda   
 AND  estado <> 'V'
set nocount off
END

GO
