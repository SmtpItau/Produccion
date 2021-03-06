USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAGARES]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PAGARES]
                           (@Desde Numeric (8),
                            @Hasta Numeric (8))
AS
BEGIN
SET NOCOUNT ON
DECLARE @RazonSocial     CHAR(50)  ,
        @RutRazonSocial  NUMERIC(9)  ,
        @DvRazonSocial   CHAR(01)  ,
        @DireccionRazon  CHAR(50)  ,
        @Ciudad          CHAR(15)  ,
        @X               INTEGER   ,
        @Y               INTEGER   ,
 @FechaOperacion  DATETIME  ,
 @FechaVencimiento DATETIME  ,
        @TipoOperacion          CHAR(03)  ,
        @RutCliente  NUMERIC(10)  ,
        @CodigoRut  NUMERIC(05)  ,
        @Base   CHAR(05)  ,
        @Entidad  NUMERIC(10)  ,
        @Retiro   CHAR(03)  ,
        @Moneda   CHAR(05)  ,
        @Tasa   NUMERIC(8,4)  ,
        @Plazo   NUMERIC(05)  ,
        @DescripcionMoneda CHAR(20)  ,
        @NombreCliente  CHAR(50)  ,
        @DvCliente  CHAR(01)  ,
        @NumeroOperacion        NUMERIC(08)
IF EXISTS(SELECT name FROM sysobjects WHERE name = 'Temp_Captacion' AND type = 'U')
BEGIN
 DROP TABLE TEMP_CAPTACION
END
CREATE TABLE TEMP_CAPTACION  (  fecha_operacion   datetime null,  --1
            fecha_vencimiento datetime null,  --2
     numero_operacion Numeric(10,0) null,       --3
    tipo_operacion  char(3)  null,  --4
           rut_cliente  numeric(10,0) null,  --5
           codigo_rut  numeric(05,0) null,  --6
                  base               char(05) null,  --7
                  entidad   numeric(10)  null,  --8
            retiro   char(03) null,  --9
            monto_inicio  float   null,  --10
            monto_inicio_pesos float  null,  --11
            moneda   char(05) null,   --12
            tasa   numeric(08,04) null,  --13
            plazo   numeric(05,00) null,  --14
            monto_final  float  null,  --15
            razon_social  char(50) null,  --16
            rut_razon_social numeric(10,00) null,  --17
            dv_razon_social  char(01) null,  --18
     direccion_razon  char(50) null,  --19
                  ciudad   char(15) null,  --20
            descripcion_moneda char(20) null,  --21
            nombre_cliente  char(50) null,  --22
            dv_cliente  char(01) null)   --23
  SELECT @RazonSocial    = acnomprop  ,
         @RutRazonSocial = acrutprop  ,
         @DvRazonSocial  = acdigprop  ,
         @DireccionRazon = acdirprop
         FROM MDAC
      INSERT INTO TEMP_CAPTACION(Numero_Operacion,Monto_Inicio,Monto_Inicio_Pesos,Monto_Final) 
                  Select Numero_Operacion,
    sum(monto_inicio),
    sum(monto_inicio_pesos),
    sum(monto_final) from GEN_CAPTACION group by numero_operacion order by numero_operacion  
     SELECT @Y = count(*) FROM TEMP_CAPTACION 
     SELECT @X = 0
   WHILE @X < @Y
        BEGIN
           SET ROWCOUNT @X
           
             Select @NumeroOperacion = Numero_Operacion FROM TEMP_CAPTACION order by Numero_Operacion
           
           SET ROWCOUNT 0        
           SET ROWCOUNT 1
           SELECT @FechaOperacion     = Fecha_Operacion       ,
    @FechaVencimiento   = Fecha_Vencimiento     ,
                  @TipoOperacion      = tipo_operacion        ,
                  @RutCliente         = Rut_Cliente       ,  
                  @CodigoRut          = Codigo_Rut       ,  
                  @Base               = CONVERT(CHAR(05),mnbase)  ,
                  @Entidad            = Entidad     ,  
                  @Retiro             = Retiro           ,  
                  @Moneda             = mnnemo        ,    
                  @Tasa        = Tasa        ,  
            @Plazo       = Plazo             ,  
                  @DescripcionMoneda  = mnglosa        ,  
                  @NombreCliente      = clnombre              ,  
                  @DvCliente       = cldv          
           FROM GEN_CAPTACION, VIEW_CLIENTE, VIEW_MONEDA WHERE Numero_Operacion = @NumeroOperacion  AND
                                              Moneda           = mncodmon           AND
                                              Rut_Cliente      = clrut 
            
           SET ROWCOUNT 0
            
           UPDATE TEMP_CAPTACION SET   fecha_operacion   = @FechaOperacion  ,
                                       fecha_vencimiento  = @FechaVencimiento  ,
             tipo_operacion   = @TipoOperacion  , 
             rut_cliente   = @RutCliente   ,
             codigo_rut   = @CodigoRut   ,
             base    = @Base    ,
             entidad    = @Entidad   ,
             retiro    = @Retiro   ,
             moneda    = @Moneda   ,
             tasa    = @Tasa    ,
             plazo    = @Plazo   ,
             razon_social   = @RazonSocial   ,
             rut_razon_social  = @RutRazonSocial  ,
             dv_razon_social   = @DvRazonSocial  ,
      direccion_razon   = @DireccionRazon  ,
             ciudad    = 'Santiago'   ,
             descripcion_moneda  = @DescripcionMoneda  ,
             nombre_cliente   = @NombreCliente  ,
             dv_cliente   = @DvCliente
                  WHERE numero_operacion = @NumeroOperacion
           
          SELECT @X = @X + 1
        END
SELECT   Convert(CHAR(10),Fecha_Operacion,103) ,  --1
         Convert(CHAR(10),Fecha_Vencimiento,103),  --2
         tipo_operacion    ,  --3
         numero_operacion   ,  --4
         rut_cliente    ,  --5
         codigo_rut    ,  --6
         base     ,  --7
         entidad    ,  --8
         retiro     ,  --9
         monto_inicio     ,  --10
         monto_inicio_pesos   ,  --11
         moneda     ,   --12
         tasa     ,  --13
         plazo     ,  --14
         monto_final    ,  --15
         razon_social    ,  --16
         rut_razon_social   ,  --17
         dv_razon_social   ,  --18
  direccion_razon   ,  --19
         ciudad     ,  --20
         descripcion_moneda   ,  --21
         nombre_cliente    ,  --22
         dv_cliente      --23
         FROM TEMP_CAPTACION WHERE numero_operacion >= @Desde AND 
                                   Numero_Operacion <= @Hasta ORDER BY Numero_Operacion
SET NOCOUNT OFF
END

GO
