USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAPARAMETROS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGAPARAMETROS](@ENTIDAD CHAR(2)) 
AS
BEGIN
SET NOCOUNT ON
   DECLARE @FECHA_HOY  DATETIME,
           @VALOR_UF   FLOAT   ,
           @VALOR_DO   FLOAT   ,
           @VALOR_AC   FLOAT   ,
           @POSINIUSD  FLOAT   ,
           @BANCO      CHAR(40)
    SELECT @FECHA_HOY = ACFECPRO             FROM MEAC
    SELECT @VALOR_UF  = 0.0
    SELECT @VALOR_DO  = 0.0
    SELECT @VALOR_AC  = 0.0
    SELECT @BANCO     = ' '
    SELECT @POSINIUSD = 0.0
    SELECT @VALOR_UF  = ISNULL(VMVALOR ,0.0) FROM VIEW_VALOR_MONEDA  WHERE VMCODIGO = 998   AND VMFECHA = @FECHA_HOY
    SELECT @VALOR_DO  = ISNULL(VMVALOR ,0.0) FROM VIEW_VALOR_MONEDA  WHERE VMCODIGO = 994   AND VMFECHA = @FECHA_HOY
    SELECT @VALOR_AC  = ISNULL(VMVALOR ,0.0) FROM VIEW_VALOR_MONEDA  WHERE VMCODIGO = 995   AND VMFECHA = @FECHA_HOY
    SELECT @BANCO     = ISNULL(ACNOMBRE,'')  FROM MEAC
    SELECT @POSINIUSD = ISNULL(VMPOSINI,0.0) FROM VIEW_POSICION_SPT  WHERE VMCODIGO = 'USD' AND VMFECHA = @FECHA_HOY
    SELECT 'ACFECPRO'  = CONVERT(CHAR(10),ACFECPRO,103),   -- FECHA DE PROCESO
           'OBSERVADO' = @VALOR_DO,                        -- OBSERVADO
           'VALOR_UF'  = @VALOR_UF,                        -- VALOR UF
    
           'ACFECPRX'  = CONVERT(CHAR(10),ACFECPRX,103),   -- FECHA PROXIMO PROCESO
           'ACNOMBRE'  = @BANCO,                           -- 5. NOMBRE
           'ACUERDO'   = @VALOR_AC,                        -- 6. DOLAR ACUERDO
           ACTCAMAR,                         -- 7. TASA CAMARA
           ACTOVERN,                         -- 8. TASA OVERNIGHT
           ACDCAMAR,                         -- 9. DIAS CAMARA
           ACDOVERN,                         --10. DIAS OVERNIGHT
           ACLOGDIG,                         --11. LOGGER MEAC      <- CONTROL
           ACFINDIA,                         --12. FIN DE DIA       <- CONTROL
           ACMTOPTAS,                        --13. VALORES POR DEFAULT
           ACFPRPTAC,                        --14. RECIBE COMPRA PUNTA
           ACFPEPTAC,                        --15. ENTREGA
           ACFPRPTAV,                        --16. RECIBE VENTA  PUNTA
           ACFPEPTAV,                        --17. ENTREGA
           ACFPREMPC,                        --18. RECIBE COMPRA EMPRESA
           ACFPEEMPC,                        --19. ENTREGA
           ACFPREMPV,                        --20. RECIBE VENTA  EMPRESA
           ACFPEEMPV,                        --21. ENTREGA
           ACCBAND,                          --22. BANDA DE COMPRA
           ACVBAND,                          --23. BANDA DE VENTA
           ACOMAC,                           --24.
           ACRENTAB,                         --25.
           ACMONEDA,                         --26.
           ACOMAV,                           --27.
           ACOMACPTA,                        --28.
           ACOMAVPTA,                        --29.
           ACRENTABP,                        --30.
           @POSINIUSD,                       --31. POSICION USD INICIAL
           ACRUT,                            --32. RUT    ENTIDAD
           ACDV,                             --33. DV     ENTIDAD
           ACCODIGO,                         --34. CODIGO ENTIDAD (BCCH)
           ACHEDGEINICIALSPOT,               --35,  
           ACHEDGEINICIALFUTURO,             --36,
           ACHEDGEPRECIOINICIAL,             --37,
           6,                                --38, PAIS FERIADO LOCAL
           1,                                --39, PAIS FERIADO EXTRANJERO
           0,         --40, LEY DE TIMBRE Y ESTAMPILLAS, AGREGAR A MDMN.CODIGO = 888 Y MDMN.PERIODO = MENSUAL
           'ACFECANT'  = CONVERT(CHAR(10),ACFECANT,103)   --41. FECHA ANTERIOR DE PROCESO
      FROM MEAC
     WHERE ACENTIDA = @ENTIDAD
SET NOCOUNT OFF
END

GO
