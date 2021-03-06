USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Plataforma_Papeleta]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Plataforma_Papeleta]
                   (@numoper    NUMERIC(10),
                    @sistema    VARCHAR(30),
                    @fecha      DATETIME   = ''
                   )
            

AS 
BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET DATEFORMAT dmy
   SET NOCOUNT ON

   DECLARE @fechaProceso   DATETIME
   SET @fechaProceso =  ( SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES )


   CREATE TABLE #TEMPORAL2(
				[Nombre Sistema]	char(30)
			,	[Rut Cartera]		numeric(9)
			,	[Tipo Producto]		char(50)
			,	[NºOperación]		numeric(10)
			,	[Tipo Oper.]		char(05)
			,	[estado]		char(01)
			,	[Serie]			char(20)
			,	[RutCliente]		numeric(09)
			,	[CodigoCliente]		numeric(09)
			)

   /* RENTA FIJA */

  IF @sistema = 'RENTA FIJA' BEGIN

	  INSERT INTO #TEMPORAL2
   SELECT 'Nombre Sistema'  = CONVERT(CHAR(30),'RENTA FIJA')
      ,   'Rut Cartera'     = ISNULL(morutcart,0)
      ,   'Tipo Producto'   = ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'BTR' AND codigo_producto = motipoper),' ')
      ,   'NºOperación'     = ISNULL(monumoper,0)
      ,   'Tipo Oper.'      = CONVERT(CHAR(05),ISNULL(motipoper,' '))
      ,   'estado'          = mostatreg
      ,   'Serie'           = CONVERT(CHAR(20),moinstser)
      ,   'RutCliente'      = morutcli
      ,   'CodigoCliente'   = mocodcli
      
	   FROM MOVIMIENTO_TRADER WITH (NOLOCK)
  WHERE monumoper = @numoper 
    AND (mostatreg = '' OR mostatreg = 'A' OR mostatreg = 'V')
    AND mofecpro   =  @fecha
    AND motipoper <> 'TI' 
  END

   /* CAMBIO */
  IF @sistema = 'SPOT' BEGIN
      INSERT INTO #TEMPORAL2
      SELECT 
          'Nombre Sistema'  = 'SPOT'
      ,   'Rut Cartera'     = ISNULL(moentidad,0)
      ,   'Tipo Producto'   = ISNULL((CASE  motipmer WHEN 'EMPR' THEN 'EMPRESAS'
                                                     WHEN 'ARBI' THEN 'ARBITRAJES' 
                                                     WHEN 'PTAS' THEN 'PUNTAS'  
                                                     WHEN 'CANJ' THEN 'CANJES' 
                                                     WHEN 'SINT' THEN 'SINTETICOS'
                                                     WHEN 'TRAN' THEN 'TRANSFERENCIA'
                                                     WHEN 'OVER' THEN 'OVERNIGHT'
                                                     WHEN 'WEEK' THEN 'WEEKEND'
                                                     WHEN 'LIQU' THEN 'LIQUIDEZ'
                                                     END),'')

      ,   'NºOperación'     = ISNULL(monumope,0)
      ,   'Tipo Oper.'      = ISNULL(motipope,'')
      ,   'estado'          = moestatus
      ,   'Serie'           = ''
      ,   'RutCliente'      = morutcli
      ,   'CodigoCliente'   = mocodcli

    FROM VIEW_MOVIMIENTO_CAMBIO WHERE  monumope=@numoper 
                      and  ( moestatus = ' ' or moestatus = 'A' )
                      and  mofech    =  @fecha


      INSERT INTO #TEMPORAL2
      SELECT 
          'Nombre Sistema'  = 'SPOT'
      ,   'Rut Cartera'     = ISNULL(moentidad,0)
      ,   'Tipo Producto'   = 'OVERNIGHT'
      ,   'NºOperación'     = ISNULL(monumope,0)
      ,   'Tipo Oper.'      = ISNULL(motipope,'')
      ,   'estado'          = moestatus
      ,   'Serie'           = ''
      ,   'RutCliente'      = morutcli
      ,   'CodigoCliente'   = mocodcli

    FROM VIEW_MOVIMIENTO_CAMBIO WHERE  monumope=@numoper 
                      and  ( moestatus = ' ' or moestatus = 'A' )
                      and  Movaluta2    =  @fecha
                      and  motipmer	= 'OVER'	

   END

   /* FORWARD */   
  IF @sistema = 'FORWARD' BEGIN
   INSERT INTO #TEMPORAL2
   SELECT 'Nombre Sistema'  = 'FORWARD   '
      ,   'Rut Cartera'     = ISNULL(mocodcart,0)
      ,   'Tipo Producto'   = ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'BFW' AND codigo_producto = mocodpos1),'')
                            + CASE WHEN mocodpos1=4 AND 'COMEX'= (SELECT tipo_sintetico FROM VIEW_CARTERA_FORWARD_HISTORICA WHERE monumoper=canumoper and   ( caestado = ' ' or caestado = 'A') and   Fecha_Proceso  =  @fecha)
                                   THEN ' (COMEX)' 
                                   ELSE ''
                              END
      ,   'NºOperación'     = ISNULL(monumoper,0)
      ,   'Tipo Oper.'      = ISNULL(motipoper,'')
      ,   'estado'          = moestado
      ,   'Serie'           = ''
      ,   'RutCliente'      = mocodigo
      ,   'CodigoCliente'   = mocodcli

   FROM VIEW_MOVIMIENTO_FORWARD WHERE   monumoper=@numoper 
   and   ( moestado = ' ' or moestado = 'A' or moestado = 'M' )
   and   mofecha  =  @fecha	



 IF @fecha = @fechaProceso OR @fecha = '' BEGIN
   /* FUTURO */



   INSERT INTO #TEMPORAL2 
   SELECT 'Nombre Sistema'  = 'FORWARD   '
      ,   'Rut Cartera'     = ISNULL(cacodcart,0)
      ,   'Tipo Producto'   = LTRIM(RTRIM(ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'BFW' AND codigo_producto = cacodpos1),'')
                            )) + CASE WHEN tipo_sintetico = 'COMEX'
              THEN ' (COMEX)' 
                                   ELSE ''
       END
      ,   'NºOperación'     = ISNULL(canumoper,0)
      ,   'Tipo Oper.'      = ISNULL(catipoper,'')
      ,   'estado'          = caestado
      ,   'Serie'           = ''
      ,   'RutCliente'      = cacodigo
      ,   'CodigoCliente'   = cacodcli

   FROM VIEW_CARTERA_FORWARD
   WHERE   canumoper=@numoper and (caestado = ' ' or caestado = 'A' or caestado = 'M')




 END   
 ELSE BEGIN

   /* FUTURO */


   
   INSERT INTO #TEMPORAL2
   SELECT 'Nombre Sistema'  = 'FORWARD   '
      ,   'Rut Cartera'     = ISNULL(cacodcart,0)
      ,   'Tipo Producto'   = ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'BFW' AND codigo_producto = cacodpos1),'')
                            + CASE WHEN tipo_sintetico = 'COMEX'
                                   THEN ' (COMEX)' 
                                   ELSE ''
                              END
      ,   'NºOperación'     = ISNULL(canumoper,0)
      ,   'Tipo Oper.'      = ISNULL(catipoper,'')
      ,   'estado'          = caestado
      ,   'Serie'           = ''
      ,   'RutCliente'      = cacodigo
      ,   'CodigoCliente'   = cacodcli

   FROM VIEW_CARTERA_FORWARD_HISTORICA
   WHERE canumoper=@numoper and (caestado = ' ' or caestado = 'A' or caestado = 'M')
     AND ( fecha_proceso = @fecha OR cafecvcto = @fecha )


 END
  END

