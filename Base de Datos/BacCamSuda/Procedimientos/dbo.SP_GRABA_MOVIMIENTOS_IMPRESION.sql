USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_MOVIMIENTOS_IMPRESION]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_MOVIMIENTOS_IMPRESION] (  @Numero_Operacion  CHAR(10),
       @Mercado   CHAR(15),
       @Tipo_Operacion   CHAR(10),
       @Estado_Operacion  CHAR(15),
       @Nombre_Cliente   CHAR(45),
       @Monto    FLOAT,
       @Monto_Pesos   FLOAT,
       @Moneda    CHAR(15),
       @Moneda_Conversion  CHAR(15),
       @Tipo_Cambio_Cierre  FLOAT,
       @Tipo_Cambio_Costo  FLOAT,
       @Paridad_Cierre   FLOAT,
       @Paridad_Costo   FLOAT,
       @FP_Pagamos   CHAR(25),
       @FP_Recibimos   CHAR(25),
       @Fecha    CHAR(10),
       @Hora    CHAR(8),
       @Usuario   CHAR(25),
       @Terminal   CHAR(15)
      )
AS
BEGIN
INSERT INTO Movimientos_Impresion (  Numero_Operacion,
     Mercado,
     Tipo_Operacion,
     Estado_Operacion,
     Nombre_Cliente,
     Monto,
     Monto_Pesos,
     Moneda,
     Moneda_Conversion,
     Tipo_Cambio_Cierre,
     Tipo_Cambio_Costo,
     Paridad_Cierre,
     Paridad_Costo,
     FP_Pagamos,
     FP_Recibimos,
     Fecha,
     Hora,
     Usuario,
     Terminal ) VALUES ( @Numero_Operacion,
        @Mercado,
        @Tipo_Operacion,
        @Estado_Operacion,
        @Nombre_Cliente,
        @Monto,
        @Monto_Pesos,
        @Moneda,
        @Moneda_Conversion,
        @Tipo_Cambio_Cierre,
        @Tipo_Cambio_Costo,
        @Paridad_Cierre,
        @Paridad_Costo,
        @FP_Pagamos,
        @FP_Recibimos,
        SUBSTRING(@Fecha,7,2)+'/'+SUBSTRING(@Fecha,5,2)+'/'+SUBSTRING(@Fecha,1,4),
        SUBSTRING(@Hora,1,2)+':'+SUBSTRING(@Hora,3,2)+':'+SUBSTRING(@Hora,5,2),
        @Usuario,
        @Terminal )
END

GO
