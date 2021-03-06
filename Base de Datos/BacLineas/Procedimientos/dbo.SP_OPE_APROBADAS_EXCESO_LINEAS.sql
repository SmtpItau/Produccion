USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPE_APROBADAS_EXCESO_LINEAS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_OPE_APROBADAS_EXCESO_LINEAS]
	(
		@nfechaVcto CHAR(08)
	)
  						   	
AS BEGIN
   SET NOCOUNT ON

select  a.NumeroOperacion
      , a.id_sistema
      ,'TipoOperación'= case when c.id_sistema ='PCS' and c.Codigo_Producto=1  THEN  (select descripcion from bacparamsuda..PRODUCTO b where b.id_sistema = c.id_sistema and b.codigo_producto ='ST')
			     when c.id_sistema ='PCS' and c.Codigo_Producto=2  THEN  (select descripcion from bacparamsuda..PRODUCTO b where b.id_sistema = c.id_sistema and b.codigo_producto ='SM')	
			     when c.id_sistema ='PCS' and c.Codigo_Producto=2  THEN  (select descripcion from bacparamsuda..PRODUCTO b where b.id_sistema = c.id_sistema and b.codigo_producto ='FR')	
			ELSE (select descripcion from bacparamsuda..PRODUCTO b where b.id_sistema = c.id_sistema and b.codigo_producto =c.Codigo_Producto) END 
      ,c.MontoExceso	
      ,a.Operador_Ap_Limites	
      ,a.Operador_Ap_Lineas
      ,'MensajeError' = c.Mensaje_Error
      ,a.FechaOperacion  
      ,d.Monto_Operacion
      ,'Entidad' = (select rcnombre  from  view_entidad)
      ,'Fecha_Proc'=(select acfecproc  from  view_mdac)
      ,'Grupo'	= case when (substring(c.Mensaje_Error,1,14) ='Limite Sistema'	OR substring(c.Mensaje_Error,1,14) ='Limite General' or 
		       substring(c.Mensaje_Error,1,13) ='Linea Sistema'	OR substring(c.Mensaje_Error,1,13) ='Linea General')  then 'Lineas'  	
		       when (substring(c.Mensaje_Error,1,5) ='No se'  OR substring(c.Mensaje_Error,1,5) ='La Ta') then 	'Tasas'
		       else 'Plazos' end	
from  APROBACION_OPERACIONES a   	
     ,linea_transaccion_detalle c  
     ,DETALLE_APROBACIONES d  

where  a.NumeroOperacion = c.NumeroOperacion and       		
       c.NumeroOperacion = d.Numero_Operacion and
       a.estado ='A'  and
       c.Error   = 'S' and 
       a.FechaOperacion = @nfechaVcto

   SET NOCOUNT OFF
END
GO