------------------------ FORWARD DE PAPELES---------------------------

  IF @sistema = 'FORWARD' BEGIN
   INSERT INTO #TEMPORAL2
   SELECT 'Nombre Sistema'  = 'FORWARD   '
      ,   'Rut Cartera'     = ISNULL(cartera_inversion,0)
      ,   'Tipo Producto'   = ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'BFW' AND codigo_producto = 7),'')
      ,   'NºOperación'     = ISNULL(numero_operacion,0)
      ,   'Tipo Oper.'      = ISNULL(tipo_operacion,'')
      ,   'estado'          = estado
      ,   'Serie'           = ''
      ,   'RutCliente'      = rut_cliente
      ,   'CodigoCliente'   = codigo_cliente

   FROM VIEW_MOVIMIENTO_FORWARD_PAPEL WHERE   numero_operacion=@numoper 
   and   ( estado = ' ' or estado = 'A' or estado = 'M' )
   and   fecha_operacion  =  @fecha	

  END

----------------------------------------------------------------------
   /* INVERSION EXTERIOR */

  IF @sistema = 'INVERSION EXTERIOR' BEGIN
   INSERT INTO #TEMPORAL2
   SELECT 'Nombre Sistema'  = 'INVERSION EXTERIOR'
      ,   'Rut Cartera'     = ISNULL(morutcart,0)
      ,   'Tipo Producto'   = ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'INV' AND codigo_producto = motipoper),'')
      ,   'NºOperación'     = ISNULL(monumoper,0)
      ,   'Tipo Oper.'      = ISNULL(motipoper,'') 
      ,   'estado'          = mostatreg
      ,   'Serie'           = cod_nemo
      ,   'RutCliente'      = morutcli
      ,   'CodigoCliente'   = mocodcli
    
   FROM VIEW_MOVIMIENTO_INVERSION_EXTERIOR WHERE  monumoper=@numoper 
   and  (mostatreg = '' or mostatreg = 'A')
   and  mofecpro  =  @fecha

  END

   /* SWAPS */
  IF @sistema = 'SWAPS' BEGIN

   INSERT INTO #TEMPORAL2
   SELECT 'Nombre Sistema'  = 'SWAPS'
      ,   'Rut Cartera'     = ISNULL(rut_entidad,0)
      ,   'Tipo Producto'   = ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'SWP' AND codigo_producto = tipo_swap),'')
      ,   'NºOperación'     = ISNULL(numero_operacion,0)
      ,   'Tipo Oper.'      = ISNULL(tipo_operacion,'') 
      ,   'estado'          = Estado_oper_lineas
      ,   'Serie'           = ''
      ,   'RutCliente'      = rut_cliente
      ,   'CodigoCliente'   = codigo_cliente
   FROM VIEW_CONTRATO, VIEW_DATOS_GENERALES
   WHERE  numero_operacion  = @numoper 
   AND  (Estado_oper_lineas IN ('', 'A'))
   AND  fecha_cierre        =  @fecha


   INSERT INTO #TEMPORAL2
   SELECT DISTINCT
	  'Nombre Sistema'  = 'SWAPS'
      ,   'Rut Cartera'     = ISNULL(rut_entidad,0)
      ,   'Tipo Producto'   = ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'SWP' AND codigo_producto = tipo_swap),'')
      ,   'NºOperación'     = ISNULL(A.numero_operacion,0)
      ,   'Tipo Oper.'      = ISNULL(tipo_operacion,'') 
      ,   'estado'          = Estado_oper_lineas
      ,   'Serie'           = ''
      ,   'RutCliente'      = rut_cliente
      ,   'CodigoCliente'   = codigo_cliente
   FROM  VIEW_CONTRATO A, VIEW_CONTRATO_FLUJO B, VIEW_DATOS_GENERALES
   WHERE A.numero_operacion = @numoper
   and A.numero_operacion   = B.numero_operacion
   and Estado_oper_lineas   = 'E'
   and estado_flujo = 2
   and fecha_vence_flujo    = @fecha

   INSERT INTO #TEMPORAL2
   SELECT DISTINCT
	  'Nombre Sistema'  = 'SWAPS'
      ,   'Rut Cartera'     = ISNULL(rut_entidad,0)
      ,   'Tipo Producto'   = ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'SWP' AND codigo_producto = A.tipo_swap),'')
      ,   'NºOperación'     = ISNULL(A.numero_operacion,0)
      ,   'Tipo Oper.'      = ISNULL(A.tipo_operacion,'') 
      ,   'estado'          = A.Estado_oper_lineas
      ,   'Serie'           = ''
      ,   'RutCliente'      = A.rut_cliente
      ,   'CodigoCliente'   = A.codigo_cliente
   FROM VIEW_CONTRATO A, VIEW_CONTRATO_LOG B, VIEW_DATOS_GENERALES
   WHERE fecha_modifica  >= @fecha
   AND A.numero_operacion = @numoper 


  END

