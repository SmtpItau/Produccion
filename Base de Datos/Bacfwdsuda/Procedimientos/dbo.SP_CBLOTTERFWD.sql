USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CBLOTTERFWD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CBLOTTERFWD] (
     @Fecha_Proceso  CHAR(08)
    )
AS
BEGIN
--SET NOCOUNT ON
SELECT
  'Numero_Operacion'   = canumoper                                                         ,
  'Tipo_Operacion'     = (CASE catipoper WHEN 'C' THEN 'Compra'
          WHEN 'V' THEN 'Venta'
          ELSE '--'
          END)                                              ,
  'Operacion'         = (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = 50 and CONVERT(NUMERIC (5),tbcodigo1) = cacodpos1),
  'Cliente'            = a.clnombre                                                        ,
  'Monto_MX'           = camtomon1,
  'Monto_USD'          = ( CASE cacodpos1 WHEN 1 THEN camtomon1 WHEN 2 THEN camtomon2 WHEN 3 THEN camtomon1 * b.vmvalor ELSE 0 END),
  'Monto_Pesos'        = ( CASE WHEN cacodpos1 <> 2 THEN caequmon2 ELSE camtomon2 * b.vmvalor END ),
  'TC_Paridad'         = ( CASE cacodmon1 WHEN 13 THEN catipcam  ELSE (CASE cacodmon2 WHEN 13  THEN caparmon2
                         WHEN 999 THEN capremon2  END)
                                    END)                                        ,
  'Fecha_Vencimiento'  = Convert(Char(10),cafecvcto,103)                                   , 
  'Tipo_Entrega'      = (CASE catipmoda WHEN 'E' THEN 'Entrega Fisica'
          WHEN 'C' THEN 'Compensaci¢n' ELSE '--' END)                                              ,
  'Estado'              = CASE caestado  WHEN 'A' THEN 'ANULADA' 
                                            WHEN ' ' THEN 'Vigente' 
         WHEN 'M' THEN 'Vgte-Modif'   -- Solicitado x DELOITTE
         WHEN 'M' THEN 'Modificada' 
                                            ELSE ' ' END              ,
  'Hora'    = Convert(Char(10),getdate(),108)                                 ,  
  'FechaProc'   = Convert(Char(10),c.acfecprox,103)                                  
  FROM   MFCA  ,
  VIEW_CLIENTE a,
  VIEW_VALOR_MONEDA b,
  MFAC    c
 WHERE cacodigo       = a.clrut  
   AND cacodcli       = a.clcodigo
   AND CONVERT(CHAR(08),@Fecha_Proceso,112) = CONVERT(CHAR(08),cafecha,112)
   AND b.vmcodigo     = 994
   AND CONVERT(CHAR(08),b.vmfecha,112) = CONVERT(CHAR(08),cafecha,112)
UNION
SELECT 
  'Numero_Operacion'   = canumoper                                                         ,
  'Tipo_Operacion'     = (CASE catipoper WHEN 'C' THEN 'Compra'
          WHEN 'V' THEN 'Venta'
          ELSE '--'
          END)                                              ,
  'Operacion'          = (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = 50 and CONVERT(NUMERIC (5),tbcodigo1) = cacodpos1),
  'Cliente'             = a.clnombre                                                        ,
  'Monto_MX'           = camtomon1,
  'Monto_USD'  = ( CASE cacodpos1 WHEN 1 THEN camtomon1 WHEN 2 THEN camtomon2 WHEN 3 THEN camtomon1 * b.vmvalor ELSE 0 END),
  'Monto_Pesos'  = ( CASE WHEN cacodpos1 <> 2 THEN caequmon2 ELSE camtomon2 * b.vmvalor END ),
  'TC_Paridad'  = (CASE cacodmon1 WHEN 13 THEN catipcam 
                  ELSE (CASE cacodmon2 WHEN 13  THEN caparmon2
                         WHEN 999 THEN capremon2
                                               END)
                                                   END)                                        ,
  'Fecha_Vencimiento' = Convert(Char(10),cafecvcto,103)                                   , 
  'Tipo_Entrega'  = (CASE catipmoda WHEN 'E' THEN 'Entrega Física'
          WHEN 'C' THEN 'Compensación'
          ELSE '--'
          END)                                              ,
  'Estado'  = 'Anulada'       ,
  'Hora'    = Convert(Char(10),getdate(),108)                                 , 
  'FechaProc'   = Convert(Char(10),c.acfecprox,103)                                  
 FROM  MFCA_LOG  ,
  VIEW_CLIENTE a,
  VIEW_VALOR_MONEDA b,
  MFAC     c
 WHERE  cacodigo       = a.clrut  
 AND cacodcli       = a.clcodigo
 AND CONVERT(CHAR(08),@Fecha_Proceso,112) = CONVERT(CHAR(08),cafecha,112)
 AND caestado       <> 'M'
 AND b.vmcodigo     = 994
 AND CONVERT(CHAR(08),b.vmfecha,112)      = CONVERT(CHAR(08),cafecha,112)
  SET NOCOUNT OFF
END

GO
