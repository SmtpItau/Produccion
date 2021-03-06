USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_PerfilContable_DevuelveFolio]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_PerfilContable_DevuelveFolio]
         (
         @folio_perfil   NUMERIC(5)
         )

AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

      SELECT DISTINCT
             PD.id_sistema 
         ,   PD.codigo_producto 
         ,   PD.codigo_evento 
         ,   PD.codigo_moneda1 
         ,   PD.codigo_moneda2 
         ,   PD.codigo_instrumento 
         ,   'Voucher' = ' '

      INTO #TMP

      FROM  PERFIL_DETALLE PD 
 
      WHERE folio_perfil = @folio_perfil

      UPDATE #TMP SET Voucher = (SELECT tipo_voucher FROM PERFIL P WHERE           #TMP.id_sistema            = P.id_sistema 
                                                                                   AND #TMP.codigo_producto       = P.codigo_producto 
                                                                                   AND #TMP.codigo_evento         = P.codigo_evento 
                                                                                   AND #TMP.codigo_moneda1        = P.codigo_moneda1 
                                                                                   AND #TMP.codigo_moneda2        = P.codigo_moneda2 
                                                                                   AND #TMP.codigo_instrumento    = P.codigo_instrumento 
                                 )    

      SELECT * FROM #TMP

   SET NOCOUNT OFF

END





GO
