USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAPARAMETROSCAMBIO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_CargaParametrosCambio    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_CargaParametrosCambio    fecha de la secuencia de comandos: 14/02/2001 09:58:24 ******/
CREATE PROCEDURE [dbo].[SP_CARGAPARAMETROSCAMBIO](@entidad CHAR(2)) 
AS
BEGIN
   SET NOCOUNT ON
    SELECT 'acfecpro'  = CONVERT(CHAR(10),acfecpro,103),   -- Fecha de Proceso
           'acfecprx'  = CONVERT(CHAR(10),acfecprx,103),   -- Fecha Proximo Proceso
           'acnombre'  = acnombre,                         -- 5. Nombre
           actcamar,                         -- 7. tasa camara
           actovern,                         -- 8. tasa overnight
           acdcamar,                         -- 9. dias camara
           acdovern,                         --10. dias overnight
           aclogdig,                         --11. logger meac      <- control
           acfindia,                         --12. fin de dia       <- control
           acmtoptas,                        --13. valores por default
           acfprptac,                        --14. recibe compra punta
           acfpeptac,                        --15. entrega
           acfprptav,                        --16. recibe venta  punta
           acfpeptav,                        --17. entrega
           acfprempc,                        --18. recibe compra empresa
           acfpeempc,                        --19. entrega
           acfprempv,                        --20. recibe venta  empresa
           acfpeempv,                        --21. entrega
           accband,                          --22. banda de compra
           acvband,                          --23. banda de venta
           acomac,                           --24.
           acrentab,                         --25.
           acmoneda,                         --26.
           acomav,                           --27.
           acomacpta,                        --28.
           acomavpta,                        --29.
           acrentabp,                        --30.
           acrut,                            --32. rut    entidad
           acdv,                             --33. dv     entidad
           accodigo                          --34. codigo entidad (bcch)
      FROM VIEW_MEAC
     WHERE acentida = @entidad
    SET NOCOUNT OFF
END
GO
