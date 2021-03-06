USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOG_AUDITORIA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LOG_AUDITORIA] (
     @Entidad    CHAR(2) ,
     @FechaProceso    CHAR(8) ,
     @Terminal    CHAR(15) ,
     @Usuario    CHAR(15) ,
     @Id_Sistema    CHAR(3) ,
     @CodigoMenu    VARCHAR(12) ,
     @Codigo_Evento    VARCHAR(2) ,
     @DetalleTransac   VARCHAR(80) ,
     @TablaInvolucrada VARCHAR(50) ,
     @ValorAntiguo    NTEXT  ,
     @ValorNuevo    NTEXT 
       )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @Menu   VARCHAR(30)
 DECLARE @Evento  VARCHAR(30)
 DECLARE @Detalle_Final  VARCHAR(250)
 DECLARE @Sistema        VARCHAR(30)
/*
 SELECT  @Evento = descripcion   
 FROM  log_evento 
 WHERE  @Codigo_Evento = codigo_evento
 SELECT  @menu   = nombre_opcion
 FROM  gen_menu   
 WHERE  @CodigoMenu    = nombre_objeto AND 
  @id_sistema = entidad
*/  
 SELECT  @sistema = nombre_sistema 
 FROM  view_sistema_cnt 
 WHERE  @id_sistema= id_sistema
-- SELECT @evento  = ISNULL( @evento  , 'EVENTO NO DEFINIDO' )
-- SELECT @menu    = ISNULL( @menu    , 'OPCION DE MENU NO DEFINIDO' )
 SELECT @sistema = ISNULL( @sistema , 'SISTEMA NO DEFINIDO' )
-- SELECT @DETALLE_FINAL = UPPER(RTRIM(@SISTEMA)) + ' ' + UPPER(RTRIM(@MENU)) + ' ' + UPPER(RTRIM(@EVENTO)) + ' ' + UPPER(RTRIM(@DetalleTransac))
 SELECT @DETALLE_FINAL = UPPER(RTRIM(@DetalleTransac))
 INSERT INTO view_log_auditoria( 
  Entidad  ,  
  FechaProceso ,
  FechaSistema ,
  HoraProceso ,
  Terminal ,
  Usuario  ,
  Id_Sistema ,
  CodigoMenu ,
  Codigo_Evento ,
  DetalleTransac ,
  TablaInvolucrada,
  ValorAntiguo ,
  ValorNuevo 
  )
 VALUES (
  @Entidad   ,
  @FechaProceso   ,
  CONVERT(CHAR(8),getdate(),112) ,
  CONVERT(CHAR(8),getdate(),108) ,
  @Terminal   ,
  @Usuario   ,
  @id_Sistema   ,
  @CodigoMenu   ,
  @Codigo_Evento   ,
  @Detalle_final   ,
  @TablaInvolucrada  ,
  @ValorAntiguo   ,
  @ValorNuevo
  )
  
   SELECT 'OK'
 SET NOCOUNT OFF 
END
/*
se
select * from monedas_tasas_fwd
select * from canasta
select * from log_auditoria where id_sistema='PCS' order by fechasistema 
delete from log_auditoria where Codigo_Evento = '02' and id_sistema='PCS'
sp_log_auditoria '1','20010516', 'BAC_0259_AGONZA', 'ADMINISTRA', 'PCS','Opc_20100','02','Modificacion Operacion 18 Swap de Tasas operacion N. 18', 'Cartera-Carteralog', '''', ''''
select * from log_auditoria where fechasistema='2001-06-07' order by fechasistema
SP_LOG_Auditoria '1','20010516', 'BAC_0259_AGONZA', 'ADMINISTRA', 'PCS','Opc_20100','02','Modificacion Operacion 18 Swap de Tasas operacion N. 18', 'Cartera-Carteralog', '''', ''''
sp_log_auditoria '1','20010516', 'BAC_0259_AGONZA', 'ADMINISTRA', 'PCS','Opc_20100','02','Modificacion Operacion 18 Swap de Tasas operacion N. 18', 'Cartera-Carteralog', '''', ''''
sp_log_auditoria 1,0,'2001-06-07',0,BAC0159_LABARCA,ADMINISTRA,'ADM',Opcion_003,'06','SALIDA DEL SISTEMA',' ',' ',' '
sp_log_auditoria 1,'','2001-06-07','',BAC0159_LABARCA,ADMINISTRA,'ADM',0,'05','',USUARIO,' ',' '
sp_log_auditoria 1,'','2001-06-07','',BAC0159_LABARCA,ADMINISTRA,'ADM',Opcion_007,'02','USUARIO :JUANP',USUARIO,DESBLOQUEAR,BLOQUEAR
select * from sistema_cnt
select * from log_evento
bacparamsuda..SP_Log_Auditoria '1','20010523', 'BAC_0259_AGONZA', 'ADMINISTRA', 'BFW','OPC_1001','02','operacion N. 28906', 'Cartera-Carteralog', ' Mon Mda1: 3000; Mon Mda1 Eq.$: 4180227; Mon Mda2: 1680000; Mon Mda2 Eq USD: 1680000; Mon Mda2 Eq.$: 1017794400; Est Operación: ; Op Tomada por: ; Monto ini Mon1: 3000; Monto Fin Mon1: 3000; Monto ini Mon2: 1680000; Monto Fin Mon2: 1680000; Monto diferido: 0; Area Respon: ; Pais Ori: 0;', ' Mon Mda1: 2000; Mon Mda1 Eq.$: 2786818; Mon Mda2: 1120000; Mon Mda2 Eq USD: 1120000; Mon Mda2 Eq.$: 678529600; Est Operación:  ; Op Tomada por:  ; Monto ini Mon1: 2000; Monto Fin Mon1: 2000; Monto ini Mon2: 1120000; Monto Fin Mon2: 1120000; Monto diferido: -675742782; Area Respon: BFW; Pais Ori: 6;'
sp_log_auditoria '1','20010516', 'BAC_0259_AGONZA', 'ADMINISTRA', 'PCS','Opc_20100','01','Ingreso Operacion 18 Swap de Tasas operacion N. 18', 'MovDiario-Cartera-Carteralog', '', ''
sp_log_auditoria 1,'','2001-06-07','',BAC0159_LABARCA,ADMINISTRA,'ADM',0,'05',,USUARIO,' ',' '
sp_helptext sp_Bloquea_Gen_Usuario
sp_helptext sp_traeBloqueo_Usuario
select * from tasa_fwd
sp_helptext SP_LOG_Auditoria
*/

GO
