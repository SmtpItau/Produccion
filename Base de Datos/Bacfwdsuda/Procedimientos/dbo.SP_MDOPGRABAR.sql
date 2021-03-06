USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDOPGRABAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDOPGRABAR]
       (
        @nrutcli     NUMERIC(9,0)    , -- RUT Cliente
        @nrutOpe     NUMERIC(9,0)    , -- Rut Apoderado
        @cdigOpe     CHAR(1)         , -- Digito Rut Apoderado
        @cnomOpe     CHAR(40)        , -- Nombre Apoderado
        @ncodcli     Numeric (5)      -- codigo cliente
       )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   IF NOT EXISTS (
                   SELECT       Oprutcli
                          FROM  VIEW_CLIENTE_OPERADOR
                          WHERE Oprutcli = @nrutcli      AND
                                Opcodcli = @ncodcli      AND
                                OprutOpe= @nrutOpe
                 ) BEGIN
    /*====================================================================*/
      INSERT INTO VIEW_CLIENTE_OPERADOR (
                        oprutcli   , -- 01 RUT Cliente
                        oprutOpe   , -- 03 Rut Apoderado
                        OpdvOpe    , -- 04 Digito Rut Apoderado
                        Opnombre   ,   -- 05 Nombre Apoderado
                        Opcodcli       
                       )
             VALUES    (
                        @nrutcli    , -- 01 RUT Cliente
                        @nrutOpe    , -- 03 Rut Apoderado
                        @cdigOpe    , -- 04 Digito Rut Apoderado
                        @cnomOpe    ,  -- 05 Nombre Apoderado
                        @ncodcli
                       )
    /*======================================================================*/
    END ELSE BEGIN
    /*===================================================================*/
       UPDATE       VIEW_CLIENTE_OPERADOR
              SET   Opnombre = @cnomOpe          -- Nombre Apoderado
              WHERE Oprutcli = @nrutcli       AND
                    Opcodcli = @ncodcli       AND
                    OprutOpe = @nrutOpe
    END
    /*======================================================================*/
    SELECT 'OK', ''
    /*======================================================================*/
    
SET NOCOUNT OFF
END

GO
