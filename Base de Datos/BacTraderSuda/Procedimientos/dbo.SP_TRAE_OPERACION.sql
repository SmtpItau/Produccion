USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_OPERACION]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_OPERACION]
                                 ( @xNumeroOperacion  NUMERIC(10) ,
     @xSistema   CHAR(3)  ,
     @xtipo_operacion  CHAR(5)  ,
     @xCorrelativo   NUMERIC(5) )
AS
BEGIN
DECLARE @Genera_Docto  CHAR(1)
SELECT @Genera_Docto = 'N'
SELECT @Genera_Docto = ISNULL(Genera_Docto,'N') 
  FROM  view_Movimiento_cnt
 WHERE  tipo_operacion = @xtipo_operacion
   AND  id_sistema     = @xSistema
SELECT  ''    ,--1
 tipo_operacion   ,--2
 operacion   ,--3    
 rut_cliente   ,--4
 codigo_rut   ,--5
 monto_operacion   ,--6
 moneda    ,--7
 forma_pago   ,--8
 0    ,--9
 ''    ,--10
 ''    ,--11
 fecha_pago   ,--12
 ''    ,--13
 ''         ,--14
        @Genera_Docto                    --15
 FROM GEN_PAGOS_OPERACION 
    WHERE  Operacion = @xNumeroOperacion  AND
     Correlativo = @xCorrelativo  AND 
     id_sistema = @xSistema  AND 
     tipo_operacion = @xtipo_operacion
END

GO
