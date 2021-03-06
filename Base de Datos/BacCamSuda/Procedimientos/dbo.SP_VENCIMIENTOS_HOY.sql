USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VENCIMIENTOS_HOY]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_VENCIMIENTOS_HOY]
     
AS
BEGIN
   DECLARE  @acfecproc     CHAR(10)
           ,@acfecprox     CHAR(10)
           ,@uf_hoy        FLOAT
           ,@uf_man        FLOAT
           ,@ivp_hoy       FLOAT
           ,@ivp_man       FLOAT
           ,@do_hoy        FLOAT
           ,@do_man        FLOAT
           ,@da_hoy        FLOAT
           ,@da_man        FLOAT
           ,@acnomprop     CHAR(40)
           ,@rut_empresa   CHAR(12)
           ,@hora          CHAR(8)
           ,@OMA           CHAR(3)
           ,@Fecha_Proceso DATETIME           
   EXECUTE Sp_Base_Del_Informe   @acfecproc   OUTPUT
          			,@acfecprox   OUTPUT
          			,@uf_hoy      OUTPUT
          			,@uf_man      OUTPUT
         			,@ivp_hoy     OUTPUT
          			,@ivp_man     OUTPUT
			        ,@do_hoy      OUTPUT
				,@do_man      OUTPUT
			        ,@da_hoy      OUTPUT
			        ,@da_man      OUTPUT
			        ,@acnomprop   OUTPUT
			        ,@rut_empresa OUTPUT
			        ,@hora        OUTPUT
			        ,@OMA         OUTPUT
   SET NOCOUNT ON
   SELECT @Fecha_Proceso = acfecpro FROM meac

   SELECT  'Nombre_Cliente' = ISNULL(clnombre,'CLIENTE NO EXISTE')
          ,'Moneda'         = mocodmon  
          ,'Moneda_Cnv'     = mocodcnv 
          ,'Monto_Mx'       = momonmo 
          ,'Monto_USD'      = moussme 
          ,'Tipo_Cambio'    = moticam 
          ,'Paridad'        = moparme 
          ,'Monto_Pesos'    = momonpe 
          ,'Recibimos'      = ISNULL(a.glosa,'FORMA PAGO NO EXISTE')
          ,'Entregamos'     = ISNULL(b.glosa,'FORMA PAGO NO EXISTE')
          ,'Fecha_Valor'    = CONVERT(CHAR(10),mofech,103)
          ,'Tipo_Moneda'    = CASE WHEN mocodcnv = 'CLP' THEN 'L' ELSE 'X' END
          ,'Tipo_Operacion' = CASE WHEN motipope = 'C' THEN 'COMPRA' ELSE 'VENTA' END
          ,'Tipo_Mercado'   = CASE WHEN motipmer = 'EMPR' THEN 'EMPRESAS' ELSE 'PUNTAS' END
          ,'fecha_SERV'     = CONVERT( CHAR(10) , GETDATE(), 103)
          ,'acfecproc'      = CONVERT(CHAR(10),@acfecproc,103)
          ,'acfecprox'      = CONVERT(CHAR(10),@acfecprox,103)
          ,'uf_hoy'         = @uf_hoy
          ,'uf_man'         = @uf_man
          ,'ivp_hoy'        = @ivp_hoy
          ,'ivp_man'        = @ivp_man
          ,'do_hoy'         = @do_hoy
          ,'do_man'         = @do_man
          ,'da_hoy'         = @da_hoy
          ,'da_man'         = @da_man
          ,'pmnomprop'      = @acnomprop
          ,'rut_empresa'    = @rut_empresa
          ,'hora'           = CONVERT( CHAR(10) , GETDATE(), 108)
          ,'operador'       = mooper
          ,'numope'         = monumope    
   FROM memoh LEFT OUTER JOIN view_forma_de_pago a ON morecib = a.codigo      
          LEFT OUTER JOIN view_forma_de_pago b ON moentre = b.codigo
          ,view_cliente
   WHERE  morutcli  = clrut            AND
          cltipcli IN (1,2,3,4)        AND
          motipmer IN ('EMPR','PTAS')  AND
          moestatus <> 'A'             AND
         (@Fecha_Proceso = movaluta1 OR @Fecha_Proceso = movaluta2)
   ORDER BY motipope,clnombre

 
/* REQ.7619 CASS 07-01-2011
   FROM    memoh   
          ,view_forma_de_pago a 
          ,view_forma_de_pago b 
          ,view_cliente
   WHERE  morutcli  = clrut            AND
          cltipcli IN (1,2,3,4)        AND
          motipmer IN ('EMPR','PTAS')  AND
          moestatus <> 'A'             AND
          morecib  *= a.codigo         AND
          moentre  *= b.codigo         AND
         (@Fecha_Proceso = movaluta1 OR @Fecha_Proceso = movaluta2)
   ORDER BY motipope
           ,clnombre
*/

   SET NOCOUNT OFF
END



GO
