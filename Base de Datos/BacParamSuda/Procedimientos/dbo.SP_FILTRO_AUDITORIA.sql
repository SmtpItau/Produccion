USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRO_AUDITORIA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FILTRO_AUDITORIA]
  ( @fechainicioproc datetime='',
   @fechafinalproc  datetime='',
   @fechainisist  datetime='',
   @fechafinalsist  datetime='',
   @horaini  char(8) ='',
   @horater  char(8) ='',
   @usuario  char(15)='',
   @id_sist  char(3) ='',
   @menu   char(12)='',
   @evento   char(02)='')
AS   
BEGIN
 
 SELECT  a.entidad,
  a.fechaproceso,
  a.fechasistema,
  a.horaproceso,
  a.terminal,
  a.usuario,
  a.id_sistema,
  g.nombre_opcion,
  e.descripcion,
  a.detalletransac,
  a.tablainvolucrada,
  a.valorantiguo,
  a.valornuevo
                 
 FROM    LOG_AUDITORIA a,
  LOG_EVENTO e,
  GEN_MENU g
 WHERE   
  ( CONVERT(CHAR(10),a.fechaproceso,112) >= CONVERT(CHAR(10),@fechainicioproc,112) and CONVERT(CHAR(10),a.fechaproceso,112) <= CONVERT(CHAR(10),@fechafinalproc,112) )
 AND ( CONVERT(CHAR(10),a.fechasistema,112) >= CONVERT(CHAR(10),@fechainisist,112)    and CONVERT(CHAR(10),a.fechasistema,112) <= CONVERT(CHAR(10),@fechafinalsist,112) )
 AND (a.horaproceso >=@horaini OR @horaini='' )
 AND (a.horaproceso<=@horater OR @horater='')
 AND  (a.usuario=@usuario OR @usuario='')
 AND (a.id_sistema=@id_sist OR @id_sist='')
 AND (a.codigomenu=@menu OR @menu='')
 AND (a.codigo_evento=@evento OR @evento='')
 AND (a.codigo_evento=e.codigo_evento)
 AND (a.codigomenu=g.nombre_objeto)
END 
GO
