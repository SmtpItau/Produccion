USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_ARB_MXMN]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--SP_HELPTEXT SP_RPT_OPERACIONES_INTRAMESAS  'T', '20160301', 'T', 'CP'

--SP_RPT_OPERACIONES_INTRAMESAS 'CP', '20160301', 'T', 'T'

--SP_LEEINFSEGCAM 1, '20160301', 1111, 1554, 1552

-- sp_helptext  SP_INFORME_ARB_MXMN '20160301'


CREATE PROCEDURE [dbo].[SP_INFORME_ARB_MXMN]
   (   @dfecdesde         CHAR(08) = Null
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Cat_CartNorm      CHAR(06)
   DECLARE @Cat_SubCartNorm   CHAR(06)
   DECLARE @Cat_Libro         CHAR(06)
       SET @Cat_CartNorm      = '1111'
       SET @Cat_SubCartNorm   = '1554'
       SET @Cat_Libro         = '1552'

   DECLARE @cnomprop          CHAR(40)
   DECLARE @cdirprop          CHAR(40)
   DECLARE @cfecproc          CHAR(10)
   DECLARE @dfecproc          CHAR(8)
   DECLARE @ENCONTRO1         CHAR(1)
   DECLARE @ENCONTRO2         CHAR(1)

   SELECT  @cnomprop = (SELECT rcnombre FROM VIEW_ENTIDAD with (nolock) )
   ,       @cdirprop = acdirprop
   ,       @dfecproc = CONVERT(CHAR(08),acfecproc,112)
   ,       @cfecproc = CONVERT(CHAR(10),acfecproc,103)
   FROM    MFAC      with (nolock)

   set @cnomprop = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

   SET @encontro1 = 'S' 
   SET @encontro2 = 'S'

   IF @dfecdesde = @dfecproc or @dfecdesde is Null
   BEGIN
      SELECT 'Numero Contrato'  = a.monumoper
      ,	     'Producto' 	    = z.cacodpos1
      ,      'OpRelacionada'    = z.var_moneda2
      ,      'Rut Cliente'      = c.clrut
      ,      'DV'               = c.cldv
      ,      'Nombre Cliente'   = c.clnombre
      ,      'Fecha Inicio'     = CONVERT(CHAR(10),a.mofecha,103)
      ,      'Fecha Termino'    = CONVERT(CHAR(10),a.mofecvcto,103)
      ,      'Dias'             = a.moplazo
      ,      'Moneda'           = ISNULL(G.mnnemo,'N/D') --> ISNULL(f.mnnemo,'N/D')
      ,      'M/X'              = g.mnnemo
      ,      'Monto M/X'        = a.momtomon1
      ,      'M/N cnv'          = h.mnnemo
      ,      'Precio'           = a.moprecal
      ,      'T/C Final'        = a.motipcam
      ,      'Monto Final'      = a.momtomon2
      ,      'mod.cumplimiento' = a.motipmoda
      ,      'Pago M/N'         = (SELECT ISNULL( glosa,' ') FROM VIEW_FORMA_DE_PAGO with (nolock) WHERE codigo = a.mofpagomn )
      ,      'Pago M/X'         = (SELECT ISNULL( glosa,' ') FROM VIEW_FORMA_DE_PAGO with (nolock) WHERE codigo = a.mofpagomx )
      ,      'Nombre Empresa'   = @cnomprop
      ,      'Tipo de Operacion'= a.motipoper
      ,      'Spread'           = a.mospread
      ,      'Direccion'        = @cdirprop
      ,      'Fecha de Proceso' = @cfecproc
      ,      'Entidad'          = @cnomprop
      ,      'Hora'             = CONVERT(CHAR(08),GETDATE(),108)
      ,      'Fecha_Cons'	    = CONVERT(CHAR(10),CONVERT(DATETIME,@dfecdesde),103)
      ,      'cartnorm'	        = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE with (nolock) WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = mocartera_normativa),   'No Especificado')
      ,      'subcart'	        = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE with (nolock) WHERE tbcateg = @cat_subcartNorm  AND tbcodigo1 = mosubcartera_normativa),'No Especificado')
      ,      'Libro'		    = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE with (nolock) WHERE tbcateg = @cat_libro        AND tbcodigo1 = molibro),               'No Especificado')
      INTO   #MOVIMIENTO
      FROM   MFMO                    a with (nolock)
             INNER JOIN VIEW_CLIENTE c with (nolock) ON c.clrut      = a.mocodigo AND c.clcodigo = a.mocodcli
             INNER JOIN VIEW_MONEDA  f with (nolock) ON a.momdausd   = f.mncodmon
             INNER JOIN VIEW_MONEDA  g with (nolock) ON a.mocodmon1  = g.mncodmon
             INNER JOIN VIEW_MONEDA  h with (nolock) ON a.mocodmon2  = h.mncodmon
	     INNER JOIN mfca         z with (nolock) ON a.monumoper = z.canumoper
      WHERE  z.var_moneda2 != 0

      IF (SELECT COUNT(1) FROM #MOVIMIENTO) = 0
         GOTO SINDATOS
      ELSE
         SELECT * FROM #MOVIMIENTO Order by 1,2 asc

   END ELSE 
   BEGIN

      SELECT 'Numero Contrato'  = a.monumoper
      ,      'Rut Cliente'      = c.clrut
      ,	     'Producto' 	    = z.cacodpos1
      ,      'OpRelacionada'    = z.var_moneda2
      ,      'DV'               = c.cldv
      ,      'Nombre Cliente'   = c.clnombre
      ,      'Fecha Inicio'     = CONVERT(CHAR(10),a.mofecha,103)
      ,      'Fecha Termino'    = CONVERT(CHAR(10),a.mofecvcto,103)
      ,      'Dias'             = a.moplazo
      ,      'Moneda'           = ISNULL(G.mnnemo,'N/D') --> ISNULL(f.mnnemo,'N/D')
      ,      'M/X'              = g.mnnemo
      ,      'Monto M/X'        = a.momtomon1
      ,      'M/N cnv'          = h.mnnemo
      ,      'Precio'           = a.moprecal
      ,      'T/C Final'        = a.motipcam
      ,      'Monto Final'      = a.momtomon2
      ,      'mod.cumplimiento' = a.motipmoda
      ,      'Pago M/N'         = (SELECT ISNULL( glosa ,' ') FROM VIEW_FORMA_DE_PAGO with (nolock) WHERE codigo = a.mofpagomn)
      ,      'Pago M/X'         = (SELECT ISNULL( glosa ,' ') FROM VIEW_FORMA_DE_PAGO with (nolock) WHERE codigo = a.mofpagomx)
      ,      'Nombre Empresa'   = @cnomprop
      ,      'Tipo de Operacion'= a.motipoper
      ,      'Spread'           = a.mospread
      ,      'Direccion'        = @cdirprop
      ,      'Fecha de Proceso' = @cfecproc
      ,      'Entidad'          = @cnomprop
      ,      'Hora'             = CONVERT(CHAR(08),GETDATE(),108)
      ,      'Fecha_Cons'       = CONVERT(CHAR(10),CONVERT(DATETIME,@dfecdesde),103)
      ,      'cartnorm'	        = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE with (nolock) WHERE tbcateg = @cat_cartnorm AND tbcodigo1 = mocartera_normativa),       'No Especificado')
      ,      'subcart'	        = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE with (nolock) WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = mosubcartera_normativa),'No Especificado')
      ,      'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE with (nolock) WHERE tbcateg = @cat_libro    AND tbcodigo1 = molibro),                   'No Especificado') 
      INTO   #HISTORICO
      FROM   MFMOH                   a with (nolock)
             INNER JOIN VIEW_CLIENTE c with (nolock) ON c.clrut     = a.mocodigo AND c.clcodigo = a.mocodcli
             INNER JOIN VIEW_MONEDA  f with (nolock) ON a.momdausd  = f.mncodmon
             INNER JOIN VIEW_MONEDA  g with (nolock) ON a.mocodmon1 = g.mncodmon
             INNER JOIN VIEW_MONEDA  h with (nolock) ON a.mocodmon2 = h.mncodmon
	     INNER JOIN mfca         z with (nolock) ON a.monumoper = z.canumoper
      WHERE  z.var_moneda2 != 0
      AND    a.mofecha    = @dfecdesde

      IF (SELECT COUNT(1) FROM #HISTORICO) = 0
         GOTO SINDATOS
      ELSE
         SELECT * FROM #HISTORICO Order by 1,2 desc

   END

RETURN
SINDATOS:
      SELECT 'Numero Contrato'  = 0
      ,      'Rut Cliente'      = 0
      ,      'DV'               = ''
      ,      'Nombre Cliente'   = ''
      ,      'Fecha Inicio'     = ''
      ,      'Fecha Termino'    = ''
      ,      'Dias'             = 0
      ,      'Moneda'           = ''
      ,      'M/X'              = ''
      ,      'Monto M/X'        = 0
      ,      'M/N cnv'          = ''
      ,      'Precio'           = 0
      ,      'T/C Final'        = 0
      ,      'Monto Final'      = 0
      ,      'mod.cumplimiento' = ''
      ,      'Pago M/N'         = ''
      ,      'Pago M/X'         = ''
      ,      'Nombre Empresa'   = @cnomprop
      ,      'Tipo de Operacion'= ''
      ,      'Spread'           = 0
      ,      'Direccion'        = @cdirprop
      ,      'Fecha de Proceso' = @cfecproc
      ,      'Entidad'          = @cnomprop
      ,      'Hora'             = CONVERT(CHAR(08),GETDATE(),108)
      ,      'Fecha_Cons'       = CONVERT(CHAR(10),CONVERT(DATETIME,@dfecdesde),103)
      ,      ''	
      ,      ''	
      ,      ''	

END

GO