/*
   INSERT INTO #TEMPORAL2
   SELECT 'Nombre Sistema'  = 'SWAPS'
      ,   'Rut Cartera'     = ISNULL(rut_entidad,0)
      ,   'Tipo Producto'   = ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'SWP' AND codigo_producto = tipo_swap),'')
      ,   'NºOperación'     = ISNULL(numero_operacion,0)
      ,   'Tipo Oper.'      = ISNULL(tipo_operacion,'') 
      ,   'estado'          = Estado_oper_lineas
      ,   'Serie'           = ''
      ,   'RutCliente'      = rut_cliente
      ,   'CodigoCliente'   = codigo_cliente
   FROM VIEW_CARTERA_SWAP_VENCIDA, VIEW_DATOS_GENERALES
   WHERE Estado = 'E'
   AND tipo_flujo = 1 
   AND fecha_modifica = @fecha
   AND numero_operacion=@numoper 
*/

   /* PASIVO */
  IF @sistema = 'PASIVO' BEGIN
   INSERT INTO #TEMPORAL2
   SELECT 'Nombre Sistema'  = 'PASIVO'
      ,   'Rut Cartera'     = ISNULL(M.entidad_cartera,0)
      ,   'Tipo Producto'   = P.codigo_producto
      ,   'NºOperación'     = ISNULL(M.numero_operacion,0)
      ,   'Tipo Oper.'      = ''
      ,   'estado'          = M.estado_operacion
      ,   'Serie'           = ''
      ,   'RutCliente'      = M.rut_cliente
      ,   'CodigoCliente'   = M.codigo_cliente
   FROM VIEW_MOVIMIENTO_PASIVO M
