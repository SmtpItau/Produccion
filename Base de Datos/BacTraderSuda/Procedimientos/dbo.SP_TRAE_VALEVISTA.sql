USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_VALEVISTA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_VALEVISTA]
                                    ( @xNumeroOperacion  NUMERIC(6) ,
     @xSistema   CHAR(3)  ,
     @xCorrelaPago   NUMERIC(5) ,
     @xTipoOperacion   CHAR(5)  ,
     @Modo    CHAR(1)  ,
     @xCorrelativo   NUMERIC(5) )
AS
BEGIN
 DECLARE @Banco  NUMERIC(10)
 DECLARE @Plaza  NUMERIC(10)
 DECLARE @Oficina NUMERIC(10)
 SELECT @Banco  = Folio FROM GEN_FOLIOS WHERE Codigo = 'BANCO'
 SELECT @Plaza  = Folio FROM GEN_FOLIOS WHERE Codigo = 'PLAZA'
 SELECT @Oficina = Folio FROM GEN_FOLIOS WHERE Codigo = 'OFICINA'
IF @Modo = 'A'
   SELECT gen_pagos_operacion.Monto_Operacion   ,
  CONVERT(CHAR(10),gen_pagos_operacion.Fecha_Pago,103) ,
  clnombre      ,
  RTRIM(Str(clrut) + '-' + cldv)    ,
  gen_pagos_operacion.Codigo_Rut    ,
  gen_pagos_operacion.Moneda    ,
  @Banco       ,
  @Plaza       ,
  @Oficina      ,
  gen_pagos_operacion.Nombre_Cliente
  FROM GEN_PAGOS_OPERACION, VIEW_CLIENTE, GEN_OPERACIONES
  WHERE  GEN_PAGOS_OPERACION.operacion     = @xNumeroOperacion
  AND     GEN_PAGOS_OPERACION.correlativo    = @xCorrelativo
  AND     GEN_PAGOS_OPERACION.tipo_operacion = @xTipoOperacion
  AND GEN_PAGOS_OPERACION.id_sistema     = @xSistema
  AND GEN_PAGOS_OPERACION.correla_pago   = @xCorrelaPago
  AND GEN_OPERACIONES.rut_cliente     = clrut
  AND GEN_OPERACIONES.operacion          = gen_pagos_operacion.Operacion
  AND GEN_OPERACIONES.tipo_operacion     = gen_pagos_operacion.tipo_operacion
  AND  GEN_PAGOS_OPERACION.estado    = 'A'
IF @Modo = 'M'
   SELECT gen_pagos_operacion.Monto_Operacion   ,
  CONVERT(CHAR(10),gen_pagos_operacion.Fecha_Pago,103) ,
  gen_pagos_operacion.Nombre_Cliente   ,
  RTRIM(Str(gen_pagos_operacion.Rut_Cliente) + '-' + Str(gen_pagos_operacion.Codigo_Rut)),
  gen_pagos_operacion.Codigo_Rut    ,
  gen_pagos_operacion.Moneda    ,
  @Banco       ,
  @Plaza       ,
  @Oficina      ,
  gen_pagos_operacion.Nombre_Cliente
  FROM GEN_PAGOS_OPERACION
  WHERE  GEN_PAGOS_OPERACION.operacion     = @xNumeroOperacion
  AND     GEN_PAGOS_OPERACION.correlativo    = @xCorrelativo
  AND     GEN_PAGOS_OPERACION.tipo_operacion = @xTipoOperacion
  AND GEN_PAGOS_OPERACION.id_sistema     = @xSistema
  AND GEN_PAGOS_OPERACION.correla_pago   = @xCorrelaPago
END

GO
