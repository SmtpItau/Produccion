USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROLPROCESOSGRABAR]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROLPROCESOSGRABAR]
 ( @id_sistema  CHAR(3),
         @sw_procesos            CHAR(50)
 )
AS
BEGIN
 IF @id_sistema = 'BCC'
 BEGIN
    DECLARE @sw_procesos_aux CHAR(50)
           SELECT @sw_procesos_aux = @sw_procesos
    SELECT @sw_procesos_aux = @sw_procesos_aux + SUBSTRING(@sw_procesos,1,1)
PRINT @sw_procesos_aux 
    SELECT @sw_procesos_aux = @sw_procesos_aux + SUBSTRING(@sw_procesos,2,1)
PRINT @sw_procesos_aux 
    SELECT @sw_procesos_aux = @sw_procesos_aux + SUBSTRING(@sw_procesos,3,1)
PRINT @sw_procesos_aux 
    SELECT @sw_procesos_aux = @sw_procesos_aux + SUBSTRING(@sw_procesos,4,1)
PRINT @sw_procesos_aux 
    SELECT @sw_procesos_aux = @sw_procesos_aux + SUBSTRING(@sw_procesos,5,1)
PRINT @sw_procesos_aux 
    SELECT @sw_procesos_aux = @sw_procesos_aux + SUBSTRING(@sw_procesos,6,1)
PRINT @sw_procesos_aux 
    SELECT @sw_procesos_aux = @sw_procesos_aux + SUBSTRING(@sw_procesos,7,1)
PRINT @sw_procesos_aux 
    SELECT @sw_procesos_aux = @sw_procesos_aux + SUBSTRING((SELECT aclogdig FROM VIEW_MEAC ),8,1)
PRINT @sw_procesos_aux 
    SELECT @sw_procesos_aux = @sw_procesos_aux + SUBSTRING(@sw_procesos,9,1)
PRINT @sw_procesos_aux 
           UPDATE VIEW_MEAC SET  aclogdig = @sw_procesos_aux
        
 END
 IF @id_sistema = 'BTR'
 BEGIN
  UPDATE MDAC SET
   ACsw_pd  =    SUBSTRING (@sw_procesos,1,1),   --INICIO DE DIA
   ACsw_rc =     SUBSTRING (@sw_procesos,2,1),   --RECOMPRAS 
   ACsw_rv =     SUBSTRING (@sw_procesos,3,1),   --REVENTAS       
          ACsw_co =     SUBSTRING (@sw_procesos,4,1),   --CORTES         
   ACsw_dv =     SUBSTRING (@sw_procesos,5,1),   --DEVENGAMIENTO   
   --ACsw_cm =     SUBSTRING (@sw_procesos,6,1),   --CIERRE DE MESA 
          --ACsw_ptw =    SUBSTRING (@sw_procesos,6,1),   --DESCONOCIDO-A    
   --ACsw_trd =    SUBSTRING (@sw_procesos,7,1),   --DESCONOCIDO-B  
   --ACsw_btw =    SUBSTRING (@sw_procesos,8,1),   --DESCONOCIDO-C   
   --ACsw_mesa =   SUBSTRING (@sw_procesos,6,1),  --DESCONOCIDO-D 
   --ACsw_pc =     SUBSTRING (@sw_procesos,7,1),  --DESCONOCIDO-E   
   ACsw_mm =     SUBSTRING (@sw_procesos,6,1),  --DESCONOCIDO-F   
    ACsw_fd =     SUBSTRING (@sw_procesos,7,1),  --FIN DE DIA    
          ACsw_finmes = SUBSTRING (@sw_procesos,8,1)   --FIN DE MES  
   
 END
 IF @id_sistema = 'BFW'
 BEGIN
               UPDATE VIEW_MFAC SET 
          acsw_pd       =SUBSTRING (@sw_procesos,1,1), --INICIO DE DIA
   --acsw_ciemefwd =SUBSTRING (@sw_procesos,2,1), --CIERRE DE MESA
          acsw_contafwd =SUBSTRING (@sw_procesos,2,1), --CONTABILIDAD
   acsw_devenfwd =SUBSTRING (@sw_procesos,3,1), --DEVENGAMIENTO 
    acsw_fd       =SUBSTRING (@sw_procesos,4,1)  --FIN DE DIA      
   
 END
   SET NOCOUNT OFF
END


GO
