USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAPARAMETROS_TURING]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGAPARAMETROS_TURING]( @Entidad CHAR(2) = 'ME' )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @Fecha_Hoy  CHAR(8) ,
           @Valor_UF   FLOAT   ,
           @Valor_DO   FLOAT   ,
           @Valor_AC   FLOAT   ,
           @PosIniUSD  FLOAT   ,
           @Banco      CHAR(40),
           @CodBCCH    INTEGER ,
           @CodSBIF    INTEGER
    SELECT @Fecha_Hoy = CONVERT(CHAR(8),acfecpro,112) FROM meac
    SELECT @Valor_UF  = 0.0
    SELECT @Valor_DO  = 0.0
    SELECT @Valor_AC  = 0.0
    SELECT @Banco     = ' '
    SELECT @PosIniUSD = 0.0
    SELECT @CodBCCH   = 0
    SELECT @CodSBIF   = 0
    SELECT @Valor_UF  = ISNULL(vmvalor ,0.0) FROM view_valor_moneda  WHERE vmcodigo = 998   AND CONVERT(CHAR(8),vmfecha,112) = @Fecha_Hoy
    SELECT @Valor_DO  = ISNULL(vmvalor ,0.0) FROM view_valor_moneda  WHERE vmcodigo = 994   AND CONVERT(CHAR(8),vmfecha,112) = @Fecha_Hoy
    SELECT @Valor_AC  = ISNULL(vmvalor ,0.0) FROM view_valor_moneda  WHERE vmcodigo = 995   AND CONVERT(CHAR(8),vmfecha,112) = @Fecha_Hoy
    SELECT @Banco     = ISNULL(acnombre, '') FROM MEAC
    SELECT @PosIniUSD = ISNULL(vmposini,0.0) FROM view_posicion_spt  WHERE vmcodigo = 'USD' AND CONVERT(CHAR(8),vmfecha,112) = @Fecha_Hoy
    SELECT @CodBCCH   = ISNULL(clcodban,  0) FROM view_cliente, meac WHERE clrut = acrut AND clcodigo = accodigo
    SELECT @CodSBIF   = ISNULL(cod_inst,  0) FROM view_cliente, meac WHERE clrut = acrut AND clcodigo = accodigo
    SELECT 'acFecPro'  = CONVERT(CHAR(10),acfecpro,103),   -- 1. Fecha de Proceso
           'Observado' = @Valor_DO,                        -- 2. Observado
           'Valor_UF'  = @Valor_UF,                        -- 3. Valor UF
           'acFecAnt'  = CONVERT(CHAR(10),acfecant,103),   -- 4. Fecha Anterior de Proceso    
           'acFecPrx'  = CONVERT(CHAR(10),acfecprx,103),   -- 5. Fecha Proximo Proceso
           'acNombre'  = @Banco,                           -- 6. Nombre
           'Acuerdo'   = @Valor_AC,                        -- 7. Dolar Acuerdo
           AcTCamar,                         -- 8. Tasa Camara
           AcTOvern,                         -- 9. Tasa Overnight
           AcDCamar,                         --10. Dias Camara
           AcDOvern,                         --11. Dias Overnight
           acLogDig,                         --12. Logger MEAC      <- Control
           acFinDia,                         --13. Fin de Dia       <- Control
           acMtoPtas,                        --14. Valores por Default
           AcFPrPtaC,                        --15. Recibe Compra Punta
           AcFPePtaC,                        --16. Entrega
           AcFPrPtaV,                        --17. Recibe Venta  Punta
           AcFPePtaV,                        --18. Entrega
           AcFPrEmpC,                        --19. Recibe Compra Empresa
           AcFPeEmpC,                        --20. Entrega
           AcFPrEmpV,                        --21. Recibe Venta  Empresa
           AcFPeEmpV,                        --22. Entrega
           acCband,                          --23. Banda de Compra
           acVband,                          --24. Banda de Venta
           acomac,                           --25.
           acrentab,                         --26.
           acmoneda,                         --27.
           acomav,                           --28.
           acomacpta,                        --29.
           acomavpta,                        --30.
           acrentabp,                        --31.
           'acposiniUSD' = @PosIniUSD,       --32. Posicion USD inicial
           acrut,                            --33. Rut    Entidad
           acdv,                             --34. DV     Entidad
           accodigo,                         --35. Codigo Entidad BAC
           info_utili,                       --achedgeinicialspot,               --36,  
           achedgeinicialfuturo,             --37,
   	       achedgeprecioinicial,             --38,
           'paisferiadolocal'=6,                                --39, Pais Feriado Local
           'paisferiadoextranjero' =1,                                --40, Pais Feriado Extranjero
           'timbreestampilla'=0,          --41, Ley de timbre y estampillas, agregar a mdmn.codigo = 888 y mdmn.periodo = Mensual
           'accodigoBCCH' = @CodBCCH,        --42. Codigo Entidad BCCH
           'accodigoSBIF' = @CodSBIF,        --43. Codigo Entidad SBIF
           acprecie   ,                      --44.  
           acpmeco    ,                      --45. Precio Promedio Compras
           acpmeve                           --46. Precio Promedio Ventas 
     FROM meac
     WHERE acentida = @Entidad
END

GO
