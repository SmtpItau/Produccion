USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CODIGOS_GESTION]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ACT_CODIGOS_GESTION](
                                    @iCodigo_Sistema    Char(3),
                                    @iCodigo_Familia    Numeric(4),
                                    @iCodigo_Gestion    Numeric(5),
                                    @iCodigo_AtcPas     Char(7),
                                    @iCodigo_Cartera    Char(25),
                                    @iSub_Producto      Char(60),
                                    @iForma_Pago_Ini    Numeric(3),
                                    @iForma_Pago_Fin    Numeric(3),
                                    @iCodigo_Moneda     Numeric(5),
                                    @iRut_Emisor        Numeric(9),
                                    @iTipo_Tasa         Numeric(3),
                                    @iTipo_Operacion    Char(3)
                                   )
AS
BEGIN
  

	SET DATEFORMAT DMY
	SET NOCOUNT ON

  
    IF NOT EXISTS(  SELECT 1 FROM  GESTION_TESORERIA 
                WHERE    @iCodigo_Sistema    = id_sistema     AND
                         @iCodigo_Familia    = codigo_familia AND
                         @iCodigo_Gestion    = correlativo    AND
                         @iCodigo_AtcPas     = activo_pasivo  AND
                         @iCodigo_Cartera    = tipo_cartera   AND
                         @iForma_Pago_Ini    = forma_pago_ini AND
                         @iForma_Pago_Fin    = foma_pago_fin  AND
                         @iCodigo_Moneda     = codigo_moneda  AND
                         @iRut_Emisor        = rut_emisor     AND
                         @iTipo_Tasa         = tipo_tasa      AND
                         @iTipo_Operacion    = tipo_operacion  
            ) BEGIN

        INSERT GESTION_TESORERIA 
        VALUES(  
               @iCodigo_Sistema    ,
               @iCodigo_Familia    ,
               @iCodigo_Gestion    ,
               @iCodigo_AtcPas     ,
               @iCodigo_Cartera    ,
               @iSub_Producto      ,
               @iForma_Pago_Ini    ,
               @iForma_Pago_Fin    ,
               @iCodigo_Moneda     ,
               @iRut_Emisor        ,
               @iTipo_Tasa         ,
               @iTipo_Operacion    
              )

    END 
    ELSE     
    BEGIN

        UPDATE GESTION_TESORERIA 
        SET      id_sistema     =   @iCodigo_Sistema ,
                 codigo_familia =   @iCodigo_Familia ,
                 correlativo    =   @iCodigo_Gestion ,
                 activo_pasivo  =   @iCodigo_AtcPas  ,
                 tipo_cartera   =   @iCodigo_Cartera ,                 
                 sub_grupo      =   @iSub_Producto   ,
                 forma_pago_ini =   @iForma_Pago_Ini ,
                 foma_pago_fin  =   @iForma_Pago_Fin ,
                 codigo_moneda  =   @iCodigo_Moneda  ,
                 rut_emisor     =   @iRut_Emisor     ,
                 tipo_tasa      =   @iTipo_Tasa      ,
                 tipo_operacion =   @iTipo_Operacion
 
        WHERE    @iCodigo_Sistema    = id_sistema     AND
                 @iCodigo_Familia    = codigo_familia AND
                 @iCodigo_Gestion    = correlativo    AND
                 @iCodigo_AtcPas     = activo_pasivo  AND
                 @iCodigo_Cartera    = tipo_cartera   AND
                 @iForma_Pago_Ini    = forma_pago_ini AND
                 @iForma_Pago_Fin    = foma_pago_fin  AND
                 @iCodigo_Moneda     = codigo_moneda  AND
                 @iRut_Emisor        = rut_emisor     AND
                 @iTipo_Tasa         = tipo_tasa      AND
                 @iTipo_Operacion    = tipo_operacion   
        
    END
    
END





GO
