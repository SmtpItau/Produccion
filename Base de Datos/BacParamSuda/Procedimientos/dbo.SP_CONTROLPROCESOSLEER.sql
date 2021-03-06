USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROLPROCESOSLEER]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTROLPROCESOSLEER]
  ( @id_sistema CHAR(3)
  )
AS 
BEGIN
  SET NOCOUNT OFF
 IF @id_sistema = 'BTR'   --TRADER
 BEGIN
  SELECT  'INICIO DE DIA'     = ACsw_pd + '-INICIO DE DIA'  ,
   'RECOMPRAS'         = ACsw_rc + '-RECOMPRAS'   ,
   'REVENTAS'          = ACsw_rv + '-REVENTAS'       ,
   'CONTABILIDAD'     = ACsw_co + '-CONTABILIDAD'   ,--ANTIGUAMENTE CORTES
   'DEVENGAMIENTO'     = ACsw_dv + '-DEVENGAMIENTO'  , 
   --'CIERRE DE MESA'  = ACsw_cm + '-CIERRE DE MESA' ,
          --'DESCONOCIDO-A'   = ACsw_ptw +'-DESCONOCIDO-A'  ,  
   --'DESCONOCIDO-B'   = ACsw_trd +'-DESCONOCIDO-B'  ,
   --'DESCONOCIDO-C'   = ACsw_btw +'-DESCONOCIDO-C'  , 
   --'BLOQUEO DE OPERACIONES'    = ACsw_mesa +'-BLOQUEO DE OPERACIONES'  , -- bloquear operaciones
   --'PROCEDIMIENTO A COMENZADO' = ACsw_pc + '-PROCEDIMIENTO A COMENZADO', --proc. a comenzado
   'MARK TO MARKET'           = ACsw_mm + '-MARK TO MARKET'  ,          --mark to market
    'FIN DE DIA'                = ACsw_fd + '-FIN DE DIA'     ,
          'FIN DE MES'                = ACsw_finmes + '-FIN DE MES'  
   FROM VIEW_MDAC
 END
 IF @id_sistema = 'BCC'
 BEGIN
  SELECT 'INICIO DE DIA'                 = SUBSTRING(aclogdig,1,1) + '-INICIO DE DIA',
         'PARAMETROS FINANCIEROS'        = SUBSTRING(aclogdig,2,1) + '-PARAMETROS FINANCIEROS',
                       'PARIDADES DIARIAS'             = SUBSTRING(aclogdig,3,1) + '-PARIDADES DIARIAS',
                       'POSICIONES INICIALES'          = SUBSTRING(aclogdig,4,1) + '-POSICIONES INICIALES',
                       'PARIDADES MENSUALES  DEL BCCH' = SUBSTRING(aclogdig,5,1) + '-PARIDADES MENSUALES DEL BCCH',
         'CONTROL OPER ???'              = SUBSTRING(aclogdig,6,1) + '-CONTROL OPER ???',
                       'CONTROL OPER ???'              = SUBSTRING(aclogdig,7,1) + '-CONTROL OPER ???',--al parecer es pre cierre de mesa
                --'PRE-CIERRE MESA'               = SUBSTRING(aclogdig,8,1) + 'CIERRE MESA',
                       'FIN DE DIA'                    = SUBSTRING(aclogdig,9,1) + ' FIN DE DIA'
   FROM VIEW_MEAC
 END
 IF @id_sistema = 'BFW'
 BEGIN
  SELECT  'INICIO DE DIA'   = acsw_pd       + '-INICIO DE DIA' ,
   --'CIERRE DE MESA'  = acsw_ciemefwd + '-CIERRE DE MESA' ,
          'CONTABILIDAD'    = acsw_contafwd + '-CONTABILIDAD' ,
   'DEVENGAMIENTO'   = acsw_devenfwd + '-DEVENGAMIENTO' , 
    'FIN DE DIA'      = acsw_fd       + '-FIN DE DIA'      
   FROM VIEW_MFAC
 END
END
GO
