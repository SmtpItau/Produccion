USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAPARAMETROS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGAPARAMETROS](@Entidad CHAR(2)) 
AS
BEGIN
set nocount on
   DECLARE @Fecha_Hoy  DATETIME,
           @Valor_UF   FLOAT   ,
           @Valor_DO   FLOAT   ,
           @Valor_AC   FLOAT   ,
           @PosIniUSD  FLOAT   ,
           @Banco      CHAR(40)
    SELECT @Fecha_Hoy = acfecpro             FROM meac
    SELECT @Valor_UF  = 0.0
    SELECT @Valor_DO  = 0.0
    SELECT @Valor_AC  = 0.0
    SELECT @Banco     = ' '
    SELECT @PosIniUSD = 0.0
    SELECT @Valor_UF  = ISNULL(vmvalor ,0.0) FROM view_valor_moneda  WHERE vmcodigo = 998   AND vmfecha = @Fecha_Hoy
    SELECT @Valor_DO  = ISNULL(vmvalor ,0.0) FROM view_valor_moneda  WHERE vmcodigo = 994   AND vmfecha = @Fecha_Hoy
    SELECT @Valor_AC  = ISNULL(vmvalor ,0.0) FROM view_valor_moneda  WHERE vmcodigo = 995   AND vmfecha = @Fecha_Hoy
    SELECT @Banco     = ISNULL(acnombre,'')  FROM MEAC
    SELECT @PosIniUSD = ISNULL(vmposini,0.0) FROM view_posicion_spt  WHERE vmcodigo = 'USD' AND vmfecha = @Fecha_Hoy
    SELECT 'acFecPro'  = CONVERT(CHAR(10),acfecpro,103),   -- Fecha de Proceso
           'Observado' = @Valor_DO,                        -- Observado
           'Valor_UF'  = @Valor_UF,                        -- Valor UF
    
           'acFecPrx'  = CONVERT(CHAR(10),acfecprx,103),   -- Fecha Proximo Proceso
           'acNombre'  = @Banco,                           -- 5. Nombre
           'Acuerdo'   = @Valor_AC,                        -- 6. Dolar Acuerdo
           AcTCamar,                         -- 7. Tasa Camara
           AcTOvern,                         -- 8. Tasa Overnight
           AcDCamar,                         -- 9. Dias Camara
           AcDOvern,                         --10. Dias Overnight
           acLogDig,                         --11. Logger MEAC      <- Control
           acFinDia,                         --12. Fin de Dia       <- Control
           acMtoPtas,                        --13. Valores por Default
           AcFPrPtaC,                        --14. Recibe Compra Punta
           AcFPePtaC,                        --15. Entrega
           AcFPrPtaV,                        --16. Recibe Venta  Punta
           AcFPePtaV,                        --17. Entrega
           AcFPrEmpC,                        --18. Recibe Compra Empresa
           AcFPeEmpC,                        --19. Entrega
           AcFPrEmpV,                        --20. Recibe Venta  Empresa
           AcFPeEmpV,                        --21. Entrega
           acCband,                          --22. Banda de Compra
           acVband,                          --23. Banda de Venta
           acomac,                           --24.
           acrentab,                         --25.
           acmoneda,                         --26.
           acomav,                           --27.
           acomacpta,                        --28.
           acomavpta,                        --29.
           acrentabp,                        --30.
           @PosIniUSD,                       --31. Posicion USD inicial
           acrut,                            --32. Rut    Entidad
           acdv,                             --33. DV     Entidad
           accodigo,                         --34. Codigo Entidad (BCCH)
           achedgeinicialspot,               --35,  
           achedgeinicialfuturo,             --36,
           achedgeprecioinicial,             --37,
           6,                                --38, Pais Feriado Local
           1,                                --39, Pais Feriado Extranjero
           0,         --40, Ley de timbre y estampillas, agregar a mdmn.codigo = 888 y mdmn.periodo = Mensual
           'acFecAnt'  = CONVERT(CHAR(10),acfecant,103)   --41. Fecha Anterior de Proceso
      FROM meac
     WHERE acentida = @Entidad
--           acrentaa
set nocount off
END
-- sp_CargaParametros 'ME'
GO
