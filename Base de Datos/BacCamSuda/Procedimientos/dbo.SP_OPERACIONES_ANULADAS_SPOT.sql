USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERACIONES_ANULADAS_SPOT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OPERACIONES_ANULADAS_SPOT]
            (
                @USUARIO       CHAR(30)
               ,@DESDE         DATETIME
               ,@HASTA         DATETIME
            )
AS
BEGIN
IF EXISTS( SELECT 1 FROM  MEMO,VIEW_PRODUCTO P WHERE P.codigo_producto =  motipmer AND p.id_sistema = 'BCC' AND moestatus = 'A')
   BEGIN
       SELECT 
         'TIPO_OPER'         =   motipope
        ,'NUM_OPERA'         =   monumope
        ,'TIPO_MERC'         =   motipmer
        ,'CLIENTE'           =   monomcli
        ,'TIPO_CAMB'         =   moticam
        ,'OPERADOR'          =   mooper
        ,'ENTREGAMOS'         =   ( SELECT F.glosa FROM VIEW_FORMA_DE_PAGO F WHERE F.codigo = moentre )
        ,'RECIBIMOS'         =   ( SELECT F.glosa FROM VIEW_FORMA_DE_PAGO F WHERE F.codigo = morecib )
        ,'CODIGO_PRODUCTO'   =   P.descripcion
        ,'FECHA_EMISION'     =   CONVERT( CHAR(10), GETDATE(), 103 )
        ,'FECHA_PROCESO'     =   CONVERT( CHAR(10), (SELECT acfecpro FROM MEAC), 103 )
        ,'HORA'              =   CONVERT( CHAR(10), GETDATE(), 108 )
        ,'FECHA_OPERACION'   =   mofech   
        ,'USUARIO'           =   @USUARIO
        ,'DESDE'             =   @DESDE
        ,'HASTA'             =   @HASTA
        ,'MONTO_USD'         =   moussme
        ,'MONTO_CLP'         =   momonpe
        ,'MONTO_ORI'         =   momonmo
       FROM MEMO,VIEW_PRODUCTO P
      WHERE P.codigo_producto = motipmer AND p.id_sistema = 'BCC' AND moestatus = 'A' 
   END ELSE
         BEGIN
            SELECT 
             'TIPO_OPER'         =   ''
            ,'NUM_OPERA'         =   ''
            ,'TIPO_MERC'         =   ''
            ,'CLIENTE'           =   ''
            ,'TIPO_CAMB'         =   ''
            ,'OPERADOR'          =   ''
            ,'ENTREGAMOS'         =   ''
            ,'RECIBIMOS'         =   ''
            ,'CODIGO_PRODUCTO'   =   ''
            ,'FECHA_EMISION'     =   CONVERT( CHAR(10), GETDATE(), 103 )
            ,'FECHA_PROCESO'     =   CONVERT( CHAR(10), GETDATE(), 103 )
            ,'HORA'              =   CONVERT( CHAR(10), GETDATE(), 108 )
            ,'FECHA_OPERACION'   =   CONVERT( CHAR(10), (SELECT acfecpro FROM MEAC), 103 )
            ,'USUARIO'           =   @USUARIO
            ,'DESDE'             =   @DESDE
            ,'HASTA'             =   @HASTA
            ,'MONTO_USD'         =   ''
            ,'MONTO_CLP'         =   ''
            ,'MONTO_ORI'         =   ''
        END
END

GO
