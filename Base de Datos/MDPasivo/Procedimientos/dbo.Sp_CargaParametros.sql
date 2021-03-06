USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CargaParametros]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_CargaParametros](@entidad CHAR(2)) 
AS
BEGIN
set nocount on
SET DATEFORMAT dmy

   DECLARE @fecha_hoy  DATETIME,
           @valor_uf   FLOAT   ,
           @valor_do   FLOAT   ,
           @valor_ac   FLOAT   ,
           @posiniusd  FLOAT   ,
           @banco      CHAR(40)

    SELECT @fecha_hoy = fecha_proceso             FROM DATOS_GENERALES
    SELECT @valor_uf  = 0.0
    SELECT @valor_do  = 0.0
    SELECT @valor_ac  = 0.0
    SELECT @banco     = " "
    SELECT @posiniusd = 0.0

    SELECT @valor_uf  = ISNULL(vmvalor ,0.0) FROM VALOR_MONEDA  WHERE vmcodigo = 998   AND vmfecha = @fecha_hoy
    SELECT @valor_do  = ISNULL(vmvalor ,0.0) FROM VALOR_MONEDA  WHERE vmcodigo = 994   AND vmfecha = @fecha_hoy
    SELECT @valor_ac  = ISNULL(vmvalor ,0.0) FROM VALOR_MONEDA  WHERE vmcodigo = 995   AND vmfecha = @fecha_hoy
    SELECT @banco     = ISNULL(nombre_entidad,"") FROM DATOS_GENERALES
    SELECT @posiniusd = ISNULL(vmposini,0.0) FROM VIEW_POSICION WHERE vmcodigo = "USD" AND vmfecha = @fecha_hoy

    SELECT "acFecPro"  = CONVERT(CHAR(10), fecha_proceso,103),   -- Fecha de Proceso
           "observado" = @valor_do,                        -- Observado
           "valor_uf"  = @valor_uf,                        -- Valor UF
	   
           "acfecprx"  = CONVERT(CHAR(10), fecha_proxima,103),   -- Fecha Proximo Proceso
           "acnombre"  = @banco,                           -- 5. Nombre

           "acuerdo"   = @valor_ac,                        -- 6. Dolar Acuerdo

           0,--actcamar,                         -- 7. tasa camara
           0,--actovern,                         -- 8. tasa overnight
           0,--acdcamar,                         -- 9. dias camara
           0,--acdovern,                         --10. dias overnight

           0,--aclogdig,                         --11. logger baccambio..meac      <- control
           0,--acfindia,                         --12. fin de dia       <- control

           0,--acmtoptas,                        --13. valores por default
           0,--acfprptac,                        --14. recibe compra punta
           0,--acfpeptac,                        --15. entrega
           0,--acfprptav,                        --16. recibe venta  punta
           0,--acfpeptav,                        --17. entrega
           0,--acfprempc,                        --18. recibe compra empresa
           0,--acfpeempc,                        --19. entrega
           0,--acfprempv,                        --20. recibe venta  empresa
           0,--acfpeempv,                        --21. entrega

           0,--accband,                          --22. banda de compra
           0,--acvband,                          --23. banda de venta

           0,--acomac,                           --24.
           0,--acrentab,                         --25.
           0,--acmoneda,                         --26.
           0,--acomav,                           --27.
           0,--acomacpta,                        --28.
           0,--acomavpta,                        --29.
           0,--acrentabp,                        --30.
           @posiniusd,                       --31. posicion usd inicial
           rut_entidad,                            --32. rut    entidad
           digito_entidad,                             --33. dv     entidad
           codigo_entidad                          --34. codigo entidad (bcch)

      FROM DATOS_GENERALES


--           acrentaa
set nocount off

END



GO
