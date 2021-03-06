USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CREDITO]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INFORME_CREDITO]
   (   @RutCliente   NUMERIC(9)  = 0    
   ,   @CodCliente   NUMERIC(9)  = 0    
   ,   @TipoClinte   NUMERIC(9)  = 0    
   ,   @Estado       NUMERIC(5)  = 0    
   ,   @BacUser      VARCHAR(15) = 'ADMINISTRA'    
   )    
AS    
BEGIN    
    
   SET NOCOUNT ON    
    
   DECLARE @dFechaProceso  DATETIME    
       SET @dFechaProceso  = (SELECT acfecproc FROM Bactradersuda.dbo.MDAC with(nolock) )    
    
   SELECT 'Cliente'        = CONVERT(CHAR(35),    clie.clnombre       )    
   ,      'Rut'            = CONVERT(NUMERIC(10), clie.clrut          )    
   ,      'Sistema'        = CONVERT(CHAR(3),     lsis.id_sistema     )    
   ,      'GloSistema'     = CONVERT(CHAR(15),    sist.nombre_sistema )    
   ,   'Instrumento'    = ISNULL( inst.inserie,'')    
   ,      'Producto'       = ISNULL( lpzo.codigo_producto, '')    
   ,      'GloProducto'    = CONVERT(CHAR(30), ISNULL( prod.Descripcion, '') )    
 --,      'Plazo'          = CONVERT(CHAR(10), ISNULL( lpzo.plazodesde, 0) ) + ' - ' + CONVERT(CHAR(10), ISNULL(lpzo.Plazohasta, 0) )  
   ,      'Plazo'          = CONVERT(CHAR(05), ISNULL( lpzo.plazodesde, 0) ) + ' - ' + CONVERT(CHAR(05), ISNULL(lpzo.Plazohasta, 0) )  
   ,      'Moneda'         = CONVERT(NUMERIC(5), lgen.moneda)    
   ,      'GloMoneda'      = mone.mnnemo    
   ,      'Gen_Asignado'   = convert(numeric(21,4), ISNULL( lgen.totalasignado,   0) )    
   ,      'Gen_Ocupado'    = convert(numeric(21,4), ISNULL( lgen.totalocupado,    0) )    
   ,      'Gen_Disponible' = convert(numeric(21,4), ISNULL( lgen.totaldisponible, 0) )    
   ,      'Gen_Exceso'     = convert(numeric(21,4), ISNULL( lgen.totalexceso,     0) )    
   ,      'Sis_Asignado'   = convert(numeric(21,4), ISNULL( lsis.totalasignado,   0) )    
   ,      'Sis_Ocupado'    = convert(numeric(21,4), ISNULL( lsis.totalocupado,    0) )    
   ,      'Sis_Disponible' = convert(numeric(21,4), ISNULL( lsis.totaldisponible, 0) )    
   ,      'Sis_Exceso'     = convert(numeric(21,4), ISNULL( lsis.totalexceso,     0) )    
   ,      'Pla_Asignado'   = convert(numeric(21,4), ISNULL( lpzo.totalasignado,   0) )    
   ,      'Pla_Ocupado'    = convert(numeric(21,4), ISNULL( lpzo.totalocupado,    0) )    
   ,      'Pla_Disponible' = convert(numeric(21,4), ISNULL( lpzo.totaldisponible, 0) )    
   ,      'Pla_Exceso'     = convert(numeric(21,4), ISNULL( lpzo.totalexceso,     0) )    
   ,      'Estado'         = CONVERT(CHAR(1),   lgen.Bloqueado)    
   ,      'FechaProceso'   = CONVERT(CHAR(10),  @dFechaProceso  ,103)    
   ,      'FechaEmision'   = CONVERT(CHAR(10),  GETDATE() ,103)    
   ,      'HoraEmision'    = CONVERT(CHAR(10),  GETDATE() ,108)    
   ,      'Usuario'        = @BacUser    
   ,      'EstadoLinea'    = CASE WHEN lgen.Bloqueado        =  'S'            THEN 'Bloqueada'    
                                  WHEN lgen.FechaVencimiento <  @dFechaProceso THEN 'Vencida'    
                                  WHEN lgen.FechaVencimiento >= @dFechaProceso THEN 'Vigente'    
                                  ELSE                                              'No Definido'    
                             END    
   ,      'FechaVcto'      = CONVERT(CHAR(10), lsis.fechavencimiento,103)    
   ,      'Vcto'           = lsis.fechavencimiento     
   ,      'EstadoLineaSist'= CASE WHEN lsis.Bloqueado        =  'S'            THEN 'Bloqueada'    
                                  WHEN lsis.FechaVencimiento <  @dFechaProceso THEN 'Vencida'    
                                  WHEN lsis.FechaVencimiento >= @dFechaProceso THEN 'Vigente'    
                                  ELSE                                              'No Definido'    
                            END    
   ,   'THRESHOLD' = ISNULL (( select Monto_Linea_Threshold  
           from BacLineas..linea_General  
           where clie.clrut = Rut_Cliente and clie.clcodigo = Codigo_Cliente),0)  
           
   ,   'METODOLOGIA' =  ISNULL(Baclineas.dbo.FN_RIEFIN_METODO_LCR( clie.clrut, clie.clcodigo, clie.clrut, clie.clcodigo ),1)    
   ,   'DESC_METODOLOGIA' =(SELECT RecMtdDsc FROM TBL_METODOLOGIAREC   
   WHERE  RecMtdCod = ISNULL(Baclineas.dbo.FN_RIEFIN_METODO_LCR( clie.clrut, clie.clcodigo, clie.clrut, clie.clcodigo ),1))  
   INTO  #RetornoLineas    
   FROM  BacLineas.dbo.LINEA_GENERAL                      lgen    
         LEFT JOIN BacLineas.dbo.LINEA_SISTEMA            lsis ON lsis.rut_cliente = lgen.Rut_Cliente AND lsis.Codigo_Cliente  = lgen.Codigo_Cliente    
         LEFT JOIN BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO lpzo ON lpzo.Rut_Cliente = lsis.rut_cliente AND lpzo.Codigo_Cliente  = lsis.Codigo_Cliente AND lpzo.Id_Sistema = lsis.Id_Sistema    
         LEFT JOIN Bacparamsuda.dbo.CLIENTE               clie ON clie.clrut       = lgen.Rut_Cliente AND clie.clcodigo        = lgen.Codigo_Cliente    
         LEFT JOIN BacParamSuda.dbo.SISTEMA_CNT           sist ON sist.id_sistema  = lsis.Id_Sistema    
         LEFT JOIN BacParamSuda.dbo.INSTRUMENTO           inst ON inst.incodigo    = lpzo.incodigo    
         LEFT JOIN BacLineas.dbo.PRODUCTO_SISTEMA         prod ON prod.id_sistema  = lpzo.id_sistema  AND prod.Codigo_Producto = lpzo.Codigo_Producto    
         LEFT JOIN BacParamSuda.dbo.MONEDA                mone ON mone.mncodmon    = lgen.moneda    
   WHERE (lgen.rut_cliente     = @RutCliente OR @RutCliente     = 0)    
   AND   (lgen.codigo_cliente  = @CodCliente OR @CodCliente     = 0)    
   AND   (clie.cltipcli        = @TipoClinte OR @TipoClinte     = 0)    
   AND   (lgen.TotalDisponible > 0.0         OR lgen.TotalExceso > 0.0 OR lgen.TotalOcupado > 0.0 )    
   ORDER BY lpzo.id_sistema , lpzo.codigo_producto, lpzo.incodigo , lpzo.plazodesde , lpzo.Plazohasta    
    
   IF @Estado = 0 -- Totos    
   BEGIN    
      IF (SELECT COUNT(1) FROM #RetornoLineas) = 0    
      BEGIN    
         GOTO LlenaDatosBlanco       
      END ELSE    
      BEGIN    
         SELECT * FROM #RetornoLineas    
      END    
      RETURN    
   END    
    
   IF @Estado = 1 -- Vigentes    
   BEGIN    
      IF (SELECT COUNT(1) FROM #RetornoLineas , bactradersuda..MDAC WHERE Vcto >= acfecproc) = 0    
      BEGIN    
         GOTO LlenaDatosBlanco    
      END ELSE    
      BEGIN    
         SELECT * FROM #RetornoLineas , bactradersuda..MDAC WHERE Vcto >= acfecproc    
      END         
      RETURN    
   END    
    
   IF @Estado = 2 -- Bloqueadas    
   BEGIN    
      IF (SELECT COUNT(1) FROM #RetornoLineas WHERE Estado = 'S') = 0    
      BEGIN    
         GOTO LlenaDatosBlanco    
      END ELSE    
      BEGIN    
         SELECT * FROM #RetornoLineas WHERE Estado = 'S'    
      END    
      RETURN    
   END    
    
   IF @Estado = 3 -- Vencidas    
   BEGIN    
      IF (SELECT COUNT(1) FROM #RetornoLineas , bactradersuda..MDAC WHERE Vcto < acfecproc) = 0    
      BEGIN    
         GOTO LlenaDatosBlanco    
      END ELSE    
      BEGIN    
         SELECT * FROM #RetornoLineas , bactradersuda..MDAC WHERE Vcto < acfecproc    
      END    
      RETURN    
   END    
    
RETURN    
LlenaDatosBlanco:    
    
   SELECT 'Cliente'        = ' '    
   ,      'Rut'            = 0    
   ,      'Sistema'        = ' '    
   ,      'GloSistema'     = ' '    
   ,   'Instrumento'    = ' '    
   ,      'Producto'       = ' '    
   ,      'GloProducto'    = ' '    
   ,      'Plazo'          = convert(char(10),0) + ' - ' + convert(char(10),0)  
   ,      'Moneda'         = 0    
   ,      'GloMoneda'      = ' '    
   ,      'Gen_Asignado'   = 0.0    
   ,      'Gen_Ocupado'    = 0.0    
   ,      'Gen_Disponible' = 0.0    
   ,      'Gen_Exceso'     = 0.0    
   ,      'Sis_Asignado'   = 0.0    
   ,      'Sis_Ocupado'    = 0.0    
   ,      'Sis_Disponible' = 0.0    
   ,      'Sis_Exceso'     = 0.0    
   ,      'Pla_Asignado'  = 0.0    
   ,      'Pla_Ocupado'    = 0.0    
   ,      'Pla_Disponible' = 0.0    
   ,      'Pla_Exceso'     = 0.0    
   ,      'Estado'         = ' '    
   ,      'FechaProceso'   = CONVERT(CHAR(10),acfecproc,103)    
   ,      'FechaEmision'   = CONVERT(CHAR(10),GETDATE(),103)    
   ,      'HoraEmision'    = CONVERT(CHAR(10),GETDATE(),108)    
   ,      'Usuario'        = @BacUser    
   ,      'EstadoLinea'    = ' '    
,      'FechaVcto'      = '19000101'    
   ,      'Vcto'           = '19000101'    
   ,      'EstadoLineaSist'= ' '    
   ,   'THRESHOLD'    = 0.0  
   ,   'METODOLOGIA'    = 0.0  
   ,   'DESC_METODOLOGIA' =' '  
   FROM   bactradersuda..MDAC    
   SET NOCOUNT OFF  
END
GO