,	VIEW_INSTRUMENTO_PASIVO I
,	VIEW_PRODUCTO P
   WHERE  M.numero_operacion= @numoper 
   AND  (M.Estado_operacion IN ('', 'A'))
   AND	M.fecha_movimiento = @fecha
   AND  P.id_sistema = 'PSV' 
   AND  I.codigo_instrumento = M.codigo_instrumento
   AND	I.codigo_producto = P.codigo_producto

  End

    IF @sistema = 'RENTA FIJA' BEGIN

       UPDATE MOVIMIENTO_TRADER WITH (ROWLOCK)
		SET moimpreso = 'S' 
                 WHERE monumoper = @numoper

    END



    IF @sistema = 'SPOT' BEGIN

       UPDATE VIEW_MOVIMIENTO_CAMBIO WITH (ROWLOCK)
		SET moimpreso = 'S' 
                       WHERE monumope = @numoper

    END



    IF @sistema = 'FORWARD' BEGIN

       UPDATE VIEW_MOVIMIENTO_FORWARD WITH (ROWLOCK)
		       SET moimpreso = 'S' 
                       WHERE monumoper = @numoper

	IF (@fecha = @fechaProceso OR @fecha = '') BEGIN
        	UPDATE  VIEW_CARTERA_FORWARD WITH (ROWLOCK)
		SET marca = 'S'
  	        WHERE   canumoper=@numoper and (caestado = ' ' or caestado = 'A')
	END	
    ELSE BEGIN 
	       UPDATE  VIEW_CARTERA_FORWARD_HISTORICA WITH (ROWLOCK)
	       SET marca = 'S'
               WHERE  fecha_proceso = @fecha AND canumoper=@numoper and (caestado = ' ' or caestado = 'A')
	
   END

    END

    IF @sistema = 'INVERSION EXTERIOR' BEGIN

       UPDATE VIEW_MOVIMIENTO_INVERSION_EXTERIOR WITH (ROWLOCK)
		 SET impreso = 'S' 
                 WHERE monumoper = @numoper

    END

    IF @sistema = 'SWAPS' BEGIN

       UPDATE VIEW_CONTRATO WITH (ROWLOCK)
		 SET impreso = 'S' 
                 WHERE numero_operacion = @numoper

    END

 SET ROWCOUNT 1

    SELECT * FROM #TEMPORAL2 where [Nombre Sistema]=@sistema ORDER BY [Nombre Sistema],[NºOperación]

 SET ROWCOUNT 0

    SET NOCOUNT OFF


END

GO
