USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_AUTORIZA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_AUTORIZA]
    (
    @dFecha  DATETIME ,
    @cSistema CHAR (03) ,
    @nNumoper NUMERIC (10,0) ,
    @cOperador_Ap CHAR (15) ,
    @limites CHAR (01) ,
    @lineas  CHAR (01)
    )
AS
BEGIN
 SET NOCOUNT ON
-- FechaOperacion NumeroOperacion Id_Sistema Estado Operador_Ap_Lineas Operador_Ap_Limites 
 DECLARE @Operador_Lineas  CHAR(15) ,
  @Operador_limites CHAR(15) ,
  @estado   CHAR(1)
 SELECT @Operador_Lineas = '' ,
  @Operador_limites = '' ,
  @estado   = 'P'
 IF NOT EXISTS(  SELECT  *
   FROM  aprobacion_operaciones 
   WHERE  @nNumoper = NumeroOperacion AND 
    @cSistema = Id_Sistema   )
  BEGIN
   INSERT INTO aprobacion_operaciones(  FechaOperacion  ,
        NumeroOperacion  ,
        Id_Sistema  ,
        Estado   ,
        Operador_Ap_Lineas ,
        Operador_Ap_Limites
         )
   VALUES( @dFecha  ,
    @nNumoper ,
    @cSistema ,
    ' '  ,
    ' '  ,
    ' '
          )
  END
 ELSE
  BEGIN
   SELECT @Operador_Lineas = Operador_Ap_Lineas ,
    @Operador_limites = Operador_Ap_Limites 
   FROM aprobacion_operaciones
   WHERE  @nNumoper = NumeroOperacion AND 
    @cSistema = Id_Sistema
  END
 IF @Operador_Lineas = '' AND @lineas = 'S'
  UPDATE  aprobacion_operaciones 
  SET  Operador_Ap_Lineas  = @cOperador_Ap
  WHERE  @nNumoper = NumeroOperacion AND 
   @cSistema = Id_Sistema
 IF @Operador_limites = '' AND @limites = 'S' 
  UPDATE  aprobacion_operaciones 
  SET  Operador_Ap_Limites = @cOperador_Ap
  WHERE  @nNumoper = NumeroOperacion AND 
   @cSistema = Id_Sistema
 SELECT @estado = 'A' 
 FROM aprobacion_operaciones
 WHERE  @nNumoper = NumeroOperacion  AND 
  @cSistema = Id_Sistema  AND
  Operador_Ap_Limites <> '' AND
  Operador_Ap_Lineas  <> ''
        IF @cSistema='BTR'
 BEGIN
  UPDATE VIEW_MDMO SET mostatreg   = ' ' WHERE monumoper=@nNumoper AND @estado = 'A'
  IF EXISTS(SELECT * FROM VIEW_MDCP WHERE cpnumdocu=@nNumoper)
   UPDATE VIEW_MDCP SET Estado_Operacion_Linea = ' ' WHERE cpnumdocu=@nNumoper AND @estado = 'A'
  IF EXISTS(SELECT * FROM VIEW_MDDI WHERE dinumdocu=@nNumoper)
   UPDATE VIEW_MDDI SET Estado_Operacion_Linea = ' ' WHERE dinumdocu=@nNumoper AND @estado = 'A'
  IF EXISTS(SELECT * FROM VIEW_MDCI WHERE cinumdocu=@nNumoper)
   UPDATE VIEW_MDCI SET Estado_Operacion_Linea = ' ' WHERE cinumdocu=@nNumoper AND @estado = 'A'
 END
        IF @cSistema='BCC'
  UPDATE  VIEW_MEMO 
  SET  moestatus = ' '    ,
   autorizador_limite = @cOperador_Ap
  WHERE monumope=@nNumoper AND @estado = 'A'
        IF @cSistema='BFW'
  UPDATE  VIEW_MFMO
  SET  moestado   = ' '
  WHERE  monumoper=@nNumoper AND @estado = 'A'
  
  UPDATE  VIEW_MFCA
  SET  caautoriza = @cOperador_Ap ,
   caestado   = ' '
  WHERE  canumoper=@nNumoper AND @estado = 'A'
 UPDATE  aprobacion_operaciones SET Estado = @estado
 WHERE  @nNumoper = NumeroOperacion  AND 
  @cSistema = Id_Sistema  
 SELECT @estado
 SET NOCOUNT OFF
END
-- Sp_Lineas_Error 'BTR', 2
-- select * from aprobacion_operaciones
-- delete aprobacion_operaciones
-- EXECUTE Sp_Lineas_Autoriza '20011228', 'BFW', 29176, 'ADMINISTRA', 'S', 'N'

GO
