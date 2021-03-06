USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_CUPOARRIENDO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_CUPOARRIENDO] (
                                        @NumOper numeric(7)
                )
                           
AS
BEGIN 
        
select  'FEC_PRO    ' = MOFECH   
       ,'TIPOCV     ' = MOTIPMER
       ,'MONTOUSD   ' = MOMONMO
       ,'CLIENTE    ' = MONOMCLI
       ,'RUTCLIE    ' = MORUTCLI
       ,'CODCLI     ' = MOCODCLI
       ,'TIPOPER    ' = MOTIPOPE
       ,'PRECIO     ' = MOPRECIO
       ,'TIPCAMBIO  ' = MOTICAM
       ,'TIPCAMVEN  ' = MOTCTRA
       ,'FORPAGCOM  ' = MORECIB
       ,'FORPAGVEN  ' = FORMA_PAGO_CLI_EXT
       ,'FORPAGMNCOM' = MOENTRE
       ,'FORPAGMNVEN' = FORMA_PAGO_CLI_NAC
       ,'VALUTA1    ' = MOVALUTA1
       ,'VALUTA2    ' = MOVALUTA2
       ,'NUMEROOPER ' = MONUMOPE
       from memo where monumope = @NumoPer
END
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
IF @@ERROR <> 0 BEGIN
   ROLLBACK TRANSACTION
   SELECT -1, 'ERROR:  NO SE PUEDE CARGAR.'
   SET NOCOUNT OFF
 --  exec sp_Grabar_Log 'BCC',@usuario,@Fecha,'NO SE PUEDE CARGAR CUPO,ARRIENDO.'
   RETURN
END
-- SELECT 'NUM' = MONUMOPE  FROM MEMO
-- select * from memo
-- select * from meac
-- sp_helptext SP_MODIFICAOPERACIONES_TRAE_PRODUCTO



GO
