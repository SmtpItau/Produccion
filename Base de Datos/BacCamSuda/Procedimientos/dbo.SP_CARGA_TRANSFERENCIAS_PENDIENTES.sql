USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_TRANSFERENCIAS_PENDIENTES]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_TRANSFERENCIAS_PENDIENTES] 
      (   
          @FECHAFILTRO   DATETIME
         ,@SW            NUMERIC(1)
      )
AS
BEGIN
IF @SW = 1 --GRILLA
BEGIN
    SELECT  
       fecha_operacion             
      ,fecha_vencimiento           
      ,'id_sistema'           = ( SELECT DISTINCT nombre_sistema FROM VIEW_SISTEMAS_CNT S, TRANSFERENCIA_PENDIENTE T WHERE S.id_sistema = T.id_sistema )
      ,codigo_producto        --= ( SELECT ( CASE codigo_producto WHEN 'ARBI' THEN 'ARBITRAJE' )
      ,tipo_mercado 
      ,numero_operacion 
      ,'codigo_moneda'        = ( SELECT DISTINCT mnnemo FROM VIEW_MONEDA WHERE TRANSFERENCIA_PENDIENTE.codigo_moneda = mncodmon )
      ,'tipo_operacion'       = ( CASE tipo_operacion WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END)
      ,monto_original        
      ,monto_dolares         
      ,monto_pesos           
      ,tipo_cambio  
      ,paridad
      ,'rut_cliente'          = ( SELECT DISTINCT ISNULL(clnombre,'') FROM VIEW_CLIENTE WHERE clrut = TRANSFERENCIA_PENDIENTE.rut_cliente )
      ,'codigo_pais'          = ( SELECT DISTINCT ISNULL(nombre,'') FROM VIEW_PAIS WHERE codigo_pais =  TRANSFERENCIA_PENDIENTE.codigo_pais )
      ,'codigo_plaza'         = ( SELECT DISTINCT ISNULL(glosa,'')  FROM VIEW_PLAZA WHERE codigo_plaza = TRANSFERENCIA_PENDIENTE.codigo_plaza AND codigo_pais = TRANSFERENCIA_PENDIENTE.codigo_pais )
      ,codigo_swift         --= ( SELECT DISTINCT  from VIEW_CORRESPONSAL  ) 
      ,'forma_pago'           = ( SELECT DISTINCT ISNULL(glosa,'') FROM VIEW_FORMA_DE_PAGO WHERE codigo = TRANSFERENCIA_PENDIENTE.forma_pago )
      ,'Estado_transferencia' = ( CASE Estado_transferencia 
                                           WHEN 'P' THEN 'PENDIENTE' 
                                           WHEN 'A' THEN 'ANULADA' 
                                           WHEN 'V' THEN 'VENCIMIENTO' 
                                           END )
     ,'Corresponsal'         =  ( SELECT DISTINCT nombre FROM VIEW_CORRESPONSAL  WHERE codigo_swift = TRANSFERENCIA_PENDIENTE.codigo_swift )
     ,'FECHA_PORC'           =  ( SELECT acfecpro FROM MEAC )  
    INTO #TEMPORAL
    FROM  TRANSFERENCIA_PENDIENTE 
   WHERE fecha_vencimiento   >=   @FECHAFILTRO
   SELECT 
       'Fecha_Operacion' = fecha_operacion             
      ,'Fecha_Vencimiento' = fecha_vencimiento           
      ,'Id_Sistema'  = id_sistema
      ,'Codigo_Producto' = codigo_producto
      ,'Tipo_Mercado'  = tipo_mercado 
      ,'Numero_Operacion' = numero_operacion 
      ,'Codigo_Moneda'  = ISNULL(codigo_moneda, 0)
      ,'Tipo_Operacion'  = ISNULL(tipo_operacion,'')
      ,'Monto_Original'  = monto_original        
      ,'Monto_Dolares'  = monto_dolares         
      ,'Monto_Pesos'  = monto_pesos           
      ,'Tipo_Cambio'  = tipo_cambio
      ,'Paridad'  = paridad
      ,'Rut_Cliente'  = ISNULL(rut_cliente,0)
      ,'Codigo_Pais'  = ISNULL(codigo_pais,'')
      ,'Codigo_Plaza'  = ISNULL(codigo_plaza,'')
      ,'Codigo_Swift'  = codigo_swift
      ,'Forma_Pago'  = ISNULL(forma_pago,'')
      ,'Estado_Transferencia' = Estado_transferencia 
      ,'Corresponsal'  = ISNULL(corresponsal,'')
      ,'Fecha_Proceso'  = (SELECT acfecpro FROM MEAC)
 FROM #TEMPORAL
END 
IF @SW =2 --INFORME VCTO FUTUROS
BEGIN
    SELECT  
       fecha_operacion             
      ,fecha_vencimiento           
      ,'id_sistema'           = ( SELECT DISTINCT nombre_sistema FROM VIEW_SISTEMAS_CNT S, TRANSFERENCIA_PENDIENTE T WHERE S.id_sistema = T.id_sistema )
      ,codigo_producto        --= ( SELECT ( CASE codigo_producto WHEN 'ARBI' THEN 'ARBITRAJE' )
      ,tipo_mercado 
      ,numero_operacion 
      ,'codigo_moneda'        = ( SELECT mnnemo FROM VIEW_MONEDA WHERE codigo_moneda = mncodmon )
      ,'tipo_operacion'       = ( SELECT ( CASE tipo_operacion WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END    ))
      ,monto_original        
      ,monto_dolares         
      ,monto_pesos           
      ,tipo_cambio  
      ,paridad
      ,'rut_cliente'          = ( SELECT clnombre FROM VIEW_CLIENTE WHERE rut_cliente = clrut )
      ,'codigo_pais'          = ( SELECT DISTINCT nombre from VIEW_PAIS P, TRANSFERENCIA_PENDIENTE T  WHERE P.codigo_pais = T.codigo_pais )
      ,'codigo_plaza'         = ( SELECT DISTINCT glosa    FROM VIEW_PLAZA P, TRANSFERENCIA_PENDIENTE T WHERE P.codigo_plaza = T.codigo_plaza AND P.codigo_pais = T.codigo_pais )
      ,codigo_swift         --= ( SELECT DISTINCT  from VIEW_CORRESPONSAL  ) 
      ,'forma_pago'           = ( SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE forma_pago = CODIGO )
      ,'Estado_transferencia' = ( SELECT ( CASE Estado_transferencia 
                                           WHEN 'P' THEN 'PENDIENTE' 
                                           WHEN 'A' THEN 'ANULADA' 
                                           WHEN 'V' THEN 'VENCIMIENTO' 
                                           END ))
     ,'Corresponsal'         =  ( SELECT DISTINCT NOMBRE FROM VIEW_CORRESPONSAL C , TRANSFERENCIA_PENDIENTE T WHERE C.codigo_swift  = T.codigo_swift )
     ,'FECHA PORC'           =  ( SELECT acfecpro FROM MEAC )  
    FROM  TRANSFERENCIA_PENDIENTE 
   WHERE fecha_vencimiento   <=   @FECHAFILTRO
--    AND  fecha_operacion      
END
IF @SW = 3 --INFORME VCTO DEL DIA
BEGIN
    SELECT  
          fecha_operacion             
         ,fecha_vencimiento           
         ,'id_sistema'           = ( SELECT DISTINCT nombre_sistema FROM VIEW_SISTEMAS_CNT S, TRANSFERENCIA_PENDIENTE T WHERE S.id_sistema = T.id_sistema )
         ,codigo_producto        --= ( SELECT ( CASE codigo_producto WHEN 'ARBI' THEN 'ARBITRAJE' )
         ,tipo_mercado 
         ,numero_operacion 
         ,'codigo_moneda'        = ( SELECT mnnemo FROM VIEW_MONEDA WHERE codigo_moneda = mncodmon )
         ,'tipo_operacion'       = ( SELECT ( CASE tipo_operacion WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END    ))
         ,monto_original        
         ,monto_dolares         
         ,monto_pesos           
         ,tipo_cambio  
         ,paridad
         ,'rut_cliente'          = ( SELECT clnombre FROM VIEW_CLIENTE WHERE rut_cliente = clrut )
         ,'codigo_pais'          = ( SELECT DISTINCT nombre from VIEW_PAIS P, TRANSFERENCIA_PENDIENTE T  WHERE P.codigo_pais = T.codigo_pais )
         ,'codigo_plaza'         = ( SELECT DISTINCT glosa    FROM VIEW_PLAZA P, TRANSFERENCIA_PENDIENTE T WHERE P.codigo_plaza = T.codigo_plaza AND P.codigo_pais = T.codigo_pais )
         ,codigo_swift         --= ( SELECT DISTINCT  from VIEW_CORRESPONSAL  ) 
         ,'forma_pago'           = ( SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE forma_pago = CODIGO )
         ,'Estado_transferencia' = ( SELECT ( CASE Estado_transferencia 
                                              WHEN 'P' THEN 'PENDIENTE' 
                                              WHEN 'A' THEN 'ANULADA' 
                                              WHEN 'V' THEN 'VENCIMIENTO' 
                                              END ))
        ,'Corresponsal'         =  ( SELECT DISTINCT NOMBRE FROM VIEW_CORRESPONSAL C , TRANSFERENCIA_PENDIENTE T WHERE C.codigo_swift  = T.codigo_swift )
        ,'FECHA PORC'           =  ( SELECT acfecpro FROM MEAC )  
    FROM  TRANSFERENCIA_PENDIENTE 
   WHERE fecha_vencimiento   =   ( SELECT acfecpro FROM MEAC )
END
END




GO
