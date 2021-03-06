USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAPARAMETROS_CONTROLFINANCIERO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGAPARAMETROS_CONTROLFINANCIERO]
   (   @entidad   CHAR(2)   )
AS
BEGIN
   SET NOCOUNT ON

   DECLARE @fecha_hoy  DATETIME
   DECLARE @valor_uf   FLOAT
   DECLARE @valor_do   FLOAT
   DECLARE @valor_ac   FLOAT
   DECLARE @posiniusd  FLOAT
   DECLARE @banco      CHAR(40)
   DECLARE @gloUm      CHAR(03)

    SELECT @gloUm        = mnsimbol 
      FROM CONTROL_FINANCIERO   with (nolock)
         , MONEDA               with (nolock)
     WHERE monedacontrol = mncodmon

    SELECT @fecha_hoy = acfecproc             
      FROM VIEW_MDAC  with (nolock)

    SET @valor_uf  = 0.0
    SET @valor_do  = 0.0
    SET @valor_ac  = 0.0
    SET @banco     = ' '
    SET @posiniusd = 0.0

    SELECT @valor_uf  = ISNULL(vmvalor ,0.0) FROM VALOR_MONEDA  with (nolock) WHERE vmcodigo = 998   AND vmfecha = @fecha_hoy
    SELECT @valor_do  = ISNULL(vmvalor ,0.0) FROM VALOR_MONEDA  with (nolock) WHERE vmcodigo = 994   AND vmfecha = @fecha_hoy
    SELECT @valor_ac  = ISNULL(vmvalor ,0.0) FROM VALOR_MONEDA  with (nolock) WHERE vmcodigo = 995   AND vmfecha = @fecha_hoy
    SELECT @banco     = ISNULL(acnomprop,'') FROM VIEW_MDAC     with (nolock) 
    SELECT @posiniusd = ISNULL(vmposini,0.0) FROM POSICION_SPT  with (nolock) WHERE vmcodigo = 'USD' AND vmfecha = @fecha_hoy

    SELECT 'acfecpro'  = CONVERT(CHAR(10),acfecproc,103),   -- Fecha de Proceso
           'observado' = @valor_do,                        -- Observado
           'valor_uf'  = @valor_uf,                        -- Valor UF
    
           'acfecprx'  = CONVERT(CHAR(10),acfecprox,103),   -- Fecha Proximo Proceso
           'acnombre'  = @banco,                           -- 5. Nombre
           'acuerdo'   = @valor_ac,                        -- 6. Dolar Acuerdo
           'glomon'    = @gloUm
         --  AcTCamar,                         -- 7. Tasa Camara
         --  AcTOvern,                         -- 8. Tasa Overnight
         --  AcDCamar,                         -- 9. Dias Camara
         --  AcDOvern,                         --10. Dias Overnight
     --      acLogDig,                         --11. Logger BacCambio..meac      <- Control
      --     acFinDia,                         --12. Fin de Dia       <- Control
      --     acMtoPtas,                        --13. Valores por Default
      --     AcFPrPtaC,                        --14. Recibe Compra Punta
      --     AcFPePtaC,                        --15. Entrega
      --     AcFPrPtaV,                        --16. Recibe Venta  Punta
      --     AcFPePtaV,                        --17. Entrega
      --     AcFPrEmpC,                        --18. Recibe Compra Empresa
      --     AcFPeEmpC,                        --19. Entrega
      --     AcFPrEmpV,                        --20. Recibe Venta  Empresa
      --     AcFPeEmpV,                        --21. Entrega
      --     acCband,                          --22. Banda de Compra
      --     acVband,                          --23. Banda de Venta
     --      acomac,                           --24.
     --      acrentab,                         --25.
     --      acmoneda,                         --26.
     --      acomav,                           --27.
     --      acomacpta,                        --28.
     --      acomavpta,                        --29.
     --      acrentabp,                        --30.
     --      @PosIniUSD,                       --31. Posicion USD inicial
    --       acrut,                            --32. Rut    Entidad
    --       acdv,                             --33. DV     Entidad
    --       accodigo                          --34. Codigo Entidad (BCCH)
     -- FROM view_meac 
    FROM VIEW_MDAC   with (nolock) 
     --WHERE acentida = @Entidad
--           acrentaa

END
GO
