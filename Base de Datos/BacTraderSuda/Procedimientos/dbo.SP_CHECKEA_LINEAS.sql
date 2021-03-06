USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHECKEA_LINEAS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CHECKEA_LINEAS]
    (
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nRutcli NUMERIC (09,0) ,
    @dFecvctop DATETIME ,
    @cUsuario CHAR (15)
    )
AS
BEGIN
 DECLARE @dFecPro  DATETIME
 DECLARE @cNombre CHAR(60)
 DECLARE @nCodigo NUMERIC (09,0)
 SET NOCOUNT ON
 DECLARE @iFound   INTEGER  ,
  @cCtrlplazo  CHAR (01) 
 SELECT @dFecPro = acfecproc FROM mdac
 SELECT  @cNombre = clnombre,
  @nCodigo = clcodigo
 FROM  view_cliente
 WHERE clrut  = @nRutcli
-- AND clcodigo = @nCodigo
 --*************** LINEA GENERAL
 SELECT @iFound  = 0
 SELECT @iFound   = 1
        FROM VIEW_LINEA_GENERAL
 WHERE rut_cliente  = @nRutcli
 AND  codigo_cliente  = @nCodigo
 IF @iFound = 1
 BEGIN
  --*************** LINEA SISTEMA
  SELECT  @iFound = 0
  SELECT @iFound  = 1  ,
   @cCtrlplazo = controlaplazo
         FROM VIEW_LINEA_SISTEMA
  WHERE rut_cliente = @nRutcli 
  AND codigo_cliente = @nCodigo
  AND id_sistema = @cSistema
  IF @iFound = 0
  BEGIN
   SELECT 'NO','No Existe Linea Sistema Para ' + @cNombre
   RETURN
  END
  --*************** LINEA POR PLAZO
  IF @cCtrlplazo='S'
  BEGIN
   SELECT  @iFound  = 0
   SELECT @iFound  = 1
          FROM VIEW_LINEA_POR_PLAZO
   WHERE rut_cliente=@nRutcli
   AND codigo_cliente=@nCodigo
   AND id_sistema=@cSistema
   AND plazodesde <= DATEDIFF(day, @dFecPro, @dFecvctop)
   AND plazohasta  > DATEDIFF(day, @dFecPro, @dFecvctop)
   IF @iFound = 0
   BEGIN
    SELECT 'NO','No Existe Linea Para Plazo '  + RTRIM(LTRIM(CONVERT(CHAR(06), DATEDIFF(day, @dFecPro, @dFecvctop)))) + ' Días Para ' + @cNombre
    RETURN
   END
  END
 END
 ELSE
 BEGIN
  SELECT 'NO','No Existe Linea General Para ' + @cNombre
  RETURN
 END
 SELECT 'SI','Lineas Disponibles'
  
 SET NOCOUNT OFF
END
-- Sp_Checkea_Lineas 'BTR', 'CP ', 97004000, '20090101', 'ADMINISTRA'
-- select * from VIEW_LINEA_GENERAL
-- select * from VIEW_LINEA_SISTEMA
-- select * from  VIEW_LINEA_TRANSACCION
-- select * from  VIEW_LINEA_TRANSACCION_detalle
-- select * from VIEW_LINEA_POR_PLAZO
-- select * from VIEW_LINEA_PRODUCTO
-- select * from VIEW_LINEA_AFILIADO
-- select * from VIEW_LINEA_TRASPASO
-- select * from VIEW_PRODUCTO order by id_sistema
-- select * from VIEW_CLIENTE
-- select * from VIEW_SISTEMA_CNT
-- select * from VIEW_CONTROL_FINANCIERO
-- sp_help VIEW_LINEA_SISTEMA
-- SELECT * from view_cliente
--sp_help

GO
