USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CANJES_TRAE_OPERACION]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CANJES_TRAE_OPERACION]
            (
               @FECHA      DATETIME,
               @TIPOOPERA  CHAR(4)               
            )
AS
BEGIN
      SELECT 
            morutcli
           ,'monomcli'             = ( SELECT clnombre FROM VIEW_CLIENTE where clrut = MEMO.morutcli )
           ,momonmo
           ,moticam
           ,motctra
           ,'moentre'              =  ( SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = MEMO.moentre )
           ,'morecib'              =  ( SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = MEMO.morecib )
           ,'forma_pago_cli_nac'   =  ( SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = MEMO.forma_pago_cli_nac )
           ,'forma_pago_cli_ext'   =  ( SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = MEMO.forma_pago_cli_ext )
           ,'observaciones'        = ''
           ,monumope
           ,moestatus
    ,observacion
    ,'cod_cliente'    = ( SELECT clcodigo FROM VIEW_CLIENTE where clrut = MEMO.morutcli )
      FROM MEMO
      WHERE @FECHA      =   mofech
      AND   @TIPOOPERA   =   motipmer
END




GO
