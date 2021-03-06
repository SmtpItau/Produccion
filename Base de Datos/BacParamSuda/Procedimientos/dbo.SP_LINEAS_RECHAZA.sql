USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_RECHAZA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_RECHAZA](
     @dFecha   DATETIME  ,
     @cSistema  CHAR (03)  ,
     @nNumoper  NUMERIC (10,0)  ,
     @cOperador_Ap  CHAR (15)
       )
AS
BEGIN
 SET NOCOUNT ON
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
    'R'  ,
    @cOperador_Ap ,
    @cOperador_Ap
          )
  END
 ELSE
  BEGIN
    UPDATE aprobacion_operaciones
    SET FechaOperacion  = @dFecha ,
     Operador_Ap_Lineas = @cOperador_Ap ,
     Operador_Ap_Limites = @cOperador_Ap
    WHERE  @nNumoper = NumeroOperacion AND 
     @cSistema = Id_Sistema
  END
        IF @cSistema = 'BTR' UPDATE view_mdmo SET mostatreg = 'R' WHERE monumoper = @nNumoper
        IF @cSistema = 'BCC' UPDATE view_memo SET moestatus = 'R' WHERE monumope = @nNumoper
        IF @cSistema = 'BFW' 
  BEGIN
   UPDATE view_mfmo SET moestado  = 'R' WHERE monumoper = @nNumoper
   UPDATE view_mfca SET caestado  = 'R' WHERE canumoper = @nNumoper
  END
 SET NOCOUNT OFF
END
-- Sp_Lineas_Error 'BTR', 2
-- select * from mdmo
-- Sp_Lineas_GrabarError 'BTR', 49
-- EXECUTE Sp_Lineas_Autoriza 'BTR', 36530

GO
