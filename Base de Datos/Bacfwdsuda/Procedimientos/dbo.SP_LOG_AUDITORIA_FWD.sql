USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOG_AUDITORIA_FWD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_LOG_AUDITORIA_FWD] (
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
 
 SELECT  @sistema = nombre_sistema 
 FROM  view_sistema_cnt 
 WHERE  @id_sistema= id_sistema

 SELECT @sistema = ISNULL( @sistema , 'SISTEMA NO DEFINIDO' )

 SELECT @DETALLE_FINAL = UPPER(RTRIM(@DetalleTransac))

 INSERT INTO log_auditoria_FWD( 
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



GO
