USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_Encabezado_Reportes]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_Encabezado_Reportes]
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

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

   EXECUTE Sp_Base_Del_Informe     
           @Fecha_proceso      	OUTPUT ,
           @Fecha_proxima      	OUTPUT ,
           @uf_hoy         	OUTPUT ,
           @uf_man         	OUTPUT ,
           @ivp_hoy        	OUTPUT ,
           @ivp_man        	OUTPUT ,
           @do_hoy         	OUTPUT ,
           @do_man         	OUTPUT ,
           @da_hoy         	OUTPUT ,
           @da_man         	OUTPUT ,
           @acnomprop      	OUTPUT ,
           @rut_empresa    	OUTPUT ,
           @hora           	OUTPUT ,
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
    ,      'fecha_emision'    = CONVERT(CHAR(10),GETDATE(),103)
    ,      'sistema'          = ' / PARAMETROS'
    
SET NOCOUNT OFF
END                                                                                                                                                                                                                                                  





GO
