USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_inf_codigos_planillasAutomatica]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_inf_codigos_planillasAutomatica] --X  dbo.SP_inf_codigos_planillasAutomatica 'h','h'
            (   @USUARIO     VARCHAR(15) 
               ,@OPERADOR_X  CHAR(15)
            )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   DECLARE        @OPERADOR  VARCHAR(50)


   SELECT    @OPERADOR  = (SELECT nombre FROM VIEW_USUARIO WHERE @OPERADOR_X  = usuario)

   DECLARE @Fecha_proceso      CHAR(10)
   DECLARE @Fecha_proxima      CHAR(10)
   DECLARE @uf_hoy         FLOAT   
   DECLARE @uf_man         FLOAT   
   DECLARE @ivp_hoy        FLOAT   
   DECLARE @ivp_man        FLOAT   
   DECLARE @do_hoy         FLOAT   
   DECLARE @do_man         FLOAT   
   DECLARE @da_hoy         FLOAT   
   DECLARE @da_man         FLOAT   
   DECLARE @acnomprop      CHAR(40)
   DECLARE @rut_empresa    CHAR(12)
   DECLARE @hora           CHAR(8) 
   DECLARE @fecha_busqueda DATETIME
   DECLARE @SISTEMA        VARCHAR(50)
   DECLARE @TITULO         VARCHAR(100)

   SELECT @SISTEMA = @USUARIO + ' /BAC-CAMBIO'
   SELECT @TITULO = 'PRODUCTOS V/S CODIGOS DE COMERCIO' 

   EXECUTE Sp_Base_Del_Informe     
           @Fecha_proceso      OUTPUT ,
           @Fecha_proxima      OUTPUT ,
           @uf_hoy         OUTPUT ,
           @uf_man         OUTPUT ,
           @ivp_hoy        OUTPUT ,
           @ivp_man        OUTPUT ,
           @do_hoy         OUTPUT ,
           @do_man         OUTPUT ,
           @da_hoy         OUTPUT ,
           @da_man         OUTPUT ,
           @acnomprop      OUTPUT ,
           @rut_empresa    OUTPUT ,
           @hora           OUTPUT ,
           @fecha_busqueda 

    SELECT 'Fecha Proc'       = @Fecha_proceso
    ,      'Fecha Prox'       = @Fecha_proxima
    ,      'UF Hoy'           = @uf_hoy
    ,      'UF Mañana'        = @uf_man
    ,      'IVP Hoy'          = @ivp_hoy
    ,      'IVP Mañana'       = @ivp_man
    ,      'DolObs Hoy'       = @do_hoy
    ,      'DolObs Mañana'    = @do_man
    ,      'DolCie Hoy'       = @da_hoy
    ,      'DolCie Mañana'    = @da_man
    ,      'Nombre Empresa'   = @acnomprop
    ,      'Rut Empresa'      = @rut_empresa
    ,      'Hora'             = @hora
    ,      'Titulo'           = @TITULO
    ,      'SISTEMA'          = @SISTEMA
    ,      'username'         = @OPERADOR_X
    INTO    #BASE




SELECT 
	        'Codigo Comercio1'	=a.comercio
	,	'Desc_cod_com1'		=b.glosa
	,	'Desc_Prod1'		=c.descripcion
	,	'Desc_tip_cli1'		=d.Descripcion
	,	'Desc_tip_op1'		=CASE WHEN a.tipo_operacion ='V' THEN 'VENTA' ELSE 'COMPRA' END
	,	'Desc_glosa_mon1'	=e.mnglosa 
	,	'vencimiento1'		=vencimiento_fisico 
	,	'nacionalidad1'		= case WHEN nacionalidad=1 then 'NACIONAL' else 'EXTRANJERO' end
	,	'Sistema_origen'		= s.nombre_sistema
INTO   #DEFAULT
FROM CODIGO_PLANILLA_AUTOMATICA a
,CODIGO_COMERCIO b
,producto c
,TIPO_CLIENTE d
,MONEDA e
,SISTEMA s
WHERE 
a.comercio=b.comercio
and a.codigo_producto=c.codigo_producto
and a.tipo_cliente=d.Codigo_tipo_cliente
and a.codigo_moneda=e.mncodmon
and a.id_sistema = s.id_sistema
order by a.COMERCIO,'Desc_Prod1','Desc_tip_cli','Desc_tip_op1',Desc_glosa_mon1,'vencimiento',nacionalidad

 SELECT * FROM #DEFAULT,#BASE


end
--SELECT * FROM CODIGO_COMERCIO
--SELECT * FROM CODIGO_PLANILLA_AUTOMATICA
--SELECT * FROM MONEDA
--select * from producto
--SELECT * FROM TIPO_CLIENTE
--select * from VIEW_USUARIO
--select * from sistema

--SP_inf_codigos_planillasAutomatica '',''


GO
