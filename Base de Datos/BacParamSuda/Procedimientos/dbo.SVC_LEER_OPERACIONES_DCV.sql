USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_LEER_OPERACIONES_DCV]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVC_LEER_OPERACIONES_DCV]
   (   @fecha       DATETIME
   ,   @Modulo      CHAR(3)     = ''
   ,   @Producto    VARCHAR(5)  = ''
   ,   @Moneda      INT		    = 0
   ,   @FPago       INT			= 0
   ,   @Estado      CHAR(1)     = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nFilas   NUMERIC(9)
       SET @nFilas   = (SELECT COUNT(1) FROM  dbo.TBL_ARCHIVOS_DCV dcv with(nolock) 
                                       WHERE  dcv.Fecha     = @fecha
                                         AND (dcv.Modulo    = @Modulo   or @Modulo   = '')
                                         AND (dcv.Producto  = @Producto or @Producto = '')
                                         AND (dcv.MonedaCnv = @Moneda   or @Moneda   = 0 )
                                         AND (dcv.fPago     = @FPago    or @FPago    = 0 )
                                         AND (dcv.Estado    = @Estado   or @Estado   = '') )

   SELECT /*01*/ Marca        = 0
      ,   /*02*/ Fecha        = dcv.Fecha
      ,   /*03*/ Modulo       = sis.nombre_sistema --> dcv.Modulo
      ,   /*04*/ Producto     = pro.descripcion    --> dcv.Producto
      ,   /*05*/ Contrato     = dcv.Contrato
      ,   /*06*/ Estado       = CASE WHEN dcv.Estado = 'P' THEN 'PENDIENTE'
                                     WHEN dcv.Estado = 'E' THEN 'ENVIADO'
                                     ELSE                       dcv.Estado
                                END
      ,   /*07*/ Cliente      = cli.clnombre
      ,   /*08*/ Moneda       = LTRIM(RTRIM( mon.mnnemo )) + '/' + LTRIM(RTRIM( cnv.mnnemo ))    --> dcv.Moneda
      ,   /*09*/ fPago        = fpa.glosa                                                        --> dcv.fPago
      ,   /*10*/ Monto        = dcv.Monto
      ,   /*11*/ Precio       = dcv.Precio
      ,   /*12*/ FechaVcto    = dcv.FechaVcto
      ,   /*13*/ IdGrupo      = dcv.IdGrupo
      ,   /*14*/ EstadoGrupo  = dcv.EstadoGrupo
      ,   /*15*/ Reservado    = dcv.Reservado
      ,   /*16*/ CodModulo    = dcv.Modulo
      ,   /*99*/ nFilas       = @nFilas
   FROM   dbo.TBL_ARCHIVOS_DCV                     dcv with(nolock) 
          LEFT JOIN BacParamSuda.dbo.CLIENTE       cli with(nolock) ON cli.clrut      = dcv.RutCliente AND cli.clcodigo = dcv.CodCliente
          LEFT JOIN BacParamSuda.dbo.SISTEMA_CNT   sis with(nolock) ON sis.id_sistema = dcv.Modulo
          LEFT JOIN BacParamSuda.dbo.PRODUCTO      pro with(nolock) ON pro.id_sistema = dcv.Modulo	   AND pro.codigo_producto = dcv.Producto
          LEFT JOIN BacParamSuda.dbo.MONEDA        mon with(nolock) ON mon.mncodmon   = dcv.Moneda
          LEFT JOIN BacParamSuda.dbo.MONEDA        cnv with(nolock) ON cnv.mncodmon   = dcv.MonedaCnv
          LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO fpa with(nolock) ON fpa.codigo     = dcv.fPago
	     INNER JOIN BacParamSuda.dbo.TBL_CODIGO_CLIENTE_DCV ccdv with(nolock) ON ccdv.RutCliente = cli.Clrut
																			 AND ccdv.CodCliente = cli.Clcodigo
   WHERE  dcv.Fecha     = @fecha
   AND   (dcv.Modulo    = @Modulo   or @Modulo   = '')
   AND   (dcv.Producto  = @Producto or @Producto = '')
   AND   (dcv.MonedaCnv = @Moneda   or @Moneda   = 0 )
   AND   (dcv.fPago     = @FPago    or @FPago    = 0 )
   AND   (dcv.Estado    = @Estado   or @Estado   = '')
   AND	 (cli.cltipcli  IN(1, 2, 3, 4, 5, 6)		 )
   AND	 (ccdv.CodDcv	> 0						     )
   ORDER BY dcv.Modulo, dcv.Producto, dcv.RutCliente

END

GO
