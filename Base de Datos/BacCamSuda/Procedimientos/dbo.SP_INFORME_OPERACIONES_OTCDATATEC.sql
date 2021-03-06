USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_OPERACIONES_OTCDATATEC]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--     EXECUTE   SP_INFORME_OPERACIONES_OTCDATATEC '20040907' , '20040907' , 'ADMINISTRA' 
--     EXECUTE   SP_INFORME_OPERACIONES_OTCDATATEC '20050101' , '20050101' , 'ADMINISTRA' 
CREATE PROCEDURE [dbo].[SP_INFORME_OPERACIONES_OTCDATATEC]
   (   @FechaDesde   DATETIME
   ,   @FechaHasta   DATETIME
   ,   @Usuario      VARCHAR(15) = 'ADMINISTRA'
   )
AS 
BEGIN

   SET NOCOUNT ON

   DECLARE @acfecproc    CHAR(10)
   ,       @acfecprox    CHAR(10)
   ,       @uf_hoy       FLOAT
   ,       @uf_man       FLOAT
   ,       @ivp_hoy      FLOAT
   ,       @ivp_man      FLOAT
   ,       @do_hoy       FLOAT
   ,       @do_man       FLOAT
   ,       @da_hoy       FLOAT
   ,       @da_man       FLOAT
   ,       @acnomprop    CHAR(40)
   ,       @rut_empresa  CHAR(12)
   ,       @hora         CHAR(8)
   ,       @oma          CHAR(3)
   ,       @FechaProceso CHAR(10)
   ,       @FechaEmision CHAR(10)
   ,       @HoraEmision  CHAR(10)
   ,       @SubTitulo    VARCHAR(50)

   SELECT  @SubTitulo    = 'Desde el dÃ­a ' + CONVERT(CHAR(10),@FechaDesde,103) + ' Hasta el dÃ­a ' + CONVERT(CHAR(10),@FechaHasta,103)
   SELECT  @FechaEmision = convert(char(10),getdate(),103)
   SELECT  @HoraEmision  = convert(char(10),getdate(),108)
   SELECT  @FechaProceso = convert(char(10),acfecpro,103)
   FROM    MEAC

   EXECUTE SP_BASE_DEL_INFORME
           @acfecproc   OUTPUT
   ,       @acfecprox   OUTPUT
   ,       @uf_hoy      OUTPUT
   ,       @uf_man      OUTPUT
   ,       @ivp_hoy     OUTPUT
   ,       @ivp_man     OUTPUT
   ,       @do_hoy      OUTPUT
   ,       @do_man      OUTPUT
   ,       @da_hoy      OUTPUT
   ,       @da_man      OUTPUT
   ,       @acnomprop   OUTPUT
   ,       @rut_empresa OUTPUT
   ,       @hora        OUTPUT
   ,       @oma         OUTPUT

   SELECT  mofech 
   ,       monumope 
   ,       CASE WHEN motipope = 'C' THEN 'COMPRA'
                WHEN motipope = 'V' THEN 'VENTA'
           END          as motipope
   ,       mocodmon 
   ,       momonmo 
   ,       moparme 
   ,       mopartr 
   ,       moussme 
   ,       mohora 
   ,       moticam 
   ,       motctra 
   ,       momonpe 
   ,       mocodoma 
   ,       mooper
   ,       moentre
   ,       morecib
   ,       movaluta1
   ,       movaluta2
   ,       moestatus
   ,       monomcli
   ,       morutcli
   ,       moterm
   INTO    #OPERACIONES_DATATECBOLSA
   FROM    MEMO
   WHERE   moterm        IN('BOLSA','DATATEC') 
   AND     mofech        BETWEEN @FechaDesde AND @FechaHasta

   UNION

   SELECT  mofech 
   ,       monumope 
   ,       CASE WHEN motipope = 'C' THEN 'COMPRA'
                WHEN motipope = 'V' THEN 'VENTA'
           END          as motipope
   ,       mocodmon 
   ,       momonmo 
   ,       moparme 
   ,       mopartr 
   ,       moussme 
   ,       mohora 
   ,       moticam 
   ,       motctra 
   ,       momonpe 
   ,       mocodoma 
   ,       mooper
   ,       moentre
   ,       morecib
   ,       movaluta1
   ,       movaluta2
   ,       moestatus
   ,       monomcli
   ,       morutcli
   ,       moterm
   FROM    MEMOH
   WHERE   moterm        IN('BOLSA','DATATEC') 
   AND     mofech        BETWEEN @FechaDesde AND @FechaHasta

   IF (SELECT COUNT(*) FROM #OPERACIONES_DATATECBOLSA) > 0
   BEGIN
      SELECT  CONVERT(CHAR(10),mofech,103)   as FechaOperacion
      ,       monumope 
      ,       motipope
      ,       mocodmon 
      ,       momonmo 
      ,       moparme 
      ,       mopartr 
      ,       moussme 
      ,       mohora 
      ,       moticam 
      ,       motctra 
      ,       momonpe 
   -- ,       mocodoma 
      ,       mooper
   -- ,       moentre
   -- ,       morecib
      ,       CONVERT(CHAR(10),movaluta1,103) as FechaEntregamos
      ,       CONVERT(CHAR(10),movaluta2,103) as FechaRecibimos
      ,       CASE WHEN moestatus = 'P' THEN CONVERT(CHAR(20),'Pendiente')
                   WHEN moestatus = 'A' THEN CONVERT(CHAR(20),'Anulada')
                   WHEN moestatus = 'M' THEN CONVERT(CHAR(20),'Modificada')
                   WHEN moestatus = ' ' THEN CONVERT(CHAR(20),'Aprobada')
                   ELSE                      CONVERT(CHAR(20),moestatus)
              END                             as moestatus
      ,       monomcli
      ,       moterm
      ,       a.glosa                         as GlosaEntregamos
      ,       b.glosa                         as GlosaRecibimos
      ,       @SubTitulo                      as SubTitulo
      ,       @FechaProceso                   as FechaProceso
      ,       @FechaEmision                   as FechaEmision
      ,       @HoraEmision                    as HoraEmision
      ,       CONVERT(NUMERIC(21,4),@uf_hoy)  as Uf
      ,       CONVERT(NUMERIC(21,4),@ivp_hoy) as Ivp
      ,       CONVERT(NUMERIC(21,4),@do_hoy)  as Do
      ,       CONVERT(NUMERIC(21,4),@da_hoy)  as Da
      ,       @Usuario                        as Usuario
      FROM    #OPERACIONES_DATATECBOLSA
      ,       VIEW_FORMA_DE_PAGO a
      ,       VIEW_FORMA_DE_PAGO b
      WHERE   moentre       = a.codigo
      AND     morecib       = b.codigo

   END ELSE
   BEGIN

      SELECT  CONVERT(CHAR(10),@FechaDesde,103)   as FechaOperacion
      ,       'monumope' = 0 
      ,       'motipope' = ''
      ,       'mocodmon' = ''
      ,       'momonmo'  = 0.0
      ,       'moparme'  = 0.0
      ,       'mopartr'  = 0.0
      ,       'moussme'  = 0.0
      ,       'mohora'   = CONVERT(CHAR(10),GETDATE(),108)
      ,       'moticam'  = 0.0
      ,       'motctra'  = 0.0
      ,       'momonpe'  = 0
   -- ,       'mocodoma' = ''
      ,       'mooper'   = ''
   -- ,       'moentre'  = 0
   -- ,       'morecib'  = 0
      ,       ' '        as FechaEntregamos
      ,       ' '        as FechaRecibimos
      ,       ' '        as moestatus
      ,       'monomcli' = ' ' 
      ,       'moterm'   = ' ' 
      ,       ' '        as GlosaEntregamos
      ,       ' '        as GlosaRecibimos
      ,       @SubTitulo                      as SubTitulo
      ,       @FechaProceso                   as FechaProceso
      ,       @FechaEmision                   as FechaEmision
      ,       @HoraEmision                    as HoraEmision
      ,       CONVERT(NUMERIC(21,4),@uf_hoy)  as Uf
      ,       CONVERT(NUMERIC(21,4),@ivp_hoy) as Ivp
      ,       CONVERT(NUMERIC(21,4),@do_hoy)  as Do
      ,       CONVERT(NUMERIC(21,4),@da_hoy)  as Da
      ,       @Usuario                        as Usuario

   END   
   --     EXECUTE   SP_INFORME_OPERACIONES_OTCDATATEC 'ADMINISTRA' , '20040525' , '20040525'

END

GO
