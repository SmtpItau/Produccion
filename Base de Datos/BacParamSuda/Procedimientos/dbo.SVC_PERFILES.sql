USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_PERFILES]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SVC_PERFILES]
AS
BEGIN

   SET NOCOUNT ON

   SELECT DISTINCT folio_perfil, Puntero = Identity(int)
     INTO #TMP_FOLIO_PERFIL
     FROM BacParamSuda..PERFIL_CNT  with(nolock)
    WHERE id_sistema   = 'BFW'
   ORDER BY folio_perfil

   DECLARE @iRegistros   NUMERIC(9)
   DECLARE @iContador    NUMERIC(9)
   DECLARE @nPerfil      NUMERIC(9)

       SET @iRegistros = ( SELECT MAX(Puntero) FROM #TMP_FOLIO_PERFIL )
       SET @iContador  = ( SELECT MIN(Puntero) FROM #TMP_FOLIO_PERFIL )


   WHILE @iRegistros >= @iContador
   BEGIN
      SET @nPerfil = ( SELECT folio_perfil FROM #TMP_FOLIO_PERFIL WHERE Puntero = @iContador )

      SELECT DISTINCT 
          Modulo         = p.id_sistema
      ,   Movimiento     = ISNULL( SUBSTRING(m.glosa_movimiento, 1, 40), '')      --> p.tipo_movimiento
      ,   Operacion      = ISNULL( SUBSTRING(m.glosa_operacion,  1, 40), '')      --> p.tipo_operacion
      ,   Instrumento    = ISNULL( SUBSTRING(i.Inglosa,          1, 40), '')      --> p.codigo_instrumento
      ,   Moneda         = ISNULL( SUBSTRING(n.mnnemo,1,3) + ' ' + n.mnglosa, '') --> p.moneda_instrumento
      ,   Tipo           = CASE WHEN p.tipo_voucher = 'I' THEN 'INGRESO'
                                WHEN p.tipo_voucher = 'E' THEN 'EGRESO'
                                ELSE                           'TRASPASO'
                           END
      ,   Glosa          = p.glosa_perfil
      ,   Folio          = p.folio_perfil
      FROM  BacParamSuda..PERFIL_CNT p with(nolock)
            INNER JOIN BacParamSuda..PERFIL_DETALLE_CNT d with(nolock) ON p.folio_perfil = d.folio_perfil
            LEFT  JOIN BacParamSuda..MOVIMIENTO_CNT     m with (nolock)  ON m.id_sistema = p.id_sistema AND m.tipo_movimiento = p.tipo_movimiento AND m.tipo_operacion = p.tipo_operacion
            LEFT  JOIN BacParamSuda..INSTRUMENTO        i with (nolock)  ON i.inserie         = p.codigo_instrumento
            LEFT  JOIN BacParamSuda..MONEDA             n with (nolock)  ON n.mncodmon   = CASE WHEN p.id_sistema = 'BFW' THEN CONVERT(INTEGER,codigo_instrumento)
                                                                                                ELSE                           CONVERT(INTEGER,moneda_instrumento)
                                                                                           END

      WHERE  p.id_sistema   = 'BFW'
        AND  p.folio_perfil = @nPerfil --> 272
      ORDER BY p.folio_perfil

      SELECT Campo          = d.codigo_campo
      ,      Correlativo    = d.correlativo_perfil
      ,      Descripcion    = c.descripcion_campo
      ,      TipoMov        = d.tipo_movimiento_cuenta
      ,      Fijo           = d.perfil_fijo
      ,      Valor          = CASE WHEN d.perfil_fijo = 'S' THEN 0 ELSE ISNULL( v.valor_dato_campo, '') END
      ,      Cuenta         = CASE WHEN d.perfil_fijo = 'S' THEN d.codigo_cuenta ELSE v.codigo_cuenta END
      ,      Glosa          = ISNULL( u.descripcion , '<< CTA NO DEFINIDA >>')
      ,      Perfil         = d.folio_perfil
      FROM   BacParamSuda..PERFIL_CNT p with(nolock)
             INNER JOIN BacParamSuda..PERFIL_DETALLE_CNT  d with (nolock) ON p.folio_perfil = d.folio_perfil
             LEFT  JOIN BacParamSuda..PERFIL_VARIABLE_CNT v with (nolock) ON p.folio_perfil = v.folio_perfil AND v.correlativo_perfil = d.correlativo_perfil
             LEFT  JOIN BacParamSuda..CAMPO_CNT           c with (nolock) ON c.id_sistema   = p.id_sistema AND c.tipo_movimiento = p.tipo_movimiento AND c.tipo_operacion  = p.tipo_operacion  AND c.codigo_campo = d.codigo_campo
             LEFT  JOIN BacParamSuda..PLAN_DE_CUENTA      u with (nolock) ON u.cuenta       = CASE WHEN d.perfil_fijo = 'S' THEN d.codigo_cuenta ELSE v.codigo_cuenta END
      WHERE  p.id_sistema   = 'BFW'
        AND  p.Folio_Perfil = @nPerfil --> 272
      ORDER BY p.folio_perfil

      SET @iContador = @iContador + 1

   END

END
GO
