USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNT_LISTAINSTRUMENTOS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CNT_LISTAINSTRUMENTOS]
     ( 
     @paresid_sistemas CHAR(03)
     )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @varorginstrumentos CHAR (60) ,
  @vardatainstrumentos CHAR (60) ,
  @cFiltroBtr  CHAR (160)
 IF @paresid_sistemas<>'BTR'
 BEGIN
  IF EXISTS(SELECT * FROM PRODUCTO_CNT WHERE id_sistema=@paresid_sistemas)
  BEGIN
   SELECT @varorginstrumentos = origen_instrumentos ,
    @vardatainstrumentos =  datos_instrumentos
   FROM PRODUCTO_CNT 
   WHERE id_sistema=@paresid_sistemas
   IF @varorginstrumentos<>'' OR @vardatainstrumentos<>''
    EXECUTE ('SELECT '+@vardatainstrumentos+' FROM '+@varorginstrumentos)
  END
  ELSE
   SELECT 'NO HAY DATOS'
 END
 ELSE
 BEGIN
  SELECT @cFiltroBtr = 'incodigo<>600 AND incodigo<>601 AND incodigo<>602 AND incodigo<>603 AND incodigo<>700 AND incodigo<>701 AND incodigo<>702 AND incodigo<>703'
  IF EXISTS(SELECT * FROM PRODUCTO_CNT WHERE id_sistema=@paresid_sistemas)
  BEGIN
   SELECT @varorginstrumentos = origen_instrumentos ,
    @vardatainstrumentos = datos_instrumentos
   FROM PRODUCTO_CNT 
   WHERE id_sistema=@paresid_sistemas
   IF @varorginstrumentos<>'' OR @vardatainstrumentos<>''
    EXECUTE ('SELECT '+@vardatainstrumentos+' FROM '+@varorginstrumentos+' WHERE '+@cFiltroBtr)
  END
  ELSE
   SELECT 'NO HAY DATOS'
 END
 SET NOCOUNT OFF
END
-- select * from instrumento
-- SP_CNT_LISTAINSTRUMENTOS 'BTR'
-- SP_CNT_LISTAINSTRUMENTOS 'BCC'
-- SP_CNT_LISTAINSTRUMENTOS 'BFW'
-- select * from mdmo where motipoper='IB'
-- delete mdci where cinumdocu=46830
-- delete mdmo where monumdocu=46830
-- SELECT * FROM PRODUCTO_CNT
-- select * from instrumento

GO
