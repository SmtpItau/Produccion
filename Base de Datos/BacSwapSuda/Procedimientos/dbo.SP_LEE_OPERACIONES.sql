USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_OPERACIONES]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEE_OPERACIONES]
   (   @dFechaConsulta   DATETIME
   ,   @nInterbancario   INTEGER   = 0
   ,   @iTodos           INTEGER   = 0
   )
AS
BEGIN

   SET NOCOUNT ON


   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = ( SELECT fechaproc FROM BacSwapSuda..SWAPGENERAL )

   IF @dFechaProceso = @dFechaConsulta and @iTodos = 0
   BEGIN

      SELECT DISTINCT numero_operacion = numero_operacion
                    , tipo_swap        = CASE WHEN tipo_swap = 1 THEN 'TASA'
                                              WHEN tipo_swap = 2 THEN 'MONEDA'
                                              WHEN tipo_swap = 3 THEN 'FRA'
                                              WHEN tipo_swap = 4 THEN 'CAMARA'
                                         END
                    , Nombre           = clnombre
                    , Rut              = rut_cliente
                    , Codigo           = codigo_cliente
                    , Tipo             = cltipcli
                    , Glosa            = tbglosa
                    , Fecha_Cierre     = Fecha_Cierre
      FROM   MOVDIARIO
             INNER JOIN BacParamSuda..CLIENTE               ON clrut = Rut_Cliente and clcodigo = Codigo_Cliente
             LEFT  JOIN bacParamSuda..TABLA_GENERAL_DETALLE ON tbcateg = 72 and tbcodigo1 = cltipcli
      WHERE ((@iTodos = 0 AND fecha_cierre = @dFechaConsulta) 
         OR  (@iTodos = 1 AND fecha_cierre > '19000101')
            )
      AND    estado      <> 'C'
      AND  ((@nInterbancario = 1 and cltipcli < 5) 
          OR(@nInterbancario = 2 and cltipcli > 4)
          OR(@nInterbancario = 0 )
           )
      ORDER BY Numero_operacion

   END ELSE
   BEGIN

      SELECT DISTINCT numero_operacion = numero_operacion
                    , tipo_swap        = CASE WHEN tipo_swap = 1 THEN 'TASA'
                                              WHEN tipo_swap = 2 THEN 'MONEDA'
                                              WHEN tipo_swap = 3 THEN 'FRA'
                                              WHEN tipo_swap = 4 THEN 'CAMARA'
                                         END
                    , Nombre           = clnombre
                    , Rut              = rut_cliente
                    , Codigo           = codigo_cliente
                    , Tipo             = cltipcli
                    , Glosa            = tbglosa
                    , Fecha_Cierre     = Fecha_Cierre
      FROM   MOVHISTORICO
             INNER JOIN BacParamSuda..CLIENTE ON clrut = Rut_Cliente and clcodigo = Codigo_Cliente
             LEFT  JOIN bacParamSuda..TABLA_GENERAL_DETALLE ON tbcateg = 72 and tbcodigo1 = cltipcli
      WHERE ((@iTodos = 0 AND fecha_cierre = @dFechaConsulta) 
         OR  (@iTodos = 1 AND fecha_cierre > '19000101')
            )
      AND    estado      <> 'C'
      AND  ((@nInterbancario = 1 and cltipcli < 5) 
          OR(@nInterbancario = 2 and cltipcli > 4)
          OR(@nInterbancario = 0 )
           )
      ORDER BY Numero_operacion

   END
   
END
GO
